import 'package:brew_crew2/models/user1.dart';
import 'package:brew_crew2/screens/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//create user1 object based on Firebase----User
  User1 _userFromFareBaseUser(User user) {
    return user != null ? User1(uid: user.uid) : null;
  }

  Stream<User1> get user {
    return _firebaseAuth
        .authStateChanges()
// .map((User user) => _userFromFareBaseUser(user));
        .map(_userFromFareBaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      User user = result.user;

      return _userFromFareBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
 Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
        User user = result.user;
        return _userFromFareBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
        User user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);

        return _userFromFareBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
