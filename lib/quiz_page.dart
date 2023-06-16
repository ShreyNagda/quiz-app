import 'package:flutter/material.dart';

import 'main.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  List<Icon> scoreKeeper = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // QuestionProvider provider = QuestionProvider();
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Exit kwizz?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Exit',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
        );
        return Future.value(false);
      },
      child: SafeArea(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [...scoreKeeper],
                ),
              ),
              Expanded(
                flex: 10,
                child: Center(
                  child: Text(
                    provider.getQuestionText(),
                    style:
                        const TextStyle(fontSize: 25, fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              Row(
                children: [
                  Text('Category:${provider.getQuestionCategory()}'),
                  Text("")
                ],
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    checkAnswer('true');
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: Colors.green),
                  child: const Text('True'),
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    checkAnswer('false');
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: Colors.red),
                  child: const Text('False'),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void checkAnswer(String userEnteredAnswer) {
    if (provider.correctAnswer() == userEnteredAnswer) {
      //add to score
      score++;
      // print(score);
      scoreKeeper.add(const Icon(
        Icons.check,
        color: Colors.green,
      ));
      // print('Correct');
    } else {
      //not add to score
      scoreKeeper.add(const Icon(
        Icons.close,
        color: Colors.red,
      ));
      // print('Incorrect');
    }

    if (!provider.isFinished()) {
      setState(() {
        provider.nextQuestion();
      });
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return WillPopScope(
              onWillPop: () => Future.value(false),
              child: SizedBox(
                width: 200,
                height: 200,
                child: AlertDialog(
                  title: const Text('Quiz Finished'),
                  content: Text(
                    'Your Score: $score/${provider.questions.length}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(30)),
                      onPressed: () {
                        Navigator.pop(context);
                        score = 0;
                        scoreKeeper = [];
                        Navigator.pop(context);
                        provider.reset();
                      },
                      child: const Text('Home'),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}
