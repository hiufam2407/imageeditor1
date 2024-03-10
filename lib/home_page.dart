import 'package:flutter/material.dart';
import 'package:imageeditor/model/image_property.dart';
import 'edit_image_screen.dart';
import 'model/project.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Project> projects = [
    Project(
        name: 'Project 1', imageList: [ImageProperty(path: "assets/1.jpg")]),
    Project(name: 'Project 5', imageList: [
      ImageProperty(path: "assets/2.jpg"),
      ImageProperty(path: "assets/3.jpg")
    ]),
    // Thêm các dự án khác tại đây.
  ];

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Dữ liệu giả định cho các dự án.

    return Scaffold(
      appBar: AppBar(
          title: Text('My Projects',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          actions: [
            IconButton(
              onPressed: () {
                projects.add(
                  Project(
                      name: 'Untitle',
                      imageList: [ImageProperty(path: "assets/1.jpg")]),
                );
                setState(() {});
              },
              icon: Icon(Icons.add_box),
            ),
          ]),
      body: Container(
        color: Color(0xffF8D4D2),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/cover.webp',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Grid view các dự án
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditImageScreen(project: projects[index])),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffA6AFBA),
                      ),
                      child: ListTile(
                        title: Text(projects[index].name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _controller = TextEditingController(
                                    text: projects[index].name);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Đổi tên'),
                                      content: TextField(
                                        controller: _controller,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            projects[index].name =
                                                _controller.text.trim();
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                projects.removeAt(index);
                                setState(() {});
                              },
                              icon: Icon(Icons.remove_circle_outline_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
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
