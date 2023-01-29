import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/data/task_inherited.dart';
import 'package:gerenciador_tarefas/screens/form_screen.dart';

class InitialSceen extends StatefulWidget {
  const InitialSceen({Key? key}) : super(key: key);

  @override
  State<InitialSceen> createState() => _InitialSceenState();
}

class _InitialSceenState extends State<InitialSceen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Terefas'),
      ),
      body: ListView(
        children: TaskInherited.of(context).taskList,
        padding: EdgeInsets.only(top: 8, bottom: 70),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context,)
          )
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}