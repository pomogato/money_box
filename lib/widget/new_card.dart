
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_box/style/colors.dart';
import 'package:money_box/style/text.dart';

class NewCard extends StatelessWidget {

  TextEditingController _name_controller = new TextEditingController();
  TextEditingController _sum_controller = new TextEditingController();
  TextEditingController _last_sum_controller = new TextEditingController();
  String _name;
  int _sum;
  int _last_sum;
  int _min_sum = 0;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
backgroundColor: StyleColor.background,
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
                  _name = _name_controller.text,
                  _sum = int.tryParse(_sum_controller.text),
                  _last_sum = int.tryParse(_last_sum_controller.text),

                    FirebaseFirestore.instance.collection(user.email)
                        .add({
                      'item': _name,
                      'sum': _sum,
                      'last': _last_sum,
                      'first': 200,
                      'currency': 'USD',
                      'date1': 2021,
                      'date2': 2024,
                        }),

                    Navigator.pop(context, false),
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

      ListView(
        children: [Container(
          alignment: Alignment.center,
          color: StyleColor.background,
    child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
          children: [

             Row(
                children: [
                  Expanded(
                    flex: 1,
                      child:
                      Text("Название",style: StyleText.title_appBar)
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      style: StyleText.title_appBar,
                      cursorHeight: 16,
                      keyboardType: TextInputType.text,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign:TextAlign.right,
                      controller: _name_controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                        hintText: 'Новая цель',
                        hintStyle:StyleText.title_appBar,
                        border:  const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),

                    ),
                  ),
                ],
              ),

            Row(
              children: [
                Expanded(
                  flex: 1,
                    child:
                    Text("Сумма",style: StyleText.title_appBar)
                ),
                SizedBox(width: 15,),
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: StyleText.title_appBar,
                    cursorHeight: 16,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign:TextAlign.right,
                    controller: _sum_controller,
                    decoration: InputDecoration(
                      hintText: '0,00',
                      hintStyle:StyleText.title_appBar,
                      border: const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),

                  ),
                ),


              ],
            ),
            Row(
              children: [
                Text("Начальная сумма",style: StyleText.title_appBar),
                SizedBox(width: 15,),
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: StyleText.title_appBar,
                    cursorHeight: 16,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign:TextAlign.right,
                    controller: _last_sum_controller,
                    decoration: InputDecoration(
                      hintText: '0,00',
                      hintStyle:StyleText.title_appBar,
                      border:  const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),

                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Крайний срок пополнения",style: StyleText.title_appBar),
                SizedBox(width: 15,),
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: StyleText.title_appBar,
                    cursorHeight: 16,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign:TextAlign.right,
                    // controller: _section_id,
                    onChanged: (_) {

                    },
                    decoration: InputDecoration(
                      hintText: '00/00/2021',
                      hintStyle:StyleText.title_appBar,
                      border:  const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),

                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Дата уведомления",style: StyleText.title_appBar),
                SizedBox(width: 15,),
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: StyleText.title_appBar,
                    cursorHeight: 16,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign:TextAlign.right,
                    // controller: _section_id,
                    onChanged: (_) {

                    },
                    decoration: InputDecoration(
                      hintText: '00/00/2021',
                      hintStyle:StyleText.title_appBar,
                      border:  const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),

                  ),
                ),


              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Валюта",style: StyleText.title_appBar),

                const SizedBox(width: 15,),

                DropDown(),
                  // child: TextField(
                  //   style: StyleText.title_appBar,
                  //   cursorHeight: 16,
                  //   keyboardType: TextInputType.text,
                  //   textInputAction: TextInputAction.next,
                  //   textAlignVertical: TextAlignVertical.top,
                  //   textAlign:TextAlign.right,
                  //   // controller: _section_id,
                  //   onChanged: (_) {
                  //
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: 'BYN',
                  //     hintStyle:StyleText.title_appBar,
                  //     border:  const UnderlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     ),
                  //   ),
                  //
                  // ),


              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                    child:
                    Text("Минимальная сумма ежемесячного платежа",style: StyleText.title_appBar)
                ),
                SizedBox(width: 10,),
                const Spacer(
                  flex: 1,
                ),
                   Text("${_min_sum},00",style: StyleText.title_appBar),


              ],
            ),
           // razdelitel(),


            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child: TextField(
            //     textAlignVertical: TextAlignVertical.bottom,
            //     style: TextStyle(fontSize: 16,color: Colors.white),
            //     cursorHeight: 16,
            //     onChanged: (String value){
            //       _name = value;
            //     },
            //     decoration:  const InputDecoration(
            //       fillColor: Colors.grey,
            //       filled: true,
            //       hintText: 'Название',
            //       hintStyle:TextStyle(fontSize: 16,color: Colors.white,),
            //       border:  OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //       ),
            //     ),
            //
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child: TextField(
            //     keyboardType: TextInputType.number,
            //     textAlignVertical: TextAlignVertical.bottom,
            //     style: TextStyle(fontSize: 16,color: Colors.white),
            //     cursorHeight: 16,
            //     controller: _num_controler,
            //     decoration:  const InputDecoration(
            //       fillColor: Colors.grey,
            //       filled: true,
            //       hintText: 'значение',
            //       hintStyle:TextStyle(fontSize: 16,color: Colors.white,),
            //       border:  OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //       ),
            //     ),
            //
            //   ),
            // ),
            // TextButton(
            //   onPressed: () =>{
            //     _sum = int.tryParse(_num_controler.text),
            //     FirebaseFirestore.instance.collection(user.email).add({'item': _name,'sum': _sum}),
            //
            //     Navigator.pop(context, false),
            //   },
            //
            //   child:
            //   const Text("Сохранить",style: TextStyle(fontSize: 14,color: Colors.white60,fontWeight: FontWeight.bold)),
            // ),
          ],
        ),
    ),
        ),],
      ),

    );
  }
  Widget razdelitel(){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child: Container(width: double.infinity,height: 1,color: Colors.white10,));

  }
  }

  class DropDown extends StatefulWidget{


  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List listItem = ['USD', 'EUR', 'BYN', 'RUB'];
  String _currency = 'USD';
  @override
  Widget build(BuildContext context) {

    return DropdownButton(
      dropdownColor: const Color.fromRGBO(60, 71, 85, 1),
      value: _currency,
      onChanged: (newValue){
        setState(() {
          _currency = newValue;

        });
      },
      items: listItem.map((valueItem){
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem,style: StyleText.title_appBar,),
        );
      } ).toList(),
      icon: const Icon(Icons.arrow_drop_down,size: 16,color: Colors.white60,),

      //elevation: 30,
      style: StyleText.title_appBar,
      underline: Container(
        height: 1,
        color: Colors.black26,
      ),


    );

  }
}