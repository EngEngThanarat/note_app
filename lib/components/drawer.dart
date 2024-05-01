import 'package:flutter/material.dart';
import 'package:note_app_nosql/components/drawer_tile.dart';
import 'package:note_app_nosql/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(children: [
        //Header
        const DrawerHeader(
          child: Icon(Icons.note),
        ),

        // note tile
        DrawerTile(
            title: "Notes",
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pop(context)),

        // setting tile
        DrawerTile(
          title: "Setting",
          leading: const Icon(Icons.settings),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingPage(),
                ));
          },
        )
      ]),
    );
  }
}
