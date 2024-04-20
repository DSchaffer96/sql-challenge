--List the employee number, last name, first name, sex, and salary of each employee.
SELECT emp_no,last_name,first_name,sex,
(SELECT salary FROM salaries WHERE salaries.emp_no=employees.emp_no)
FROM employees

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name,last_name,hire_date
FROM employees
WHERE hire_date LIKE '%%%%/1986' OR hire_date LIKE '%%%%%/1986'

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT emp_no,dept_no,
(SELECT dept_name FROM departments WHERE departments.dept_no=dept_manager.dept_no),
(SELECT last_name FROM employees WHERE employees.emp_no=dept_manager.emp_no),
(SELECT first_name FROM employees WHERE employees.emp_no=dept_manager.emp_no)
FROM dept_manager

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_no,emp_no,
(SELECT last_name FROM employees WHERE employees.emp_no=dept_emp.emp_no),
(SELECT first_name FROM employees WHERE employees.emp_no=dept_emp.emp_no),
(SELECT dept_name FROM departments WHERE departments.dept_no=dept_emp.dept_no)
FROM dept_emp

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name,last_name,sex
FROM employees
WHERE first_name='Hercules' AND last_name LIKE 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no,last_name,first_name
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN
	(
		SELECT dept_no
		FROM departments
		WHERE dept_name='Sales'
	)
)

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp_no,
(SELECT last_name FROM employees WHERE employees.emp_no=dept_emp.emp_no),
(SELECT first_name FROM employees WHERE employees.emp_no=dept_emp.emp_no),
(SELECT dept_name FROM departments WHERE departments.dept_no=dept_emp.dept_no)
FROM dept_emp
WHERE dept_no IN
(
	SELECT dept_no
	FROM departments
	WHERE dept_name='Sales' OR dept_name='Development'
)

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name,COUNT(last_name) AS "last name count"
FROM employees
GROUP BY last_name
ORDER BY "last name count" DESC