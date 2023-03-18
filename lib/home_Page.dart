import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  DateTime? selectDate;

  final _emailTextController = TextEditingController();

  List<Todo> todos = [];

  String todo = "";
  List<Widget> getTodos() {
    List<Widget> todo = [];
    for (int i = 0; i < todos.length; i++) {
      int todoId = i + 1;

      var listtile = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: ListTile(
            enabled: todos[i].isCompleted ? false : true,
            trailing: Switch(
              value: todos[i].isCompleted,
              onChanged: (newValue) {
                setState(() {
                  todos[i].isCompleted = newValue;
                  Timer(
                    const Duration(milliseconds: 700),
                    () {
                      setState(() {
                        if (todos[i].isCompleted) {
                          todos.add(todos[i]);
                          todos.removeAt(i);
                        } else {
                          todos.insert(0, todos[i]);
                          todos.removeAt(i + 1);
                        }
                      });
                    },
                  );
                });
              },
            ),
            leading: CircleAvatar(
              child: Text(todoId.toString()),
            ),
            title: Text(todos[i].todo),
            subtitle: Text("${todos[i].date}"),
          ),
        ),
      );
      todo.add(listtile);
    }
    return todo;
  }

  void addToDo({required DateTime date, required String todo}) {
    setState(() {
      todos.add(Todo(date: date, todo: todo, isCompleted: false));
    });
  }

  Future<void> datePicker(context) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectDate = pickedDate;
      });
    });
  }

  Future<void> _show(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: Text("Set Task"),
              content: Expanded(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                    onChanged: (value) {
                      todo = value;
                    },
                    controller: _emailTextController,
                    decoration: InputDecoration(
                        hintText: " New Task",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 60.0,
                    width: 230.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                            offset: Offset(1.0, 1.0),
                          )
                        ]),
                    child: ListTile(
                      trailing: GestureDetector(
                        onTap: () async {
                          await datePicker(context);
                          setState(() {});
                        },
                        child: Icon(
                          Icons.calendar_month,
                          color: Color.fromARGB(255, 83, 12, 88),
                        ),
                      ),
                      title: Text(
                        (selectDate != null
                            ? selectDate.toString()
                            : 'No date Selected'),
                      ),
                    ),
                  ),
                ]),
              ),
              // ),
              actions: [
                TextButton(
                    onPressed: () {
                      addToDo(date: selectDate!, todo: todo);
                      _emailTextController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text("OK")),
                TextButton(
                    onPressed: (() => Navigator.of(context).pop()),
                    child: Text("CLOSE")),
              ],
            );
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.window_outlined,
          color: Colors.blue,
        ),
        centerTitle: true,
        title: Text(
          "All Tasks",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: getTodos(),
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _show(context),
          backgroundColor: Color.fromARGB(255, 112, 2, 132),
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
// class className{

// }
class Todo {
  String todo;
  DateTime date;
  bool isCompleted;
  Todo({required this.todo, required this.date, required this.isCompleted});
}
