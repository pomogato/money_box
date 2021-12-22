import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_box/style/colors.dart';

//попап времени

class dateDialog extends StatefulWidget{
  final  DateTime res;

  const dateDialog( {
    Key key, this.res,
  }) : super(key: key);

  @override
  _dateDialogState createState() => _dateDialogState();
}

class _dateDialogState extends State<dateDialog> {
  TextStyle styleTitle = const TextStyle(fontSize: 20,color: Colors.black,);
  DateTime DateRes= DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: StyleColor.white,
      contentPadding: EdgeInsets.all(5),
      content: Container(
        height: 200,

        child: CupertinoDatePicker(
            backgroundColor: StyleColor.white,
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