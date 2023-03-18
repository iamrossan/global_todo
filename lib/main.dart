import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todolist/Signup_page.dart';
import 'package:todolist/home_Page.dart';
import 'package:todolist/signin_page.dart';

void main() {
  runApp(MaterialApp(
    home: SignUp(),
    debugShowCheckedModeBanner: false,
  ));
}

class TOdo_List extends StatefulWidget {
  const TOdo_List({super.key});

  @override
  State<TOdo_List> createState() => _TOdo_ListState();
}

class _TOdo_ListState extends State<TOdo_List> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 3.2,
                ),
                child: ListTile(
                  title: Text(
                    "TODO-LIST",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "By Mandeep",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const LinearProgressIndicator(
                minHeight: 5,
                color: Colors.red,
                backgroundColor: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
