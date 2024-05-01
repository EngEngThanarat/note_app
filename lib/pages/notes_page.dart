import 'package:flutter/material.dart';
import 'package:note_app_nosql/models/note.dart';
import 'package:note_app_nosql/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // text controller or access what user typed
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // on app startup, fetch notes
    readNote();
  }

  // create a note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Create Note'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                // create button
                MaterialButton(
                  onPressed: () {
                    // add to db
                    context.read<NoteDatabase>().addNote(textController.text);

                    // clear controller
                    textController.clear();

                    // pop dialog box
                    Navigator.pop(context);
                  },
                  child: const Text("Create"),
                )
              ],
            ));
  }

  // read notes
  void readNote() {
    context.read<NoteDatabase>().fetchNotes();
  }

// search note
  void onSearchTextChanged(String searchText) {

  }

  // update note
  void updateNote(Note note) {
    // pre-fill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          // update button
          MaterialButton(
            onPressed: () {
              // update note in db
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              // clear controller
              textController.clear();
              // pop dialog box
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }

  // delete note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: onSearchTextChanged,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search notes...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.transparent))),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: currentNotes.length,
                  itemBuilder: (context, index) {
                    // get individual note
                    final note = currentNotes[index];

                    // list tile ui
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          title: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: (note.text),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    height: 1.5),
                              )),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit button
                              IconButton(
                                onPressed: () => updateNote(note),
                                icon: const Icon(Icons.edit),
                              ),

                              // Delete Button
                              IconButton(
                                  onPressed: () => deleteNote(note.id),
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
