import 'package:flutter/material.dart';
import 'package:notodo_flutter_app/model/nodo_item.dart';
import 'package:notodo_flutter_app/util/database_client.dart';
class NotoDoScreen extends StatefulWidget{
  @override
  _NotoDoScreenState createState() => _NotoDoScreenState();
}
class _NotoDoScreenState extends State<NotoDoScreen> {
  final TextEditingController _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
  final List<NoDoItem>_itemList = <NoDoItem>[];


  @override
  void initState() {
    super.initState();
    _readNoDoList();
  }

  void _handleSubmitted(String text) async{
    _textEditingController.clear();

    NoDoItem noDoItem = new NoDoItem(text,DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(noDoItem);
    NoDoItem addedItem = await db.getItem(savedItemId);
    /**
     * Set state basically says we want to redraw our screen with the updated data
     */
    setState(() {
      _itemList.insert(0, addedItem);
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
       body: new ListView.builder(
         itemCount: _itemList.length,
         reverse: false,
         padding: new EdgeInsets.all(8.0),
         itemBuilder: (context, index) {
           return new Card(
                      color: Colors.white10,
                      child: new ListTile(
                        title: _itemList[index],
                        onLongPress:() => debugPrint(""),
                        trailing: new Listener(
                          key: new Key(_itemList[index].itemName),
                          child: new Icon(Icons.delete,
                          color: Colors.redAccent,),
                          onPointerDown: (pointerEvent)=> _deleteNoDo(_itemList[index].id, index),
                        ),

                ),
                );

//           return Container(
//             padding: new EdgeInsets.all(8.0),
//             height: 50,
//             child: Text('${_itemList[index].itemName}' , style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           );
         },
//         separatorBuilder: (BuildContext context, int index) => const Divider(),
       ),



//        body:new Row(
//          children: <Widget>[
//            Expanded(
//              child: SizedBox(
//                height: 20.0,
//                child: new ListView.builder(
//                  scrollDirection: Axis.horizontal,
//                  reverse: false,
//                  itemCount: _itemList.length,
//                  itemBuilder: (BuildContext ctxt, int index) {
//                    return new Text(_itemList[index].itemName);
////                    return new Card(
////                      color: Colors.white10,
////                      child: new ListTile(
////                        title: _itemList[index],
////    //                    onLongPress:() => debugPrint(""),
////                        trailing: new Listener(
////                          key: new Key(_itemList[index].itemName),
////                          child: new Icon(Icons.delete,
////                          color: Colors.redAccent,),
////    //                      onPointerDown: (pointerEvent)=> debugPrint(""),
////                        ),
////
////                ),
////                );
//                  },
//                ),
//              ),
//            ),
//            new IconButton(
//              icon: Icon(Icons.remove_circle),
//              onPressed: () {},
//            ),
//          ],
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        ),


//      body: new Column(
//        children: <Widget>[
//          new Flexible(child: new ListView.builder(
//              padding: new EdgeInsets.all(8.0),
//              reverse: false,
////              itemCount: _itemList.length,
//              itemBuilder: (_,int index){
//                return new Card(
//                  color: Colors.white10,
//                  child: new ListTile(
//                    title: _itemList[index],
////                    onLongPress:() => debugPrint(""),
//                    trailing: new Listener(
//                      key: new Key(_itemList[index].itemName),
//                      child: new Icon(Icons.delete,
//                      color: Colors.redAccent,),
////                      onPointerDown: (pointerEvent)=> debugPrint(""),
//                    ),
//
//                ),
//                );
//
//              })),
////          new Divider(
////            height: 1.0,
////          )
//
//
//        ],
//      ),
      floatingActionButton: new FloatingActionButton(
          tooltip: "Add Item",
          backgroundColor: Colors.pinkAccent,
          child: new ListTile(
            title: new Icon(Icons.add),
          ),
          onPressed: _showFormDialog),
    );
  }


  void _showFormDialog() {
    var alert = new AlertDialog(
        content: new Row(
          children: <Widget>[
            new Expanded(child: new TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Don't buy stuff",
                  icon: new Icon(Icons.note_add)
              ),
            ))
          ],

        ),
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                _handleSubmitted(_textEditingController.text);
                _textEditingController.clear();
                Navigator.pop(context);
              },
              child: Text("Save")),
          new FlatButton(onPressed: () => Navigator.pop(context),
              child: Text("cancel"))
        ]

    );
    showDialog(context:  context,
      builder:(_){
        return alert;
    });
  }

  _readNoDoList() async {
    List items = await db.getItems();
    items.forEach((item) {
//      NoDoItem noDoItem = NoDoItem.fromMap(item);
      /**
       * Set state basically says we want to redraw our screen with the updated data
       */
      setState(() {
        _itemList.add(NoDoItem.map(item));
      });
//      print("Db items: ${noDoItem.itemName}");
    });
  }

  _deleteNoDo(int id, int index) async{
    debugPrint("Deleted Item " + id.toString() + "Index " + index.toString());
    await db.deleteItem(id);
    /**
     * Set state basically says we want to redraw our screen with the updated data
     */
    setState(() {
      _itemList.removeAt(index);
    });

  }


}

