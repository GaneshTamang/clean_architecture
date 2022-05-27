import 'package:flutter/material.dart';

import 'screens/home.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
    return null;
  }
}
