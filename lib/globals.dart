import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthenticationFormType { login, register }

FirebaseUser currentUser;

MaterialColor primaryColor = Colors.orange;
MaterialColor secondaryColor = Colors.black;

const usersCollectionName = "users";
const postsCollectionName = "posts";

final CollectionReference usersCollection =
    Firestore.instance.collection(usersCollectionName);
final CollectionReference postsCollection =
    Firestore.instance.collection(postsCollectionName);

bool loggedIn;

// String cUserEmail;
// String cUserName;
// String cUserFollowers;
// String cUserReference;

// STATS'
int totalUsersNb;

void initGlobals() async {
  loggedIn = true;

  // STATS
  totalUsersNb = (await usersCollection.getDocuments()).documents.length;
}

void totalUsersNbUpdate() async {
  totalUsersNb = (await usersCollection.getDocuments()).documents.length;
}


