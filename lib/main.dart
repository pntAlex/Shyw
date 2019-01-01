import "package:flutter/material.dart";
import "homePage.dart";
import "globals.dart" as globals;

void main() {
  globals.initGlobals();
  runApp(Shyw());
}

class Shyw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Share your workouts",
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(),
    );
  }
}

