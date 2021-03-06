import 'package:brew_crew2/models/user1.dart';
import 'package:brew_crew2/screens/services/auth.dart';
import 'package:brew_crew2/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User1>.value(

      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Wrapper()
      ),
    );
  }
}

