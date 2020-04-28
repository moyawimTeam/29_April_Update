import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///D:/AndroidStudioProjects/moyawim2/moyawim2/lib/Results_Page/Search_Page.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => new _MainViewState();
}

class _MainViewState extends State<MainView> {
  Stack myJobs(String imageVal, String heading) {
    return Stack(children: <Widget>[
      InkWell(
        onTap: () {
          print("cleaning service");
        },
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: //ListTile(
                  Image.asset(imageVal, fit: BoxFit.cover),
              //title: Text(heading),
              // )
            )),
      ),
      Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.bottomCenter,
          child: Text(
            heading,
            textDirection: TextDirection.rtl, //textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17.0),
          )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: Data());
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('ابحث...',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0)),
                    SizedBox(width: 10.0),
                    Icon(Icons.search,
                        color: Colors.white,
                        size: 35.0,
                        textDirection: TextDirection.rtl)
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                padding: EdgeInsets.only(top: 17, left: 15),
                height: MediaQuery.of(context).size.height - 145,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0),
                    )),
                child: ListView(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(right: 20.0, top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "خدمات منزلية ",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ])),
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        height: 200,
                        child: ListView(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              myJobs(
                                  'assets/cleaningservices.jpg', 'عمال نظافة'),
                              myJobs('assets/plumber.jpg', 'سنغري'),
                              myJobs('assets/electrician.jpg', 'عامل الكهرباء'),
                              myJobs('assets/carpenter.jpg', 'نجارة'),
                              myJobs('assets/acfixer.jpg', 'تصليح مكيفات'),
                            ])),
                    Container(
                      child: Divider(
                        color: Colors.grey,
                        height: 30,
                        //indent: 10.0,
                        endIndent: 12.0,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 20.0, top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "خدمات صحية ",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ])),
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        height: 200,
                        child: ListView(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              myJobs(
                                  'assets/nutritionist.jpg', 'أخصاءية تغذية'),
                              myJobs('assets/TP.jpg', 'مدرب شخصي '),
                              myJobs('assets/nurse.jpg', 'ممرضة '),
                            ])),
                    Container(
                      child: Divider(
                        color: Colors.grey,
                        height: 30,
                        //indent: 10.0,
                        endIndent: 12.0,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 20.0, top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "خدمات تكنولوجية ",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ])),
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        height: 200,
                        child: ListView(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              myJobs('assets/programmer.jpg', 'أخصاءية تغذية'),
                              myJobs('assets/computerfixer.jpg', 'مدرب شخصي '),
                            ])),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
