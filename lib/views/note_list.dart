import 'package:flutter/material.dart';
// import 'package:lala_notes/inheritedWedgit/note_inherited_widget.dart';
import 'package:lala_notes/providers/note_provider.dart';

import 'add_note.dart';
// import 'note_details.dart';


class NoteListPage extends StatefulWidget {

  @override
  NoteListPageState createState() {
    return new NoteListPageState();
  }
}

class NoteListPageState extends State<NoteListPage> {
  
// List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lala & Faith Notes"),
      ),
      body: FutureBuilder(
        future: NoteProvider.getNoteList(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            final notes = snapshot.data;
      return ListView.builder(
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                // MaterialPageRoute(builder: (context) => NoteDetails()),
                MaterialPageRoute(builder: (context) => AddNote(NoteMode.Editing, notes[index]))
              );
            },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 13.0, right: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _NoteTitle(notes[index]['title']),
                _NoteText(notes[index]['text']),
              ],
            ),
          ),
         ),
        );
        },
        itemCount: notes.length,
      );
        }
      return Center(child: CircularProgressIndicator());
      },
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ 
          // debugPrint("You Click me"); 
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => AddNote(NoteMode.Adding, null)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _NoteTitle extends StatelessWidget{

final String _title;

_NoteTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
                  _title, 
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold 
                    ),
    );
  } 
}

class _NoteText extends StatelessWidget{

final String _text;

_NoteText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
                  _text, 
                  style: TextStyle(
                    color: Colors.orangeAccent,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
    );
  }
  
}
