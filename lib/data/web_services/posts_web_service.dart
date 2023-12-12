import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PostsWebService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String endpoint = '/posts';
  static const pagesLimit = 10;

  Future<List<dynamic>> getPosts(int page) async {
    try {
      final response = await Dio().get(
        '$baseUrl$endpoint?_limit=$pagesLimit&_page=$page',
      );
      // debugPrint("PostsWebService Data: ${response.data}");
      return response.data as List<dynamic>;
    } catch (e) {
      debugPrint("PostsWebService Error: $e");
      return [];
    }
  }
}
