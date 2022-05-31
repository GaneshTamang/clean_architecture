import 'package:cleanarchitecture/data/service/todo_service.dart';
import 'package:cleanarchitecture/presentation/screens/edit_todo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoService service = TodoService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding.top;
    service.fetchTodo();
    return RefreshIndicator(
      onRefresh: () async {
        await Future<void>.delayed(const Duration(seconds: 2));
        setState(() {
          service.fetchTodo();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Todos",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          //added  add icon with action
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green, elevation: 0),
                onPressed: () {
                  //navigated with name
                  Navigator.of(context).pushNamed("add_todo");
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: padding * 0.8),
          child: FutureBuilder<dynamic>(
              future: service.fetchTodo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: padding * 0.4, horizontal: padding * 0.8),
                        height: size.height / 90 * 13,
                        width: size.width,
                        child: Card(
                          child: ListTile(
                            title: Text(
                              snapshot.data[index]["title"],
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              snapshot.data[index]["description"],
                              textAlign: TextAlign.center,
                            ),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditTodoPage(
                                            tid: snapshot.data[index]['id']),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    TodoService todoService = TodoService();
                                    print(snapshot.data[index]['id']);
                                    todoService.deleteTodo(
                                      snapshot.data[index]["id"],
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
