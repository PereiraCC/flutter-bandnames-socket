import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Imagine Dragons', votes: 5),
    Band(id: '2', name: 'Oasis', votes: 1),
    Band(id: '3', name: 'ColdPlay', votes: 9),
    Band(id: '4', name: 'Twenty-one pilots', votes: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _BandTile(band: bands[i]),
      ),
      floatingActionButton: FloatingActionButton(  
        child: Icon(Icons.add),
        onPressed: addNewBand,
        elevation: 1,
      ),
   );
  }

  addNewBand() {

    final textController = new TextEditingController();
    
    if(Platform.isAndroid) {
      return showDialog(
        context: context, 
        builder: (_) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
              )
            ],
          );
        }
      );
    }

    return showCupertinoDialog(
      context: context, 
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New band name: '),
          content: CupertinoTextField(  
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }
    );
    
  }

  void addBandToList(String name){

    print(name);
    if( name.length > 1){
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);

  }

}

class _BandTile extends StatelessWidget {

  final Band band;

  const _BandTile({
    @required this.band,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${band.id}');
       //TODO: llamar el borrado en el server
      },
      background: _BackgroundDismissible(),
      child: ListTile(
        leading: CircleAvatar(  
          child: Text(band.name.substring(0,2)),
          backgroundColor: Colors.blue[100]
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
        onTap: () => print(band.name),
      ),
    );
  }
}

class _BackgroundDismissible extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      color: Colors.red,
      child: Align( 
        alignment: Alignment.centerLeft,
        child: Text('Delete Band', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}