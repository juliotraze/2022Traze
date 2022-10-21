import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/Transparent_Waze.png'),
              ),
            ),
          ),
          Text(
            "Traze",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Text(
            "a CDW Application",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}