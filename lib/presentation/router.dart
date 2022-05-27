import 'package:flutter/material.dart';

import 'screens/add_todo.dart';
import 'screens/home.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const HomePage());
      case "add_todo":
        return MaterialPageRoute(builder: (context) => AddTodoPage());
    }
    return null;
  }
}
