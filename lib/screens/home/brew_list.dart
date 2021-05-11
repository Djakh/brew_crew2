
import 'package:brew_crew2/models/brew.dart';
import 'package:brew_crew2/screens/home/brew_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {


  @override
  Widget build(BuildContext context) {

final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTitle (brew: brews[index]);

      });
  }
}