import 'package:flutter/material.dart';
import 'package:todo2/edit_todo.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _listOfToDos = <String>[];

  _ToDoListState() {
    _listOfToDos.add("Si vis pacem");
    _listOfToDos.add("para bellum");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO list"),
      ),
      body: ListView(children: _getToDosListWidgets()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newToDoPopUp(context),
        tooltip: "Add new TODO",
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  List<Widget> _getToDosListWidgets() {
    // Zmieniam to na listę obiektów w formacie:
    // (id, string)
    // by móc edytować po indeksie
    return _listOfToDos
        .asMap()
        .entries
        .map((it) => Card(
                child: ListTile(
              leading: const Icon(
                Icons.task,
                color: Colors.deepPurple,
              ),
              title: Text("${it.key + 1}. ${it.value}"),
              hoverColor: Colors.cyan,
              onTap: () {
                Future<Object?> editionResult = Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EditToDo(todoText: it.value)));
                editionResult.then((value) {
                  setState(() {
                    _listOfToDos[it.key] = value as String;
                  });
                });
              },
            )))
        .toList();
  }

  Future<void> _newToDoPopUp(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("Enter new TODO"),
              content: TextField(
                controller: controller,
                autofocus: true,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _listOfToDos.add(controller.text);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Done!'),
                ),
              ],
            )));
  }
}
