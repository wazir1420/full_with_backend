import 'package:flutter/material.dart';
import 'package:thirds/create_data.dart';
import 'package:thirds/delete_screen.dart';
import 'package:thirds/fetch_data.dart';
import 'package:thirds/update_date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateData()));
                },
                child: Text('Create')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FetchData()));
                },
                child: Text('Read')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpdateScreen()));
                },
                child: Text('Update')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DeleteScreen()));
                },
                child: Text('Delete'))
          ],
        ),
      ),
    );
  }
}
