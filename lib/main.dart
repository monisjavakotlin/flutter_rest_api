import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    http.Response respone = await http.get(
      Uri.encodeFull('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Accept': 'application/json'},
    );
    print(respone.body);

    data = jsonDecode(respone.body);
    for (int i = 0; i < data.length; i++) {
      print("$i : ${data[i]['title']}");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Content'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${'USERID : ${data[index]['userId']}'}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      '${'ID : ${data[index]['id']}'}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      '${'TITLE : ${data[index]['title']}'}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      '${'BODY : ${data[index]['body']}'}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API'),
      ),
      body: Center(
        child: FlatButton(
          padding: EdgeInsets.all(8.0),
          color: Colors.cyan,
          onPressed: getData,
          child: Text(
            'Get data',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }*/
}
