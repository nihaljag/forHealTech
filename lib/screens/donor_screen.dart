// import "package:flutter/material.dart";
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'MapAlert.dart';

// class DonorScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference request =
//         FirebaseFirestore.instance.collection('requests');
//     return FutureBuilder<DocumentSnapshot>(
//       future: request.doc("anbvPI8oSHXta5LhIhi0").get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data.data();
//           return Scaffold(
//               appBar: AppBar(
//                 title: Text("HealTech Donor"),
//                 actions: [
//                   DropdownButton(
//                     items: [
//                       DropdownMenuItem(
//                         child: Container(
//                           child: Row(children: [
//                             Icon(Icons.exit_to_app),
//                             SizedBox(width: 8),
//                             Text("Logout")
//                           ]),
//                         ),
//                         value: "logout",
//                       )
//                     ],
//                     onChanged: (itemIdentifier) {
//                       if (itemIdentifier == "logout")
//                         FirebaseAuth.instance.signOut();
//                     },
//                     icon: Icon(
//                       Icons.more_vert,
//                       color: Theme.of(context).primaryIconTheme.color,
//                     ),
//                   ),
//                 ],
//               ),
//               body: Container(
//                 margin: EdgeInsets.all(12),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Container(
//                       height: 200,
//                       child: Card(
//                         elevation: 5,
//                         color: Colors.black54,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     data["hospitalName"],
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                         decoration: TextDecoration.underline),
//                                   ),
//                                   Text(
//                                     data["hospitalAddress"],
//                                     style: TextStyle(
//                                         fontSize: 18, color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       "Blood Group ",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       data["bloodgroup"],
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 24,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     RaisedButton(
//                                       elevation: 5,
//                                       onPressed: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     MapAlert()));
//                                       },
//                                       child: Text("Accept"),
//                                       color: Colors.green,
//                                     ),
//                                     FlatButton(
//                                       onPressed: () {
//                                         FirebaseAuth.instance.signOut();
//                                       },
//                                       child: Text("Deny"),
//                                       color: Colors.red,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Image.asset("assets/donor tc.jpg"),
//                     RaisedButton(
//                       child: Icon(Icons.map),
//                       onPressed: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => MapAlert()),
//                         )
//                       },
//                     )
//                   ],
//                 ),
//               ));
//         }

//         return Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }

import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'MapAlert.dart';

class DonorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference request =
        FirebaseFirestore.instance.collection('requests');
    return StreamBuilder<QuerySnapshot>(
      stream: request.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState != ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                title: Text("HealTech Donor"),
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
                      if (itemIdentifier == "logout")
                        FirebaseAuth.instance.signOut();
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                              child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    
                    children: [
                      ListView.builder(shrinkWrap: true,itemCount: snapshot.data.docs.length,itemBuilder: (ctx, i) {
                       return Container(
                          height: 200,
                          child: Card(
                            elevation: 5,
                            color: Colors.black54,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data.docs[i]["hospitalName"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                            decoration: TextDecoration.underline),
                                      ),
                                      Text(
                                        snapshot.data.docs[i]["hospitalAddress"],
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                            
                                            
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Blood Group ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          snapshot.data.docs[i]["bloodgroup"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        RaisedButton(
                                          elevation: 5,
                                          onPressed: () {
                                            request.doc(snapshot.data.docs[i].id).delete();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MapAlert()));
                                          },
                                          child: Text("Accept"),
                                          color: Colors.green,
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                          },
                                          child: Text("Deny"),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      Image.asset("assets/donor tc.jpg", ),
                      RaisedButton(
                        child: Icon(Icons.map),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapAlert()),
                          )
                        },
                      )
                    ],
                  ),
              ),
              );
        }
        else

        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
