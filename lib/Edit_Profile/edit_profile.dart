import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moyawim2/Constants_Data/Data.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  final userId;
  final type;
  const EditProfile({
    this.userId,
    this.type,
  });
  @override
  State createState() => type == 'Employees'
      ? new EditEmployeeProfile()
      : new EditEmployerProfile();
}

class EditEmployeeProfile extends State<EditProfile> {
  File _image;
  String _databaseImage = '';
  bool imageExists = false;
  bool loading = false;
//  bool isEmpr;
  String firstname;
  String lastname;
  String desc;
  String city;
  String job;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  setValues(type) async {
    DocumentSnapshot ref =
        await Firestore.instance.collection(type).document(widget.userId).get();
    final userDoc = ref.data;
    firstname = userDoc['name'];
    lastname = userDoc['lastname'];
    desc = userDoc['description'];
    city = userDoc['city'];
    job = userDoc['job'];
  }

  Future uploadPic(BuildContext context, userID) async {
    String fileName = basename(_image.path);
    print("this is filename: $fileName");
    StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = ref.putFile(_image);
    await uploadTask.onComplete;
    String imageURL = await ref.getDownloadURL();
    Firestore.instance.collection('Images').document(userID).setData({
      'Profile': imageURL,
    });
    print(imageURL);
  }

  checkImage(userID) async {
    DocumentSnapshot ref =
        await Firestore.instance.collection('Images').document(userID).get();
    if (ref.exists) {
      setState(() {
        _databaseImage = ref.data['Profile'];
        imageExists = true;
      });
    }
  }
//
//  bool isEmpr;
//  checkIdent() async {
//    isEmpr = await DatabaseOperations(uid: widget.userId).isEmployer();
//  }

//  final identity;
//  EditEmployeeProfile({this.identity});
  @override
  void initState() {
    super.initState();
    setValues('Employees');
  }

  String val1;
  @override
  Widget build(BuildContext context) {
    checkImage(widget.userId);
//    checkIdent();
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Employees')
            .document(widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Material(
              child: Text('انتظر'),
            );
          } else {
            var userDoc = snapshot.data;
            return Scaffold(
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  backgroundColor: Colors.blueAccent,
                  centerTitle: true,
                  title: Text("تعديل الصفحة الشخصية",
                      textDirection: TextDirection.rtl),
                  leading: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      uploadPic(context, widget.userId);
                      Firestore.instance
                          .collection('Employees')
                          .document(widget.userId)
                          .updateData({
                        'name': firstname,
                        'lastname': lastname,
                        'description': desc,
                        'city': city,
                        'job': job,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: FutureBuilder(
                          builder: (context, snapshot) => Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                _image == null
                                    ? CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(imageExists
                                            ? _databaseImage
                                            : 'https://images.macrumors.com/t/XjzsIpBxeGphVqiWDqCzjDgY4Ck=/800x0/article-new/2019/04/guest-user-250x250.jpg'),
                                        backgroundColor: Colors.transparent,
                                      )
                                    : CircleAvatar(
                                        radius: 60,
                                        backgroundImage: FileImage(_image),
                                        backgroundColor: Colors.transparent,
                                      ),
                                IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "تعديل الصورة",
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                      SizedBox(height: 10),
                      ListView(shrinkWrap: true, children: <Widget>[
                        InputInfo(
                          initialValue: userDoc['name'],
                          hint: 'الاسم',
                          fun: (String val) {
                            setState(() {
                              firstname = val;
                            });
                          },
                          valid: (value) {
                            if (value.length == 0) {
                              return 'الرجاء إدخال رقم الهاتف(8 أرقام)';
                            }
                            return null;
                          },
                        ),
                        InputInfo(
                          initialValue: userDoc['lastname'],
                          hint: 'الشهرة',
                          fun: (val) {
                            setState(() {
                              lastname = val;
                            });
                          },
                          valid: (value) {
                            if (value.length == 0) {
                              return 'الرجاء إدخال رقم الهاتف(8 أرقام)';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DropdownButton(
                                  items: jobsList.map((var dropItems) {
                                    return DropdownMenuItem(
                                        value: dropItems,
                                        child: Text(dropItems));
                                  }).toList(),
                                  onChanged: (var item) {
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      job = item;
                                    });
                                  },
                                  value: job),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DropdownButton(
                                  items: cities.map((var dropItems) {
                                    return DropdownMenuItem(
                                        value: dropItems,
                                        child: Text(dropItems));
                                  }).toList(),
                                  onChanged: (var item) {
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      city = item;
                                    });
                                  },
                                  value: city),
                            ],
                          ),
                        ),
                        InputInfo(
                          initialValue: userDoc['description'],
                          hint: 'التعريف',
                          fun: (val) {
                            setState(() {
                              desc = val;
                            });
                          },
                          valid: (value) {
                            if (value.length == 0) {
                              return 'الرجاء إدخال رقم الهاتف(8 أرقام)';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.add_a_photo),
                                    onPressed: () {},
                                  ),
                                  Text("هل لديك صور لأعمالك؟ أضفها"),
                                ])),
                      ])
                    ]));
          }
        });
  }
}

