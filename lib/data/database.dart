import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todos = [];

  final toDoBox = Hive.box('todos');

  // Initialize the database with some initial data
  void createInitialData() {
    todos = [
      {'taskName': 'Drink water', 'isCompleted': false},
      {'taskName': 'Go for a walk', 'isCompleted': false},
      {'taskName': 'Read a book', 'isCompleted': false},
      {'taskName': 'Do some exercise', 'isCompleted': false},
      {'taskName': 'Meditate', 'isCompleted': false},
    ];
  }

  // Load the tasks from the database
  void loadTasks() {
    todos = toDoBox.get("TODOLIST");
  }

  // Update the task
  void updateTasks() {
    toDoBox.put('TODOLIST', todos);
  }
}
