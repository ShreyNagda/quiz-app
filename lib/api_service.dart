import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quizz/Model/question.dart';

import 'Model/category.dart';

class ApiService {
  Future<List<Question>> fetchQuestions(String url) async {
    List<Question> temp = [];
    var response = await http.get(Uri.parse(url));
    var dataMap = jsonDecode(response.body);
    List<dynamic> data = dataMap['results'];
    for (var element in data) {
      temp.add(Question.fromMap(element));
    }
    return temp;
  }

  Future<List<TriviaCategory>> fetchCategories() async {
    List<TriviaCategory> categories = [];
    String categoryUrl = "https://opentdb.com/api_category.php";
    Uri categoryUri = Uri.parse(categoryUrl);
    var response = await http.get(categoryUri);
    Map datamap = jsonDecode(response.body);
    List<dynamic> data = datamap['trivia_categories'];
    for (var element in data) {
      categories.add(TriviaCategory.fromMap(element));
    }
    return categories;
  }
}
