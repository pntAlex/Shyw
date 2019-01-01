import "package:flutter/material.dart";
import "globals.dart" as globals;
import "package:firebase_auth/firebase_auth.dart";

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  globals.AuthenticationFormType _formType =
      globals.AuthenticationFormType.login;
  String _password, _email;

  void validateAndSubmit() async {
    bool validateAndSave() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        return true;
      }
      return false;
    }

    AlertDialog authenticationAlert = AlertDialog(
      title: Text("The credentials you entered are incorrect"),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "Retry",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    if (validateAndSave()) {
      switch (_formType) {
        case globals.AuthenticationFormType.login:
          try {
            globals.currentUser = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password);
            setState(() => globals.loggedIn = true);
            Navigator.pop(context);
          } catch (e) {
            showDialog(
              context: context,
              builder: (context) => authenticationAlert,
            );
          }
          break;
        case globals.AuthenticationFormType.register:
          try {
            globals.currentUser = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password);
            setState(() => globals.loggedIn = true);
            Navigator.pop(context);
          } catch (e) {
            showDialog(
              context: context, 
              builder: (context) => authenticationAlert);
          }

          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    String passwordValidator(String password) {
      if (password.isEmpty)
        return "Password can't be empty";
      else if (password.length < 8)
        return "Your password must be at least 8 characters";
      return null;
    }

    void signInFormTypeSwitch() {
      _formKey.currentState.reset();
      setState(() => _formType = globals.AuthenticationFormType.login);
    }

    void registerFormTypeSwitch() {
      _formKey.currentState.reset();
      setState(() => _formType = globals.AuthenticationFormType.register);
    }

    String emailValidator(String email) {
      if (email.isEmpty)
        return "Email can't be empty";
      else if (!email.contains("@"))
        return "This address isn't an email address";
      return null;
    }

    Form authenticationForm() {
      String mainButtonLabel, secondaryButtonLabel, secondaryAuthTypemsg;
      var formTypeSwitch;

      switch (_formType) {
        case globals.AuthenticationFormType.login:
          mainButtonLabel = "Sign in";
          secondaryAuthTypemsg = "Don't have an account ?";
          secondaryButtonLabel = "Register";
          formTypeSwitch = registerFormTypeSwitch;
          break;
        case globals.AuthenticationFormType.register:
          mainButtonLabel = "Register";
          secondaryAuthTypemsg = "Already have an account ?";
          secondaryButtonLabel = "Sign in";
          formTypeSwitch = signInFormTypeSwitch;
          break;
      }

      List<Widget> buttons() => [
            Container(
                margin: EdgeInsets.only(top: 20.0),
                width: screenWidth,
                child: RaisedButton(
                    color: globals.primaryColor,
                    child: new Text(mainButtonLabel,
                        style: TextStyle(color: Colors.white)),
                    onPressed: validateAndSubmit,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ))),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(children: <Widget>[
                Text(secondaryAuthTypemsg),
                RaisedButton(
                    color: Colors.black,
                    child: new Text(secondaryButtonLabel,
                        style: TextStyle(color: Colors.white)),
                    onPressed: formTypeSwitch,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ))
              ]),
            )
          ];
      List<Widget> textFields() => [
            TextFormField(
              decoration:
                  InputDecoration(icon: Icon(Icons.mail), hintText: "Email"),
              validator: emailValidator,
              onSaved: (value) => _email = value,
            ),
            TextFormField(
              obscureText: true,
              decoration:
                  InputDecoration(icon: Icon(Icons.lock), hintText: "Password"),
              validator: passwordValidator,
              onSaved: (value) => _password = value,
            )
          ];
      return Form(
        key: _formKey,
        child: Column(
          children: textFields() + buttons(),
        ),
      );
    }

    if (!globals.loggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Authentication"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Image.network(
                  "https://www.touristguideofflorence.com/img/loghi/user.png",
                  height: screenHeight / 4,
                ),
              ),
              authenticationForm()
            ],
          ),
        ),
      );
    } else
      return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            centerTitle: true,
          ),
          body: Center(
              child: Column(
            children: <Widget>[
              Text("You are logged as ${globals.currentUser.email}"),
              RaisedButton(
                child: Text("Sign out"),
                onPressed: () {
                  setState(() {
                    globals.currentUser = null;
                    globals.loggedIn = false;
                  });
                },
              )
            ],
          )));
  }
}
