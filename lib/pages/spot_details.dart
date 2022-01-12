
import 'package:flutter/material.dart';
import 'package:travel_guide/old/widgets/appbardecoration.dart';

class SpotDetails extends StatefulWidget {
  String? spotname;
  String? tdescription;
  String? timage;

  SpotDetails({this.spotname, this.tdescription, this.timage});
  @override
  _SpotDetailsState createState() => _SpotDetailsState();

}

class _SpotDetailsState extends State<SpotDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDecoration(context, "SpotDetails"),
      body: ListView(
        children: [
        ClipRRect(
          child: Image.asset("${widget.timage}"),
        ),
          Text('Spot name'),
          Text('Spot Description'),
        ],
      ),
    );
  }
}
