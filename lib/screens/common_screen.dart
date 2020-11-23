import 'package:HealTech/screens/donor_screen.dart';
import 'package:HealTech/screens/hospital_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId;
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      userId = auth.currentUser.uid;
    }
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          if (data["userType"] == "hospital")
            return HospitalScreen();
          else if (data["userType"] == "donor") return DonorScreen();
        }

        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
