import 'package:memory_allocation/classes/deallocated_object.dart';
import 'package:memory_allocation/classes/memory_object.dart';
import 'package:memory_allocation/logic/globals.dart' as global;
import 'package:memory_allocation/classes/returned_allocated_object.dart';

//function called deallocate() that receives an object to be deallocated
ReturnedAllocatedObject deallocate(DeallocatedObject funcInput){
  ReturnedAllocatedObject funcOutput = ReturnedAllocatedObject();

  //if the object is of type "old process"
  if(funcInput.type=="old process"){
    int index;
    //find the memory object with the same type & id and pass it to the aux function deallocateSegment()
    index = global.memo.memoryObjectList.indexWhere((element) => element.type =="old process" && element.id == funcInput.id);
    deallocateSegment(global.memo.memoryObjectList[index]);
  }
  //if the deallocatedObject is of type "process"
  else if(funcInput.type=="process"){
    //search the memory for all segments with processId equals processId of the deallocatedObject
    //iterate over these segments & pass them to deallocateSegment() aux function
    for (int i=0; i<global.memo.memoryObjectList.length; i++) {
      //need a check for that condition
      if(global.memo.memoryObjectList[i].processId==funcInput.processId && global.memo.memoryObjectList[i].type == "process"){
        deallocateSegment(global.memo.memoryObjectList[i]);
        i=0;
      }
    }
  }

  funcOutput.memory = global.memo;
  funcOutput.status=true;
  return funcOutput;
}

//AUXILARY FUNCTION #3
//the function receives a memoryObject object in the memory to be replaced with a hole
void deallocateSegment(MemoryObject funcInput){
  //find maximum id+1 in the holes in the memory
  int count=0;
  for (var segment in global.memo.memoryObjectList) {
    if(segment.type=="hole"){
      count++;
    }
  }

//change the type of the object to "hole"
funcInput.type="hole";

//change the id of that hole into maxId + 1 (count)
funcInput.id=count;

//change the processId of the hole into null
funcInput.processId=null;

//change the name to hole + new id
funcInput.name="hole "+count.toString();

//if there is a hole before that hole
int beforeHoleEndAddressCheck = funcInput.startAddress ;
if(global.memo.memoryObjectList.indexWhere((element) => element.type=="hole" && element.startAddress + element.size == beforeHoleEndAddressCheck)!=-1){
//before hole index
int beforeHoleInd = global.memo.memoryObjectList.indexWhere((element) => element.type=="hole" && element.startAddress + element.size == beforeHoleEndAddressCheck);
//combine them using combineHoles() aux function
combineHoles(global.memo.memoryObjectList[beforeHoleInd],funcInput);
//this for before and after holes merge case
funcInput = global.memo.memoryObjectList[beforeHoleInd];
}

//if there is also a hole after that hole
int afterHoleAddressCheck = funcInput.startAddress + funcInput.size ;
if(global.memo.memoryObjectList.indexWhere((element) => element.type=="hole" && element.startAddress == afterHoleAddressCheck)!=-1){
  //after hole index
  int afterHoleInd = global.memo.memoryObjectList.indexWhere((element) => element.type=="hole" && element.startAddress == afterHoleAddressCheck);
  //combine them using combineHoles() aux function
  combineHoles(funcInput,global.memo.memoryObjectList[afterHoleInd]);
}

}

//AUXILARY FUNCTION #4
//the function receives 2 adjacent holes to combine them
void combineHoles(MemoryObject hole1, MemoryObject hole2){
  //determine which hole comes first in the memory (by startAddress)
  if(hole1.startAddress < hole2.startAddress){
     int hole2Index = global.memo.memoryObjectList.indexWhere((element) => element.startAddress == hole2.startAddress);
     //set the id of 1st hole as the minimum of the 2 ids of the 2 holes
     if(hole1.id>hole2.id){
       hole1.id=hole2.id;
       //set the name of the 1st hole to "hole + " the minimum id
       hole1.name=hole2.name;
     }
    //add the size of the second hole to the first hole
    hole1.size += hole2.size;
    //remove the second hole from the memory
    global.memo.memoryObjectList.removeAt(hole2Index);
  }
  else{
    int hole1Index = global.memo.memoryObjectList.indexWhere((element) => element.startAddress == hole1.startAddress);
   //set the id of 2nd hole as the minimum of the 2 ids of the 2 holes
     if(hole1.id<hole2.id){
       hole2.id=hole1.id;
       //set the name of the 2nd hole to "hole + " the minimum id
       hole2.name=hole1.name;
     }
   //add the size of the first hole to the second hole
   hole2.size += hole1.size;
   //remove the first hole from the memory
   global.memo.memoryObjectList.removeAt(hole1Index);
  }
}