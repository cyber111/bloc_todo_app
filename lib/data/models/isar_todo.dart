import 'package:isar/isar.dart';
import 'package:todo_app/domain/models/todo.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  //convert isar to domain [domain to data]
  Todo toDomain() {
    return Todo(id: id, text: text);
  }

  static fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}