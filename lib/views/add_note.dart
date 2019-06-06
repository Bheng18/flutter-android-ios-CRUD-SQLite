import 'package:flutter/material.dart';
import 'package:lala_notes/providers/note_provider.dart';
import 'package:lala_notes/inheritedWedgit/note_inherited_widget.dart';

enum NoteMode{
  Editing,
  Adding
}

class AddNote extends StatefulWidget{

final NoteMode noteMode;
// final int index;//for fix dummy data
final Map<String, dynamic> note;

AddNote(this.noteMode, this.note); //this.index

  @override
  AddNoteState createState() {
    return new AddNoteState();
  }

}

class AddNoteState extends State<AddNote>{

final TextEditingController _titleController = TextEditingController();
final TextEditingController _textController = TextEditingController();

List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

 @override
  void didChangeDependencies() {
    if (widget.noteMode == NoteMode.Editing) {
      _titleController.text = widget.note['title']; //_notes[widget.index]['title']
      _textController.text = widget.note['text']; //_notes[widget.index]['title']
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
             widget.noteMode == NoteMode.Adding ? "Add Note" : "Edit Note",
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Note Title'
            ),
          ),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Note text'
            ),
          ),
          Container(height: 10,), //space up and down
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               _NoteButton('Save', Colors.blue, (){
                   final title = _titleController.text;
                   final text = _textController.text;

                 if(widget?.noteMode == NoteMode.Adding){
                  //  _notes.add({
                  NoteProvider.insertNote({
                     "title": title,
                     "text": text,
                   });
                 }else if(widget?.noteMode == NoteMode.Editing){
                  //  _notes[widget.index] = {
                  NoteProvider.updateNote({
                     "id": widget.note['id'],
                     "title": title,
                     "text": text,
                   });
                 }
                 Navigator.pop(context);
               }),

               _NoteButton('Discard', Colors.grey, (){
                 Navigator.pop(context);
               }),
               _NoteButton('Delete', Colors.orange, () async {
                //  _notes.removeAt(widget.index);
                await NoteProvider.deleteNote(widget.note['id']);
                 Navigator.pop(context);
               }),
            ],
          )
        ],
      ),
      ),
    );
  }

}

class _NoteButton extends StatelessWidget{

final String _text;
final Color _color;
final Function _onPressed;

_NoteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
                onPressed: _onPressed,
                child: Text(_text, style: TextStyle(color: Colors.white),),
                color: _color,
                minWidth: 90,
                height: 40,
    );
  }

}