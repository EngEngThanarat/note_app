import 'package:flutter/material.dart';
import 'package:note_app_nosql/components/drawer.dart';
import 'package:note_app_nosql/models/note.dart';
import 'package:note_app_nosql/models/note_database.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
  void onSearchTextChanged(String searchText) {}

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADING
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text('Notes',style: GoogleFonts.dmSerifText(
              fontSize: 48,
              color: Theme.of(context).colorScheme.inversePrimary,
            )),
          ),

          // Search Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.inversePrimary),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  hintText: "Search notes...",
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent))),
            ),
          ),

          // LIST OF NOTES
          Expanded(
            child: ListView.builder(
/*                 padding: const EdgeInsets.only(top: 20), */
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  // get individual note
                  final note = currentNotes[index];
            
                  // list tile ui
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        title: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: (note.text),
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.inversePrimary, fontSize: 16, height: 1.5),
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
                }),
          ),
        ],
      ),
    );
  }
}
