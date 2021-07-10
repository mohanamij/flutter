import 'dart:io';

import 'package:blog_app/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String authorName, title, des;
  bool _isloading = false;
  TextEditingController authorNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CrudMethods crudmethods = new CrudMethods();

  // ignore: unused_field
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  uploadbtn() async {
    if (_image != null) {
      setState(() {
        _isloading = true;
      });

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child("image1").child("${randomAlphaNumeric(9)}.jpg");

      UploadTask uploadTask = ref.putFile(_image);

      var downlaodlink =
          await uploadTask.then((res) => res.ref.getDownloadURL());

      Map<String, String> map = {
        "imageURL": downlaodlink,
        "author": authorName,
        "title": title,
        "des": des,
      };
      crudmethods.addData(map).then((result) => {
            Navigator.pop(context),
          });
      print("downlaod url $downlaodlink");
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "BlogApp",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: _isloading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: _image != null
                          ? Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ))
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Column(
                      children: [
                        TextField(
                          controller: authorNameController,
                          decoration: InputDecoration(
                            hintText: "Author Name",
                            hintStyle: TextStyle(fontSize: 18),
                          ),
                          onEditingComplete: () {
                            if (authorNameController.text == "" ||
                                authorNameController.text == null) {
                              // ignore: deprecated_member_use
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Author Name can't be null"),
                                backgroundColor: Colors.redAccent,
                              ));
                            }
                          },
                          onChanged: (val) {
                            authorName = val;
                          },
                        ),
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(fontSize: 18),
                          ),
                          onEditingComplete: () {
                            if (authorNameController.text == "" ||
                                authorNameController.text == null) {
                              // ignore: deprecated_member_use
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Title Name can't be null"),
                                backgroundColor: Colors.redAccent,
                              ));
                            }
                          },
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(fontSize: 18),
                          ),
                          onEditingComplete: () {
                            if (authorNameController.text == "" ||
                                authorNameController.text == null) {
                              // ignore: deprecated_member_use
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Description Name can't be null"),
                                backgroundColor: Colors.redAccent,
                              ));
                            }
                          },
                          onChanged: (val) {
                            des = val;
                          },
                        )
                      ],
                    )),
                  ),
                  SizedBox(height: 20),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      uploadbtn();
                    },
                    child: Text(
                      "Upload",
                      style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 0.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.deepPurpleAccent,
                  )
                ],
              ),
            ),
    );
  }
}
