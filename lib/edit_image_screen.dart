import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'model/image_property.dart';
import 'model/project.dart';

class EditImageScreen extends StatefulWidget {
  Project project;

  EditImageScreen({required this.project});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  double _startRotation = 0.0;
  double _startScale = 1.0;
  Size? _startSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffA6AFBA),
          title: Text('Editing ${widget.project.name}'),
          actions: [
            IconButton(
              onPressed: () async {
                final result =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (result != null) {
                  widget.project.imageList
                      .add(ImageProperty(path: File(result.path)));
                  setState(() {});
                }
              },
              icon: Icon(Icons.add_a_photo_rounded),
            ),
          ]),
      body: Stack(
        children: widget.project.imageList
            .map((e) => Positioned(
                top: e.position.dy,
                left: e.position.dx,
                child: Transform.scale(
                  scale: e.scale,
                  child: Transform.rotate(
                    angle: e.rotate,
                    child: GestureDetector(
                      onScaleUpdate: (detail) {
                        if (detail.pointerCount == 1) {
                          e.position = Offset(
                              e.position.dx + detail.focalPointDelta.dx * e.scale,
                              e.position.dy + detail.focalPointDelta.dy * e.scale); //di chuyen anhs
                        } else {
                          e.rotate = (_startRotation + detail.rotation);
                          e.scale = (_startScale * detail.scale);
                        }
                        // e.scale =  detail.scale;
                        // print(e.scale);
                        // e.rotate = detail.rotation;
                        // print(e.rotate); //Xoay anh
                        // e.position = Offset(e.position.dx + detail.rotation, e.position.dy + detail.delta.dy); //di chuyen anh
                        // double _minScale = 0.9;
                        // double _maxScale = 1.2;
                        // e.scale = (e.scale * detail.scale).clamp(_minScale, _maxScale);
                        // e.width = e.width * e.scale;
                        // e.height = e.height * e.scale;
                        // print('Scale: ${e.scale}, Width: ${e.width}, Height: ${e.height}');
                        // ImageProperty().scale = e.scale * detail.scale;
                        setState(() {});
                      },
                      onScaleStart: (details) {
                        _startScale = e.scale;
                        _startRotation = e.rotate;
                        _startSize = Size(e.width, e.height);
                        setState(() {});
                      },
                      child: e.path is String
                          ? Image.asset(
                              (e).path,
                              // scale: e.scale,
                              // width: e.width * 2,
                              // height: e.height * 2,
                              gaplessPlayback: true,
                            )
                          : Image.file(
                              (e).path,
                              // scale: e.scale,
                              // width: e.width * 2,
                              // height: e.height * 2,
                              gaplessPlayback: true,
                            ),
                    ),
                  ),
                )))
            .toList(),
      ),
    );
  }
}
