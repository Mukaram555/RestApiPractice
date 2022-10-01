import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../jsondata/JsonData.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<JsonData> listData = [];
  Future<List<JsonData>> postList()async {
    final response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        listData.add(JsonData.fromJson(i));
      }
      return listData;
    }
    else
      {
        return listData;
      }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: postList(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: listData.length,
                        itemBuilder: (context,index){
                      return Card(
                          margin: const EdgeInsets.all(10),
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green,width: 2,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ID :\n ${listData[index].id}",style: const TextStyle(color: Colors.black,),),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Title :\n ${listData[index].title}",style: const TextStyle(color: Colors.black,),),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Body :\n ${listData[index].body}",style: const TextStyle(color: Colors.black,),),
                            ],
                          ),
                        ),
                      ));
                    });
                  }
                  else{
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
