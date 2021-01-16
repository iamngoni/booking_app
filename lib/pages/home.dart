import 'package:booking_app/pages/applications.dart';
import 'package:booking_app/pages/bookmarks.dart';
import 'package:booking_app/pages/community.dart';
import 'package:booking_app/pages/discover.dart';
import 'package:booking_app/pages/settings.dart';
import 'package:booking_app/utils/color.dart';
import 'package:booking_app/utils/custom_icons.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  List _pages = [
    Applications(),
    Discover(),
    Community(),
    Bookmarks(),
    Settings()
  ];
  int _index = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kYellow,
        unselectedItemColor: kPurple,
        showUnselectedLabels: true,
        backgroundColor: kBackground,
        elevation: 0,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            backgroundColor: kBackground,
            icon: customIcon(
              path: "assets/icons/icons8-squared-menu-48.png",
              size: 20,
              color: _index == 0 ? kYellow : kPurple,
            ),
            label: "Applications",
          ),
          BottomNavigationBarItem(
            backgroundColor: kBackground,
            icon: Icon(
              Icons.wb_sunny_sharp,
              color: _index == 1 ? kYellow : kPurple,
            ),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            backgroundColor: kBackground,
            icon: customIcon(
              path: "assets/icons/icons8-speaker-notes-48.png",
              size: 20,
              color: _index == 2 ? kYellow : kPurple,
            ),
            label: "Community",
          ),
          BottomNavigationBarItem(
            backgroundColor: kBackground,
            icon: customIcon(
              path: "assets/icons/icons8-bookmark-48.png",
              size: 20,
              color: _index == 3 ? kYellow : kPurple,
            ),
            label: "Bookmarks",
          ),
          BottomNavigationBarItem(
            backgroundColor: kBackground,
            icon: customIcon(
              path: "assets/icons/setting-1881213.png",
              size: 20,
              color: _index == 4 ? kYellow : kPurple,
            ),
            label: "Settings",
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
