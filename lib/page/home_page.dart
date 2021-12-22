import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_box/provider/google_sign_in.dart';
import 'package:money_box/widget/logged_in_widget.dart';
import 'package:money_box/widget/sign_up_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: MultiProvider(
          providers:[
          ChangeNotifierProvider(
              create: (context) => GoogleSignInProvider(),),
          ],
            child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final provider = Provider.of<GoogleSignInProvider>(context);

                if (provider.isSigningIn) {
                  return buildLoading();
                } else if (snapshot.hasData) {
                  return LoggedInWidget();
                } else {
                  return SignUpWidget();
                }
              },
            ),

        ),
      );

  Widget buildLoading() =>
          Center(child: CircularProgressIndicator());

}
