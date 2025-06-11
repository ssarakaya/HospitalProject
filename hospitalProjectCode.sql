-- HOSPITAL TABLE
CREATE TABLE HOSPITAL (
                          hospital_id INT PRIMARY KEY,         -- Unique ID for each hospital
                          name VARCHAR(100),                   -- Hospital name
                          location VARCHAR(200)                -- Hospital location/address
);

-- DEPARTMENT TABLE
CREATE TABLE DEPARTMENT (
                            department_id INT PRIMARY KEY,       -- Unique ID for each department
                            name VARCHAR(100),                   -- Department name
                            floor INT,                           -- Floor number where department is located
                            hospital_id INT,                     -- Foreign key to hospital
                            FOREIGN KEY (hospital_id) REFERENCES HOSPITAL(hospital_id)
);

-- ROOM TABLE
CREATE TABLE ROOM (
                      room_id INT PRIMARY KEY,             -- Unique ID for each room
                      room_number VARCHAR(10),             -- Room number
                      type VARCHAR(50),                    -- Room type ( ICU, General)
                      capacity INT,                        -- Number of patients room can hold
                      hospital_id INT,                     -- Foreign key to hospital
                      FOREIGN KEY (hospital_id) REFERENCES HOSPITAL(hospital_id)
);

-- INSURANCE_POLICY TABLE
CREATE TABLE INSURANCE_POLICY (
                                  policy_id INT PRIMARY KEY,           -- Unique insurance policy ID
                                  provider VARCHAR(100),               -- Insurance company/provider name
                                  coverage_amount DECIMAL(10, 2)       -- Maximum coverage amount
);

-- PATIENT TABLE
CREATE TABLE PATIENT (
                         patient_id INT PRIMARY KEY,          -- Unique patient ID
                         name VARCHAR(100),                   -- Patient's full name
                         dob DATE,                            -- Date of birth
                         gender VARCHAR(10),                  -- Gender
                         room_id INT,                         -- Assigned room ID (foreign key)
                         policy_id INT,                       -- Insurance policy ID (foreign key)
                         FOREIGN KEY (room_id) REFERENCES ROOM(room_id),
                         FOREIGN KEY (policy_id) REFERENCES INSURANCE_POLICY(policy_id)
);

-- ADDRESS TABLE
CREATE TABLE ADDRESS (
                         address_id INT PRIMARY KEY,          -- Unique address ID
                         street VARCHAR(100),                 -- Street address
                         city VARCHAR(100),                   -- City
                         zip VARCHAR(10),                     -- ZIP code
                         patient_id INT,                      -- Foreign key to patient
                         FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

-- DOCTOR TABLE
CREATE TABLE DOCTOR (
                        doctor_id INT PRIMARY KEY,           -- Unique doctor ID
                        name VARCHAR(100),                   -- Doctor's full name
                        specialization VARCHAR(100),         -- Medical specialization
                        department_id INT,                   -- Department foreign key
                        FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
);

-- PHYSICIAN TABLE
CREATE TABLE PHYSICIAN (
                           physician_id INT PRIMARY KEY,        -- Doctor ID also acts as primary key
                           clinic_hours VARCHAR(50),            -- Working hours for the physician
                           FOREIGN KEY (physician_id) REFERENCES DOCTOR(doctor_id)
);

-- SURGEON TABLE
CREATE TABLE SURGEON (
                         surgeon_id INT PRIMARY KEY,          -- Doctor ID acting as surgeon ID
                         surgery_type VARCHAR(100),           -- Type of surgeries performed
                         FOREIGN KEY (surgeon_id) REFERENCES DOCTOR(doctor_id)
);

-- APPOINTMENT TABLE
CREATE TABLE APPOINTMENT (
                             appointment_id INT PRIMARY KEY,     -- Unique appointment ID
                             date DATE,                          -- Appointment date
                             time TIME,                          -- Appointment time
                             status VARCHAR(50),                 -- Appointment status (Scheduled, Completed, etc.)
                             patient_id INT,                     -- Patient foreign key
                             doctor_id INT,                      -- Doctor foreign key
                             FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id),
                             FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
);

