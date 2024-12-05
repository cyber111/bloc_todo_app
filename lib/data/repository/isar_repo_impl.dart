import 'package:isar/isar.dart';
import 'package:todo_app/data/models/isar_todo.dart';
import 'package:todo_app/domain/models/todo.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future<void> addTodo(Todo newTodo) {
    final todo = TodoIsar.fromDomain(newTodo);
    return db.writeTxn(() => db.todoIsars.put(todo));
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return db.writeTxn(() => db.todoIsars.delete(todo.id));
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todos = await db.todoIsars.where().findAll();
    return todos.map((todo) => todo.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) {
    final isarTodo = TodoIsar.fromDomain(todo);
    return db.writeTxn(() => db.todoIsars.put(isarTodo));
  }
}
