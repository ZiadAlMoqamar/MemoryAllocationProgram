import 'package:memory_allocation/classes/deallocated_object.dart';
import 'package:memory_allocation/classes/memory_object.dart';
import 'package:memory_allocation/classes/process.dart';
import 'package:memory_allocation/classes/returned_allocated_object.dart';
import 'package:memory_allocation/logic/globals.dart' as global;
import 'package:memory_allocation/logic/deallocation.dart';

//make a function called allocateProcess() that receives a process(array of memoryObjects) and allocation method
ReturnedAllocatedObject allocateProcess(Process funcInput, String allocationMethod) {
  ReturnedAllocatedObject funcOutput = ReturnedAllocatedObject();
  //make a loop on the process, for each memoryObject:
  for(int i=0; i<funcInput.segments!.length; i++){
   //search the memory for a hole with size >= the size of the memoryObject
   if(global.memo.memoryObjectList.indexWhere((element) => element.type=="hole" && element.size >= funcInput.segments![i].size)!=-1){
     //if found and the method is first fit
     if(allocationMethod == "first fit"){
       //sort according to startaddress
       global.memo.memoryObjectList.sort((a, b) => a.startAddress.compareTo(b.startAddress));
       // filter memory to get first of holes of size more than size of memoryObject
       var firstFitHole = global.memo.memoryObjectList.firstWhere((element) =>element.type=="hole" && element.size>=funcInput.segments![i].size );
       
       //allocate that memoryObject into that hole using allocateSegmentIntoHole() auxillary function
       allocateSegmentIntoHole(funcInput.segments![i],firstFitHole);
     }
     //if found and the method is best fit
     else if(allocationMethod == "best fit"){
       //sort according to size
       global.memo.memoryObjectList.sort((a, b) => a.size.compareTo(b.size));
       var bestFitHole = global.memo.memoryObjectList.firstWhere((element) => element.type=="hole" && element.size>=funcInput.segments![i].size);
       //allocate that memoryObject into that hole using allocateSegmentIntoHole() auxillary function
       allocateSegmentIntoHole(funcInput.segments![i],bestFitHole);
     }
     //if found and the method is worst fit
     else if(allocationMethod == "worst fit"){
       //sort according to size DESC
       global.memo.memoryObjectList.sort((b, a) => a.size.compareTo(b.size));
       var worstFitHole = global.memo.memoryObjectList.firstWhere((element) => element.type=="hole" && element.size>=funcInput.segments![i].size);
       //allocate that memoryObject into that hole using allocateSegmentIntoHole() auxillary function
       allocateSegmentIntoHole(funcInput.segments![i],worstFitHole);
     }
   }
   //if not found, return an error message to front end saying process doesn't fit into the memory.
   else{
     //sort according to startaddress
     global.memo.memoryObjectList.sort((a, b) => a.startAddress.compareTo(b.startAddress)); 
     //Also remove any memoryObject in the memory having processId equal to the id of current process (sent to this function) using Deallocate
     DeallocatedObject removal = DeallocatedObject(processId: funcInput.id, type: "process", id: null);
     funcOutput = deallocate(removal);
     funcOutput.message = "The process doesn't fit into the memory.";
     funcOutput.status = false;
     return funcOutput;
   } 
  }

  funcOutput.memory = global.memo;
  funcOutput.status = true;
  return funcOutput;
}


//AUXILARY FUNCTION #1
//the function receives a memoryObject object (from a process) and a hole object (from the memory)
void allocateSegmentIntoHole(MemoryObject segment, MemoryObject hole){
  //it sets the start of the memoryObject to the start of the hole and push it into the memory
  segment.startAddress = hole.startAddress;
  global.memo.memoryObjectList.add(segment);
  //it also modifies the start of the hole to be old start + memoryObject size
  hole.startAddress += segment.size;
  //and its size to be old size - memoryObject size
  hole.size -= segment.size;
  //if the size of the hole became 0, it removes the hole from the memory
  if(hole.size == 0){
    global.memo.memoryObjectList.removeWhere((element) => element.size == 0);
  }
   //sort according to startaddress
   global.memo.memoryObjectList.sort((a, b) => a.startAddress.compareTo(b.startAddress));
}