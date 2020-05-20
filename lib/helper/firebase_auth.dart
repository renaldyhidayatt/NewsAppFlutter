import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthProvider{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if(user != null)
      return true;
      else
      return false;
    }catch(e){
      print(e.message);
      return false;
    }
  }

  Future<void> logOut() async{
    try{
      await _auth.signOut();
    }catch(e){
      print("Error logging out");
    }
  }

  Future<Null> ensureLoggedIn() async{
    FirebaseUser firebaseUser = await _auth.currentUser();
    assert(firebaseUser != null);
    assert(firebaseUser.isAnonymous == false);
    print('We are logged into Firebase');
  }

  Future<bool> loginWithGoogle() async{
    try{
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if(account == null)
      return false;

      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: (await account.authentication).idToken, accessToken: (await account.authentication).accessToken));
      if(res.user == null)
        return false;
      return true;
    }catch(e){
      print(e.message);
      print("Error Logging with google");
      return false;
    }
  }
}