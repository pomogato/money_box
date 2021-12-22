import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dateDialog extends StatefulWidget{
  final  DateTime res;

  const dateDialog( {
    Key key, this.res,
  }) : super(key: key);

  @override
  _dateDialogState createState() => _dateDialogState();
}

class _dateDialogState extends State<dateDialog> {
  TextStyle styleTitle = TextStyle(fontSize: 20,color: Colors.white60,);
  DateTime DateRes= DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      content: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: CupertinoDatePicker(
          backgroundColor: Colors.grey,
          mode: CupertinoDatePickerMode.date,
          initialDateTime: widget.res,
          minimumYear: 2021,
          maximumYear: 2300,
          onDateTimeChanged: (DateTime newDateTime) {
            DateRes = newDateTime;
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: () {
          Navigator.of(context).pop(DateRes);
        },
            child: Text('ОК',style: styleTitle,)),
        FlatButton(onPressed: () {
          Navigator.of(context).pop(false);
        },
            child: Text('Отмена',style: styleTitle,)),
      ],
    );
  }
}