import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:myfirebase/screens/authen.dart';
import 'package:myfirebase/screens/home.dart';

class Login extends StatefulWidget {
  final String title;
  const Login({Key key, this.title}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: Text(""),
        //backgroundColor: Colors.pink[50],
      //),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[200],
              Colors.pink[100],
              Colors.pink[50],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 300),
                ),
                GoogleSignInButton(
                    onPressed: () => signInwithGoogle().then((value) {
                          if (value != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Homepage(),
                                ),
                                (route) => false);
                          }
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
