import 'package:flutter/material.dart';

class Resize {
  //setting up media query once in the whole app to not to intialize it again
  static final Resize _singleton = Resize._internal();

  late double _height;
  late double _width;
  late double _paddingTop;
  late double _resposiveConst;
  get mediumSpace => const SizedBox(
        height: 30,
      );
  get fromPaddingHorizontal => _resposiveConst * 25;
  get fromPaddingHorizontal2 => _resposiveConst * 20;
  get formPaddingVertical => resposiveConst * 40;
  //vertical2 is used forms inside app
  get formPaddingVertical2 => resposiveConst * 20;
  get resposiveConst => _resposiveConst;
  get tempConst => double.parse((12.3412).toStringAsFixed(2));
  get height => _height;
  get width => _width;
  get paddingTop => _paddingTop;
  void setValue(BuildContext context) {
    _singleton._height = MediaQuery.of(context).size.height;
    _singleton._width = MediaQuery.of(context).size.width;
    _singleton._paddingTop = MediaQuery.of(context).padding.top;
    _singleton._resposiveConst = (_height / _width) / 2.345; // 3.09000298;
  }

  factory Resize() {
    return _singleton;
  }

  Resize._internal();
}
