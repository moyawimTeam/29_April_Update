import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moyawim2/Loading/loading.dart';
import 'package:path/path.dart';

class ImageTest extends StatefulWidget {
  @override
  _ImageTestState createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  File _image;
  bool loading = false;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    print("this is filename: $fileName");
    StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = ref.putFile(_image);
//    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    await uploadTask.onComplete;
    String test = await ref.getDownloadURL();
    print(test);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Image trial'),
              backgroundColor: Colors.blueAccent,
            ),
            body: FutureBuilder(
              builder: (context, snapshot) => Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image == null
                        ? CircleAvatar(
                            radius: 130,
                            backgroundImage: NetworkImage(
                                'https://dyl80ryjxr1ke.cloudfront.net/external_assets/hero_examples/hair_beach_v1785392215/original.jpeg'),
                            backgroundColor: Colors.transparent,
                          )
                        : CircleAvatar(
                            radius: 130,
                            backgroundImage: FileImage(_image),
                            backgroundColor: Colors.transparent,
                          ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        size: 50,
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.file_upload),
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        uploadPic(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
