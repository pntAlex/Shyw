import "package:flutter/material.dart";

void main(BuildContext context) => runApp(MaterialApp(
      home: Shyw(),
      debugShowCheckedModeBanner: false,
    ));

class Shyw extends StatefulWidget {
  @override
  _ShywState createState() => _ShywState();
}

class _ShywState extends State<Shyw> {
  // List<bool> favoriteList = [];
  // List<bool> followedList = [];
  // List<bool> commentedList = [];
  List<String> labelList = [
    "dvgzefdibzjkebfuioaez",
    "dbhezgabdjzbhghxieokfio",
    "huifzheuifbhjuiappepldoeloolpp",
    "hjezgdhaezioixiekodorlo"
  ];
  List<int> followList = [1, 1256, 12773, 893, 65];
  List<Widget> content = [];
  var followedDict = new Map<int,bool>();
  var favoriteDict = new Map<int,bool>();
  var commentedDict = new Map<int,bool>();

  bool firstLaunch = true;

  void favorite(int i) {
    setState(() => favoriteDict[i] = !favoriteDict[i]);
  }

  void follow(int i) {
    setState(() => followedDict[i] = !followedDict[i]);
  }

  void comment(int i) {
    setState(() => commentedDict[i] = !commentedDict[i]);
  }

  @override
  Widget build(BuildContext context) {
    
    Stopwatch stopwatch = new Stopwatch()..start();

    List<Widget> content = [];
    for (var i = 1 ; i < labelList.length; i++) {
      if(firstLaunch){
        commentedDict[i] = false;
        followedDict[i] = false;
        favoriteDict[i] = false;
        firstLaunch = (i != labelList.length);
      }
      content.add(Container(
          padding: EdgeInsets.fromLTRB(20.0, 5.0, 15.0, .0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.home),
                  Expanded(
                    child: Text(
                      "user " + i.toString(),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    child: Text(followedDict[i] ? "Followed" : "Follow"),
                    onPressed: () => follow(i),
                    color: followedDict[i]? Colors.blueAccent : Colors.greenAccent,
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: Text(
                    (followList[i]).toString() +
                        " people follows this programme",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
              Row(children: <Widget>[
                IconButton(
                  icon: favoriteDict[i]
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () => favorite(i),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
                Expanded(
                    child: IconButton(
                  icon: commentedDict[i]
                      ? Icon(Icons.chat_bubble)
                      : Icon(Icons.chat_bubble_outline),
                  onPressed: () => comment(i),
                ))
              ]),
              Center(
                child: Text(labelList[i]),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          )));
    }

    
    print('doSomething() executed in ${stopwatch.elapsedMicroseconds}');
    firstLaunch = false;
    return DefaultTabController(
    length: 4,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Share your workouts'),
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.calendar_today)),
            Tab(icon: Icon(Icons.map)),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          ListView(children: content),
          Text("b"),
          Text("c"),
          Text("d")
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 15.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
  }
}
