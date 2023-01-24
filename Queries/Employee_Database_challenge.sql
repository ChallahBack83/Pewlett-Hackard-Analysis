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


SELECT * 
FROM mentor_eligible
LIMIT 200;

SELECT COUNT(employees.emp_no) AS "Total Employees"
FROM employees
JOIN emp_info
ON employees.emp_no = emp_info.emp_no
WHERE (emp_info.to_date = '9999-01-01');

SELECT COUNT(emp_no) AS "Total Mentor Eligible"
FROM unique_titles;
--GROUP BY title
--ORDER BY "Count" DESC;


SELECT dept_no, COUNT(emp_no) AS "Department Employees"
FROM dept_emp
GROUP BY dept_no
ORDER BY dept_no;

--Mentorship titles	count		   
SELECT COUNT(title) AS "mentorship_count", title
INTO mentor_titles
FROM mentor_eligible
GROUP BY title
ORDER BY "mentorship_count" DESC;

SELECT rt.count,
	rt.title,
	mt.mentorship_count
INTO title_compare
FROM retiring_titles AS rt
LEFT JOIN mentor_titles AS mt
ON rt.title = mt.title
ORDER BY rt.count, mt.mentorship_count;

SELECT de.dept_no,
	COUNT(ut.emp_no) AS "retiree_count"
INTO retiree_departments
FROM unique_titles AS ut
LEFT JOIN dept_emp AS de
ON ut.emp_no = de.emp_no
GROUP BY de.dept_no;

SELECT de.dept_no,
	COUNT(me.emp_no) AS "mentor_count"
INTO mentor_departments
FROM mentor_eligible AS me
INNER JOIN dept_emp AS de
ON me.emp_no = de.emp_no
GROUP BY de.dept_no;

SELECT rd.dept_no,
	rd.retiree_count,
	md.mentor_count
INTO dept_compare
FROM retiree_departments AS rd
INNER JOIN mentor_departments AS md
ON rd.dept_no = md.dept_no;
