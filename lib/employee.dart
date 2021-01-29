class Employee {
  int id;
  String name;

  Employee(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  Employee.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}

class Note {
  int id;
  String title;
  String message;
  String date;

  Note(
    this.id,
    this.title,
    this.message,
    this.date,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'date': date
    };
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    message = map['message'];
    date = map['date'];
  }
}
