package Quiz.src.main.java.models;

public class Answer{
    public int id;
    public int question_id;
    public String answer;
    public boolean isCorrect;

    public Answer(int id, int question_id, String answer, boolean isCorrect) {
        this.id = id;
        this.question_id = question_id;
        this.answer = answer;
        this.isCorrect = isCorrect;
    }
}