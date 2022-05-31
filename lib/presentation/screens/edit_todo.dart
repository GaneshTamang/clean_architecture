import 'package:cleanarchitecture/data/model/todo.dart';
import 'package:cleanarchitecture/data/service/todo_service.dart';
import 'package:cleanarchitecture/presentation/screens/home.dart';
import 'package:flutter/material.dart';
//page and class for add icon

class EditTodoPage extends StatelessWidget {
  final int tid;
  EditTodoPage({Key? key, required this.tid}) : super(key: key);
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  TodoService service = TodoService();

  @override
  Widget build(BuildContext context) {
    //media query and  for padding always put top
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
          child: FutureBuilder<dynamic>(
            future: service.getTodoById(tid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return Form(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: snapshot.data["title"],
                        decoration: const InputDecoration(hintText: "Title"),
                        onChanged: (value) {
                          _title.text = value;
                        },
                      ),
                      SizedBox(
                        height: size.height / 90 * 2,
                      ),
                      TextFormField(
                        initialValue: snapshot.data["description"],
                        onChanged: (value) {
                          _desc.text = value;
                        },
                        decoration:
                            const InputDecoration(hintText: "Description"),
                      ),
                      SizedBox(
                        height: size.height / 90 * 2,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          TodoModel todoModel = TodoModel(
                              title: _title.text, description: _desc.text);
                          TodoService service = TodoService();
                          service.editTodo(todoModel, tid);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const HomePage(),
                            ),
                          );
                        },
                        child: const Text("Update"),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
