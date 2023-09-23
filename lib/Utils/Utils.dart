import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red[300],
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 16.0,
    );
  }
}
