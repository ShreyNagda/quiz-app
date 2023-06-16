import 'package:html_unescape/html_unescape.dart';
import 'package:quizz/Model/question.dart';
import 'package:quizz/api_service.dart';

class QuestionProvider {
  late List<Question> questions;

  // late String url;
  bool isInitialized = false;
  int questionNumber = 0;

  QuestionProvider() {
    // init(url)
  }

  Future<void> init(String url) async {
    questions = await ApiService().fetchQuestions(url);
    isInitialized = true;
    // notifyListeners();
  }

  String getQuestionText() {
    HtmlUnescape unescape = HtmlUnescape();
    return unescape.convert(questions[questionNumber].question);
  }

  String correctAnswer() {
    // print(questions[questionNumber].correct_answer);
    return questions[questionNumber].correct_answer.toLowerCase();
  }
  String getQuestionDifficulty() {
    return questions[questionNumber].category;
  }

  void nextQuestion() {
    if (questionNumber < questions.length - 1) {
      questionNumber++;
    }
  }
  String getQuestionCategory() {
    return questions[questionNumber].category;
  }

  bool isFinished() {
    return questionNumber >= questions.length - 1;
  }

  void reset() {
    questionNumber = 0;
  }

  Future<List<String>> categorynames() async {
    List<String> names = [];
    var data = await ApiService().fetchCategories();
    data.forEach((element) {
      names.add(element.name);
    });
    return names;
  }
}
