-- Query 1: Students, and their birthdays, of students born in September. Format the date to look like it is shown in the result set. Sort by the student's last name.
SELECT first_name AS 'fname', last_name 'lname', DATE_FORMAT(birthdate, '%b %d, %Y') AS 'Sept Birthdays'
FROM student
WHERE MONTH(birthdate) = 9
ORDER BY last_name;

-- Query 2: Student's age in years and days as of Jan. 5, 2017.  Sorted from oldest to youngest.  (You can assume a 365 day year and ignore leap day.) Hint: Use modulus for days left over after years. The 5th column is just the 3rd and 4th column combined with labels.
SELECT
    last_name,
    first_name,
    FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS 'Years',
    DATEDIFF('2017-01-05', birthdate) % 365 AS 'Days',
    CONCAT(FLOOR(DATEDIFF('2017-01-05', birthdate) / 365), ' years, ', DATEDIFF('2017-01-05', birthdate) % 365, ' days') AS 'Years and Days'
FROM student
ORDER BY Years DESC, Days DESC;

-- Query 3: Students taught by John Jensen. Sorted by student's last name
SELECT s.first_name, s.last_name
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section se ON e.section_id = se.section_id
JOIN faculty f ON se.faculty_id = f.faculty_id
WHERE f.faculty_fname = 'John' AND f.faculty_lname = 'Jensen'
ORDER BY s.last_name;

-- Query 4:   Instructors Bryce will have in Winter 2018. Sort by the faculty's last name.
SELECT f.faculty_fname, f.faculty_lname
FROM faculty f
JOIN section s ON f.faculty_id = s.faculty_id
JOIN term t ON s.term_id = t.term_id
JOIN enrollment e ON s.section_id = e.section_id
JOIN student st ON e.student_id = st.student_id
WHERE st.first_name = 'Bryce' AND st.last_name = 'Carlson'
  AND t.term = 'Winter' AND t.year = '2018'
ORDER BY f.faculty_lname;

-- Query 5: Students that take Econometrics in Fall 2019. Sort by student last name.
SELECT s.last_name, s.first_name
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section se ON e.section_id = se.section_id
JOIN course c ON se.course_id = c.course_id
JOIN term t ON se.term_id = t.term_id
WHERE c.course_title = 'Econometrics'
  AND t.term = 'Fall' AND t.year = '2019'
ORDER BY s.last_name;

-- Query 6: Report showing all of Bryce Carlson's courses for Winter 2018. Sort by the name of the course.
SELECT t.year, t.term, c.course_num, c.course_title, c.credits
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section se ON e.section_id = se.section_id
JOIN course c ON se.course_id = c.course_id
JOIN term t ON se.term_id = t.term_id
WHERE s.first_name = 'Bryce' AND s.last_name = 'Carlson'
  AND t.year = '2018' AND t.term = 'Winter'
ORDER BY c.course_title; 

-- Query 7: The number of enrollments for Fall 2019
SELECT COUNT(e.student_id) AS 'Enrollments'
FROM enrollment e
JOIN section s ON e.section_id = s.section_id
JOIN term t ON s.term_id = t.term_id
WHERE t.year = '2019' AND t.term = 'Fall'; 

-- Query 8: The number of courses in each college. Sort by college name.
SELECT co.college_name, COUNT(c.course_id) as 'Number of Courses'
FROM college co
JOIN department d ON co.college_id = d.college_id
JOIN course c ON d.department_id = c.department_id
GROUP BY co.college_name
ORDER BY co.college_name; 

-- Query 9: The total number of students each professor can teach in Winter 2018. Sort by that total number of students (teaching capacity).
SELECT f.faculty_fname, f.faculty_lname, SUM(s.capacity) AS 'Teaching Capacity'
FROM faculty f
JOIN section s ON f.faculty_id = s.faculty_id
JOIN term t ON s.term_id = t.term_id
WHERE t.year = '2018' AND t.term = 'Winter'
GROUP BY f.faculty_id
ORDER BY `Teaching Capacity`; 

--Query 10: Each student's total credit load for Fall 2019, but only students with a credit load greater than three.  Sort by credit load in descending order. 
SELECT s.first_name, s.last_name, SUM(c.credits) AS 'Credit Load'
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section se ON e.section_id = se.section_id
JOIN course c ON se.course_id = c.course_id
JOIN term t ON se.term_id = t.term_id
WHERE t.year = '2019' AND t.term = 'Fall'
GROUP BY s.student_id
HAVING `Credit Load` > 3
ORDER BY `Credit Load` DESC;
