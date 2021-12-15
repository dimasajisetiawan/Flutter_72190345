import 'dart:async';
import 'package:flutter_72190345/apiservices.dart';
import 'package:flutter_72190345/mahasiswa/updatemhs.dart';
import 'package:flutter_72190345/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_72190345/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addmhs.dart';

class Dashboardmhs extends StatefulWidget {
  const Dashboardmhs({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Dashboardmhs> createState() => _DashboardmhsState();
}

class _DashboardmhsState extends State<Dashboardmhs> {
  final _formKey = GlobalKey<FormState>();

  List<Mahasiswa> lMhs = [];

  FutureOr onGoBack(dynamic value){
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddMhs(title : "Input Data Mahasiswa")),
                ).then(onGoBack);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: ApiServices().getMahasiswa(),
          builder: (BuildContext context, AsyncSnapshot<List<Mahasiswa>?> snapshot) {
    if(snapshot.hasError){
    return Center(
    child: Text(
    "Something error : ${snapshot.error.toString()}"),
    );
    } else if (snapshot.connectionState == ConnectionState.done) {
      lMhs = snapshot.data!;
    return ListView.builder(
    itemBuilder: (context, position){
    return Card(
    margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
    child: Container(
    child: ListTile(
    title: Text(lMhs[position].nama!  + " - " + lMhs[position].nim!  ),
    subtitle: Text(lMhs[position].email!),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(lMhs[position].foto!),
      ),
      onLongPress: (){
      showDialog(context: context,
          builder: (_) => new AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpdateMhs(title:"Input Data Mahasiswa", mhs : lMhs[position], nimcari : lMhs[position].nim!)),
                  ).then(onGoBack);
                }, child: Text("Update")
                ),
                Divider(
                  color : Colors.black,
                  height: 20,
                ),
                TextButton(onPressed: () async {
                  ApiServices().deleteMhs(lMhs[position].nim!);
                  Navigator.pop(context);
                  setState(() {});
                }, child: Text("Delete")),
              ],
            ),
          ));
      },
    ),
    ),
    );
    },
    itemCount: lMhs.length,
    );
    } else {
    return Center(
    child: CircularProgressIndicator(),
    );
    }
    },
            )
    );
  }
}

