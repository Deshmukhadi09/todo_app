import 'package:flutter/material.dart';
import 'package:todos_app/add_todo.dart';
import 'package:todos_app/services.dart';
import 'package:todos_app/todo_view.dart';
import 'package:todos_app/todotile.dart';
import 'models.dart';


class TodoListScreen extends StatefulWidget {
    const TodoListScreen({ Key? key }) : super(key: key);
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  Future<void> _getTodos() async {
    final todos = await DatabaseService.instance.getAllTodos();
    if (mounted) {
      setState(() => _todos = todos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("My Todos"),),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          itemCount: 1 + _todos.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return TodosOverview(todos: _todos);
            final todo = _todos[index - 1];
            return TodoTile(
              updateTodos: _getTodos,
              todo: todo,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => AddTodoScreen(updateTodos: _getTodos),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
