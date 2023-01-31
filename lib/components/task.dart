import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/data/task_dao.dart';

import 'difficult.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome, this.foto, this.dificuldade, {Key? key})
      : super(key: key);
  int nivel = 0;
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  var listarCor = {1 : Colors.blue, 2 : Colors.green, 3 : Colors.yellow, 4 : Colors.orange, 5 : Colors.red};
  int corAtual = 1;

  bool asserOrNetwork() {
    if(widget.foto.contains('http'))
    {
      return false;
    }
    return true;
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            //color: Colors.blue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: listarCor[corAtual],
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      //color: Colors.black26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: asserOrNetwork() ? Image.asset(
                          widget.foto,
                          fit: BoxFit.cover,
                        ): 
                        Image.network(widget.foto, fit: BoxFit.cover,),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        Difficulty( dificultyLevel: widget.dificuldade,)
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onLongPress: (){
                            TaskDao().delete(widget.nome);
                          },
                          onPressed: () {
                            setState(() {
                              if(widget.nivel < widget.dificuldade * 10)
                                widget.nivel++;
                              else{
                                widget.nivel = 1;
                                corAtual < 5 ? corAtual++ : corAtual;
                              }

                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade) > 0
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nivel: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
