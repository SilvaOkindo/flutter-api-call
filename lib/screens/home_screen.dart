import 'package:flutter/material.dart';
import 'package:flutter_api_call/controllers/todo_controller.dart';
import 'package:flutter_api_call/models/todo.dart';
import 'package:flutter_api_call/repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // dependency injection
    var todoController = TodoController(TodoRepository());
    todoController.fetchTodoList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TodoList'
        ),
        elevation: 0.0,
      ),
      body: FutureBuilder<List<Todo>> (
        future: todoController.fetchTodoList(),
        builder: (_, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          return ListView.separated(
              itemBuilder: (_, index) {
                var todo = snapshot.data?[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text('${todo?.id}')),
                      Expanded(flex: 3, child: Text('${todo?.title}')),
                      Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildContainer('patch', Colors.orange.shade200),
                              buildContainer('put', Colors.purple.shade200),
                              buildContainer('del', Colors.redAccent.shade100),
                            ],
                          )
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return const Divider(
                  thickness: 0.5,
                  height: 0.5,
                );
              },
              itemCount: snapshot.data?.length ?? 0
          );
        },
      ),
    );
  }

  Container buildContainer(String title, Color color) {
    return  Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(title)),
    );
  }

}

