-- First step of challenge deliverable: a query to aggregate relevant employee information into a table titled "retirement_titles" and export it to csv
SELECT e.emp_no, e.first_name, e.last_name,
	ti.title, ti.from_date, ti.to_date
-- INTO retirement_titles
FROM employees AS e
JOIN titles AS ti
ON e.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
-- INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- Get the count of retirement employees by title
SELECT COUNT(title), title
-- INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Finding employees eligible for the mentorship program per the instructions
SELECT DISTINCT ON(e.emp_no,ti.title) e.emp_no,e.first_name,e.last_name,e.birth_date,
	de.from_date,de.to_date,
	ti.title
-- INTO mentorship_eligibility
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no=de.emp_no
JOIN titles AS ti ON e.emp_no=ti.emp_no
WHERE ((de.to_date = '9999-01-01') AND (ti.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'))
ORDER BY e.emp_no;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Additional queries to help with the summary and recommendations

-- Get the count of retirement employees by title
SELECT COUNT(title)
-- INTO retiring_titles
FROM unique_titles;

-- Finding the total number of currently active employees by title
SELECT COUNT(ti.title), ti.title
FROM employees as e
JOIN dept_emp AS de
	ON e.emp_no=de.emp_no
JOIN titles AS ti
	ON e.emp_no=ti.emp_no
WHERE (ti.to_date = '9999-01-01')
GROUP BY ti.title
ORDER BY COUNT(ti.title) DESC;

-- Get the count of potential mentors born in 1965 by title
SELECT COUNT(title), title
-- INTO retiring_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Finding employees eligible for the mentorship program that have birthdays from 1956 to 1965
SELECT DISTINCT ON(e.emp_no,ti.title) e.emp_no,e.first_name,e.last_name,e.birth_date,
	de.from_date,de.to_date,
	ti.title
-- INTO mentorship_eligibility2
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no=de.emp_no
JOIN titles AS ti ON e.emp_no=ti.emp_no
WHERE ((de.to_date = '9999-01-01') AND (ti.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1956-01-01' AND '1965-12-31'))
ORDER BY e.emp_no;

-- Get a list of all potential mentors with birthdays between 1956 and 1965
SELECT COUNT(title), title
FROM mentorship_eligibility2
GROUP BY title
ORDER BY COUNT(title) DESC;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- NOT PART OF PRIMARY DELIVERABLES PER THE ASSIGNMENT, EXTRA QUERIES FOR PRACTICE AND REFERENCE

-- Queries from trouble-shooting
SELECT * FROM titles WHERE emp_no = 10476;
SELECT * FROM dept_emp WHERE emp_no = 10476;
SELECT DISTINCT ON(emp_no) * FROM titles WHERE emp_no = 10476;
SELECT * FROM titles WHERE emp_no = 10291;
SELECT DISTINCT ON(emp_no) * FROM titles WHERE emp_no = 10291;
SELECT * FROM titles WHERE emp_no = 12155;
SELECT * FROM dept_emp WHERE emp_no = 12155;
SELECT * FROM titles WHERE emp_no = 10663;
SELECT * FROM dept_emp WHERE emp_no = 10663;


