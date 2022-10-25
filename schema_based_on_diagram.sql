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
    patient_id INT,
    status VARCHAR(50),
    
    CONSTRAINT fk_patient_id FOREIGN KEY(patient_id) REFERENCES patients(id)
);
-- create a non clustered index for patient_id on medical_histories table
CREATE INDEX medical_histories_patient_id ON medical_histories(patient_id);

/* Creating 'medical_histories_treatments' table in 'clinic' database
   Table has columns: id, histories_id(As Foreign Key) and treatment_id(As Foreign Key)
*/
CREATE TABLE medical_histories_treatments(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    histories_id INT,
    treatment_id INT,

    CONSTRAINT fk_medical_history_id FOREIGN KEY(histories_id) REFERENCES medical_histories(id),
    CONSTRAINT fk_medical_history_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
);
-- create a non clustered index for medical_histories_treatments_histories_id on medical_histories_treatments table
CREATE INDEX medical_histories_treatments_histories_id ON medical_histories_treatments(histories_id);
-- create a non clustered index for medical_histories_treatments_treatment_id on medical_histories_treatments table
CREATE INDEX medical_histories_treatments_treatment_id ON medical_histories_treatments(treatment_id);

/* Creating 'treatments' table in 'clinic' database
   Table has columns: id, type, and name
*/
CREATE TABLE treatments(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(40),
    name VARCHAR(50)
);

/* Creating 'invoices' table in 'clinic' database
   Table has columns: id, total_amount, generated_amount, payed_at, and medical_history_id(As Foreign Key)
*/
CREATE TABLE invoices(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_amount TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,

    CONSTRAINT fk_medical_history_id FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
);
-- create a non clustered index for medical_history_id on invoices table
CREATE INDEX invoices_medical_history_id ON invoices(medical_history_id);

/* Creating 'invoice_items' table in 'clinic' database
   Table has columns: id, unit_price, total_price, total_price,
   quantity, invoice_id,(As Foreign Key) and treatment_id(As Foreign Key)
*/

CREATE TABLE invoice_items(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    total_price DECIMAL,
    quantity INT,
    invoice_id INT,
    treatment_id INT,

    CONSTRAINT fk_invoice_id FOREIGN KEY(invoice_id) REFERENCES invoices(id),
    CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);
-- create a non clustered index for invoice_id on invoice_items table
CREATE INDEX invoice_items_invoice_id ON invoice_items(invoice_id);