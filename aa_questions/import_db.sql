PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
id INTEGER PRIMARY KEY,
fname VARCHAR(100),
lname VARCHAR(100)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(200),
  body VARCHAR(300),
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR(300),
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  parent_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  likes INTEGER,
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);


INSERT INTO users
  (fname, lname)
VALUES
  ('Kristina', 'Miller'),
  ('Devin', 'Patel'),
  ('Nicholas', 'Cage');

INSERT INTO questions
  (title, body, author_id)
VALUES
  ('SQL', 'How do I create a SQL database?', 1),
  ('Quiz prep', 'How do I study for a quiz?', 2),
  ('Rails', 'What is Ruby on Rails?', 3);

  INSERT INTO question_follows
  (question_id, user_id)
VALUES
  (1,3),
  (2, 1),
  (2, 3);
  
INSERT INTO replies
  (body, question_id, user_id, parent_id)
VALUES
  ('You look at Github', 1, 3, NULL),
  ('Look at the cohort resources repository', 1, 2, 1),
  ('Its a framework!', 3, 1, NULL);

INSERT INTO question_likes
  (likes, question_id, user_id)
VALUES
  (1, 1, 3),
  (2, 1, 2),
  (3, 1, 3);