import 'package:cleanarchitecture/data/model/todo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TodoService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchTodo() async {
    try {
      Response response = await _dio.get("http://192.168.0.108:3000/todos");
      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
    }
    return [];
  }

  addTodo(TodoModel todoModel, BuildContext context) async {
    try {
      Map data = {
        "title": todoModel.title,
        "description": todoModel.description
      };
      Response response =
          await _dio.post("http://192.168.0.108:3000/todos", data: data);
      return response.data;
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
