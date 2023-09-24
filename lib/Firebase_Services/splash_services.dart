import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Screens/LoginScreen.dart';
import '../Screens/PostScreen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => PostScreen()),
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => LoginScreen()),
          ),
        );
      });
    }
  }
}
