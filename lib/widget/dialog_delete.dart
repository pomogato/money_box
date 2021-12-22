import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogDelete extends StatelessWidget{
  TextStyle styleText = TextStyle(fontSize: 16,color: Colors.white60,);
  TextStyle styleTitle = TextStyle(fontSize: 20,color: Colors.white60,);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      title: Text('Удалить',style: styleTitle,),
      content: Text('Вы уверены,что хотите удалить ЦЕЛЬ?',style: styleText,),
      actions: <Widget>[
        FlatButton(onPressed: () {
          Navigator.of(context).pop(true);
        },
            child: Text('Да',style: styleTitle,)),
        FlatButton(onPressed: () {
          Navigator.of(context).pop(false);
        },
            child: Text('Нет',style: styleTitle,)),
      ],
    );
  }

}