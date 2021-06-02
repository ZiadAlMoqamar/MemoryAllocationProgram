  // NewMemoryRequest memoReqExample = NewMemoryRequest();
  // memoReqExample.size =100;
  // memoReqExample.holes.add(Hole(startAddress: 0, size: 20));
  // memoReqExample.holes.add(Hole(startAddress: 30, size: 20));
  // memoReqExample.holes.add(Hole(startAddress: 60, size: 40));
  // ReturnedAllocatedObject test = intializing.makeNewMemory(memoReqExample);
  // print(test.status);
  // print(test.message);
  // print(test);
  // global.memorySize = 100;
  // global.memo.memoryObjectList.add(MemoryObject(
  //     name: "hole 0",
  //     type: "hole",
  //     id: 0,
  //     processId: null,
  //     startAddress: 10,
  //     size: 30));
  // global.memo.memoryObjectList.add(MemoryObject(
  //     name: "hole 1",
  //     type: "hole",
  //     id: 1,
  //     processId: null,
  //     startAddress: 50,
  //     size: 40));
  // global.memo.memoryObjectList.add(MemoryObject(
  //   name: "hole 2",
  //   type: "hole",
  //   id: 2,
  //   processId: null,
  //   startAddress: 80,
  //   size: 10));
  // global.memo.memoryObjectList.add(MemoryObject(
  //     name: "old process 0",
  //     type: "old process",
  //     id: 0,
  //     processId: null,
  //     startAddress: 0,
  //     size: 10));
  // global.memo.memoryObjectList.add(MemoryObject(
  //     name: "old process 1",
  //     type: "old process",
  //     id: 1,
  //     processId: null,
  //     startAddress: 40,
  //     size: 10));
  //   global.memo.memoryObjectList.add(MemoryObject(
  //     name: "old process 2",
  //     type: "old process",
  //     id: 2,
  //     processId: null,
  //     startAddress: 90,
  //     size: 10));
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
  // print(global.memorySize);
  // DeallocatedObject testde =
  //     DeallocatedObject(processId: 0, type: "process", id: null);
  // var returned = deallocate(testde);
  // List<MemoryObject> objectSegments = [];
  // objectSegments.add(MemoryObject(
  //     name: "bla bla", type: "process", id: 0, processId: 0, size: 20));
  // objectSegments.add(MemoryObject(
  //     name: "bla bla", type: "process", id: 1, processId: 0, size: 20));
  // // objectSegments.add(MemoryObject(
  // //     name: "bla bla", type: "process", id: 2, processId: 0, size: 40));
  // Process test = Process(id: 0, segments: objectSegments);
  // var returned = allocateProcess(test, "worst fit");
  // Memory x = global.memo;
  // print(x);