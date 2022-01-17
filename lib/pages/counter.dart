

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/pages/count_provider.dart';

class CounterClass extends StatefulWidget {
  const CounterClass({Key? key}) : super(key: key);

  @override
  _CounterClassState createState() => _CounterClassState();
}

class _CounterClassState extends State<CounterClass> {
  // int count = 0;
  //
  // void increment() {
  //   setState(() {
  //     count++;
  //   });
  //
  // }
  // void decrement() {
  //   setState(() {
  //     count--;
  //   });
  //
  // }
  @override
  Widget build(BuildContext context) {
    final CounterProvider counterProvider =Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Example"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
            counterProvider.count.toString(),style: TextStyle(fontSize: 50),
            ),
            RaisedButton(
                child: Text("Increment"),
                onPressed: counterProvider.increment,),
            RaisedButton(
              child: Text("Decrement"),
              onPressed: counterProvider.decrement,),
          ],
        ),
      ),
    );
  }
}
