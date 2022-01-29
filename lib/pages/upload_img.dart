import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  ImagePicker image = ImagePicker();
  File? file;
  String uri = "";

  Future CameraImage() async{
    var img = await image.pickImage(source: ImageSource.camera);
   setState(() {
     file = File(img!.path);
   });
  }
  Future GaleryImage() async{
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }
 Future<void> uploadFile() async {
    String ImageName = DateTime.now().microsecondsSinceEpoch.toString();
    var imagefile = FirebaseStorage.instance.ref().child(ImageName).child("/.jpg");
    UploadTask task = imagefile.putFile(file!);
    TaskSnapshot snapshot = await task;

    uri = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection("images").doc().set({"img" : uri});
    print(uri);
  }
  Future<void> deleteImage(String id,BuildContext context)async{
    await FirebaseFirestore.instance.collection('images').doc(id).delete().then((value) {
      FirebaseStorage.instance.ref().child('imageName').child(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Delete Successfully',
          )));
      // Navigator.pop(context);
    },onError: (error){
      Navigator.pop(context);
    });
  }

  Future <void> UpdateImg(String id) async {
    var imagefile = FirebaseStorage.instance.ref().child('imageName').child(id);
    TaskSnapshot snapshot = await imagefile.putFile(file!);
    /// for download the image
    uri = await snapshot.ref.getDownloadURL();
    /// store the image url into the firestore database
    await FirebaseFirestore.instance
        .collection("images")
        .doc(id)
        .set({"img": uri});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Successfully Updated',
        )));
    // print(uri);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
        centerTitle: true,
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(),
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: file == null
                ?AssetImage("images/asset/pictures/Bangladesh.jpg")
                  : FileImage(File(file!.path)) as ImageProvider,

            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      CameraImage();
                    },
                    child: Text("Camera")),
                SizedBox(width: 5,),
                ElevatedButton(
                    onPressed: () {
                      GaleryImage();
                    },
                    child: Text("Galery")),
                SizedBox(width: 5,),
                ElevatedButton(
                    onPressed: () {
                      uploadFile();
                    },
                    child: Text("Upload Image")),
              ],
            ),
          ),
          SizedBox(height: 5,),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("images").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasData) {
                return GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    primary: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index) {
                      QueryDocumentSnapshot querysnapshot = snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      View(
                                        url: querysnapshot['img'],
                                      )));

                        },
                        child: Hero(
                          tag:querysnapshot['img'],
                          child: Card(
                            child: Column(
                              children: [
                                Image.network(
                                  querysnapshot['img'],
                                  fit: BoxFit.fill,
                                ),
                                Row(
                                  children: [
                                    RaisedButton(
                                      onPressed: () async{
                                        await deleteImage(querysnapshot.id, context);
                                      },
                                      child: Text("Delete"),
                                    ),
                                    RaisedButton(
                                      onPressed: () async{
                                        await  UpdateImg(querysnapshot.id);
                                      },
                                      child: Text("Update"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                          ),
                        ),
                      );
                    }

                );

              }
              return Center(child: CircularProgressIndicator());
            },
          )


        ],
      ),
    );
  }
}


class View extends StatelessWidget {
  final url;

  View({this.url});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: url, child: Image.network(url));
  }
}
