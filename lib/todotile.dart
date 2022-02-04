import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/add_todo.dart';
import 'package:todos_app/models.dart';
import 'package:todos_app/services.dart';
import 'package:todos_app/string_ex.dart';

class TodoTile extends StatelessWidget {
  final VoidCallback updateTodos;
  final Todo todo;

  const TodoTile({Key ? key,
    required this.updateTodos,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedTextDecoration =
        !todo.completed ? TextDecoration.none : TextDecoration.lineThrough;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ListTile(
        
        tileColor: Colors.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(13),),
        leading: const Icon(Icons.task),
        iconColor: Colors.indigo,
        key: Key(todo.id.toString()),
        title: Text(
          todo.name,
          style: TextStyle(
            fontSize: 19.0,
            decoration: completedTextDecoration,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              '${DateFormat.MMMMEEEEd().format(todo.date)} • ',
              style: TextStyle(
                height: 1.3,
                decoration: completedTextDecoration,
              ),
            ),
            const SizedBox(width:10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.5,
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                color: _getColor(),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Text(
                EnumToString.convertToString(todo.priorityLevel).capitalize(),
                style: TextStyle(
                  color: !todo.completed ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: completedTextDecoration,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: todo.completed,
          activeColor: _getColor(),
          onChanged: (value) {
            DatabaseService.instance.update(todo.copyWith(completed: value));
            updateTodos();
          },
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => AddTodoScreen(
              updateTodos: updateTodos,
              todo: todo,
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    switch (todo.priorityLevel) {
      case PriorityLevel.low:
        return Colors.purple;
      case PriorityLevel.medium:
        return Colors.indigo;
      case PriorityLevel.high:
        return Colors.green;
    }
  }
}
