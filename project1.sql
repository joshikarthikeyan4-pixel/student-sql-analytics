DROP TABLE IF EXISTS students;
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name TEXT,
  gender CHAR(1),
  department TEXT,
  admission_year INT
);
INSERT INTO students (student_id,name,gender,department,admission_year)
VALUES							('1','Aarav','M','CS','2022'),
								('2','Diya','F','EE','2021'),
								('3','Rohan','M','ME','2023'),
								('4','Ananya','F','CS','2022'),
								('5','Kunal','M','IT','2021'),
								('6','Priya','F','CS','2023'),
								('7','Arjun','M','EE','2022'),
								('8','Sneha','F','ME','2021'),
								('9','Rahul','M','IT','2022'),
								('10','Neha','F','CS','2021')
SELECT * FROM students;


DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name TEXT,
  department TEXT,
  credits INT
);
INSERT INTO courses (course_id,course_name,department,credits)
VALUES      			('101','DBMS','CS','3'),
						('102','Data Structures','CS','4'),
						('103','Operating Systems','CS','4'),
						('201','Circuits','EE','4'),
						('202','Signals and Systems','EE','3'),
						('301','Thermodynamics','ME','3'),
						('302','Fluid Mechanics','ME','4'),
						('401','Computer Networks','IT','4'),
						('402','Software Engineering','IT','3')
SELECT * FROM courses;


DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT REFERENCES students(student_id),
  course_id INT REFERENCES courses(course_id),
  semester TEXT,
  marks INT
);

INSERT INTO enrollments (enrollment_id,student_id,course_id,semester,marks)
VALUES  						('1','1','101','2023-1','78'),
								('2','1','102','2023-1','85'),
								('3','2','201','2023-1','67'),
								('4','3','301','2023-1','45'),
								('5','4','101','2023-1','92'),
								('6','5','401','2023-1','74'),
								('7','6','103','2023-1','88'),
								('8','7','202','2023-1','59'),
								('9','8','302',2023-1,'63'),
								('10','9','402','2023-1',NULL),
								('11','10','101','2023-1','81'),
								('12','2','202','2023-1','72'),
								('13','3','302','2023-1','55'),
								('14','4','102','2023-1','90'),
								('15','6','101','2023-1','84')
SELECT * FROM enrollments;	

--Q1- List all students with their name and department.
SELECT name,department FROM students;
-- Q2-Count the total number of students in each department.
SELECT COUNT(name) AS total_students FROM students;
-- Q3-Show all courses offered by the CS department.
SELECT course_name,department FROM courses
WHERE department='CS' ; 
--Q4-Display all enrollments where marks are NULL.
SELECT enrollment_id,student_id,course_id,semester,marks FROM enrollments
WHERE marks IS NULL;
-- Q5-List students admitted after 2021.
SELECT name,admission_year FROM students
WHERE admission_year>2021;
--Q6-Show each student’s name, course name, and marks. 
SELECT
s.name,
c.course_name,
e.marks
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id;
-- Q7-Find the average marks per course.	
SELECT AVG(marks) AS average_marks FROM enrollments;						
-- Q8-List students who are enrolled in more than 1 course.
SELECT
c.course_name,
COUNT(e.student_id) AS total_students
FROM courses c
JOIN enrollments e
 ON c.course_id = e.course_id
GROUP BY c.course_name; 
-- Q9-Calculate the pass percentage per department (pass = marks ≥ 50).
SELECT (COUNT(e.marks>=50) AS passed_marks)*100 , s.department FROM students s 
JOIN enrollments e
ON s.student_id=e.student_id;
-- Q10-Show the top 3 students based on average marks.
SELECT
s.department,
COUNT(CASE WHEN e.marks >= 50 THEN 1 END) * 100.0
/ COUNT(e.marks) AS pass_percentage
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY s.department;

