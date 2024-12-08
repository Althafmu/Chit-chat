import 'dart:developer';
import 'package:chit_chat/utils/constants/colorconstants.dart';
import 'package:chit_chat/view/login_screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenController with ChangeNotifier {
  bool islogined = false;
  bool googleislogined = false;
  String? currentuseremail;
  String? currentuserphoto;
  String? currentusername;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      islogined = true;
      notifyListeners();

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection('users').doc(credential.user?.uid).set({
        'uid': credential.user?.uid,
        'email': email,
      });

      if (credential.user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error: ${e.code}');
      if (e.code == 'invalid-email') {
        log('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('No user found for that email.'),
          backgroundColor: Colorconstants.primarycolor,
        ));
      } else if (e.code == 'invalid-credential') {
        log('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Wrong password provided for that user.'),
            backgroundColor: Colorconstants.primarycolor));
      }
      islogined = false;
      notifyListeners();
    }

    islogined = false;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      currentuseremail = null;
      currentuserphoto = null;
      islogined = false;
      googleislogined = false;
      notifyListeners();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      log('Error during sign out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Error signing out. Please try again.'),
          backgroundColor: Colorconstants.primarycolor,
        ),
      );
    }
  }

  Future<bool> googleSignin() async {
    try {
      googleislogined = true;
      notifyListeners();
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      if (guser == null) {
        log('Google Sign-In cancelled by the user.');
        googleislogined = false;
        notifyListeners();
        return false;
      }
      final GoogleSignInAuthentication gauth = await guser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken,
        idToken: gauth.idToken,
      );

      var response =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (response.user != null) {
        log(response.user.toString());
        return true;
      }
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInWithCredential(credential);
      // String? idToken = await userCredential.user?.getIdToken();
      // log("id token: ${idToken.toString()}");
    } catch (e) {
      print(e);
      return false;
    }
    googleislogined = false;
    notifyListeners();
    return false;
  }

  User? getCurrentUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    currentuseremail = user?.email;
    currentuserphoto = user?.photoURL;
    currentusername = user?.displayName;
    return auth.currentUser;
  }
}
