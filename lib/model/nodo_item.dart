import 'package:flutter/material.dart';

class NoDoItem extends StatelessWidget{
  String _itemName;
  String _dateCreated;
  int _id;

  NoDoItem(this._itemName, this._dateCreated);

  NoDoItem.map(dynamic obj){
    this._itemName = obj["itemName"]; // mapping to database
    this._dateCreated = obj["dataCreated"];
    this._id = obj["id"];
  }

  String get itemName => _itemName;
  String get dateCreated => _dateCreated;
  int get id => _id;
  /*
  Mapping things back and forth so that they comply with the objects that we get from the getters
   */
  Map<String,dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["itemName"] = _itemName;
    map["dataCreated"] = _dateCreated;
    if (_id != null){
      map["id"]= _id;
    }
    return map;
  }

  NoDoItem.fromMap(Map<String,dynamic> map){
    this._itemName = map["itemName"];
    this._dateCreated = map["dataCreated"];
    this._id = map["id"];
  }


  @override
  Widget build(BuildContext context){
    return new Container(
        margin: const EdgeInsets.all(8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_itemName,
              style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.9
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text("Created on: $_dateCreated",
              style: new TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic),)
            )
          ],
        )

    );

  }




}