-- PRESCRIPTION TABLE
CREATE TABLE PRESCRIPTION (
                              prescription_id INT PRIMARY KEY,    -- Unique prescription ID
                              date DATE,                          -- Date prescribed
                              notes TEXT,                         -- Additional notes or instructions
                              patient_id INT,                     -- Patient foreign key
                              doctor_id INT,                      -- Doctor foreign key
                              FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id),
                              FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
);

-- MEDICATION TABLE
CREATE TABLE MEDICATION (
                            medication_id INT PRIMARY KEY,    -- Unique medication ID
                            name VARCHAR(100),                -- Medication name
                            dosage VARCHAR(50)                -- Dosage info
);

-- PRESCRIPTION_MEDICATION TABLE
CREATE TABLE PRESCRIPTION_MEDICATION (
                                         prescription_id INT,              -- Prescription foreign key
                                         medication_id INT,                -- Medication foreign key
                                         dosage_instructions VARCHAR(200), -- Instructions on how to take medication
                                         PRIMARY KEY (prescription_id, medication_id),
                                         FOREIGN KEY (prescription_id) REFERENCES PRESCRIPTION(prescription_id),
                                         FOREIGN KEY (medication_id) REFERENCES MEDICATION(medication_id)
);

-- MEDICAL_RECORD TABLE
CREATE TABLE MEDICAL_RECORD (
                                record_id INT PRIMARY KEY,        -- Unique medical record ID
                                created_date DATE,                -- Date record was created
                                summary TEXT,                     -- Summary of patient's condition or visit
                                patient_id INT,                   -- Patient foreign key
                                FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

-- DIAGNOSIS TABLE
CREATE TABLE DIAGNOSIS (
                           diagnosis_id INT PRIMARY KEY,     -- Unique diagnosis ID
                           description TEXT,                 -- Diagnosis description
                           diagnosed_date DATE,              -- Date diagnosed
                           record_id INT,                    -- Medical record foreign key
                           FOREIGN KEY (record_id) REFERENCES MEDICAL_RECORD(record_id)
);

-- TREATMENT TABLE
CREATE TABLE TREATMENT (
                           treatment_id INT PRIMARY KEY,     -- Unique treatment ID
                           type VARCHAR(100),                -- Treatment type (e.g., medication, therapy)
                           duration VARCHAR(50),             -- Duration of treatment
                           description TEXT,                 -- Details about treatment
                           record_id INT,                    -- Medical record foreign key
                           FOREIGN KEY (record_id) REFERENCES MEDICAL_RECORD(record_id)
);

-- LAB_TEST TABLE
CREATE TABLE LAB_TEST (
                          test_id INT PRIMARY KEY,          -- Unique lab test ID
                          test_type VARCHAR(100),           -- Type of test (e.g., Blood Test, MRI)
                          result TEXT,                      -- Test results
                          record_id INT,                    -- Medical record foreign key
                          FOREIGN KEY (record_id) REFERENCES MEDICAL_RECORD(record_id)
);

-- BILL TABLE
CREATE TABLE BILL (
                      bill_id INT PRIMARY KEY,          -- Unique bill ID
                      amount DECIMAL(10, 2),            -- Total bill amount
                      issued_date DATE,                 -- Date bill issued
                      status VARCHAR(50),               -- Bill status (Paid, Unpaid, etc.)
                      patient_id INT,                   -- Patient foreign key
                      FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

-- PAYMENT TABLE
CREATE TABLE PAYMENT (
                         payment_id INT PRIMARY KEY,       -- Unique payment ID
                         amount DECIMAL(10, 2),            -- Payment amount
                         method VARCHAR(50),               -- Payment method (Cash, Credit Card, etc.)
                         date DATE,                        -- Payment date
                         bill_id INT,                      -- Bill foreign key
                         FOREIGN KEY (bill_id) REFERENCES BILL(bill_id)
);

-- VISITOR TABLE
CREATE TABLE VISITOR (
                         visitor_id INT PRIMARY KEY,        -- Unique visitor ID
                         name VARCHAR(100),                 -- Visitor name
                         relation VARCHAR(50),              -- Relation to patient
                         visit_date DATE,                   -- Date of visit
                         patient_id INT,                    -- Patient foreign key
                         FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
);

-- EMERGENCY_CASE TABLE
CREATE TABLE EMERGENCY_CASE (
                                case_id INT PRIMARY KEY,           -- Unique emergency case ID
                                description TEXT,                 -- Description of emergency
                                arrival_time DATETIME,            -- Arrival timestamp
                                patient_id INT,                   -- Patient foreign key
                                doctor_id INT,                    -- Doctor foreign key attending case
                                FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id),
                                FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
);

-- EQUIPMENT TABLE
CREATE TABLE EQUIPMENT (
                           equipment_id INT PRIMARY KEY,     -- Unique equipment ID
                           name VARCHAR(100),                -- Equipment name
                           purchase_date DATE,               -- Date purchased
                           department_id INT,                -- Department foreign key
                           FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
);

-- MAINTENANCE_RECORD TABLE
CREATE TABLE MAINTENANCE_RECORD (
                                    maintenance_id INT PRIMARY KEY,   -- Unique maintenance record ID
                                    date DATE,                        -- Maintenance date
                                    technician_name VARCHAR(100),     -- Name of technician
                                    equipment_id INT,                 -- Equipment foreign key
                                    FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT(equipment_id)
);

-- NURSE TABLE
CREATE TABLE NURSE (
                       nurse_id INT PRIMARY KEY,        -- Unique nurse ID
                       name VARCHAR(100),               -- Nurse's full name
                       shift VARCHAR(50),               -- Shift description
                       department_id INT,               -- Department foreign key
                       FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
);

-- SHIFT TABLE
CREATE TABLE SHIFT (
                       shift_id INT PRIMARY KEY,         -- Unique shift ID
                       start_time TIME,                  -- Shift start time
                       end_time TIME                     -- Shift end time
);

-- NURSE_SHIFT TABLE
CREATE TABLE NURSE_SHIFT (
                             nurse_id INT,                  -- Nurse foreign key
                             shift_id INT,                  -- Shift foreign key
                             date DATE,                     -- Date of shift
                             PRIMARY KEY (nurse_id, shift_id, date),
                             FOREIGN KEY (nurse_id) REFERENCES NURSE(nurse_id),
                             FOREIGN KEY (shift_id) REFERENCES SHIFT(shift_id)
);

-- Insert into HOSPITAL
INSERT INTO HOSPITAL VALUES (1, 'City Hospital', 'Downtown');
INSERT INTO HOSPITAL VALUES (2, 'Green Valley Clinic', 'Uptown');

-- Insert into DEPARTMENT
INSERT INTO DEPARTMENT VALUES (1, 'Cardiology', 2, 1);
INSERT INTO DEPARTMENT VALUES (2, 'Neurology', 3, 2);

-- Insert into ROOM
INSERT INTO ROOM VALUES (1, '101A', 'ICU', 2, 1);
INSERT INTO ROOM VALUES (2, '202B', 'General', 4, 2);

-- Insert into INSURANCE_POLICY
INSERT INTO INSURANCE_POLICY VALUES (1, 'HealthSecure', 10000.00);
INSERT INTO INSURANCE_POLICY VALUES (2, 'MediCare', 15000.00);

-- Insert into PATIENT
INSERT INTO PATIENT VALUES (1, 'Sule Korkmaz', '1985-04-23', 'Male', 1, 1);
INSERT INTO PATIENT VALUES (2, 'Hanne Terzi', '1990-11-12', 'Female', 2, 2);

-- Insert into ADDRESS
INSERT INTO ADDRESS VALUES (1, '123 Main St', 'Metropolis', '12345', 1);
INSERT INTO ADDRESS VALUES (2, '456 Elm St', 'Smalltown', '67890', 2);

-- Insert into DOCTOR
INSERT INTO DOCTOR VALUES (1, 'Dr. Kaya', 'Diagnostics', 1);
INSERT INTO DOCTOR VALUES (2, 'Dr. Celik ', 'Surgery', 2);

-- Insert into PHYSICIAN
INSERT INTO PHYSICIAN VALUES (1, '9am-5pm');
INSERT INTO PHYSICIAN VALUES (2, '10am-4pm');

-- Insert into SURGEON
INSERT INTO SURGEON VALUES (2, 'Neurosurgery');
INSERT INTO SURGEON VALUES (1, 'Cardiothoracic');

-- Insert into APPOINTMENT
INSERT INTO APPOINTMENT VALUES (1, '2025-05-01', '10:00:00', 'Scheduled', 1, 1);
INSERT INTO APPOINTMENT VALUES (2, '2025-05-02', '14:00:00', 'Completed', 2, 2);

-- Insert into PRESCRIPTION
INSERT INTO PRESCRIPTION VALUES (1, '2025-05-01', 'Take with food', 1, 1);
INSERT INTO PRESCRIPTION VALUES (2, '2025-05-02', 'Twice daily', 2, 2);

-- Insert into MEDICATION
INSERT INTO MEDICATION VALUES (1, 'Aspirin', '100mg');
INSERT INTO MEDICATION VALUES (2, 'Ibuprofen', '200mg');

-- Insert into PRESCRIPTION_MEDICATION
INSERT INTO PRESCRIPTION_MEDICATION VALUES (1, 1, 'After breakfast');
INSERT INTO PRESCRIPTION_MEDICATION VALUES (2, 2, 'Before sleep');

-- Insert into MEDICAL_RECORD
INSERT INTO MEDICAL_RECORD VALUES (1, '2025-04-30', 'Routine check-up', 1);
INSERT INTO MEDICAL_RECORD VALUES (2, '2025-05-01', 'Emergency visit', 2);

-- Insert into DIAGNOSIS
INSERT INTO DIAGNOSIS VALUES (1, 'Hypertension', '2025-04-30', 1);
INSERT INTO DIAGNOSIS VALUES (2, 'Migraine', '2025-05-01', 2);

-- Insert into TREATMENT
INSERT INTO TREATMENT VALUES (1, 'Medication', '2 weeks', 'Blood pressure meds', 1);
INSERT INTO TREATMENT VALUES (2, 'Therapy', '1 month', 'Cognitive therapy', 2);

-- Insert into LAB_TEST
INSERT INTO LAB_TEST VALUES (1, 'Blood Test', 'Normal', 1);
INSERT INTO LAB_TEST VALUES (2, 'MRI', 'Mild anomaly', 2);

-- Insert into BILL
INSERT INTO BILL VALUES (1, 200.00, '2025-05-01', 'Unpaid', 1);
INSERT INTO BILL VALUES (2, 350.00, '2025-05-02', 'Paid', 2);

-- Insert into PAYMENT
INSERT INTO PAYMENT VALUES (1, 350.00, 'Credit Card', '2025-05-02', 2);
INSERT INTO PAYMENT VALUES (2, 200.00, 'Cash', '2025-05-01', 1);

-- Insert into VISITOR
INSERT INTO VISITOR VALUES (1, 'Eyup Koc', 'Sister', '2025-05-03', 1);
INSERT INTO VISITOR VALUES (2, 'Sara Kaya', 'Brother', '2025-05-03', 2);

-- Insert into EMERGENCY_CASE
INSERT INTO EMERGENCY_CASE VALUES (1, 'Chest pain', '2025-05-01 03:00:00', 1, 1);
INSERT INTO EMERGENCY_CASE VALUES (2, 'Seizure', '2025-05-02 04:00:00', 2, 2);

-- Insert into EQUIPMENT
INSERT INTO EQUIPMENT VALUES (1, 'MRI Scanner', '2023-01-01', 1);
INSERT INTO EQUIPMENT VALUES (2, 'X-Ray Machine', '2024-06-15', 2);

-- Insert into MAINTENANCE_RECORD
INSERT INTO MAINTENANCE_RECORD VALUES (1, '2025-01-15', 'Technician A', 1);
INSERT INTO MAINTENANCE_RECORD VALUES (2, '2025-02-10', 'Technician B', 2);

-- Insert into NURSE
INSERT INTO NURSE VALUES (1, 'Nurse Meryem', 'Morning', 1);
INSERT INTO NURSE VALUES (2, 'Nurse Asiye', 'Evening', 2);

-- Insert into SHIFT
INSERT INTO SHIFT VALUES (1, '08:00:00', '16:00:00');
INSERT INTO SHIFT VALUES (2, '16:00:00', '00:00:00');

-- Insert into NURSE_SHIFT
INSERT INTO NURSE_SHIFT VALUES (1, 1, '2025-05-01');
INSERT INTO NURSE_SHIFT VALUES (2, 2, '2025-05-02');

-- 1. COMPLEX SQL QUERIES

-- Get patients with their appointments and the attending doctor's details
SELECT p.name, p.dob, a.date, a.time, a.status, d.name AS doctor_name
FROM PATIENT p
         JOIN APPOINTMENT a ON p.patient_id = a.patient_id
         JOIN DOCTOR d ON a.doctor_id = d.doctor_id
ORDER BY p.name, a.date DESC;

-- List patients with their insurance details, if any
SELECT p.name, ip.provider, ip.coverage_amount
FROM PATIENT p
         LEFT JOIN INSURANCE_POLICY ip ON p.policy_id = ip.policy_id;

-- Find patients whose total bills exceed 300
SELECT p.name, SUM(b.amount) AS total
FROM PATIENT p
         JOIN BILL b ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.name
HAVING SUM(b.amount) > 300;

-- Count emergency cases handled by each doctor
SELECT d.name, COUNT(ec.case_id) AS emergency_cases
FROM DOCTOR d
         JOIN EMERGENCY_CASE ec ON d.doctor_id = ec.doctor_id
GROUP BY d.name;

-- Find patients diagnosed with migraine
SELECT p.name, mr.summary, dg.description, dg.diagnosed_date
FROM PATIENT p
         JOIN MEDICAL_RECORD mr ON p.patient_id = mr.patient_id
         JOIN DIAGNOSIS dg ON mr.record_id = dg.record_id
WHERE dg.description LIKE '%Migraine%';

-- Top 3 most frequently prescribed medications
SELECT m.name, COUNT(pm.prescription_id) AS count
FROM MEDICATION m
         JOIN PRESCRIPTION_MEDICATION pm ON m.medication_id = pm.medication_id
GROUP BY m.name
ORDER BY count DESC
LIMIT 3;

-- 2. USER-DEFINED FUNCTIONS

-- Drop existing function if any
DROP FUNCTION IF EXISTS CalculatePatientAge;

-- Function to calculate age from date of birth
CREATE FUNCTION CalculatePatientAge(dob DATE) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, dob, CURDATE()); -- Calculate year difference from dob to current date
END;

