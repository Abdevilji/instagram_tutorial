import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final  datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post(
      {required this.username,
        required this.uid,
        required this.postId,
        required this.datePublished,
        required this.description,
        required this.postUrl,
        required this.profImage,
      required this.likes,
      });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot["username"],
      uid: snapshot["uid"],
      postUrl: snapshot["postUrl"],
      postId: snapshot["postId"],
      description: snapshot["description"],
      profImage: snapshot["profImage"],
      likes: snapshot["likes"],
      datePublished: snapshot["datePublished"]
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "postId": postId,
    "postUrl": postUrl,
    "description": description,
    "profImage": profImage,
    "likes": likes,
    "datePublished": datePublished,
  };
}