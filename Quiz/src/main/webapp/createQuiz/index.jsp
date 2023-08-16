<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Quiz.src.main.java.models.Achievement" %>
<%@ page import="Quiz.src.main.java.models.User" %>
<%@ page import="Quiz.src.main.java.models.Notification" %>
<%@ page import="Quiz.src.main.java.models.QuizHistory" %>
<%@ page import="Quiz.src.main.java.models.Quiz" %>
<%@ page import="Quiz.src.main.java.models.DBConn" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
  <title>Create Quiz</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginPage.jsp");
            return;
        }
        int userId= user.getId();
    %>
    <div class="block-container">
        <div class="block-contents">
            <div id="create_manually" class="block-title">Create manually</div>
            <form action="/CreateQuiz" method="get" id="quiz-contents">
                <input name="userId" type="hidden" value="<%= userId%>"></input>
                <input name="quiz_name" class="note_text" placeholder="Quiz name" type="text"></input>
                <br>
                <textarea name="description" class="note_text" placeholder="Quiz description" rows="4" cols="50"></textarea>
                <br>
                <input type="checkbox" name="isSinglePageCB" value="1">
                <label for="isSinglePageCB"> Is single page</label>
                <br>
                <input type="checkbox" name="canBePracticedCB" value="1">
                <label for="canBePracticedCB"> Can be practiced</label>
                <br>
                <input type="checkbox" name="randQuestOrderCB" value="1">
                <label for="randQuestOrderCB"> Randomize quesiton order</label>
                <br>
                <button class="action-button" id="addQuestion">Add Question</button>
                <br>
                <input class="action-button" type="submit">
                <input type="hidden" id="maxQuestionIndex" name="maxQuestionIndex" value="0">
            </form>
        </div>
    </div>
    <div class="block-container">
        <div class="block-contents">
            <div class="block-title">Create from json file</div>
            <br>
            <form action="/CreateQuizJson" method="post" enctype="multipart/form-data">
                <input class="action-button" type="file" id="fileId" name="filename">
                <br>
                <input class="action-button" type="submit">
            </form>
            <br>
            <div class="block-items"> sample quiz json:</div>
            <img class="sampleQuiz" src="./sampleQuiz.svg"/>
        </div>
    </div>
    <script src="script.js"></script>
</body>
</html>