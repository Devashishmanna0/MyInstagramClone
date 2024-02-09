import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Models/User.dart' as model;
import 'package:instagram/resources/storage_methods.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  //sign up
  Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file!= null){
       // register user
       UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       print(cred.user!.uid);

       String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

       // add user to our database

       model.User user = model.User(
         Username: username,
         Uid: cred.user!.uid,
         Email: email,
         Bio: bio,
         photoUrl : photoUrl,
         Followers: [],
         following: [],
       );
       await _firestore.collection('User').doc(cred.user!.uid).set(user.toJson());

     /*await _firestore.collection('User').doc(cred.user!.uid).set({
         'Username': username,
         'Uid': cred.user!.uid,
         'Email': email,
         'Bio': bio,
         'Followers': [],
         'following': [],
         'photoUrl' : photoUrl,
       });*/

       /*await _firestore.collection('users').add({
         'Username': username,
         'Uid': cred.user!.uid,
         'Email': email,
         'Bio': bio,
         'Followers': [],
         'following': []
       });*/
       
       res = "Success";
      }
    } /*on FirebaseAuthException catch(err) {
      if(err.code == 'invalid-email'){
        res = 'The Email is badly formatted' ;
      } else if(err.code == 'weak-password'){
        res = 'Password should be atleast 6 characters';
      }
    }*/

    catch(err){
      res = err.toString();
    }
    return res;
  }

//logging in user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
   String res = "Some error Occurred";

   try {
     if (email.isNotEmpty || password.isNotEmpty) {
       await _auth.signInWithEmailAndPassword(email: email, password: password);
       res = "Success";
     } else {
       res = "Please enter all the Fields";
     }

   }
   catch(err) {
        res = err.toString();
    }
    return res;
   }

   Future<void> signOut() async {
    await _auth.signOut();
   }
}