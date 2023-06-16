class TriviaCategory{
  int id;
  String name;

  TriviaCategory({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory TriviaCategory.fromMap(Map<String, dynamic> map) {
    return TriviaCategory(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}