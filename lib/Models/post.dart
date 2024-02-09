
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description ;
  final String Uid ;
  final String Username ;
  final String postId ;
  final datePublished ;
  final String postUrl ;
  final String profImage ;
  final likes;

  const Post ({
    required this.description,
    required this.Uid,
    required this.Username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
    "Username" : Username,
    "Uid" : Uid,
    "Description" : description,
    "PostId" : postId,
    "Posturl" : postUrl,
    "Profile Img" : profImage,
    "Likes" : likes,
    "Date Published" : datePublished,
  };

  static Post fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post (
      Username: snapshot['Username'],
      Uid: snapshot['Uid'],
      description: snapshot['Description'],
      profImage: snapshot['Profile Img'],
      postUrl: snapshot['PostUrl'],
      postId: snapshot['PostId'],
      likes: snapshot['Likes'],
      datePublished: snapshot['Date Published'],
    );
  }

}