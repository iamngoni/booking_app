import 'package:flutter/cupertino.dart';

class kDimensions {
  double height;
  double width;
  BuildContext context;
  kDimensions({@required this.context}) {
    this.height = MediaQuery.of(this.context).size.height;
    this.width = MediaQuery.of(this.context).size.width;
  }

  double kHeight(ratio) {
    return this.height * ratio;
  }

  double kWidth(ratio) {
    return this.width * ratio;
  }
}
