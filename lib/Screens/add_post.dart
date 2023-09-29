import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Utils/utils.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 120),
            TextFormField(
              controller: postcontroller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What is in your mind?',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.purple,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                setState(() {
                  loading = true;
                });
                databaseRef
                    .child(DateTime.now().millisecondsSinceEpoch.toString())
                    .set({
                  'title': postcontroller.text.toString(),
                  'id': DateTime.now().millisecondsSinceEpoch.toString()
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('Post Added');
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      )
                    : const Text('Add'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
