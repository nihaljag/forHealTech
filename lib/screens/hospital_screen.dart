import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File image;String message = "";
   _HospitalScreenState() { message = "";}
  
  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
    
    }
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    uploadFile(image.path);
  }

  String _hospitalName, _hospitalAddress, _requiredBloodGroup;

      Future<void> addRequest() {
      
      return FirebaseFirestore.instance.collection("requests")
          .add({
            'hospitalName': _hospitalName,
            'hospitalAddress': _hospitalAddress, 
            'bloodgroup': _requiredBloodGroup 
          })
          .then((value) => setState(() => message="Request Added"))
          .catchError((error) => print("Failed to add request: $error"));
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("HealTech Hospital"),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text("Logout")
                  ]),
                ),
                value: "logout",
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "logout") FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        child: ListView(
                  children: [Column(
            children: [
              RaisedButton(
                onPressed: () {
                  _imgFromGallery();
                },
                child: Text("Finger Print Identification",
                    style: TextStyle(fontSize: 25)),
                color: Colors.blue,
                padding: EdgeInsets.all(50),
              ),
              SizedBox(height: 100),
              TextFormField(
                key: ValueKey("hospitalname"),
            onChanged: (u) => _hospitalName = u,
                decoration: InputDecoration(
                    labelText: "Enter Hospital Name",
                    labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                key: ValueKey("hospitaladdress"),
            onChanged: (u) => _hospitalAddress = u,
                decoration: InputDecoration(
                    labelText: "Enter Hospital Address",
                    labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                key: ValueKey("bloodgroup"),
            onChanged: (u) => _requiredBloodGroup = u,
                decoration: InputDecoration(
                    labelText: "Enter blood group needed",
                    labelStyle: TextStyle(fontSize: 14)),
              ),
              RaisedButton(
                onPressed: addRequest,
                child: Text("Blood Donation Request",
                style: TextStyle(fontSize: 25)),
                color: Colors.blue,
                padding: EdgeInsets.all(25),
              ),
              Text(message),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),]
        ),
      ),
    );
  }
}
