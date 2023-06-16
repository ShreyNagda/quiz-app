// ignore_for_file: non_constant_identifier_names

class Question{
  String category;
  String question;
  String difficulty;
  String correct_answer;
  List<dynamic> incorrect_answers;

  Question({
    required this.category,
    required this.question,
    required this.difficulty,
    required this.correct_answer,
    required this.incorrect_answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': this.category,
      'question': this.question,
      'difficulty': this.difficulty,
      'correct_answer': this.correct_answer,
      'incorrect_answers': incorrect_answers,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      category: map['category'] as String,
      question: map['question'] as String,
      difficulty: map['difficulty'] as String,
      correct_answer: map['correct_answer'] as String,
      incorrect_answers: map['incorrect_answers'] as List<dynamic>,
    );
  }
}