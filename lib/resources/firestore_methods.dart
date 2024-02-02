import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_tutorial/model/post.dart';
import 'package:instagram_tutorial/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v1.dart';
class FirestoreMethods {
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  //upload post
Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
    ) async{
  String res ="Some erorr occured";
  try {
    String photoUrl = await StorageMethods().UploadImageToStorage(
        'posts', file, true);

    String postId = const Uuid().v1();
    Post post = Post(
      description: description,
      uid: uid,
      username: username,
      postId: postId,
      datePublished: DateTime.now(),
      postUrl: photoUrl,
      profImage: profImage,
      likes: [],
    );
   _firestore.collection('posts').doc(postId).set(post.toJson());
   res="success";

  } catch(err){
      res=err.toString();
      }
      return res;
}
}