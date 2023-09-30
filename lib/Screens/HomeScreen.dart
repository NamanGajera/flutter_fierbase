// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fierbase/Screens/FireStoreScreen.dart';
import 'package:flutter_fierbase/Screens/LoginScreen.dart';
import 'package:flutter_fierbase/Screens/PostScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int SelectedIndex = 0;
  final List Pages = [
    const PostScreen(),
    const FireStoreScreen(),
  ];

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
        title: const Text('Firebase'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Pages[SelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue[400],
        elevation: 0,
        unselectedItemColor: Colors.grey,
        currentIndex: SelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            label: 'Database',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            label: 'FireStore',
          ),
        ],
        onTap: (setvalue) {
          setState(() {
            SelectedIndex = setvalue;
          });
        },
      ),
    );
  }
}
