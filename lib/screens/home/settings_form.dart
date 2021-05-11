import 'package:brew_crew2/models/user1.dart';
import 'package:brew_crew2/screens/services/database.dart';
import 'package:brew_crew2/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew2/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> listSugar = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User1>(context);

    return StreamBuilder<DocumentData>(
        stream: DatabaseService(uid: userProvider.uid).documentData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentData documentData = snapshot.data;

            return Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: documentData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    value: _currentSugar ?? documentData.sugar,
                    decoration: textInputDecoration,
                    items: listSugar.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugar = val),
                  ),
                  //slader
                  Slider(
                    activeColor:
                        Colors.brown[_currentStrength ?? documentData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? documentData.strength],
                    value:
                        (_currentStrength ?? documentData.strength).toDouble(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.pink,
                    child: Text(
                      "update",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        await DatabaseService(uid: userProvider.uid)
                            .updateUserData(
                                _currentSugar ?? documentData.sugar,
                                _currentName ?? documentData.name,
                                _currentStrength ?? documentData.strength);
                      }
                    Navigator.pop(context);

                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
