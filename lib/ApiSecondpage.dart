import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Apisecondpage extends StatefulWidget {
  const Apisecondpage({super.key});

  @override
  State<Apisecondpage> createState() => _ApisecondpageState();
}

class _ApisecondpageState extends State<Apisecondpage> {



  List<dynamic>users=[];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Call"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers,
        child: Text("Click"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: users.length,
            itemBuilder: (context,index){
            final user=users[index];
            final email=user["email"];
            final name=user["name"]["first"];
            final image=user["picture"]["thumbnail"];
          return Card(
            elevation: 2,
            child: ListTile(
              leading: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(image,fit: BoxFit.cover,),
                ),
              ),
              title: Text(name),
              subtitle: Text(email),
            ),
          );
        }),
      )
    );
  }
  void fetchUsers()async{
    //print("fetchuseer");
    const url="https://randomuser.me/api/?results=200";
    final uri=Uri.parse(url);
      final response= await http.get(uri);
      final body=response.body;
      final json= jsonDecode(body);
      setState(() {
        users=json["results"];
      });
      print("success");
  }
}
