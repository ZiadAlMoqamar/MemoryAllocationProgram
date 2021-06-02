import 'package:flutter/material.dart';
import 'package:memory_allocation/classes/deallocated_object.dart';
import 'package:memory_allocation/classes/memory_object.dart';
import 'package:memory_allocation/classes/new_memory_request.dart';
import 'package:memory_allocation/classes/hole.dart';
import 'package:memory_allocation/classes/returned_allocated_object.dart';
import 'package:memory_allocation/logic/allocation.dart';
import 'package:memory_allocation/logic/deallocation.dart';
import 'package:memory_allocation/logic/intialization.dart' as intializing;
import 'package:memory_allocation/classes/memory.dart';
import 'package:memory_allocation/logic/globals.dart' as global;
import 'package:memory_allocation/classes/hole.dart';

import 'classes/process.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Allocation Program',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 //here
 
  int memorySizeInput = -1;
  int holesNumInput = -1;


  void setMemorySizeInput() {
    setState(() {});
  }

  void setHolesNumInput() {
    setState(() {});
  }

  
  TextEditingController numberOfHoles = TextEditingController();
  int numberOfFields = 2;
  var controllers;
  List<Hole> input = [];
  void generateInput() {
    input = [];
    int? numOfHoles = (numberOfHoles.text.length == 0)
        ? 0
        : double.tryParse(numberOfHoles.text) == null
            ? 0
            : int.tryParse(numberOfHoles.text);
    for (var i = 0; i < numOfHoles!; i++) {
      input.add(Hole());
    }
  }

  void generateControllers() {
    int? numOfHoles = numberOfHoles.text.length == 0
        ? 0
        : double.tryParse(numberOfHoles.text) == null
            ? 0
            : int.tryParse(numberOfHoles.text);
    controllers = List.generate(numOfHoles!,
        (index) => List.filled(numberOfFields, null, growable: false),
        growable: false);
    for (var i = 0; i < numOfHoles; i++) {
      for (var j = 0; j < numberOfFields; j++) {
        controllers[i][j] = TextEditingController();
      }
    }
  }

  var validators;
  void generatevalidators() {
    int? numOfHoles = numberOfHoles.text.length == 0
        ? 0
        : double.tryParse(numberOfHoles.text) == null
            ? 0
            : int.tryParse(numberOfHoles.text);
    validators = List.generate(numOfHoles!,
        (index) => List.filled(numberOfFields, null, growable: false),
        growable: false);
    for (var i = 0; i < numOfHoles; i++) {
      for (var j = 0; j < numberOfFields; j++) {
        validators[i][j] = false;
      }
    }
  }

  void clearControllers() {
    int? numOfHoles = numberOfHoles.text.length == 0
        ? 0
        : double.tryParse(numberOfHoles.text) == null
            ? 0
            : int.tryParse(numberOfHoles.text);

    for (var i = 0; i < numOfHoles!; i++) {
      for (var j = 0; j < numberOfFields; j++) {
        controllers[i][j].clear();
      }
    }
  }

  void emptyControllers() {
    int? numOfHoles = numberOfHoles.text.length == 0
        ? 0
        : double.tryParse(numberOfHoles.text) == null
            ? 0
            : int.tryParse(numberOfHoles.text);

    for (var i = 0; i < numOfHoles!; i++) {
      for (var j = 0; j < numberOfFields; j++) {
        controllers[i][j].clear();
      }
    }
  }

  TextEditingController general = TextEditingController();

  Widget inputField(
      Function onChanged, TextEditingController controller, bool valid) {
    return Container(
      width: 60,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Color(0xfff0f2f5),
          filled: true,
          errorText: valid
              ? controller.text.length == 0
                  ? 'Empty'
                  : double.tryParse(controller.text) == null
                      ? 'Invalid'
                      : null
              : null,
          border: OutlineInputBorder(),
        ),
        textAlign: TextAlign.center,
        onChanged: onChanged(),
      ),
    );
  }

  NewMemoryRequest reqes = NewMemoryRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: [
          // number of holes
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              Text('Number of Holes:'),
              SizedBox(width: 15),
              Container(
                width: 50,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Color(0xfff0f2f5),
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  controller: numberOfHoles,
                  onChanged: (s) {
                    if (double.tryParse(numberOfHoles.text) != null)
                      setState(() {
                        generateInput();
                        generateControllers();
                        generatevalidators();
                      });
                    else
                      setState(() {
                        generateInput();
                        generateControllers();
                        generatevalidators();
                      });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          // titles
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: Text(
                    '#',
                    textAlign: TextAlign.center,
                  )),
              SizedBox(width: 25),
              Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: Text(
                    'Starting address',
                    textAlign: TextAlign.center,
                  )),
              SizedBox(width: 25),
              Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: Text(
                    'Size',
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
          // user input
          Container(
            height: 250,
            child: Scrollbar(
              isAlwaysShown: true,
              thickness: 14,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numberOfHoles.text.length == 0 ? 0 : input.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          child: CircleAvatar(
                              backgroundColor: Color(0xfff0f2f5),
                              child: Text('$index')),
                        ),
                        SizedBox(width: 25),
                        inputField((s) {
                          setState(() {
                            input[index].startAddress = int.tryParse(s)!;
                          });
                        }, controllers[index][0], validators[index][0]),
                        SizedBox(width: 25),
                        inputField((s) {
                          setState(() {
                            input[index].size = int.tryParse(s)!;
                          });
                        }, controllers[index][1], validators[index][1]),
                      ],
                    );
                  }),
            ),
          ),
          // function buttons
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 40),
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Allocate",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  bool go = true;
                  setState(() {
                    go = true;
                  });
                  int? numOfHoles = numberOfHoles.text.length == 0
                      ? 0
                      : double.tryParse(numberOfHoles.text) == null
                          ? 0
                          : int.tryParse(numberOfHoles.text);
                  for (var i = 0; i < numOfHoles!; i++) {
                    for (var j = 0; j < numberOfFields; j++) {
                      if (controllers[i][j].text.isEmpty ||
                          double.tryParse(controllers[i][j].text) == null) {
                        setState(() {
                          validators[i][j] = true;
                          go = false;
                        });
                      } else {
                        setState(() {
                          validators[i][j] = false;
                        });
                      }
                    }
                  }
                  if (go && numberOfHoles.text.length != 0) {
                    setState(() {
                      reqes.size = memorySizeInput;
                      reqes.holes = input;
                    });
                  }
                },
              ),
              SizedBox(width: 25),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Clear',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    generateInput();
                    clearControllers();
                    numberOfHoles.clear();
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
