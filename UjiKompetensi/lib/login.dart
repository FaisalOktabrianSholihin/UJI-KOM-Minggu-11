import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/register.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  registerSubmit() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text.toString().trim(),
          password: _passwordController.text);
    } catch (e) {
      print(e);
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  loginSubmit() async {
    try {
      _firebaseAuth
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())));
    } catch (e) {
      print(e);
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 40),
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Username"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Password"),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: raisedButtonStyle,
                child: Text("Login"),
                onPressed: (){
                  loginSubmit();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   height: 50,
            //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   child: ElevatedButton(
            //     style: raisedButtonStyle,
            //     child: Text("Register"),
            //     onPressed: () {
            //       registerSubmit();
            //     },
            //   ),
            // ),
            TextButton(
              child: Text("Belum memiliki akun? Register"),
              onPressed: (() => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => RegistrasiScreen()))),
            ),
          ],
        ),
      ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.grey[300],
      primary: Colors.deepOrange[300],
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))));
}
