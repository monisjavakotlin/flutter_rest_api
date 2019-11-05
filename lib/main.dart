import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    setState(() {
      data = jsonDecode(response.body);
    });

    print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Lists"), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'USERID : ${data[index]["userId"]}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'ID : ${data[index]["id"]}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'TITLE : ${data[index]["title"]}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'BODY : ${data[index]["body"]}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
