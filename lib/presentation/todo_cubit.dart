import 'package:bloc/bloc.dart';
import 'package:todo_app/domain/models/todo.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo repo;

  TodoCubit(this.repo) : super([]) {
    loadTodos();
  }

//LOAD
  Future<void> loadTodos() async {
    final todoList = await repo.getTodos();
  }

//ADD
  Future<void> addTodo(String text) async {
    await repo.addTodo(Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    ));
    loadTodos();
  }

//DELETE
  Future<void> deleteTodo(Todo todo) async {
    await repo.deleteTodo(todo);
    loadTodos();
  }

//TOGGLE
  Future<void> toggleCompletion(Todo updatedTodo) async {
    repo.updateTodo(updatedTodo.toggleCompletion());
    loadTodos();
  }
}
