import 'package:flutter/material.dart';
import 'package:moyawim2/Loading/loading.dart';
import 'package:moyawim2/Login_SignUp_Pages/AppIntro.dart';
import 'package:moyawim2/Login_SignUp_Pages/IntroPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  int initScreen;
//  bool firstTime;
  bool loading = true;

  check() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = prefs.getInt("initScreen");
    await prefs.setInt("initScreen", 1);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    check();
    return loading
        ? Loading()
        : initScreen == 0 || initScreen == null ? AppIntro() : intro();
  }
}
