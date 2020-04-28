import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:moyawim2/Constants_Data/Data.dart';

class PopUP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<PopUP> {
  String city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Directionality(
            child: Text(
              "فلتر نسبة إلى",
              textDirection: TextDirection.rtl,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: getListView(context),
        ));
  }

  //----------------Change here where is commented to do so
  Widget getListView(BuildContext context) {
    return ListView.builder(
//      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        String post = filterList[index];
        return Card(
          elevation: 4.0,
          child: ListTile(
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios),
            ),
            title: Text(post),
            onTap: () {
              popUpDialog1(context, post).then((value) => city = value);
              Navigator.of(context).pop(city);
            },
          ),
        );
      },
      itemCount: filterList.length,
    );
  }

  //-------------- Pop up CODE DONT CHANGE IT

  Future<String> popUpDialog1(BuildContext context, String post) {
    TextEditingController _controller = TextEditingController();
    return showDialog(
        context: context,
        // ignore: missing_return
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.grey.shade100,
            title: Text(
              post,
              textAlign: TextAlign.center,
            ),
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _controller,
                autofocus: true,
                style: TextStyle(fontSize: 19.0),
                keyboardType: (post == "الخبرة")
                    ? TextInputType.number
                    : TextInputType.text,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red.shade500),
                    hintText: " ادخل $post",
                    labelText: " فلتر حسب $post"),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                textColor: Colors.white,
                child: Text("إلغاء"),
                onPressed: () => Navigator.of(context).pop(),
                elevation: 5.0,
                color: Colors.blue.shade400,
              ),
              MaterialButton(
                textColor: Colors.white,
                child: Text("فلتر"),
                onPressed: () =>
                    Navigator.of(context).pop(_controller.text.toString()),
                elevation: 5.0,
                color: Colors.blue.shade400,
              ),
            ],
          );
        });
  }
}
