import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  Map<int, int> selectedAnswers = {}; // Question index and selected answer index

  // Sample questions and answers
  // In a real app, these might come from a backend or database
  List<Map<String, dynamic>> questions = [
    {
      "question": "What is Flutter?",
      "answers": [
        "A type of bird",
        "A mobile app SDK",
        "A test framework",
        "None of the above"
      ],
    },
    {
      "question": "Who created Flutter?",
      "answers": [
        "Facebook",
        "Adobe",
        "Google",
        "Microsoft"
      ],
    },
  ];

  void selectAnswer(int answerIndex) {
    if (selectedAnswers.containsKey(currentQuestionIndex)) {
      // If an answer is already selected for this question, show a toast
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cannot change answer once selected."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      selectedAnswers[currentQuestionIndex] = answerIndex;
    });
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> answers = questions[currentQuestionIndex]["answers"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              questions[currentQuestionIndex]["question"],
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: answers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(answers[index]),
                  onTap: () => selectAnswer(index),
                  tileColor: selectedAnswers[currentQuestionIndex] == index
                      ? Colors.blue
                      : null,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: goToPreviousQuestion,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: goToNextQuestion,
                child: Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