-- Drop existing procedure if any
DROP PROCEDURE IF EXISTS GetDoctorAppointments;

-- Procedure to get all appointments of a doctor on a given date
CREATE PROCEDURE GetDoctorAppointments(IN doc_id INT, IN app_date DATE)
BEGIN
    SELECT a.appointment_id, p.name AS patient_name, a.time AS appointment_time, a.status
    FROM APPOINTMENT a
             JOIN PATIENT p ON a.patient_id = p.patient_id
    WHERE a.doctor_id = doc_id AND a.date = app_date
    ORDER BY a.time;
END;

-- 3. STORED PROCEDURES

-- Drop existing procedure if any
DROP PROCEDURE IF EXISTS AddNewAppointment;

-- Procedure to add a new appointment if the doctor is available
CREATE PROCEDURE AddNewAppointment (
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_appointment_date DATE,
    IN p_appointment_time TIME,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_count INT DEFAULT 0;

    -- Check if doctor already has appointment at this time
    SELECT COUNT(*) INTO v_count
    FROM APPOINTMENT
    WHERE doctor_id = p_doctor_id AND date = p_appointment_date AND time = p_appointment_time;

    IF v_count > 0 THEN
        SET p_message = 'Doctor is already booked at this time.';
    ELSE
        -- Insert new appointment and confirm success
        INSERT INTO APPOINTMENT (date, time, status, patient_id, doctor_id)
        VALUES (p_appointment_date, p_appointment_time, 'Scheduled', p_patient_id, p_doctor_id);
        SET p_message = 'Appointment successfully added.';
    END IF;
END;

-- Drop existing procedure if any
DROP PROCEDURE IF EXISTS ProcessBillPayment;

-- Procedure to process payment for a bill
CREATE PROCEDURE ProcessBillPayment (
    IN p_bill_id INT,
    IN p_payment_amount DECIMAL(10,2),
    IN p_payment_method VARCHAR(50),
    IN p_payment_date DATE,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_bill_amount DECIMAL(10,2);
    DECLARE v_bill_status VARCHAR(50);

    -- Retrieve bill amount and status
    SELECT amount, status INTO v_bill_amount, v_bill_status
    FROM BILL WHERE bill_id = p_bill_id;

    -- Validate bill existence and payment conditions
    IF v_bill_amount IS NULL THEN
        SET p_message = 'Bill not found.';
    ELSEIF v_bill_status = 'Paid' THEN
        SET p_message = 'Bill has already been paid.';
    ELSEIF p_payment_amount < v_bill_amount THEN
        SET p_message = 'Insufficient payment.';
    ELSE
        -- Update bill status to paid and record payment
        UPDATE BILL SET status = 'Paid' WHERE bill_id = p_bill_id;
        INSERT INTO PAYMENT (amount, method, date, bill_id)
        VALUES (p_payment_amount, p_payment_method, p_payment_date, p_bill_id);
        SET p_message = 'Payment recorded successfully.';
    END IF;
END;

-- 4. TRİGGERS

-- Create audit log table to track changes
CREATE TABLE IF NOT EXISTS AUDIT_LOG (
                                         log_id INT AUTO_INCREMENT PRIMARY KEY,
                                         table_name VARCHAR(255),
                                         record_id VARCHAR(255),
                                         action_type VARCHAR(50),
                                         details TEXT,
                                         change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Drop existing trigger if any
DROP TRIGGER IF EXISTS trg_log_new_bill;

-- Trigger to log insertions in BILL table
CREATE TRIGGER trg_log_new_bill
    AFTER INSERT ON BILL
    FOR EACH ROW
BEGIN
    INSERT INTO AUDIT_LOG (table_name, record_id, action_type, details)
    VALUES ('BILL', NEW.bill_id, 'INSERT', CONCAT('New bill created: ', NEW.amount));
END;

-- Drop existing trigger if any
DROP TRIGGER IF EXISTS trg_update_bill_status;

-- Trigger to log status updates when bill is paid
CREATE TRIGGER trg_update_bill_status
    AFTER UPDATE ON BILL
    FOR EACH ROW
BEGIN
    IF NEW.status = 'Paid' AND OLD.status <> 'Paid' THEN
        INSERT INTO AUDIT_LOG (table_name, record_id, action_type, details)
        VALUES ('BILL', NEW.bill_id, 'UPDATE', 'Bill has been paid.');
    END IF;
END;
