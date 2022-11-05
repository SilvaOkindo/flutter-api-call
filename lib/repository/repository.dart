import 'package:flutter_api_call/models/todo.dart';

abstract class Repository {
  Future<List<Todo>> getTodoList();
}