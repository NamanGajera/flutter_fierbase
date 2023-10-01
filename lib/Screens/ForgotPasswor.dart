import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fierbase/Screens/LoginScreen.dart';

import '../Utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  final emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth
                    .sendPasswordResetEmail(
                        email: emailcontroller.text.toString())
                    .then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('Email Send Check Your Emails');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Forgot',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
