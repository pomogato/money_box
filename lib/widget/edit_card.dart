
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_box/style/colors.dart';
import 'package:money_box/style/text.dart';

class EditCard extends StatelessWidget {
  final  snapshot;

  TextEditingController _num_controler = new TextEditingController();
  String _name;
  int _num;
  final user = FirebaseAuth.instance.currentUser;


  Future now() async{
   print('${snapshot.get('item')}');
   print('${snapshot.get('sum')}');
  }

   EditCard({Key key, this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    now();

    return Scaffold(

      appBar: AppBar(
        backgroundColor: StyleColor.background,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.max,

            children: [
              TextButton(
                  onPressed: () => {
                    Navigator.pop(context, false) ,
                  },
                  child:
                  Text("Назад",style:StyleText.title_appBar)
              ),
              Spacer(),

              TextButton(
                onPressed: () =>{
                },

                child:
                Text("Сохранить",style: StyleText.title_appBar),
              ),

            ],
          ),
        ),
        elevation: 10,

      ),
      body:
      Container(
        alignment: Alignment.center,
        color: StyleColor.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(fontSize: 16,color: Colors.white),
                cursorHeight: 16,
                onChanged: (String value){
                  _name = value;
                },
                decoration:  const InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  hintText:  'Название',
                  hintStyle:TextStyle(fontSize: 16,color: Colors.white,),
                  border:  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(fontSize: 16,color: Colors.white),
                cursorHeight: 16,
                controller: _num_controler,
                decoration:  const InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: 'значение',
                  hintStyle:TextStyle(fontSize: 16,color: Colors.white,),
                  border:  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),

              ),
            ),
            TextButton(
              onPressed: () =>{
                _num = int.tryParse(_num_controler.text),
                FirebaseFirestore.instance.collection(user.email).doc(snapshot.id).update({'item': _name,'sum': _num}),


                Navigator.pop(context, false),
              },

              child:
               Text("Сохранить",style: StyleText.title_bold),
            ),
          ],
        ),
      ),

    );
  }
}