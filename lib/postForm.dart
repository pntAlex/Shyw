import "package:flutter/material.dart";
// import 'package:cloud_firestore/cloud_firestore.dart';
import "globals.dart" as globals;

class PostForm extends StatefulWidget {
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  int _currentstep = 0;
  String _workoutName;

  List<StepState> _stepStates = [
    StepState.editing,
    StepState.indexed,
    StepState.indexed,
  ];

  bool validateAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    } else
      return false;
  }

  String emptyFieldValidator(String value) {
    return ((value.isEmpty) ? "You must fill the workout name field" : null);
  }

  List<Step> submitProgrammeSteps() {
    List<Map<String, String>> titleTexts = [
      {
        "title": "Choose the name of your workout",
        "subtitle": "Ex : \"Bodyweight daily routine\""
      },
      {
        "title": "Compose your workout",
        "subtitle": "Eg: \"Pushups\"; \"Australian Pull-ups\""
      },
      {
        "title": "Choose the name of your workout",
        "subtitle": "Ex : \"Bodyweight daily routine\""
      }
    ];

    return [
      Step(
          state: _stepStates[0],
          content: Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(hintText: "Workout name"),
              validator: (value) {
                if (value.isEmpty)
                  return "You must fill the workout name field";
              },
              onSaved: (value) => _workoutName = value,
            ),
          ),
          title: Text(titleTexts[0]["title"]),
          subtitle: Text(titleTexts[0]["subtitle"]),
          isActive: _currentstep >= 0),
      Step(
          state: _stepStates[1],
          content: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Choose your exercices"),
                onPressed: () => "",
              ),
              RaisedButton(
                child: Text("Create your exercices"),
                onPressed: () => "",
              ),
            ],
          ),
          title: Text(titleTexts[1]["title"]),
          subtitle: Text(titleTexts[1]["subtitle"]),
          isActive: _currentstep >= 1),
      Step(
          state: _stepStates[2],
          content: Text(""),
          title: Text(titleTexts[2]["title"]),
          subtitle: Text(titleTexts[2]["subtitle"]),
          isActive: _currentstep >= 2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(_workoutName);
    return Scaffold(
        floatingActionButton: IconButton(
          tooltip: "Submit your programme",
          splashColor: globals.primaryColor,
          icon: Icon(Icons.send),
          onPressed: validateAndSave,
        ),
        appBar: AppBar(
          title: Text("Create your programme"),
          centerTitle: true,
        ),
        body: Stepper(
          steps: submitProgrammeSteps(),
          currentStep: this._currentstep,
          onStepContinue: () {
            if (validateAndSave()) {
              setState(
                  () => this._stepStates[_currentstep] = StepState.complete);
              if (this._currentstep < submitProgrammeSteps().length - 1) {
                setState(() {
                  this._currentstep += 1;
                  this._stepStates[_currentstep] = StepState.editing;
                });
              }
            } else {
              print("error");
              setState(() => this._stepStates[_currentstep] = StepState.error);
            }
          },
          onStepCancel: () {
            if (this._currentstep != 0)
              setState(() {
                this._stepStates[_currentstep] = StepState.indexed;
                this._currentstep -= 1;
              });
          },
        ));
  }
}

class ExercicesDialog extends StatefulWidget {
  @override
  _ExercicesDialogState createState() => _ExercicesDialogState();
}

class _ExercicesDialogState extends State<ExercicesDialog> {
  @override
  Dialog build(BuildContext context) {
    return Dialog(
      child: ExpansionPanelList(
        children: [
          ExpansionPanel(
              headerBuilder: (context, a) => Text("a"), body: Text("b"))
        ],
      ),
    );
  }
}
