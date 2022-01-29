

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_guide/model/travel_model.dart';

class TravelProvider extends ChangeNotifier {
  TravelModel _travelModel = TravelModel();
  List<TravelModel> _travelSpotList = [];
  String? _loadingMgs;

  TravelModel get travelModel => _travelModel;

  List<TravelModel> get travelSpotList => _travelSpotList;

  String get loadingMgs => _loadingMgs!;

  set travelSpotList(List<TravelModel> value) {
    _travelSpotList = value;
    notifyListeners();
  }

  set travelModel(TravelModel value) {
    _travelModel = value;
    notifyListeners();
  }

  set loadingMgs(String val) {
    _loadingMgs = val;
    notifyListeners();
  }

// void clearFacultyList() {
//   _facultyList.clear();
//   notifyListeners();
// }
  Future<void> addTravelSpot(
      BuildContext context,
      TravelProvider travelProvider,
      TravelModel travelModel,
      File imageFile) async {
    final int timestemp = DateTime.now().millisecond;
    String id = travelModel.spotname! + timestemp.toString();
    final String submitDate = DateFormat("dd-MMM-yyyy/hh:mm:aa")
        .format(DateTime.now());

    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance.ref().child('Travel Spot Img').child(id);
    firebase_storage.UploadTask storageUploadTask = storageReference.putFile(imageFile);
    firebase_storage.TaskSnapshot taskSnapshot;
    storageUploadTask.then((value) {
      taskSnapshot = value;
      taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl) {
        final image = newImageDownloadUrl;
        FirebaseFirestore.instance.collection('travel_spots').doc(id).set({
          'id': id,
          'spotname': travelModel.spotname,
          'image': image,
          'description': travelModel.tdescription,
          'travelregion': travelModel.travelregion,
          'travelspot': travelModel.travelspot,
          'timestemp': timestemp.toString(),
          'submitDate': submitDate,
        });
        Navigator.pop(context);
      }, onError: (error) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              error.toString(),
            )));
      });
    }, onError: (error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            error.toString(),
          )));
    });
  }

  Future<void> getTravelSpot(String travelspot) async {
    try {
      await FirebaseFirestore.instance.collection('travel_spots')
          .where('travelspot', isEqualTo: travelspot).get().then((snapShot) {
        _travelSpotList.clear();
        for (var element in snapShot.docChanges) {
          TravelModel travelModels = TravelModel(
            id: element.doc['id'],
            spotname: element.doc['spotname'],
            timage: element.doc['timage'],
            tdescription: element.doc['tdescription'],
            travelregion: element.doc['travelregion'],
            travelspot: element.doc['travelspot'],
            timestemp: element.doc['timestemp'],
            submitDate: element.doc['submitDate'],
          );
          _travelSpotList.add(travelModels);
        }
      });

      notifyListeners();
      print("Length: " + _travelSpotList.length.toString());
    } catch (error) {
      'error.toString()';
    }
  }




}