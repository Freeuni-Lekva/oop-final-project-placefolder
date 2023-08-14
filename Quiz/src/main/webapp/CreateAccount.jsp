<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Account</title>
    <style>
        body {
            background-color: #007bff;
            color: white;
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h1 {
            margin-top: 100px;
        }

        p {
            margin: 10px 0;
        }

        form {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            font-size: 18px;
            margin: 10px 0;
        }

        input[type="text"], input[type="password"] {
            width: 300px;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            margin: 5px 0;
        }

        input[type="submit"] {
            background-color: #1c98ff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Create New Account</h1>
    <p>Please enter proposed name and password</p>
    <form method="post" action="creationServlet">
        <label for="username">User Name:</label>
        <input type="text" name="username" placeholder="Enter your username" required>
        <label for="password">Password:</label>
        <input type="password" name="password" placeholder="Enter your password" required>
        <input type="submit" value="Create Account" id="CreateAccount">
    </form>
</body>
</html>