import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quiz_app/Question.dart';
import 'package:fluttertoast/fluttertoast.dart';

class quizScreen extends StatefulWidget {
  const quizScreen({super.key});

  @override
  State<quizScreen> createState() => _quizScreenState();
}

class _quizScreenState extends State<quizScreen> {
  int current_Index = 0;
  int score = 0;

  bool isEnableNextButton = false;

  Map<int, int> selectedAnswer = {};

  void RestartQuiz() {
    setState(() {
      current_Index = 0;
      score = 0;
      selectedAnswer.clear();
    });
  }

  void correctAnswer(int selectOption) {
    if (selectOption==questionList[current_Index].correctAnswer){
      setState(() {
        score++;
      });
    }
    if (selectedAnswer.containsKey(current_Index)) {
      Fluttertoast.showToast(msg: "Sorry Answer Can not be Changed");
      return;
    }
    setState(() {
      selectedAnswer[current_Index] = selectOption;
    });
  }
  showResult() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Result"),
              content: Text("Your Score = $score"),
              actions: [
                TextButton(
                    onPressed: () {
                      RestartQuiz();
                      Navigator.pop(context);
                    },
                    child: Text("Restart Quiz")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Okay"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        title: Center(child: Text("QUIZ APP")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(questionList[current_Index].Question,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 15,),

          for (int i = 0; i < questionList[current_Index].options.length; i++)
            GestureDetector(
                child: Container(
                  child: Text(
                    questionList[current_Index].options[i],
                    style: selectedAnswer[current_Index] == i
                        ? TextStyle(color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic

                               )
                        : TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                onTap: () {
                  correctAnswer(i);
                }),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ElevatedButton(
                  onPressed: () {
                    if (current_Index > 0) {
                      setState(() {
                        current_Index--;
                      });
                    } else {
                      Fluttertoast.showToast(backgroundColor:Colors.grey.shade400,
                          textColor: Colors.black,fontSize: 18,
                          msg: "Move Forword");
                    }
                  },
                  child: Text("Perivous Question",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.grey.shade400)),

              ),
              SizedBox(
                width: 10,
              ),
              if (current_Index < questionList.length - 1)
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        current_Index++;

                      });

                    }, style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.grey.shade400)),
                    child: Text("Next Question",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                    )
                )
              else
                ElevatedButton(
                    onPressed: () {
                      showResult();
                    },
                    style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.grey.shade400)),
                    child: Text("Show Result",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),))
            ],
          )
        ],
      ),
    );
  }
}
