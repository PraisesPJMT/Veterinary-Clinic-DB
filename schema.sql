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

-- Add a 'species' column with 'string' data type to 'animals' table
ALTER TABLE animals ADD species TEXT;

/* Creating 'Owners' table in 'vet_clinic' database
   Table has columns: id, full_nam, and age
*/
CREATE TABLE owners (
    id  BIGSERIAL  NOT NULL,
    full_name   TEXT NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(id)
);

/* Creating 'Species' table in 'vet_clinic' database
   Table has columns: id, and name
*/
CREATE TABLE species (
    id  BIGSERIAL  NOT NULL,
    name   TEXT NOT NULL,
    PRIMARY KEY(id)
);

-- Modify 'animals' table and set id as autoincrementedprimary key
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

-- Remove 'species' column from 'animals' table
ALTER TABLE animals DROP COLUMN species;

/* Add 'species_id' column to animals table with foreign
   key referencing 'species' table
*/
ALTER TABLE animals ADD COLUMN species_id INT references species(id);

/* Add 'owner_id' column to animals table with foreign
   key referencing 'owners' table
*/
ALTER TABLE animals ADD COLUMN owner_id INT references owners(id);

/* Creating 'vets' table in 'vet_clinic' database
   Table has columns: id, name, age, and date_of_graduation
*/
CREATE TABLE vets (
    id  BIGSERIAL  NOT NULL,
    name   TEXT NOT NULL,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

/* Creating 'specialties' table in 'vet_clinic' database
   Table has columns: id, specie, and vet
*/
CREATE TABLE specialties (
    id  BIGSERIAL  NOT NULL,
    vet TEXT,
    specie TEXT,
    PRIMARY KEY(id)
);

/* Creating 'visits' table in 'vet_clinic' database
   Table has columns: id, animal, vet, and date_of_visited
*/
CREATE TABLE visits (
    id  BIGSERIAL  NOT NULL,
    animal TEXT,
    vet TEXT,
    date_visited DATE,
    PRIMARY KEY(id)
);