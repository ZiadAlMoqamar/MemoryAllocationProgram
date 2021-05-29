import 'package:flutter/material.dart';
import 'package:memory_allocation/classes/deallocated_object.dart';
import 'package:memory_allocation/classes/memory_object.dart';
import 'package:memory_allocation/classes/new_memory_request.dart';
import 'package:memory_allocation/classes/hole.dart';
import 'package:memory_allocation/classes/returned_allocated_object.dart';
import 'package:memory_allocation/logic/allocation.dart';
import 'package:memory_allocation/logic/deallocation.dart';
import 'package:memory_allocation/logic/intializing.dart' as intializing;
import 'package:memory_allocation/classes/memory.dart';
import 'package:memory_allocation/logic/globals.dart' as global;

import 'classes/process.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // NewMemoryRequest memoReqExample = NewMemoryRequest();
    // memoReqExample.size =100;
    // memoReqExample.holes.add(Hole(startAddress: 0, size: 20));
    // memoReqExample.holes.add(Hole(startAddress: 30, size: 20));
    // memoReqExample.holes.add(Hole(startAddress: 60, size: 40));
    // ReturnedAllocatedObject test = intializing.makeNewMemory(memoReqExample);
    // print(test.status);
    // print(test.message);
    // print(test);
    global.memorySize = 100;
    global.memo.memoryObjectList.add(MemoryObject(
        name: "hole 0",
        type: "hole",
        id: 0,
        processId: null,
        startAddress: 10,
        size: 30));
    global.memo.memoryObjectList.add(MemoryObject(
        name: "hole 1",
        type: "hole",
        id: 1,
        processId: null,
        startAddress: 50,
        size: 40));
      // global.memo.memoryObjectList.add(MemoryObject(
      //   name: "hole 2",
      //   type: "hole",
      //   id: 2,
      //   processId: null,
      //   startAddress: 80,
      //   size: 10));
    global.memo.memoryObjectList.add(MemoryObject(
        name: "old process 0",
        type: "old process",
        id: 0,
        processId: null,
        startAddress: 0,
        size: 10));
    global.memo.memoryObjectList.add(MemoryObject(
        name: "old process 1",
        type: "old process",
        id: 1,
        processId: null,
        startAddress: 40,
        size: 10));
      global.memo.memoryObjectList.add(MemoryObject(
        name: "old process 2",
        type: "old process",
        id: 2,
        processId: null,
        startAddress: 90,
        size: 10));
      //  global.memo.memoryObjectList.add(MemoryObject(
      //   name: "old process 3",
      //   type: "old process",
      //   id: 3,
      //   processId: null,
      //   startAddress: 90,
      //   size: 10));
    // global.memo.memoryObjectList.add(MemoryObject(
    //     name: "old process 2",
    //     type: "old process",
    //     id: 2,
    //     processId: null,
    //     startAddress: 70,
    //     size: 30));
    print(global.memorySize);
    // DeallocatedObject testde =
    //     DeallocatedObject(processId: 0, type: "process", id: null);
    // var returned = deallocate(testde);
    List<MemoryObject> objectSegments = [];
    objectSegments.add(MemoryObject(
        name: "bla bla", type: "process", id: 0, processId: 0, size: 20));
    objectSegments.add(MemoryObject(
        name: "bla bla", type: "process", id: 1, processId: 0, size: 20));
    // objectSegments.add(MemoryObject(
    //     name: "bla bla", type: "process", id: 2, processId: 0, size: 40));
    Process test = Process(id: 0, segments: objectSegments);
    var returned = allocateProcess(test, "worst fit");
    Memory x = global.memo;
    print(x);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
