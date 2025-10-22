import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  List<dynamic> post = [];
  Future fetcData() async {
    final url = Uri.parse("https://randomuser.me/api/?results=100");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print("success");
      print(jsonData["results"].length);
      final postlist = jsonData["results"] as List;
      print(postlist.length);
      setState(() {
        post = postlist;
      });

      print(post.length);
    } else {
      print("Failed");
    }
  }

  @override
  void initState() {
    super.initState();
    fetcData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("First API"), centerTitle: true),
        body: ListView.builder(
          itemCount: post.length,
          itemBuilder: (_, index) {
            final user = post[index];
            final email = user["email"];
            final name = user["name"]["first"];
            return Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Text(name),
                subtitle: Text(email),
              ),
            );
          },
        ),
      ),
    );
  }
}
