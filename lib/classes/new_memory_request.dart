import 'package:memory_allocation/classes/hole.dart';

class NewMemoryRequest{
  int size =0;

  //nullable list
  List <Hole>? holes;

  NewMemoryRequest({this.size =0,this.holes});
}