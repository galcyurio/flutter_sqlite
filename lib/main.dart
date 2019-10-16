import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/dog/DogRepository.dart';

import 'dog/Dog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  final TextEditingController idCtr = TextEditingController();
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController ageCtr = TextEditingController();

  final TextEditingController updateIdCtr = TextEditingController();
  final TextEditingController updateNameCtr = TextEditingController();
  final TextEditingController updateAgeCtr = TextEditingController();

  final TextEditingController deleteIdCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: Text("Print dogs"),
                  color: Colors.blueAccent,
                  onPressed: () async {
                    var dogs = await DogRepository.instance.dogs();
                    log("dogs: $dogs");
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: idCtr,
                    decoration: InputDecoration(
                      hintText: 'Enter id',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: nameCtr,
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: ageCtr,
                    decoration: InputDecoration(
                      hintText: 'Enter age',
                    ),
                  ),
                ),
                MaterialButton(
                  child: Text('Insert'),
                  color: Colors.blueAccent,
                  onPressed: () async {
                    var dog = Dog(
                        id: int.parse(idCtr.text),
                        name: nameCtr.text,
                        age: int.parse(ageCtr.text));
                    DogRepository.instance.insertDog(dog);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: updateIdCtr,
                    decoration: InputDecoration(
                      hintText: 'Enter id',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: updateNameCtr,
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: updateAgeCtr,
                    decoration: InputDecoration(
                      hintText: 'Enter age',
                    ),
                  ),
                ),
                MaterialButton(
                  child: Text('Update'),
                  color: Colors.blueAccent,
                  onPressed: () async {
                    var dog = Dog(
                        id: int.parse(updateIdCtr.text),
                        name: updateNameCtr.text,
                        age: int.parse(updateAgeCtr.text));
                    DogRepository.instance.updateDog(dog);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: deleteIdCtr,
                    decoration: InputDecoration(
                      hintText: 'Enter id',
                    ),
                  ),
                ),
                MaterialButton(
                  color: Colors.blueAccent,
                  child: Text("Delete"),
                  onPressed: () async {
                    var dogId = int.parse(deleteIdCtr.text);
                    DogRepository.instance.deleteDog(dogId);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
