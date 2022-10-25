/* Clinic Database
*/

-- Creating a database called 'clinic'
CREATE DATABASE clinic;

/* Creating 'patients' table in 'clinic' database
   Table has columns: id, name, and date_of_birth,
*/
CREATE TABLE patients(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE
);

/* Creating 'medical_histories' table in 'clinic' database
   Table has columns: id, admitted_at, status, and patient_id(As Foreign Key)
*/
CREATE TABLE medical_histories(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    status VARCHAR(50),
    patient_id INT,

    CONSTRAINT fk_patient_id FOREIGN KEY(patient_id) REFERENCES patients(id)
);
-- create a non clustered index for patient_id on medical_histories table
CREATE INDEX medical_histories_patient_id ON medical_histories(patient_id);

/* Creating 'treatments' table in 'clinic' database
   Table has columns: id, type, and name
*/
CREATE TABLE treatments(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(40),
    name VARCHAR(50)
);
