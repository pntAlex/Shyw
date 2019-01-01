import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String _posterIcon;
  final String _posterName;
  final int _postFollowersCount;
  final bool postFollowed;
  final bool postLiked;
  final bool postCommented;

  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['posterIcon'] != null),
        assert(map['posterName'] != null),
        assert(map['followersCount'] != null),
        assert(map['followed'] != null),
        assert(map['commented'] != null),
        _posterIcon = map['posterIcon'],
        _posterName = map['posterName'],
        _postFollowersCount = map['followersCount'],
        postFollowed = map['followed'],
        postLiked = map["liked"],
        postCommented = map['commented'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  String getUserIcon() => _posterIcon;
  String getUserName() => _posterName;
  int getPostFollowersCount() => _postFollowersCount;
}
