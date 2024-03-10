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
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (result != null) {
              widget.project.imageList
                  .add(ImageProperty(path: File(result.path)));
              setState(() {});
            }
          },
          icon: Icon(Icons.add_a_photo_rounded),
        ),
      ]),
      body: Center(
        child: Stack(
          children: widget.project.imageList
              .map((e) => Positioned(
                  top: e.position.dy,
                  left: e.position.dx,
                  child: Transform.rotate(
                    angle: e.rotate,
                    child: GestureDetector(
                      onScaleUpdate: (detail) {
                        e.rotate = detail.rotation;
                        print(e.rotate); //Xoay anh
                        // e.position = Offset(e.position.dx + detail.rotation, e.position.dy + detail.delta.dy); //di chuyen anh
                        // e.scale = detail.scale;
                        // e.width = e.width * e.scale;
                        // e.height = e.height * e.scale;
                        setState(() {});
                      },
                      child: e.path is String
                          ? Image.asset(
                              (e).path,
                              // scale: e.scale,
                              width: e.width * 2,
                              height: e.height * 2,
                            )
                          : Image.file(
                              (e).path,
                              // scale: e.scale,
                              width: e.width * 2,
                              height: e.height * 2,
                            ),
                    ),
                  )
          )
          ).toList(),
        ),
      ),
    );
  }
}
