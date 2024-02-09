//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Models/User.dart';
import '../resources/auth_methods.dart';


class UserProvider with ChangeNotifier{
  User? _user;
  final AuthMethod _authMethods = AuthMethod();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}