import 'package:cleanarchitecture/presentation/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp(appRouter: AppRouter()));
}

class TodoApp extends StatelessWidget {
  final AppRouter appRouter;
  const TodoApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo App",
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
