
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String Username ;
  final String Uid ;
  final String Email ;
  final String Bio ;
  final String photoUrl ;
  final List Followers ;
  final List following ;

  const User({
    required this.Username,
    required this.Uid,
    required this.Email,
    required this.Bio,
    required this.photoUrl,
    required this.Followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
    "Username" : Username,
    "Uid" : Uid,
    "Email" : Email,
    "Bio" : Bio,
    "Phototurl" : photoUrl,
    "Followers" : Followers,
    "Following" : following,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      Username: snapshot['Username'],
      Uid: snapshot['Uid'],
      Email: snapshot['Email'],
      Bio: snapshot['Bio'],
      photoUrl: snapshot['PhotoUrl'],
      Followers: snapshot['Followers'],
      following: snapshot['Following'],
    );
  }

}