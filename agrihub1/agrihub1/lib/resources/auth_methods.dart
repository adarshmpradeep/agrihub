import 'package:agrihub1/resources/storage_methods.dart';
// import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agrihub1/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

//signup user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occur";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilepics', file, false);
        //add user to our database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          land: [],
          notification: [],
          photoUrl: photoUrl,
        );
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
//
        // await _firestore.collection('users').add({
        //   'username': username,
        //  'uid': cred.user!.uid,
        //  'email': email,
        //  'bio': bio,
        //  'followers': [],
        //  'following': [],
        //  });
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invail-email') {
        res = 'this is a badly formatted';
      } else if (err.code == 'weak password') {
        res = 'password should be atleast 6 character';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = "please enter all the field";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'invailed user';
      } else if (e.code == 'wrong-password') {
        res = 'invailed password';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
