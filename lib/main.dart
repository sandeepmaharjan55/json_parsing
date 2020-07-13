import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJSON();
  // print(_data[0]);
  print(_data[0]["body"]);
  for (var i = 0; i < _data.length; i++) {
    print("Title: ${_data[i]["title"]}");
  }
  runApp(new MaterialApp(
      home: new Scaffold(
    appBar: AppBar(
      title: Text("JSON Parsing"),
      backgroundColor: Colors.orangeAccent,
    ),
    body: Center(child: Text(_data[0]["body"])),
  )));
}

Future<List> getJSON() async {
  String apiURL = "http://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(apiURL);
  return json.decode(response.body);
}
