import 'package:brew_crew2/models/user1.dart';
import 'package:brew_crew2/screens/authenticate/authenticate.dart';
import 'package:brew_crew2/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<User1>(context);
    print(userProvider);
    //return either home or Authenticate widget
     if(userProvider == null) {

return Authenticate();
     } else {

return Home();

     }    
    
    
 
  }
}