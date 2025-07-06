SELECT artfile
FROM artworks
WHERE period_style = 'Impressionism';

SELECT artfile
FROM artworks
WHERE subject LIKE '%flower%';

SELECT artist.first_name, artist.last_name, artwork.title
FROM artist
INNER JOIN artwork
  ON artist.artist_id = artwork.artist_id;

  SELECT magazine.name AS magazineName,
       subscriber.last_name,
       subscriber.first_name
FROM subscription
JOIN magazine ON subscription.magazine_id = magazine.magazine_id
JOIN subscriber ON subscription.subscriber_id = subscriber.subscriber_id
ORDER BY magazine.name;

SELECT magazine.name AS magazineName
FROM subscription
JOIN subscriber ON subscription.subscriber_id = subscriber.subscriber_id
JOIN magazine ON subscription.magazine_id = magazine.magazine_id
WHERE subscriber.first_name = 'Samantha' AND subscriber.last_name = 'Sanders';

SELECT first_name, last_name
FROM employee
WHERE department = 'Customer Service'
ORDER BY last_name
LIMIT 5;

SELECT employee.first_name,
       employee.last_name,
       department.dept_name,
       salary.salary,
       salary.from_date
FROM employee
JOIN dept_emp ON employee.emp_no = dept_emp.emp_no
JOIN department ON dept_emp.dept_no = department.dept_no
JOIN salary ON employee.emp_no = salary.emp_no
WHERE employee.first_name = 'Berni' AND employee.last_name = 'Genin'
ORDER BY salary.from_date DESC
LIMIT 1;