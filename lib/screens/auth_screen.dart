import 'package:HealTech/widgets/auth_form.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String password, bool isLogin,
      String userType, String userBloodGroup, BuildContext ctx) async {
    var authResult;

    try {
      setState(() => _isLoading = true);
      if (isLogin) {
        final userDocs =
            await FirebaseFirestore.instance.collection('users').getDocuments();

        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection("users")
            .document(authResult.user.uid)
            .setData({
          "email": email,
          "userType": userType,
          "userBloodGroup": userBloodGroup
        });
      }
    } on PlatformException catch (err) {
      var message = "An error occured, please check your details";
      if (err.message != null) message = err.message;

      Scaffold.of(ctx).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (err) {
      print(err);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}
