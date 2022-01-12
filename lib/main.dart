import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart'as firebase_core;
import 'package:travel_guide/old/pages/homepage.dart';

import 'pages/crud.dart';
import 'pages/spot_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
