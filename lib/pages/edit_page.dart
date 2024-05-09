import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String text;

  const EditScreen({super.key,required this.text,});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _contentController = TextEditingController();
  
  //Note get note => null;

  @override
  void initState() {
    if (widget.text != '') {
      _contentController = TextEditingController(text: widget.text);
    }else{

    }

    super.initState();
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
                    fontSize: 18,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something here',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      )),
                ),
              ],
            ),
          ),
          )
        ]),
      ),
/*       floatingActionButton: FloatingActionButton(
        onPressed: () {
          //updateNote(note);
        },
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.save),
      ), */
    );
  }
}
