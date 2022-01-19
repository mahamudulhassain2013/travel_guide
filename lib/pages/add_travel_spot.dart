

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/form_decoration.dart';
import 'package:travel_guide/widgets/static_variable.dart';

class AddTravelSpot extends StatefulWidget {
  const AddTravelSpot({Key? key}) : super(key: key);

  @override
  _AddTravelSpotState createState() => _AddTravelSpotState();
}

class _AddTravelSpotState extends State<AddTravelSpot> {
  String? selectTravelSpot;
  String? selectTravelRegion;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Travel Spot"),
      ),
      body: _bodyUI(),

    );
  }

  Widget _bodyUI() {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 ),
      child: ListView(
        children: [
          ClipRRect(
            child: Image.asset("images/asset/pictures/Bangladesh.jpg"),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.image)),
            ],
          ),
          SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.text,
            decoration: FormDecoration.copyWith(
            labelText: 'Spot Name',
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3
              )
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: selectTravelRegion,
                hint: Container(
                  width: size.width*.75,
                  child: Text("Select Region",style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: size.height*0.023
                  )),
                ),
                items: StaticVariables.TravelRegion.map((selectTravelRegion){
                  return DropdownMenuItem(
                      child: Container(
                        width: size.width*.75,
                        child: Text("SelectTravelRegion",style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 16,
                        )),
                      ),
                    value: selectTravelRegion,
                  );
                }
                ).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectTravelRegion=newValue as String?;
                  });

                },
                dropdownColor: Colors.white,

              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3
                )
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: selectTravelSpot,
                hint: Container(
                  width: size.width*.75,
                  child: Text("Select Region",style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: size.height*0.023
                  )),
                ),
                items: StaticVariables.TravelRegion.map((selectTravelSpot){
                  return DropdownMenuItem(
                    child: Container(
                      width: size.width*.75,
                      child: Text(selectTravelSpot,style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 16,
                      )),
                    ),
                    value: selectTravelSpot,
                  );
                }
                ).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectTravelSpot=newValue as String?;
                  });

                },
                dropdownColor: Colors.white,

              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            maxLines: 5,
            keyboardType: TextInputType.text,
            decoration: FormDecoration.copyWith(
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),

        ],
      ),
    );
  }
}
