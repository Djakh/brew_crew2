import 'package:brew_crew2/models/brew.dart';
import 'package:brew_crew2/screens/home/settings_form.dart';
import 'package:brew_crew2/screens/services/auth.dart';
import 'package:brew_crew2/screens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

void _showSettingsPanel () {
showModalBottomSheet(context: context, builder: (context) {
return Container (
padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
child: SettingsForm(),
);

});


}

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Brew Crew"),
          actions: [
            FlatButton.icon(
                onPressed: () {
                  _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("logout")),
            FlatButton.icon(
                onPressed: () {_showSettingsPanel();},
                icon: Icon(Icons.settings),
                label: Text('Settings'))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage (image: AssetImage("assets/coffee_bg.png"))),
          
          child: BrewList()),
      ),
    );
  }
}
