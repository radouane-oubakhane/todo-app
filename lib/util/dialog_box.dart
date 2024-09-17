import 'package:first_project/util/button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSaved;
  final VoidCallback onCanceled;

  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSaved,
      required this.onCanceled});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: 'Enter Task Name',
                border: OutlineInputBorder(),
                // change the border color
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                )),
          ),
          Row(
            // add some space between the buttons
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const SizedBox(height: 16),
              Button(text: 'Create', onPressed: onSaved),
              const SizedBox(width: 16),
              Button(text: 'Cancel', onPressed: onCanceled, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
