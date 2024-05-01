import 'package:flutter/material.dart';
import 'package:note_app_nosql/models/note_database.dart';
import 'package:note_app_nosql/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/notes_page.dart';

void main() async {
  // initialize note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.Initialize();

  runApp(
  MultiProvider(providers: [
    // Note Provider
    ChangeNotifierProvider(create: (context) => NoteDatabase()),

    // Theme Provider
    ChangeNotifierProvider(create: (context) => ThemeProvider())
  ],
  child: const MyApp(),
  )  
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