class InputInfo extends StatelessWidget {
  const InputInfo({
    Key key,
    @required this.initialValue,
    @required this.hint,
    @required this.fun,
    @required this.valid,
  }) : super(key: key);

  final initialValue;
  final hint;
  final Function fun;
  final Function valid;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextFormField(
            validator: valid,
            onChanged: fun,
            initialValue: initialValue,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey))));
  }
}

class EditEmployerProfile extends State<EditProfile> {
  File _image;
  String _databaseImage = '';
  bool imageExists = false;
  bool loading = false;

  String firstname;
  String lastname;
  String desc;
  String city;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  setValues(type) async {
    DocumentSnapshot ref =
        await Firestore.instance.collection(type).document(widget.userId).get();
    final userDoc = ref.data;
    firstname = userDoc['name'];
    lastname = userDoc['lastname'];
    desc = userDoc['description'];
    city = userDoc['city'];
  }

  Future uploadPic(BuildContext context, userID) async {
    String fileName = basename(_image.path);
    print("this is filename: $fileName");
    StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = ref.putFile(_image);
    await uploadTask.onComplete;
    String imageURL = await ref.getDownloadURL();
    Firestore.instance.collection('Images').document(userID).setData({
      'Profile': imageURL,
    });
    print(imageURL);
  }

  checkImage(userID) async {
    DocumentSnapshot ref =
        await Firestore.instance.collection('Images').document(userID).get();
    if (ref.exists) {
      setState(() {
        _databaseImage = ref.data['Profile'];
        imageExists = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setValues('Employers');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Employers')
            .document(widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          var userDoc = snapshot.data;
          return Scaffold(
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                backgroundColor: Colors.blueAccent,
                centerTitle: true,
                title: Text("تعديل الصفحة الشخصية",
                    textDirection: TextDirection.rtl),
                leading: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    uploadPic(context, widget.userId);
                    Firestore.instance
                        .collection('Employers')
                        .document(widget.userId)
                        .updateData({
                      'name': firstname,
                      'lastname': lastname,
                      'description': desc,
                      'city': city,
                    });
                    Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          _image == null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(imageExists
                                      ? _databaseImage
                                      : 'https://images.macrumors.com/t/XjzsIpBxeGphVqiWDqCzjDgY4Ck=/800x0/article-new/2019/04/guest-user-250x250.jpg'),
                                  backgroundColor: Colors.transparent,
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(_image),
                                  backgroundColor: Colors.transparent,
                                ),
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "تعديل الصورة",
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                    SizedBox(height: 10),
                    ListView(shrinkWrap: true, children: <Widget>[
                      InputInfo(
                        initialValue: userDoc['name'],
                        hint: 'الاسم',
                        fun: (String val) {
                          setState(() {
                            firstname = val;
                          });
                        },
                        valid: (value) {
                          if (value.length == 0) {
                            return 'الرجاء إدخال الاسم';
                          }
                          return null;
                        },
                      ),
                      InputInfo(
                        initialValue: userDoc['lastname'],
                        hint: 'الشهرة',
                        fun: (String val) {
                          setState(() {
                            lastname = val;
                          });
                        },
                        valid: (value) {
                          if (value.length == 0) {
                            return 'الرجاء إدخال الشهرة';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton(
                                items: cities.map((var dropItems) {
                                  return DropdownMenuItem(
                                      value: dropItems, child: Text(dropItems));
                                }).toList(),
                                onChanged: (var item) {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    city = item;
                                  });
                                },
                                value: city),
                          ],
                        ),
                      ),
                      InputInfo(
                        initialValue: userDoc['description'],
                        hint: 'التعريف',
                        fun: (String val) {
                          setState(() {
                            desc = val;
                          });
                        },
                        valid: (value) {
                          if (value.length == 0) {
                            return 'الرجاء إدخال التعريف';
                          }
                          return null;
                        },
                      ),
                    ])
                  ]));
        });
  }
}
