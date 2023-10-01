// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fierbase/Screens/add_post.dart';
import 'package:flutter_fierbase/Utils/Utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final Ref = FirebaseDatabase.instance.ref('Post');
  final SearchFiltercontrolle = TextEditingController();

  final EditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: SearchFiltercontrolle,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.purple,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                ),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  query: Ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child('title').value.toString();
                    if (SearchFiltercontrolle.text.isEmpty) {
                      return ListTile(
                        title: Text(
                          snapshot.child('title').value.toString(),
                        ),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text('Edit'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title,
                                        snapshot.child('id').value.toString());
                                  },
                                )),
                            PopupMenuItem(
                                value: 1,
                                onTap: () {
                                  Ref.child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                                },
                                child: const ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                )),
                          ],
                        ),
                      );
                    } else if (title.toLowerCase().contains(
                        SearchFiltercontrolle.text.toLowerCase().toString())) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text('Edit'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title,
                                        snapshot.child('id').value.toString());
                                  },
                                )),
                            const PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                )),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (Context) {
                  return const AddPost();
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    EditController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('UPDATE'),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: EditController,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Ref.child(id)
                      .update({
                        'title': EditController.text.toString(),
                      })
                      .then((value) {})
                      .onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
  }
}

// Expanded(
//               child: StreamBuilder(
//                 stream: Ref.onValue,
//                 builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                   if (snapshot.hasData) {
//                     return const CircularProgressIndicator(
//                       strokeWidth: 3,
//                     );
//                   } else {
//                     Map<dynamic, dynamic> map =
//                         snapshot.data!.snapshot.value as dynamic;
//                     List<dynamic> list = [];
//                     list.clear();
//                     list = map.values.toList();
//                     return ListView.builder(
//                         itemCount: snapshot.data?.snapshot.children.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text(list[index]['title']),
//                             subtitle: Text(list[index]['id']),
//                           );
//                         });
//                   }
//                 },
//               ),
//             ),
            