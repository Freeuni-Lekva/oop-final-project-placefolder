-- CREATE USER 'oopUser'@'localhost' IDENTIFIED BY 'oopUserPasswrd';
-- GRANT ALL PRIVILEGES ON *.* TO 'oopUser'@'localhost';
-- CREATE DATABASE oop_proj;

use oop_proj;

DROP TABLE IF EXISTS announcements;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS quiz_history;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS friends;
DROP TABLE IF EXISTS user_achievements;
DROP TABLE IF EXISTS achievements;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255),
    password_hash VARCHAR(255),
    pfp VARCHAR(1000)
);

CREATE TABLE friends (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	user_id INT,
    friend_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (friend_id) REFERENCES users(id)
);

CREATE TABLE quizzes (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    creator_id INT,
    quiz_name VARCHAR(2000),
    description VARCHAR(2000),
    is_single_page bool,
    can_be_practiced bool,
    FOREIGN KEY (creator_id) REFERENCES users(id)
);

CREATE TABLE questions (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    question_num INT,
    quiz_id INT,
    question_type INT,
    question VARCHAR(2000),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

CREATE TABLE answers (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    question_id INT,
    answer VARCHAR(2000),
    is_correct bool,
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE quiz_history (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    score DECIMAL(5, 2),
    quiz_id INT,
    user_id INT,
    time_taken INT,
    take_date TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE notifications (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	receiver_id INT,
    sender_id INT,
    FOREIGN KEY (receiver_id) REFERENCES users(id),
    FOREIGN KEY (sender_id) REFERENCES users(id),
    notif_type VARCHAR(20),
    notif_body VARCHAR(2000)
);

CREATE TABLE announcements (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    announcement VARCHAR(2000)
);

CREATE TABLE achievements (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    achievement VARCHAR(2000),
    to_earn VARCHAR(2000)
);

INSERT INTO achievements (achievement, to_earn) 
VALUES ('Amateur Author', 'Create your first quiz'), 
	   ('Prolific Author', 'Create 5 quizzes'), 
       ('Prodigious Author', 'Create 10 quizzes'), 
       ('Quiz Machine', 'Take 10 quizzes'), 
       ('I am the Greatest', 'Get the highest score on a quiz'), 
       ('Practice Makes Perfect', 'Take your first practice quiz');

CREATE TABLE user_achievements (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT,
    achievement_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (achievement_id) REFERENCES achievements(id)
);

-- TEST DATA:

INSERT INTO users (username, password_hash)
VALUES ('John Deer', '1234'),
	   ('Serena Anderson', '5678'),
       ('Xavier Patel', '4321');

INSERT INTO notifications (receiver_id, sender_id, notif_type, notif_body) 
VALUES (1, 2, 'note', 'Hello'),
	   (2, 1, 'note', 'Hi'),
	   (1, 2, 'note', 'Test1'),
	   (1, 3, 'note', 'Test2'),
       (3, 2, 'note', 'qwer'),
	   (3, 1, 'note', 'tyui');

INSERT INTO quizzes(  creator_id, quiz_name, description, is_single_page, can_be_practiced)
VALUES  (1,'dinozavrebi','Dinosaurs are a diverse group of reptiles of the clade Dinosauria. They first appeared during the Triassic period, between 245 and 233.23 million years ago (mya), although the exact origin and timing of the evolution of dinosaurs is a subject of active research. They became the dominant terrestrial vertebrates after the Triassic–Jurassic extinction event 201.3 mya and their dominance continued throughout the Jurassic and Cretaceous periods. The fossil record shows that birds are feathered dinosaurs, having evolved from earlier theropods during the Late Jurassic epoch, and are the only dinosaur lineage known to have survived the Cretaceous–Paleogene extinction event approximately 66 mya. Dinosaurs can therefore be divided into avian dinosaurs—birds—and the extinct non-avian dinosaurs, which are all dinosaurs other than birds.',
         true,false)
       
INSERT INTO user_achievements(user_id, achievement_id)
VALUES (1,1),
       (1,2),
       (1,3),
       (1,4),
       (1,5),
       (1,6),
       (2,4),
       (2,5),
       (2,6),
       (3,1),
       (3,2);

