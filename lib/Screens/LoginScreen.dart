import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import '../Firebase_Services/splash_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SplashServices splashscreen = SplashServices();
  final emailtexteditor = TextEditingController();
  final passtexteditor = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailtexteditor,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passtexteditor,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator:
                        ValidationBuilder().required().minLength(6).build(),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {}
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
