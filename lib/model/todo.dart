class ToDo {
  String? id;
  String? name;
  bool isDone;

  ToDo({
    required this.id,
    required this.name,
    this.isDone = false,
  });

  // array of ToDo objects
  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '1',
        name: 'Buy Milk',
        isDone: false,
      ),
      ToDo(
        id: '2',
        name: 'Buy Bread',
        isDone: true,
      ),
      ToDo(
        id: '3',
        name: 'Buy Eggs',
        isDone: false,
      ),
    ];
  }
}
