class MemoryObject {
  String? name;
  String type = '';
  int id = -1;
  int? processId;
  int startAddress = -1;
  int size = 0;

  MemoryObject(
      {this.name,
      this.id = -1,
      this.type = '',
      this.processId,
      this.startAddress = -1,
      this.size = 0});
}
