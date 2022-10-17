/* Vet Clinic Database
*/

-- Creating a database called 'vet clinic'
CREATE DATABASE vet_clinic;

-- Connecting to 'vet_clinic' database
\c vet_clinic;

/* Creating 'Animals' table in 'vet_clinic' database
Table has columns: id, name, date_of_birth, escape_attempts,
neutered,  and weight_kg
*/
CREATE TABLE animals (
    id  INT,
    name    TEXT,
    date_of_birth   DATE,
    escape_attempts INT,
    neutered    BOOLEAN,
    weight_kg   DECIMAL,
    PRIMARY KEY(id)
);