import 'package:flutter/material.dart';

class ContactUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.pinkAccent],
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
//              Container(color: Colors.yellow, alignment: Alignment.bottomCenter, margin: EdgeInsets.only(top: height*0.6),),
          Center(child: message(context)),
        ],
      ),
    );
  }

  Widget message(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView(
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.fromLTRB(width * 0.2, height * 0.1, width * 0.2, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.grey.shade100,
          ),
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(0, 5, 10, 3),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "تواصل معنا",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: 50.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  style: TextStyle(fontSize: 17),
                  keyboardType: TextInputType.multiline,
                  maxLines: 20,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: "أكتب تعليقاتك هنا",
                  ),
                ),
              ),
            ),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("إلغاء", style: TextStyle(fontSize: 20)),
              color: Colors.blueAccent.shade100,
            ),
            SizedBox(
              width: 30,
            ),
// -------------------------- AHMED ADD the navigator HERE instead of NULL -------------------
            RaisedButton(
              onPressed: null,
              child: Text(
                "إرسال",
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.blueAccent.shade100,
            )
          ],
        )
      ],
    );
  }
}
