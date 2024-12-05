import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/models/todo.dart';
import 'package:todo_app/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showDialog(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final TextEditingController textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textEditingController,
        ),
        actions: [
          TextButton(
              onPressed: () {
                todoCubit.addTodo(textEditingController.text);
                Navigator.pop(context);
              },
              child: const Text('Add')),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      floatingActionButton: IconButton(onPressed: () => _showDialog(context), icon: const Icon(Icons.add)),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.text),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    todoCubit.toggleCompletion(todo);
                  },
                ),
                trailing: IconButton(
                    onPressed: () {
                      todoCubit.deleteTodo(todo);
                    },
                    icon: const Icon(Icons.delete)),
              );
            },
          );
        },
      ),
    );
  }
}
