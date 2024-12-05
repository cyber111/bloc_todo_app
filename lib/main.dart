import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/data/models/isar_todo.dart';
import 'package:todo_app/data/repository/isar_repo_impl.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';
import 'package:todo_app/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //path
  final dir = await getApplicationCacheDirectory();
  //open db
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);
  //init repo with db
  final todoRepo = IsarTodoRepo(isar);
  //run App
  runApp(MyApp(
    todoRepo: todoRepo,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.todoRepo,
  });

  final IsarTodoRepo todoRepo;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
