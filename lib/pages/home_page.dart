import 'package:first_project/data/database.dart';
import 'package:first_project/util/dialog_box.dart';
import 'package:first_project/util/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  // refactor the hive box to a list
  final toDoBox = Hive.box('todos');
  ToDoDataBase toDoDataBase = ToDoDataBase();

  void checkBoxCallback(bool? value, int index) {
    setState(() {
      toDoDataBase.todos[index]['isCompleted'] = value;
    });

    toDoDataBase.updateTasks();
  }

  void saveNewTask() {
    setState(() {
      toDoDataBase.todos.add({
        'taskName': _controller.text,
        'isCompleted': false,
      });
    });
    _controller.clear();
    Navigator.pop(context);
    toDoDataBase.updateTasks();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCanceled: () => {
              Navigator.pop(context),
              _controller.clear(),
            },
            onSaved: saveNewTask,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      toDoDataBase.todos.removeAt(index);
    });
    toDoDataBase.updateTasks();
  }

  @override
  void initState() {
    // TODO: implement initState

    if (toDoBox.get('TODOLIST') == null) {
      toDoDataBase.createInitialData();
    } else {
      toDoDataBase.loadTasks();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        title: const Text('Todo App'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: toDoDataBase.todos[index]['taskName'],
              isCompleted: toDoDataBase.todos[index]['isCompleted'],
              onCheckboxChanged: (value) => checkBoxCallback(value, index),
              deleteTask: (context) => deleteTask(index),
            );
          },
          itemCount: toDoDataBase.todos.length),
    );
  }
}
