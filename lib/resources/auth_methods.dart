import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_tutorial/model/user.dart' as model;
import 'package:instagram_tutorial/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails()async{
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty) {
        //register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .UploadImageToStorage('Profilepics', file, false);
        //add user to our database
        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            email: email,
            bio: bio,
            followers: [],
            following: []);

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        //another method for database with random doc id
        // await _firestore.collection('users').add({
        //   'username' : username,
        //   'uid' : cred.user!.uid,
        //   'email':email,
        //   'bio' : bio ,
        //   'followers' : [],
        //   'following' : [],
        // });
        res = "sucess";
      }
    }
    //   on FirebaseAuthException catch(err){
    //   if(err.code=='invalid-email'){
    //     res = "The Email is not correct";
    //   }
    //   else if(err.code == 'weak-password'){
    //     res = " The password is weak try again";
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //loging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
