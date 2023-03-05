import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:task_list_flutter/constants/colors.dart';
import 'package:task_list_flutter/widgets/todo_item.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //import from todoList from todo model
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todoList; // use the todo list in the model as default
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SearchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    for (var todo in _foundToDo)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: handleToDoChange,
                        onDeleteItem: deleteToDoItem,
                      ),
                  ],
                ))
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: secondaryColor),
                      ),
                      child: TextField(
                        controller: _todoController,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        ),
                        cursorColor: successColor,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add new task',
                            hintStyle: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: FloatingActionButton(
                      onPressed: () {
                        //print("Add");
                        addToDoItem(_todoController.text);
                      },
                      child: const Icon(Icons.add),
                      backgroundColor: successColor,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  // handle checkbox
  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  // handle delete button
  void deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((todo) => todo.id == id);
    });
  }

  // adding new task
  void addToDoItem(String todo) {
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: todo,
      ));
    });
    _todoController.clear();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(
        "to-do app".toUpperCase(),
        style: const TextStyle(
          color: primaryColor,
          fontSize: 32,
          fontWeight: FontWeight.w900,
          letterSpacing: 4,
        ),
      ),
      centerTitle: true,
    );
  }

  // implementing search
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget SearchBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        cursorColor: successColor,
        decoration: const InputDecoration(
            border: InputBorder.none,
            iconColor: primaryColor,
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: secondaryColor,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
            hintStyle: TextStyle(
              color: secondaryColor,
              fontSize: 16,
            )),
      ),
    );
  }
}
