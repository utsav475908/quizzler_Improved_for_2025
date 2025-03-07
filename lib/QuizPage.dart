import 'package:flutter/material.dart';
import 'QuizBrain.dart';

// View Layer
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBrain _quiz = QuizBrain();

  void _handleAnswer(bool userAnswer) {
    setState(() {
      _quiz.answerQuestion(userAnswer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: _quiz.isComplete
              ? _CompletionScreen(score: _quiz.score, totalQuestions: _quiz.questionCount)
              : _QuestionText(question: _quiz.currentQuestion),
        ),
        _AnswerButton(
          color: Colors.green,
          text: 'True',
          onPressed: _quiz.isComplete ? null : () => _handleAnswer(true),
        ),
        _AnswerButton(
          color: Colors.red,
          text: 'False',
          onPressed: _quiz.isComplete ? null : () => _handleAnswer(false),
        ),
        _ScoreRow(answerResults: _quiz.answerResults),
      ],
    );
  }
}

// Reusable Components
class _QuestionText extends StatelessWidget {
  final String question;

  const _QuestionText({required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          question,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25.0, color: Colors.green),
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;

  const _AnswerButton({
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  final List<bool> answerResults;

  const _ScoreRow({required this.answerResults});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: answerResults.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.0),
        itemBuilder: (context, index) => Icon(
          answerResults[index] ? Icons.check_circle : Icons.cancel,
          color: answerResults[index] ? Colors.green : Colors.red,
          size: 24.0,
        ),
      ),
    );
  }
}

class _CompletionScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const _CompletionScreen({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Quiz Completed!',
              style: TextStyle(fontSize: 30, color: Colors.white)),
          SizedBox(height: 20),
          Text('Score: $score/$totalQuestions',
              style: TextStyle(fontSize: 24, color: Colors.blue)),
        ],
      ),
    );
  }
}