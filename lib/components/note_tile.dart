import 'package:flutter/material.dart';
import 'package:note_app_nosql/components/note.setting.dart';
import 'package:note_app_nosql/pages/edit_page.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const NoteTile({
    super.key,
    required this.text,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(
        top: 10,
        left: 25,
        right: 25,
      ),
      child: ListTile(
        onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => EditScreen(text: text,))
                );
            },
          title: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: (text),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                    height: 1.5),
              )),
          trailing: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showPopover(
                width: 100,
                height: 100,
                backgroundColor: Theme.of(context).colorScheme.background,
                context: context,
                bodyBuilder: (context) => NoteSettings(
                  text: text,
                  onEditTap: onEditPressed,
                  onDeleteTap: onDeletePressed,
                ),
              ),
            );
          })),
    );
  }
}
