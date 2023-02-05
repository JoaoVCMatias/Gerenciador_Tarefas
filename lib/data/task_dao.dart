import 'package:gerenciador_tarefas/components/task.dart';
import 'package:gerenciador_tarefas/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT,'
      '$_level INTEGER,'
      '$_color INTEGER)';

  static const String _tablename = 'taskTable3';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';
  static const String _level = 'level';
  static const String _color = 'color';


   save(Task tarefa) async {
    print('INICIANDO O SAVE: ');
    final Database bancoDeDados = await getDataBase();
    var itemExists = await find(tarefa.nome);
    if (itemExists.isEmpty) {
      print('A TAREFA NÃO EXISTIA.');
      return await bancoDeDados.insert(_tablename, toMap(tarefa));
    } else {
      print('A TAREFA JÁ EXISTIA');
      return await bancoDeDados.update(_tablename, toMap(tarefa),
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('CONVERTENDO TAREFA PRA MAP');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.foto;
    mapaDeTarefas[_level] = tarefa.nivel;
    mapaDeTarefas[_color] = tarefa.color;
    print('MAPA DE TAREFAS: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print('ACESSANDO O FINDALL');
    final Database bancoDeDados = await getDataBase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('PROCURANDO DADOS NO BANCO DE DADOS... ENCONTADOS: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('CONVERTENDO TO LIST');
    final List<Task> tarefas = [];

    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty], linha[_level], linha[_color]);
      tarefas.add(tarefa);
    }
    print(' LISTA DE TAREFAS $tarefas');

    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('ACESSANDO FIND: --- $nomeDaTarefa');
    final Database bancoDeDados = await getDataBase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    print('TAREFA ENCONTRADA: ${toList(result)}');

    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('DELETANDO TAREFA');
    final Database bancoDeDados = await getDataBase();

    return bancoDeDados
        .delete(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }
}
