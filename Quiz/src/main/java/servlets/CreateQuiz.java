package Quiz.src.main.java.servlets;

import Quiz.src.main.java.models.*;
import Quiz.src.main.java.models.models.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Array;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.annotation.WebServlet;

@WebServlet("/CreateQuiz")
public class CreateQuiz extends HttpServlet {
    // question types:
    // 0 - Question-Response
    // 1 - Fill in the Blank
    // 2 - Multiple Choice
    // 3 - Picture-Response
    // 4 - Multi-Answer
    // 5 - Mult-answ-choise

    boolean parseBooleanFromReq(String bool_str){
        if(bool_str == null){
            return false;
        }
        if(bool_str.equals("1") || bool_str.equals("on")){
            return true;
        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Create Quiz Servlet");
        response.setContentType("text/html");

        boolean editingQuiz = false;

        String quiz_id = request.getParameter("quiz_id");
        String userId_req = request.getParameter("userId");
        String quiz_name = request.getParameter("quiz_name");
        String description = request.getParameter("description");
        String maxQuestionIndex = request.getParameter("maxQuestionIndex");
        String isSinglePageCB = request.getParameter("isSinglePageCB");
        String can_be_practicedCB = request.getParameter("canBePracticedCB");
        String randQuestOrderCB = request.getParameter("randQuestOrderCB");
        String quizTagMaxIndex = request.getParameter("quiz_tag_max_index");
        String quizCategory = request.getParameter("quiz_category");

        DBConn dbConn = new DBConn();

        int quizId = -1;
        if(quiz_id == null){
            quizId = dbConn.getNextQuizId();
        } else {
            editingQuiz = true;
            quizId = Integer.parseInt(quiz_id);
        }

        if(maxQuestionIndex == null){
            System.out.println("maxQuestionIndex is null");
            return;
        }

        System.out.println("quizCategory: " + quizCategory);

        int quizTagMax = 0;
        if(quizTagMaxIndex != null){
            quizTagMax = Integer.parseInt(quizTagMaxIndex);
        }

        for(int i = 1; i <= quizTagMax; i++){
            String quizTag = request.getParameter("quiz_tag" + i);
            if(quizTag == null){
                continue;
            }
            System.out.println(quizTag);
        }

        boolean isSinglePageCB_BOOL = parseBooleanFromReq(isSinglePageCB);
        boolean can_be_practicedCB_BOOL = parseBooleanFromReq(can_be_practicedCB);
        boolean randQuestOrderCB_BOOL = parseBooleanFromReq(randQuestOrderCB);

        int maxQuestionIndex_INT = Integer.parseInt(maxQuestionIndex);

        int creator_id = Integer.parseInt(userId_req);

        Quiz quiz = new Quiz(quizId, creator_id, quiz_name, description, isSinglePageCB_BOOL, can_be_practicedCB_BOOL, randQuestOrderCB_BOOL);

        int questionId = dbConn.getLastQuestionId();

        if(editingQuiz){
            dbConn.updateQuiz(quiz);
            dbConn.trimQuiz(quiz);
        } else {
            dbConn.insertQuiz(quiz);
        }
        ArrayList<Question> questionsToInsert = new ArrayList<>();
        ArrayList<Answer> answersToInsert = new ArrayList<>();

        for(int i = 1; i <= maxQuestionIndex_INT; i++){
            questionId++;
            String question_type = request.getParameter(String.format("select%d", i));
            String questionText = request.getParameter(String.format("question%d", i));
            String answerCount = request.getParameter(String.format("answerCount%d", i));

            if(answerCount == null){
                System.out.println("answerNum " + i + " is null");
                continue;
            }
            if(question_type == null){
                System.out.println("question_type " + i + " == null");
                continue;
            }

            int answerCount_Int = Integer.parseInt(answerCount);
            int questionType_INT = Integer.parseInt(question_type);
            int question_num = i;

            Question question = new Question(questionId, quizId, questionText, questionType_INT, question_num);
//            dbConn.insertQuestion(question);
            questionsToInsert.add(question);

            if(questionType_INT == 0 || questionType_INT == 3){                                     // 1/1 answer
                String answer_text = request.getParameter(String.format("q%d", i));
                boolean is_correct = true;
                Answer answer = new Answer(-1, questionId, answer_text, is_correct);
//                dbConn.insertAnswer(answer);
                answersToInsert.add(answer);

            } else if(questionType_INT == 1 || questionType_INT == 4){                              // n/n answers
                for(int k = 1; k <= answerCount_Int; k++) {
                    int answer_num = k;
                    String answer_text = request.getParameter(String.format("q%d-ans%d", i, k));
                    System.out.println("answer_text: " + answer_text);
                    boolean is_correct = true;
                    Answer answer = new Answer(-1, questionId, answer_text, is_correct);
                    answersToInsert.add(answer);
//                    dbConn.insertAnswer(answer);
                }
            } else if(questionType_INT == 2){                                                       // 1/n answer
                String correctAnswerIndex = request.getParameter(String.format("rb%d", i));
                if(correctAnswerIndex == null){
                    System.out.println("correctAnswerIndex " + i + "== null");
                    continue;
                }
                int correctAnswerIndex_INT = Integer.parseInt(correctAnswerIndex);
                for(int k = 1; k <= answerCount_Int; k++) {
                    int answer_num = k;
                    String answer_text = request.getParameter(String.format("q%d-ans%d", i, k));
                    boolean is_correct = k == correctAnswerIndex_INT;
                    Answer answer = new Answer(-1, questionId, answer_text, is_correct);
                    answersToInsert.add(answer);
//                    dbConn.insertAnswer(answer);
                }
            } else if(questionType_INT == 5){                                                       // m/n answer
                for(int k = 1; k <= answerCount_Int; k++) {
                    String isCorrect = request.getParameter(String.format("cb%d-ans%d", i, k));

                    boolean is_correct = parseBooleanFromReq(isCorrect);

                    String answer_text = request.getParameter(String.format("q%d-ans%d", i, k));
                    Answer answer = new Answer(-1, questionId, answer_text, is_correct);
                    answersToInsert.add(answer);
//                    dbConn.insertAnswer(answer);
                }
            }
        }

        for(Question question : questionsToInsert){
            dbConn.insertQuestion(question);
        }
        for(Answer answer : answersToInsert){
            dbConn.insertAnswer(answer);
        }

        dbConn.closeDBConn();

//        response.sendRedirect(redirectUrl);
    }
}
