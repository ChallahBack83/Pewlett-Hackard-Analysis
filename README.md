# Pewlett-Hackard-Analysis

## Overview of the analysis

The purpose of this project was to find out how many of Pewlett-Hackard's employees are retirement ready and how prepared the company is to handle that number of retirees. Do they have enough senior employees eligible to mentor under the outgoing employees and to help prepare the next generation of employees?  I did this through an analysis of the employee data which included using information about birth dates, titles, and departments.

## Results

- First I created a new table containing only the employees closest to retiring (birthdates between 1952 and 1955) by joining information from the Employees and Titles tables with the emp_no as primary key. Since employees may have had several titles, I then used Distinct On() to create a table of the retiring employees current titles and allow us to get an accurate count of retirees.
```
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

 ```
 - Using Count(), I then created a new table grouped by title to see which roles will lose the most employees. The company will potentially lose 72,458 roles in the next few years as part of the "Silver Tsunami". 
```
--Retrieve number of titles from Unique Titles table
 SELECT COUNT(title) AS "count", title
 INTO retiring_titles
 FROM unique_titles
 GROUP BY title
 ORDER BY "count" DESC;
 ```
 - If you look at the count in the retiring_titles table, we see that 50,844 of these retirees are in senior positions of "Senior Engineer", "Senior Staff", or "Manager".  This means 70% of the retirees are in leadership roles in the company.
![retiring_titles]()

- I then looked at employees who are 10 years younger, assuming these are the next generation to step up into leadership gaps left by the retirees. Joining employee information from the employees, dept_emp, and titles table, I created a mentor_eligible table with all the employee information so the company may begin training the next generation. There are a total of 1,549 employees eligible for the mentorship program.
![mentor_eligible]()

![mentor_eligible_count]()

## Summary
 
high level responses
- How many roles will need to be filled as the "silver tsunami" begins to make an impact?

There are a total of 72,458 roles that will need to be filled as the "silver tsunami begins to make an impact. Of these, approximately 70% (50,844) are in senior positions("Senior Engineer", "Senior Staff", "Manager").  

- Are there enough qualified, retirement-ready employees in the departments to mentor the next generations of Pewlett Hackard employees?

Pewlett-Hackard has plenty of retirement-ready employees to  mentor the next generation considering there are only 1,549 people eligible fore the mentorship program.  However, assuming the company fills all of those 70,000 plus roles in the next 10 years, that means these 1500 employees will need to then mentor or lead approximately 46 employees each over the next few years before they themselves retire. This is not feasible, so Pewlett-Hackard should look to create a leadership onboarding program as they hire new people to fill these roles.

![mentor_eligible_titles]()

![mentor_ret_dept]()
