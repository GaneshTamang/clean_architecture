class TodoModel {
  int? id;
  late String title;
  late String description;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"] ?? "";
    description = json["description"] ?? "";
  }
}

// Object Relational Mappping (ORM)