import 'package:flutter/material.dart';

import '../components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task(
        'Aprender Flutter',
        'assets/images/flutter.webp',
        5),
    Task(
        'Aprender Java',
        'assets/images/java.png',
        2),
    Task(
        'Aprender C#',
        'assets/images/c#.webp',
        1),
    Task(
        'Aprender SQL',
        'assets/images/sql.png',
        3),
    Task(
        'Jogar',
        'assets/images/jogar.webp',
        1),
    Task(
        'Estudar inglês',
        'assets/images/ingles.png',
        1),
  ];

  void newTask(String name, String photo, int difficulty)
  {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    print((old.taskList.length != taskList.length).toString());
    return old.taskList.length != taskList.length;
  }
}
