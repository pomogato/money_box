import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_box/provider/google_sign_in.dart';
import 'package:money_box/style/colors.dart';
import 'package:money_box/style/text.dart';
import 'package:money_box/widget/dialog_delete.dart';
import 'package:money_box/widget/edit_card.dart';
import 'package:money_box/widget/new_card.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatelessWidget {
  TextStyle _style_bold = TextStyle(fontSize: 12,color: StyleColor.white,fontWeight: FontWeight.bold);


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: StyleColor.background,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.max,

            children: [
              Expanded(
                  child:
                  Text("ЦЕЛИ",style: StyleText.title_appBar)),

              TextButton(
                onPressed: () =>{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewCard(),
                      ))
                },

                child:
                Text("Добавить",style: StyleText.title_appBar),
              ),
              ElevatedButton(
                onPressed: () {
                  final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();

                },
                child: Text('Logout'),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                maxRadius: 22,
                backgroundImage: NetworkImage(user.photoURL),
              ),
            ],
          ),
        ),
        elevation: 10,

      ),

      body: Container(
        alignment: Alignment.center,
        color: StyleColor.background,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(user.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) return Text('нет записей');
            print(snapshot.data.docs.length);
            if(snapshot.data.docs.length==0) return const Center(child: Text('Нет записей',style: TextStyle(fontSize: 24)));
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                       return Dismissible(
                        key: Key(snapshot.data.docs[index].id),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 7, 5, 0),
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditCard(snapshot: snapshot.data.docs[index]),
                                      )),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                height: 100,

                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children:
                                              [
                                                SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: CircularProgressIndicator(
                                                    color: StyleColor.green,
                                                    value: 0.3,
                                                    backgroundColor: Colors.white,
                                                    strokeWidth: 6,
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  // child: Text('23%',style:  TextStyle(fontSize: 23,color: Colors.white,),),//Icon(Icons.attach_money,size: 40,color: Colors.white60,),
                                                  decoration: BoxDecoration(
                                                    color: StyleColor.background,
                                                    borderRadius: BorderRadius.circular(35),),
                                                ),
                                                Text('${30}%', style: TextStyle(
                                                  fontSize: 18, color: Colors.white,),),
                                              ]
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Flexible(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            const Spacer( flex: 2,),
                                            Text(snapshot.data.docs[index].get('item'),
                                              style: StyleText.title_bold,),
                                            const Spacer(),
                                            Text('Начальная сумма: ${snapshot.data.docs[index].get('first')}',style: StyleText.osnovnoi),
                                            Text('Дата добавления: ${snapshot.data.docs[index].get('date1')}',style: StyleText.osnovnoi),
                                            Text('Дата окончания: ${snapshot.data.docs[index].get('date2')}',style: StyleText.osnovnoi),
                                            const Spacer(flex: 2,),

                                          ],
                                        ),
                                      ),

                                       Spacer(flex: 1,),
                                       Flexible(
                                         flex: 3,
                                         child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Spacer(),
                                              Text("СУММА", style: _style_bold,),
                                              Text("${snapshot.data.docs[index].get('sum')} ${snapshot.data.docs[index].get('currency')}",  style: TextStyle(fontSize: 12,color: StyleColor.orange,),),
                                              const Spacer(),
                                              Text("НАКОПЛЕНО", style: _style_bold,),
                                              Text("${snapshot.data.docs[index].get('last')} ${snapshot.data.docs[index].get('currency')}", style: TextStyle(fontSize: 12,color: StyleColor.green),),
                                              const Spacer(),
                                            ],
                                          ),
                                       ),


                                    ]
                                ),


                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )),
                        onDismissed: (DismissDirection direction) async{
                          final result = await showDialog(
                              context: context,
                              builder: (_) => DialogDelete());
                          if (result == true) {
                            FirebaseFirestore.instance
                                .collection(user.email)
                                .doc(snapshot.data.docs[index].id)
                                .delete();
                          }
                          return result;
                        },
                        background: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Align(
                            child: Icon(
                              Icons.delete,
                              color: Colors.grey,
                              size: 70,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      );
                    });

            }
        ),
      ),

    );

  }
}
