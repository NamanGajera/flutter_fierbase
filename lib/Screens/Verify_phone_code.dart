// ignore_for_file: use_build_context_synchronously, must_be_immutable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fierbase/Screens/HomeScreen.dart';

import '../Utils/Utils.dart';

class VerifyCode extends StatefulWidget {
  final String VerificationId;
  const VerifyCode({
    super.key,
    required this.VerificationId,
  });

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final verifycodecontoller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: verifycodecontoller,
              decoration: const InputDecoration(
                hintText: '6 digit code',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.VerificationId,
                  smsCode: verifycodecontoller.text.toString(),
                );

                try {
                  await _auth.signInWithCredential(credential);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                }
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
                    : const Text('Verify'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
