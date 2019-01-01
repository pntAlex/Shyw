// import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "postForm.dart";
import "authenticationScreen.dart";
import "workoutFeed.dart";
import "settings.dart";
import "globals.dart" as globals;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<IconButton> bottomNavBarIconButtonsList = [
      IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()))),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => print("search"),
      ),
    ];
    List<Tab> tabsList = (globals.loggedIn)
        ? [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.calendar_today)),
            Tab(icon: Icon(Icons.map)),
            Tab(icon: Icon(Icons.person))
          ]
        : [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.calendar_today)),
            Tab(icon: Icon(Icons.map))
          ];

    List<Widget> tabBarView = (globals.loggedIn)
        ? [WorkoutFeed(), Text(""), Text(""), Text("")]
        : [WorkoutFeed(), Text(""), Text("")];

    FloatingActionButton mainBottomActionButton;
    mainBottomActionButton = (globals.loggedIn)
        ? FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.orange),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PostForm()));
            },
            backgroundColor: Colors.black,
          )
        : FloatingActionButton(
            child: const Icon(Icons.person, color: Colors.orange),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthenticationScreen()));
            },
            backgroundColor: Colors.black,
          );

    return DefaultTabController(
      length: tabBarView.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Share your workouts"),
          centerTitle: true,
          bottom: TabBar(tabs: tabsList),
        ),
        body: TabBarView(
          children: tabBarView,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: mainBottomActionButton,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 15.0,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: bottomNavBarIconButtonsList),
        ),
      ),
    );
  }
}
