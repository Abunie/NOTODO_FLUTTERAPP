import 'package:flutter/material.dart';
class NotoDoScreen extends StatefulWidget{
  @override
  _NotoDoScreenState createState() => _NotoDoScreenState();
}
class _NotoDoScreenState extends State<NotoDoScreen>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: Column(),
      floatingActionButton: new FloatingActionButton(
        tooltip: "Add Item",
        backgroundColor: Colors.pinkAccent,
        child: new ListTile(
              title: new Icon(Icons.add),
        ),
        onPressed: _showFormDialog),
    );
  }
}

void _showFormDialog() {
}

