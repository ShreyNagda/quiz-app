// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz/question_provider.dart';
import 'package:quizz/quiz_page.dart';

late QuestionProvider provider;
late List<String> categoryNames;
List<String> difficulty_list = ['easy', 'medium', 'hard', 'any difficulty'];

Future<void> main() async {
  provider = QuestionProvider();
  // await ApiService().fetchCategories();
  categoryNames = await provider.categorynames();
  categoryNames.add('Any Category');
  // print(categoryNames);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizz',
      theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfQuestions = 10;

  String difficulty = difficulty_list.last.toLowerCase();
  String category = categoryNames.last.toLowerCase();
  int categoryID = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Kwizz',
          style: TextStyle(fontSize: 34, fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                const Text(
                  "Number of Questions: ",
                  style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (numberOfQuestions > 5) {
                                numberOfQuestions--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove)),
                      Text(
                        "$numberOfQuestions",
                        style: const TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (numberOfQuestions < 20) {
                                numberOfQuestions++;
                              }
                            });
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: DropdownButtonFormField(
                  // padding: const EdgeInsets.all(8),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
                  value: difficulty,
                  items: difficulty_list
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.toLowerCase(),
                          child: Text(e[0].toUpperCase() +
                              e.substring(1).toLowerCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      difficulty = value!;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                    // suffixIcon: null,
                    ),
                // padding: const EdgeInsets.all(8),
                value: category.toLowerCase(),
                items: categoryNames
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.toLowerCase(),
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    category = value!;
                    // print(categoryID);
                    categoryID = categoryNames
                            .map((e) => e.toLowerCase())
                            .toList()
                            .indexOf(category) +
                        9;
                  });
                  // print(category);
                  // print(categoryID);
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const Dialog(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Fetching Questions!",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Montserrat'),
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        );
                      });
                  String url;
                  if (difficulty == difficulty_list.last && categoryID != 33) {
                    url =
                        "https://opentdb.com/api.php?amount=$numberOfQuestions&type=boolean&category=$categoryID";
                  } else if (difficulty == difficulty_list.last &&
                      categoryID == 33) {
                    url =
                        "https://opentdb.com/api.php?amount=$numberOfQuestions&type=boolean";
                  } else {
                    url =
                        "https://opentdb.com/api.php?amount=$numberOfQuestions&category=$categoryID&difficulty=$difficulty&type=boolean";
                  }
                  // print(url);

                  await provider.init(url);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => const QuizPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text(
                  "Start Quiz",
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
