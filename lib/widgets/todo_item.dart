import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:task_list_flutter/constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo; // ToDo is a class from lib\model\todo.dart
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        onTap: () {
          //print("Tapped");
          onToDoChanged(todo);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: successColor,
        ),
        title: Text(
          todo.name!,
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            icon: const Icon(
              Icons.delete,
              color: warningColor,
            )),
      ),
    );
  }
}


/**
 * 
        subtitle: Text(
          todo.description!,
          style: TextStyle(
              color: secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
 */
