import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moyawim2/Authentication_services/User.dart';
import 'package:moyawim2/Authentication_services/authservice.dart';
import 'package:moyawim2/Constants_Data/Data.dart';
import 'package:moyawim2/Constants_Data/constants.dart';
import 'package:moyawim2/Loading/loading.dart';
import 'package:provider/provider.dart';

import 'UI.dart';

class SignUpEmployer extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class DataVarEmployer {
  static String firstname = '';
  static String lastname = '';
  static String phonenumber = '';
  static String description = '';
  static String city = 'غير محدد';
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<SignUpEmployer> {
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final myController = TextEditingController();
  final myControllerlast = TextEditingController();
  final customeFontSize = 20.0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  bool codeSent = false;
  String verificationId, smsCode;
  bool showError = false;
  bool loading = false;

  void setVerId(String verId) {
    verificationId = verId;
  }

  void setCodeSent() {
    setState(() {
      codeSent = true;
    });
  }

  void setSMS(val) {
    smsCode = val;
  }

  void signInWithSMS() async {
    final code = _controller.text.trim();
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    await AuthService().createEmployer(
        DataVarEmployer.firstname,
        DataVarEmployer.lastname,
        DataVarEmployer.phonenumber,
        DataVarEmployer.description,
        DataVarEmployer.city,
        credential);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    myControllerlast.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  HomePage(),
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 40),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    AssetImage('assets/Logo-Moyawem.jpeg'),
                                backgroundColor: Colors.transparent,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            width: 300,
                            child: ListView(children: <Widget>[
                              Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Card(
                                    elevation: 7,
                                    child: TextFormField(
                                      controller: myController,
                                      textInputAction: TextInputAction.done,
                                      style:
                                          TextStyle(fontSize: customeFontSize),
                                      decoration: textInputDecoration.copyWith(
                                          hintText: "ادخل الإسم الأول",
                                          labelText: " الإسم الأول",
                                          labelStyle: TextStyle(
                                              color: myFocusNode.hasFocus
                                                  ? Colors.red
                                                  : Colors.black)),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'الرجاء إدخال الإسم الأول';
                                        }
                                        return null;
                                      },
                                      onChanged: (String val) {
                                        setState(() {
                                          DataVarEmployer.firstname = val;
                                        });
                                      },
                                    ),
                                  )),
                              Card(
                                elevation: 7,
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: myControllerlast,
                                      textInputAction: TextInputAction.done,
                                      style:
                                          TextStyle(fontSize: customeFontSize),
                                      decoration: textInputDecoration.copyWith(
                                          hintText: "ادخل إسم العائلة",
                                          labelText: " إسم العائلة",
                                          labelStyle: TextStyle(
                                              color: myFocusNode.hasFocus
                                                  ? Colors.red
                                                  : Colors.black)),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'الرجاء إدخال إسم العائلة';
                                        }
                                        return null;
                                      },
                                      onChanged: (String val) {
                                        setState(() {
                                          DataVarEmployer.lastname = val;
                                        });
                                      },
                                    )),
                              ),
                              Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Card(
                                    elevation: 6.0,
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      style:
                                          TextStyle(fontSize: customeFontSize),
                                      keyboardType: TextInputType.phone,
                                      textAlign: TextAlign.right,
                                      decoration: textInputDecoration.copyWith(
                                          hintText: "ادخل رقم الهاتف",
                                          labelText: "رقم الهاتف",
                                          labelStyle: TextStyle(
                                              color: myFocusNode.hasFocus
                                                  ? Colors.red
                                                  : Colors.black)),
                                      validator: (value) {
                                        if (value.length != 8) {
                                          return 'الرجاء إدخال رقم الهاتف(8 أرقام)';
                                        }
                                        return null;
                                      },
                                      onChanged: (String val) {
                                        setState(() {
                                          DataVarEmployer.phonenumber =
                                              "+961" + val;
                                        });
                                      },
                                    ),
                                  )),
                              Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Card(
                                    elevation: 5.0,
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      style:
                                          TextStyle(fontSize: customeFontSize),
                                      decoration: textInputDecoration.copyWith(
                                          hintText: "أدخل معلومات إضافية",
                                          labelText: " التعريف",
                                          labelStyle: TextStyle(
                                              color: myFocusNode.hasFocus
                                                  ? Colors.red
                                                  : Colors.black)),
                                      onChanged: (String val) {
                                        setState(() {
                                          DataVarEmployer.description = val;
                                        });
                                      },
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 150,
                                  child: RaisedButton(
                                    color: Colors.blueAccent,
                                    onPressed: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (DataVarEmployer.city == 'غير محدد') {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'الرجاء اختيار الوظيفة',
                                                  textAlign: TextAlign.right,
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('حسنا'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      } else if (_formKey.currentState
                                          .validate()) {
                                        _controller.clear();
                                        bool alreadyRegistered =
                                            await AuthService().checkNb(
                                                DataVarEmployer.phonenumber);
                                        if (alreadyRegistered) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'هنالك حساب بهذا الرقم الرجاء تسجيل الدخول',
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('حسنا'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        } else {
                                          setState(() {
                                            loading = true;
                                          });
                                          codeSent
                                              ? await AuthService()
                                                  .signInWithOTP(
                                                      smsCode, verificationId)
                                              : await AuthService().verifyPhone(
                                                  context,
                                                  'signupEmpr',
                                                  DataVarEmployer.phonenumber,
                                                  setVerId,
                                                  setCodeSent,
                                                  DataVarEmployer.firstname,
                                                  DataVarEmployer.lastname,
                                                  '',
                                                  DataVarEmployer.city,
                                                  DataVarEmployer.description,
                                                );
                                          Timer(const Duration(seconds: 5), () {
                                            if (user == null) {
                                              setState(() {
                                                loading = false;
                                              });
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text("ادخل الرقم "),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          TextField(
                                                            controller:
                                                                _controller,
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            onChanged: setSMS,
                                                          ),
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text("تأكيد"),
                                                          textColor:
                                                              Colors.white,
                                                          color: Colors.blue,
                                                          onPressed: () {
                                                            signInWithSMS();
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {
                                                              loading = true;
                                                            });
                                                            Timer(
                                                                const Duration(
                                                                    seconds: 4),
                                                                () {
                                                              setState(() {
                                                                loading = false;
                                                                showError =
                                                                    true;
                                                              });
                                                            });
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  });
                                            }
                                          });
                                        }
                                      }
                                    },
                                    child: Text(
                                      "إنشاء حساب",
                                      style: TextStyle(
                                          fontSize: customeFontSize,
                                          color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      side:
                                          BorderSide(color: Colors.blueAccent),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        "اختر مدينة",
                                        style: TextStyle(
                                            fontSize: customeFontSize - 1),
                                      )),
                                  Container(
                                    child: DropdownButton(
                                        items: cities.map((var dropItems) {
                                          return DropdownMenuItem(
                                              value: dropItems,
                                              child: Text(dropItems));
                                        }).toList(),
                                        onChanged: (var item) {
                                          setState(() {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            DataVarEmployer.city = item;
                                          });
                                        },
                                        value: DataVarEmployer.city),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      showError
                          ? Padding(
                              padding: EdgeInsets.only(
                                right: 10,
                              ),
                              child: Text(
                                'الرجاء المحاولة مجددا و التأكد من رقم الهاتف و كلمة المرور ',
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : SizedBox(),
                    ],
                  )),
                ],
              ),
            ),
          ));
  }
}
