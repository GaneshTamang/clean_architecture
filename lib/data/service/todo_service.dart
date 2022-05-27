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

  addTodo(TodoModel todoModel) async {
    try {
      var data = {
        "title": todoModel.title,
        "description": todoModel.description
      };
      Response response =
          await _dio.post("http://192.168.0.108:3000/todos", data: data);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
