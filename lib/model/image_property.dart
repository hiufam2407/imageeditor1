import 'package:flutter/material.dart';

class ImageProperty{

  dynamic path;
  double height;
  double width;
  double rotate;
  double scale;
  Offset position;

  ImageProperty({this.path=null, this.height=100, this.width=100, this.rotate=0, this.scale=2, this.position=Offset.zero});
}