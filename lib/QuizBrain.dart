// Model Layer
import 'Question.dart';

class QuizBrain {
  final List<Question> _questions = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
  ];

  int _score = 0;
  List<bool> answerResults = [];

  int get questionCount => _questions.length;
  int get score => _score;
  String get currentQuestion => _questions[answerResults.length].text;
  bool get isComplete => answerResults.length >= _questions.length;

  void answerQuestion(bool userAnswer) {
    if (isComplete) return;

    bool isCorrect = userAnswer == _questions[answerResults.length].answer;
    answerResults.add(isCorrect);

    if (isCorrect) _score++;
  }
}