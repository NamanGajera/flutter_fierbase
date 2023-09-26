import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fierbase/Screens/Verify_phone_code.dart';

import '../Utils/utils.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final phonecontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 150),
              TextFormField(
                controller: phonecontroller,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: '+91 1234567890',
                ),
              ),
              const SizedBox(height: 28),
              InkWell(
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  _auth.verifyPhoneNumber(
                      phoneNumber: phonecontroller.text.toString(),
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {
                        setState(() {
                          loading = false;
                        });
                        await _auth
                            .signInWithCredential(credential)
                            .then((value) {
                          Utils().toastMessage('Login Successfully');
                        });
                      },
                      verificationFailed: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyCode(
                              VerificationId: verificationId,
                            ),
                          ),
                        );
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().toastMessage(e.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      : const Text('Login'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
