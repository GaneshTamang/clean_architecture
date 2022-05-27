import 'package:cleanarchitecture/data/model/todo.dart';
import 'package:cleanarchitecture/data/service/todo_service.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({Key? key}) : super(key: key);
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: padding * 2.8),
          padding: EdgeInsets.symmetric(
              horizontal: padding * 0.8, vertical: padding * 0.4),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                SizedBox(
                  height: size.height / 90 * 2,
                ),
                TextFormField(
                  controller: _desc,
                  decoration: const InputDecoration(hintText: "Description"),
                ),
                SizedBox(
                  height: size.height / 90 * 2,
                ),
                ElevatedButton(
                  onPressed: () {
                    TodoModel todoModel =
                        TodoModel(title: _title.text, description: _desc.text);
                    TodoService service = TodoService();
                    service.addTodo(todoModel, context);
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
