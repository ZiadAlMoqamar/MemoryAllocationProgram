import 'package:memory_allocation/classes/memory_object.dart';

class Process{
  
//nullable list
List <MemoryObject>? segments=[];
int id= -1;

Process({this.id = -1,this.segments});
}