import 'package:memory_allocation/classes/memory.dart';
import 'package:memory_allocation/classes/memory_object.dart';
import 'package:memory_allocation/classes/new_memory_request.dart';
import 'package:memory_allocation/classes/returned_allocated_object.dart';

Memory memo = Memory();
int memorySize = 0;

ReturnedAllocatedObject makeNewMemory(NewMemoryRequest req) {
  ReturnedAllocatedObject funcOutput = ReturnedAllocatedObject();

  //check that the starting address and (the starting address + size) of each hole are within the memory size
  for (var hole in req.holes) {
    if (hole.startAddress < req.size &&
        hole.startAddress + hole.size <= req.size) {
      funcOutput.status = true;
    } else {
      funcOutput.status = false;
      funcOutput.message =
          "The holes size or starting addresses are not in the memory size";
      return funcOutput;
    }
  }

  if (req.holes.length != 1) {
    //check that holes are not overlapped
    if (funcOutput.status == true) {
      for (int i = 0;
          i < req.holes.length - 1 && funcOutput.status == true;
          i++) {
        for (int j = i + 1; j < req.holes.length; j++) {
          if (req.holes[i].startAddress + req.holes[i].size >
              req.holes[j].startAddress) {
            funcOutput.message = "Holes are overlapped";
            funcOutput.status = false;
            return funcOutput;
          }
        }
      }
    }
//check that holes aren't adjacent
    if (funcOutput.status == true) {
      for (int i = 0;
          i < req.holes.length - 1 && funcOutput.status == true;
          i++) {
        for (int j = i + 1; j < req.holes.length; j++) {
          if (req.holes[i].startAddress + req.holes[i].size ==
              req.holes[j].startAddress) {
            funcOutput.message = "Holes are adjacent";
            funcOutput.status = false;
            return funcOutput;
          }
        }
      }
    }
  }

  //overwrite the memorySize to the new size
  memorySize = req.size;

  //sort holes according to start address
  req.holes.sort((a, b) => a.startAddress.compareTo(b.startAddress));

  //overwrite the global variable "memory" to just the new holes
  for (int i = 0; i < req.holes.length; i++) {
    memo.memoryObjectList.add(MemoryObject(
        name: "hole " + i.toString(),
        type: "hole",
        id: i,
        startAddress: req.holes[i].startAddress,
        size: req.holes[i].size));
  }

  //adding old processes to global var


  //check if there is an old process at address 0
  bool isThereStartOldProcess = false;
  if (req.holes.first.startAddress != 0) {
    memo.memoryObjectList.add(MemoryObject(
        name: "old process 0",
        type: "old process",
        id: 0,
        startAddress: 0,
        size: req.holes.first.startAddress ));
    isThereStartOldProcess = true;
  }
  //check if there is an old process at the end of the memory
  bool isThereEndOldProcess = false;
  if (req.holes.last.startAddress + req.holes.last.size != req.size) {
    int oldProcessNum =
        (isThereStartOldProcess) ? req.holes.length : req.holes.length - 1;
    int startAdd = req.holes.last.startAddress + req.holes.last.size ;
    memo.memoryObjectList.add(MemoryObject(
        name: "old process " + oldProcessNum.toString(),
        type: "old process",
        id: oldProcessNum,
        startAddress: startAdd,
        size: req.size - startAdd));
    isThereEndOldProcess = true;
  }

  //adding inbetween old processes
  if (isThereStartOldProcess) {
    for (int i = 0; i < req.holes.length - 1; i++) {
      int oldProcessStartingAdd = req.holes[i].startAddress + req.holes[i].size ;
      int oldProcessSize =
          req.holes[i + 1].startAddress - oldProcessStartingAdd ;
      memo.memoryObjectList.add(MemoryObject(
          name: "old process " + (i + 1).toString(),
          type: "old process",
          id: i + 1,
          startAddress: oldProcessStartingAdd,
          size: oldProcessSize));
    }
  } else {
    for (int i = 0; i < req.holes.length - 1; i++) {
      int oldProcessStartingAdd = req.holes[i].startAddress + req.holes[i].size ;
      int oldProcessSize =
          req.holes[i + 1].startAddress - oldProcessStartingAdd ;
      memo.memoryObjectList.add(MemoryObject(
          name: "old process " + (i).toString(),
          type: "old process",
          id: i,
          startAddress: oldProcessStartingAdd,
          size: oldProcessSize));
    }
  }
//sort memory according to starting address
  memo.memoryObjectList.sort((a, b) => a.startAddress.compareTo(b.startAddress));
//the function should return the memory to the front end to be drawn
  funcOutput.memory=memo;
  return funcOutput;
}
