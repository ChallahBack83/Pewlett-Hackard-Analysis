SELECT * FROM unique_titles;

--Create new table with retirement titles.
SELECT  e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM titles AS t
INNER JOIN employees as e
ON t.emp_no = e.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;
DROP TABLE retirement_titles;

-- Use Distinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (emp_no) emp_no,
		first_name,
		last_name,
		title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Retrieve number of titles from Unique Titles table
 SELECT COUNT(title) AS "count", title
 INTO retiring_titles
 FROM unique_titles
 GROUP BY title
 ORDER BY "count" DESC;

--Mentorship eligibility table
SELECT DISTINCT ON(t.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentor_eligible
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (t.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY t.emp_no;
