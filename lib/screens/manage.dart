import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Manage extends StatefulWidget {
  final String docid;
  const Manage({Key key, this.docid}) : super(key: key);
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  TextEditingController _datein = TextEditingController();
  TextEditingController _dateout = TextEditingController();

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  Widget build(BuildContext context) {
    var _controller1;
    return Scaffold(
      appBar: AppBar(
        title: Text('cosmetic'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Container(
            child: TextField(
              controller: _datein,
            ),
          ),
          Container(
            child: TextField(
              controller: _dateout,
            ),
          ),
          RaisedButton(
            onPressed: () {
              updateCosmetic();
            },
            //ปุ่ม button บันทึกการแก้ไขข้อมูล
            child: Text('บันทึก'),
            color: Colors.pink,
          ),
        ],
      ),
    );
  }

  Future<void> getInfo() async {
    await FirebaseFirestore.instance
        .collection("cosmetic")
        .doc(widget.docid)
        .get()
        .then((value) {
      setState(() {
        //ค่ามันเปลี่ยนเลยต้อง setstate
        _datein = TextEditingController(text: value.data()['cos_name']);
        _dateout =
            TextEditingController(text: value.data()['price'].toString());
      });
    });
  }

  Future<void> updateCosmetic() async {
    await FirebaseFirestore.instance
        .collection("cosmetic")
        .doc(widget.docid)
        .update({
      'cos_name': _datein.text,
      'price': _dateout.text,
    }).whenComplete(() => Navigator.pop(context));
  }
}
