# Hospital Database Management System - SQL Project



Project Overview

This project is a hospital database system built using MySQL.  
It includes database design, SQL schema creation, and advanced SQL operations such as queries, functions, procedures, and triggers.

---

##  Project Phases

- **Phase 1:** ER diagram design with main entities and relationships.
- **Phase 2:** SQL table creation with constraints and sample data.
- **Phase 3:** Advanced SQL features:
  - Complex SQL queries (JOINs, GROUP BY, HAVING, subqueries)
  - User-defined functions (UDFs)
  - Stored procedures with input/output parameters and conditionals
  - Triggers for logging and business logic automation

---

## ▶ How to Run

1. Open a MySQL client ( DataGrip).
2. Execute the SQL schema from Phase 2 to create tables and insert data.
3. Run Phase 3 SQL script:
   - Call functions: `SELECT CalculatePatientAge('1990-01-01');`
   - Call procedures: `CALL AddNewAppointment();`
4. Triggers will run automatically during insert/update actions.

---

##  Notes

- Project tested on MySQL 8.0.
- Developed for Database Management course.
- Trigger operations include:
  - Logging new bill insertions.
  - Logging when a bill is marked as paid.
