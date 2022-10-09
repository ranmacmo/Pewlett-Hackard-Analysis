-------------------------------------
-- DELIVERABLE 1 : RETIREMENT TITLES
-------------------------------------
-- Titles of employees who were born 
-- between January 1, 1952 and December 31, 1955
-- NOTE: this has duplicates due to empoyees having 
-- multiple title during their employment 
SELECT emp.emp_no, emp.first_name, emp.last_name, 
	ttl.title, ttl.from_date, ttl.to_date
INTO retirement_titles
FROM employees emp
INNER JOIN titles ttl ON ttl.emp_no = emp.emp_no 
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- Order not asked for but shown in example 
ORDER BY emp.emp_no; 

-------------------------------------
-- DELIVERABLE 1 : UNIQUE TITLES 
-------------------------------------
-- Use Distinct ON with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, from_date DESC;

-------------------------------------
-- DELIVERALBE 1 : RETIRING TITLES 
-------------------------------------
-- Retiring Titles 
SELECT count(*) AS count, title 
INTO retiring_titles
FROM unique_titles
GROUP BY title 
-- Order not asked for but shown in example 
ORDER BY count DESC

------------------------------------------
-- DELIVERABLE 2 : MENTORSHIP ELIGIBILITY 
------------------------------------------

-- NOTE: EMP NO 10291 Title in the material to "check against" is "STAFF"
-- the data is does NOT reflect that.. and has a "SENIOR STAFF" title 
-- from "1994-03-30" to current... 

SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name, 
emp.birth_date, 
de.from_date, de.to_date, ttl.title 
INTO mentorship_eligibility
FROM employees emp 
INNER JOIN dept_emp de ON de.emp_no = emp.emp_no
INNER JOIN titles ttl ON ttl.emp_no = emp.emp_no
-- Esure it a department that is current with '9999-01-01'
-- Within a department there can also be multiple titles 
-- which will be removed via instructions with DISTINCT ON 

WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND ttl.to_date = '9999-01-01' -- Ensure latest title to prevent data anomaly of 
							   -- mismatched title during department tenure 
							   -- INSTRUCTIONS ARE VERY POOR REGARDING.... 
ORDER BY emp.emp_no, emp.first_name, emp.last_name, 
			emp.birth_date, 
			de.from_date DESC, de.to_date, title 

--------------------------------------------------
-- ALTERNATE SOLUTION : Prevents posssible data analmolies 
--------------------------------------------------
-- NOTE: the joins given in instructions could mate up some department 
-- title combinations that are NOT valid... the "exercise" instructions could work 
-- but would probably not be a good solution considering: 
-- 1. Data anomalies could exist 
-- 2. Using a function specific to database engine instead of a cleaner ANSI 92 standard...
-- 3. Is much more optimized than using a ORDER ON clause... 

SELECT emp.emp_no, emp.first_name, emp.last_name, 
emp.birth_date, 
de.from_date, de.to_date, title 
FROM employees emp 
INNER JOIN dept_emp de ON de.emp_no = emp.emp_no
INNER JOIN titles ttl ON ttl.emp_no = emp.emp_no
WHERE  ttl.to_date = '9999-01-01'
AND de.to_date = '9999-01-01'
AND  (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp.emp_no 













