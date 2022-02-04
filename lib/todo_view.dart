import 'package:flutter/material.dart';
import 'package:todos_app/models.dart';

class TodosOverview extends StatelessWidget {
  final List<Todo> todos;

  const TodosOverview({Key? key,required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedTodosCount = todos.where((e) => e.completed).length;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.purple,Colors.pink, Colors.deepOrange,Colors.pink,]),
        borderRadius: BorderRadiusDirectional.circular(13.0) 
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'My Tasks',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                '~by Aditya Deshmukh',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7.0),
          Text(
            '$completedTodosCount of ${todos.length} completed',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
