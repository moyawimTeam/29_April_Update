import 'package:flutter/material.dart';

import '../Authentication_services/authservice.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title test'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('Sign Out'),
          onPressed: () {
            AuthService().signOut(context);
          },
        ),
      ),
    );
  }
}
