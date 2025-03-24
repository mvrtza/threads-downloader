import 'package:flutter/material.dart';
import 'package:the/home.dart';
import 'package:the/second.dart';
//import 'package:the/home.dart';
//import 'package:the/second.dart';
void main() => runApp(
  const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return  Home();
  }
}
