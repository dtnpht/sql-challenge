-- DROP TABLE dept_manager;
-- DROP TABLE dept_emp;
-- DROP TABLE salaries;
-- DROP TABLE departments;
-- DROP TABLE employees;
-- DROP TABLE titles;

CREATE TABLE departments (
    dept_no VARCHAR NOT NULL,
    dept_name VARCHAR NOT NULL,
    CONSTRAINT departments_PK PRIMARY KEY (dept_no)
);
--
SELECT * FROM departments;
--
CREATE TABLE dept_emp (
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR NOT NULL
);
--
SELECT * FROM dept_emp;
--
CREATE TABLE dept_manager (
    dept_no VARCHAR NOT NULL,
    emp_no INTEGER NOT NULL
);
--
SELECT * FROM dept_manager;
--
CREATE TABLE employees (
    emp_no INTEGER NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date VARCHAR NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    sex VARCHAR NOT NULL,
    hire_date VARCHAR NOT NULL,
    CONSTRAINT employees_PK PRIMARY KEY (emp_no)
);
--
SELECT * FROM employees;
--

CREATE TABLE salaries (
    emp_no INTEGER NOT NULL,
    salary_no INTEGER NOT NULL,
    CONSTRAINT salaries_PK PRIMARY KEY (emp_no)
);
--
SELECT * FROM salaries;
--

CREATE TABLE titles (
    title_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    CONSTRAINT titles_PK PRIMARY KEY (title_id)
);
--
SELECT * FROM titles;
--
ALTER TABLE dept_emp ADD CONSTRAINT dept_emp_emp_no_FK FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT dept_emp_dept_no_FK FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT dept_manager_dept_no_FK FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT dept_manager_emp_no_FK FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE employees ADD CONSTRAINT employees_emp_title_id_FK FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

ALTER TABLE salaries ADD CONSTRAINT salaries_emp_no_FK FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);
--
-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary_no
FROM employees AS emp
INNER JOIN salaries AS sal 
ON emp.emp_no = sal.emp_no
ORDER BY emp_no;


-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees AS emp
WHERE emp.hire_date LIKE '%1986';

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, dept.dept_name, dm.emp_no, emp.last_name, emp.first_name
FROM dept_manager AS dm
JOIN departments AS dept
ON dm.dept_no = dept.dept_no
JOIN employees AS emp
ON dm.emp_no = emp.emp_no

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS de
ON emp.emp_no = de.emp_no
JOIN departments AS dept
ON de.dept_no = dept.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS de
ON emp.emp_no = de.emp_no
JOIN departments AS dept
ON de.dept_no = dept.dept_no where dept.dept_name = 'Sales'

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS de
ON emp.emp_no = de.emp_no
JOIN departments AS dept
ON de.dept_no = dept.dept_no where dept.dept_name = 'Sales' or dept.dept_name = 'Development'

--List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT emp.last_name, COUNT(*)
FROM employees AS emp
GROUP BY emp.last_name
ORDER BY 2 DESC;