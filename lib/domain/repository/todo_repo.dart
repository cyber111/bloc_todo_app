import 'package:todo_app/domain/models/todo.dart';

abstract class TodoRepo {
  //get list
  Future<List> getTodos();

  //add a new todo
  Future<void> addTodo(Todo newTodo);

  //update an existing
  Future<void> updateTodo(Todo todo);

  //delete
  Future<void> deleteTodo(Todo todo);
}
