import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'Post.dart';

Future<Post> fetchPost() async {
  final res = await http.get(
      Uri.encodeFull('https://jsonplaceholder.typicode.com/posts/1'),
      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  if (res.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Post.fromJson(json.decode(res.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}