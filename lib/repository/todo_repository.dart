import 'dart:convert';

import 'package:flutter_api_call/models/todo.dart';
import 'package:flutter_api_call/repository/repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository extends Repository {
  String dataURL = "https://jsonplaceholder.typicode.com";
  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var url = Uri.parse('$dataURL/todos');
    var response = await http.get(url);
    print('status code: ${response.statusCode}');
    var body = json.decode(response.body);
    //parse

    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

}