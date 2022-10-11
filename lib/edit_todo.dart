import 'package:flutter/material.dart';

class EditToDo extends StatelessWidget {
  final String todoText;
  const EditToDo({Key? key, required this.todoText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: todoText);

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit TODO ${todoText}"),
        ),
        body: Container(
          margin: const EdgeInsets.all(50.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: controller,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, controller.text);
                },
                child: const Text("Submit!"))
          ]),
        ));
  }
}
