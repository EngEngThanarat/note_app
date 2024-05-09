import 'package:flutter/material.dart';
import 'package:note_app_nosql/models/note_database.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class EditScreen extends StatefulWidget {
  final String text;
  const EditScreen({super.key,required this.text});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _contentController = TextEditingController();
  
  //Note get note => null;

  @override
  void initState() {
      _contentController = TextEditingController(text: widget.text);
    

    super.initState();
  }

  void updateNote(Note note) {
    // pre-fill the current note text
    _contentController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Update Note"),
        content: TextField(controller: _contentController),
        actions: [
          // update button
          MaterialButton(
            onPressed: () {
              // update note in db
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, _contentController.text);
              // clear controller
              _contentController.clear();
              // pop dialog box
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 25, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ))
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListView(
              children: [
                TextField(
                  controller: _contentController,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something here',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 24,
                      )),
                ),
              ],
            ),
          ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //updateNote(note);
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.save),
      ),
    );
  }
}
