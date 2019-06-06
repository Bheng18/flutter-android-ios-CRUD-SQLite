import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget{

 final notes = [
    {
      "title": "Title1",
      "text": "asdmaskl dmsklasdmask ldmsklasdm askldmsklas dmaskldmskl"
    },
    {
      "title": "Title2",
      "text": "sadkasks adkasksad kasksadk asksadkas ksadkask"
    },
    {
      "title": "Title3",
      "text": "3asafas3 253asafas3253 asafa3asafa s3253asafa s3253asafa"
    }
  ];

NoteInheritedWidget(Widget child): super(child: child);

static NoteInheritedWidget of(BuildContext context){
  return (context.inheritFromWidgetOfExactType(NoteInheritedWidget) as NoteInheritedWidget);
}

  @override
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
        return oldWidget.notes != notes;
  }

}