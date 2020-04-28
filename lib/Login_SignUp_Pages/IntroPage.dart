import 'package:flutter/material.dart';
import 'package:moyawim2/Login_SignUp_Pages/Login_Page.dart';

import 'SignUp-Employee.dart';
import 'SignUp-employer.dart';

Widget intro() {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
        centerTitle: true,
        title: Text(
          'أنشئ حساب',
          style: TextStyle(fontSize: 26),
        ),
        bottom: TabBar(
          tabs: [
            Tab(
                child: Text(
              "الدخول",
              style: TextStyle(fontSize: 25),
            )),
            Tab(
              child: Text(
                "مياوم",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Tab(
                child: Text(
              "رب عمل",
              style: TextStyle(fontSize: 25),
            )),
          ],
        ),
      ),
      body: TabBarView(
        children: [LoginPage(), SignUpEmployee(), SignUpEmployer()],
      ),
    ),
  );
}
