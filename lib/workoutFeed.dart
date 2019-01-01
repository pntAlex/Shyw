import "package:flutter/material.dart";
// import 'package:cloud_firestore/cloud_firestore.dart';
// import "record.dart";
import "globals.dart" as globals;

// class WorkoutFeed extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: globals.postsCollection.snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();
//         return _buildList(context, snapshot.data.documents);
//       },
//     );
//   }

//   Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//     return ListView(
//       padding: const EdgeInsets.only(top: 20.0),
//       children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//     );
//   }

//   Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//     final record = Record.fromSnapshot(data);
//     return Padding(
//         key: ValueKey(record.getUserName()),
//         padding: EdgeInsets.all(10.0),
//         child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.green),
//               borderRadius: BorderRadius.circular(5.0)),
//           child: ListTile(
//             title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Container(
//                         width: 35,
//                         height: 35,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               image: NetworkImage(
//                             record.getUserIcon(),
//                           )),
//                         ),
//                       ),
//                       Container(
//                         child: Text(record.getUserName()),
//                         margin: EdgeInsets.only(left: 10.0),
//                       ),
//                     ],
//                   ),
//                   RaisedButton(
//                       color: record.postFollowed ? Colors.blue : Colors.green,
//                       child: record.postFollowed
//                           ? Text(globals.currentUser.uid)
//                           : Text(
//                               "Followed",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                       onPressed: () {
//                         record.reference
//                             .updateData({"followed": !record.postFollowed});
//                         record.postFollowed
//                             ? record.reference.updateData({
//                                 "followersCount":
//                                     record.getPostFollowersCount() + 1
//                               })
//                             : record.reference.updateData({
//                                 "followersCount":
//                                     record.getPostFollowersCount() - 1
//                               });
//                       })
//                 ]),
//             subtitle: Column(
//               children: <Widget>[
//                 Center(
//                   child: Text(
//                     record.getPostFollowersCount().toString() +
//                         " people follow this programme",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Center(child: Text("Table")),
//                 Row(children: <Widget>[
//                   IconButton(
//                     icon: record.postLiked
//                         ? Icon(Icons.favorite)
//                         : Icon(Icons.favorite_border),
//                     onPressed: () => record.reference
//                         .updateData({"liked": !record.postLiked}),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.share),
//                     onPressed: () => print("shared"),
//                   ),
//                   Expanded(
//                       child: IconButton(
//                     icon: record.postCommented
//                         ? Icon(Icons.chat_bubble)
//                         : Icon(Icons.chat_bubble_outline),
//                     onPressed: () => record.reference
//                         .updateData({"commented": !record.postCommented}),
//                   ))
//                 ]),
//               ],
//             ),
//           ),
//         ));
//   }
// }

class WorkoutFeed extends StatefulWidget {
  @override
  _WorkoutFeedState createState() => _WorkoutFeedState();
}

class _WorkoutFeedState extends State<WorkoutFeed> {
  List<IconButton> postButtonsBar() {
    return [
      IconButton(
        icon: Icon(Icons.chat_bubble_outline),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.share),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
            child: Column(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[Image.network(""), Text("efkan_knz")]),
              ]),
          Text("X peolpe follow this workout",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Workout Name"),
          Text("Table"),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: postButtonsBar(),
          ),
          Container(
              width: screenWidth / 1.5,
              child: RaisedButton(
                  color: globals.primaryColor,
                  onPressed: () {},
                  child: Text("Follow"),
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )))
        ]));
      },
    );
  }
}
