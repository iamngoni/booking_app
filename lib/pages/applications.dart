import 'dart:convert';

import 'package:booking_app/models/applications.dart';
import 'package:booking_app/models/popular.dart';
import 'package:booking_app/utils/color.dart';
import 'package:booking_app/utils/custom_icons.dart';
import 'package:booking_app/utils/date.dart';
import 'package:booking_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class Applications extends StatefulWidget {
  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  List<Map<String, dynamic>> _applicationTypes = [
    {"name": "Current", "index": 0},
    {"name": "Executed", "index": 2},
    {"name": "All", "index": 3}
  ];

  int _typeIndex = 0;

  String _dateGenerator({@required String date, @required int nights}) {
    DateTime actualDate = new DateFormat("dd-MM-yyyy").parse(date.toString());
    DateTime endDate = actualDate.add(Duration(days: nights));
    DateHelper _helper = new DateHelper(now: actualDate);
    DateHelper _endDateHelper = new DateHelper(now: endDate);
    return "${_helper.getMonth()} ${_helper.getDate()}, ${_helper.getYear()} - ${_endDateHelper.getMonth()} ${_endDateHelper.getDate()}, ${_endDateHelper.getYear()}";
  }

  Color _colorGen(String necessity) {
    Color color;
    switch (necessity.trim().toLowerCase()) {
      case "kitchen":
        color = kOrange;
        break;
      case "wi-fi":
        color = kBlue;
        break;
      case "open pool":
        color = kPurple;
        break;
      default:
        color = kGreen;
        break;
    }

    return color;
  }

  _newApplication(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                "New Application",
                style: TextStyle(
                  color: kTextDark,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                "Create an application for the hosts indicating all the necessary living concitions",
                style: TextStyle(
                  color: kGreyedText,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "New Application",
                style: TextStyle(
                  color: kTextDark,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kTextDark,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Destination",
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: kTextDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    kDimensions dimension = new kDimensions(context: context);
    return Container(
      height: dimension.height,
      width: dimension.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Applications",
                  style: TextStyle(
                    color: kTextDark,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                GestureDetector(
                  onTap: () => _newApplication(context),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: kYellow,
                    foregroundColor: kTextDark,
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _applicationTypes.map((Map<String, dynamic> type) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _typeIndex = type["index"];
                      });
                    },
                    child: Text(
                      type["name"],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _typeIndex == type["index"]
                            ? kTextDark
                            : kGreyedText,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Container(
              height: dimension.kHeight(0.25),
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString("assets/data/applications.json"),
                builder: (context, snapshot) {
                  while (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  var data = json.decode(snapshot.data);
                  List<Application> applications = [];
                  for (var map in data) {
                    applications.add(Application.fromMap(map));
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: applications.length,
                    itemBuilder: (context, index) {
                      List<String> necessities =
                          applications[index].necessities.split(",");
                      return Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          width: dimension.kWidth(0.85),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${applications[index].type} for ${applications[index].guests} in ${applications[index].destination}",
                                    style: TextStyle(
                                      color: kTextDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "🔥 ${applications[index].offers} offers",
                                    style: TextStyle(
                                      color: kBrown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                _dateGenerator(
                                  date: applications[index].date,
                                  nights: applications[index].nights,
                                ),
                                style: TextStyle(
                                  color: kGreyedText,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 7.0,
                                      horizontal: 10.0,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kLightBlue,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Text(
                                      "${applications[index].guests} guests",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 2.0,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 7.0,
                                      horizontal: 7.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kPurple,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Text(
                                      "${applications[index].bedrooms} bedrooms",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 2.0,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 7.0,
                                      horizontal: 10.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kGreen,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Text(
                                      "\$${applications[index].lowerLimit} - \$${applications[index].upperLimit}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 30,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: necessities.map((necessity) {
                                    return Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 2.0,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 7.0,
                                        horizontal: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _colorGen(necessity),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Text(
                                        "$necessity",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Stays",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kTextDark,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: customIcon(
                    path: "assets/icons/icons8-slider-48.png",
                    size: 25.0,
                    color: kPurple,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: dimension.width,
              // height: dimension.kHeight(0.6),
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context).loadString(
                  "assets/data/popular.json",
                ),
                builder: (context, snapshot) {
                  while (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = json.decode(snapshot.data);
                  List<Popular> popular = [];
                  for (var dt in data) {
                    popular.add(Popular.fromMap(dt));
                  }

                  return StaggeredGridView.countBuilder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    itemCount: popular.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 3.0,
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                          image: DecorationImage(
                            image: AssetImage(popular[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: dimension.kHeight(0.4),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  color: kYellow,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  "${double.parse(popular[index].rating.toString())}",
                                  style: TextStyle(
                                    color: kTextDark,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${popular[index].price}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "per night",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 35,
                              child: Text(
                                "${popular[index].name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(2, index.isEven ? 2.2 : 2.5);
                    },
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
