import 'package:flutter_api_call/models/todo.dart';
import 'package:flutter_api_call/repository/repository.dart';

class TodoController {
  final Repository _repository;
  TodoController(this._repository);

  Future<List<Todo>> fetchTodoList() async {

    return _repository.getTodoList();
  }
}