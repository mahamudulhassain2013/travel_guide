import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'as firebase_core;
import 'package:provider/provider.dart';
import 'package:travel_guide/pages/add_travel_spot.dart';
import 'package:travel_guide/pages/count_provider.dart';
import 'package:travel_guide/pages/counter.dart';
import 'package:travel_guide/pages/crud_sir.dart';
import 'package:travel_guide/provider/travel_provider.dart';

import 'old/pages/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>CounterProvider()),
        ChangeNotifierProvider(create: (context)=>TravelProvider()),

      ],
     // create: (context)=>CounterProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green,
          hintColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),

      ),
    );
  }
}
