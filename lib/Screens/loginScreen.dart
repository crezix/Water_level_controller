import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:water_level_indicator/Screens/Menu.dart';
import 'package:water_level_indicator/Screens/RegistrationScreen.dart';
import 'package:water_level_indicator/Screens/mainscreen.dart';
import 'package:water_level_indicator/main.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login" ;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[800],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 185.0,),
              Text("Login Here",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold" ),
                textAlign: TextAlign.center,),
              Padding(padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Brand Bold"
                        ),
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Brand Bold"
                        ),
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color: Colors.white70,
                      textColor: Colors.black,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text("Login", style: TextStyle(height:1.0 ,color: Colors.black, fontFamily: "Brand Bold", fontSize: 20.0),
                          ),

                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),

                      ),
                      onPressed: ()
                      {
                        /*if(!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("Email is not Valid", context);
                        }
                        else if(passwordTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("Please provide Password", context);
                        }
                        else
                        {*/
                          //loginAndAuthenticateUser(context);
                          Navigator.pushNamedAndRemoveUntil(context, MenuScreen.idScreen, (route) => false);

                        //}
                      },
                    ),

                  ],
                ),
              ),
              SizedBox(height: 0.1,),
              FlatButton(
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Don't have an Account? Register Here",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {
    final User firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword (email: emailTextEditingController.text, password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString() , context);
    })).user;

    if(firebaseUser != null)
    {
      usersRef.child(firebaseUser.uid).once().then( (DataSnapshot snap){
        if(snap.value!=null)
        {
        //  Navigator.pushNamedAndRemoveUntil(context,MainScreen.idScreen, (route) => false);
          Navigator.pushNamedAndRemoveUntil(context, MenuScreen.idScreen, (route) => false);
          displayToastMessage("You're logged-in Now", context);
        }
        else
        {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("No Record exist for this user. Please Create a New Account.", context);
        }
      });

    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("Error occurred, cannot be sign in", context);
    }
  }
}
