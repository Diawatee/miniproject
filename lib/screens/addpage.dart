import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _datein = TextEditingController();
  TextEditingController _dateout = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future<void> chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มข้อมูลสินค้า'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              child: RaisedButton(
                onPressed: () {
                  chooseImage();
                },
                child: Text('เลือกรูป'),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: _image == null ? Text('no image') : Image.file(_image),
            ),
            Container(
              width: 200,
              child: TextField(
                controller: _datein,
                decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
              ),
            ),
            Container(
              width: 200,
              child: TextField(
                controller: _dateout,
                decoration: InputDecoration(labelText: 'ราคา'),
              ),
            ),
            RaisedButton(
              onPressed: () {
                addCosmetic();
              },
              //ปุ่ม button บันทึกการแก้ไขข้อมูล
              child: Text('UPLOAD'),
              color: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addCosmetic() async {
    String fileName = Path.basename(_image.path);
    StorageReference reference =
        FirebaseStorage.instance.ref().child('$fileName');
    StorageUploadTask storageUploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((value) async {
      await FirebaseFirestore.instance.collection('cosmetic').add({
        'cos_name': _datein.text,
        'price': _dateout.text,
        'img': value,
      }).whenComplete(() => Navigator.pop(context));
    });
  }
}
