import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moyawim2/Results_Page/Result_Profile_Widget.dart';

class ResultsPage extends StatefulWidget {
  final String city;
  final String job;
  const ResultsPage({
    this.city,
    this.job,
  });

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Widget _buildProfileWidgets(BuildContext context, DocumentSnapshot document) {
    return ProfileBar(
      name: document['name'],
      lastName: document['lastname'],
      phoneNumber: document['phone number'],
      job: document['job'],
      desc: document['description'],
      city: document['city'],
      uid: document.documentID,
      ratingNumber: document['rating']['rating number'],
      ratingValue: document['rating']['rating value'],
      inFavoriteList: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
//      appBar: PreferredSize(
//        preferredSize: Size.fromHeight(70),
//        child: AppBar(
//          backgroundColor: Colors.blueAccent,
//          leading: Padding(
//            padding: EdgeInsets.all(8),
//            child: IconButton(
//              icon: Icon(
//                Icons.search,
//                size: 35,
//              ),
//              onPressed: () {},
//            ),
//          ),
//          title: Padding(
//            padding: const EdgeInsets.only(top: 20),
//            child: TextField(
//              textAlign: TextAlign.right,
//              textDirection: TextDirection.rtl,
//              style: TextStyle(fontSize: 22),
//              decoration: InputDecoration(
//                filled: true,
//                fillColor: Colors.white,
//                hintText: ' . . . ابحث',
//                hintStyle: TextStyle(fontSize: 22),
//              ),
//            ),
//          ),
//          actions: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(top: 15),
//              child: IconButton(
//                icon: Icon(
//                  Icons.arrow_forward_ios,
//                  color: Colors.white,
//                ),
//                onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return FavoriteList();
//                  }));
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return Loading();
//                  }));
//                  Timer(Duration(milliseconds: 700), () {
//                    Navigator.pop(context);
//                  });
//                },
//              ),
//            )
//          ],
//        ),
//      ),
      body: StreamBuilder(
        stream: widget.city == 'غير محدد'
            ? Firestore.instance
                .collection('Employees')
                .where('job',
                    isEqualTo: widget.job) //TODO: Don't forget this here
                .snapshots()
            : Firestore.instance
                .collection('Employees')
                .where('city', isEqualTo: widget.city)
                .where('job', isEqualTo: widget.job)
                .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: const Text(
              "لا مياومون حاليا",
              style: TextStyle(fontSize: 50),
            ));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildProfileWidgets(context, snapshot.data.documents[index]),
            );
          }
        },
      ),
    );
  }
}
