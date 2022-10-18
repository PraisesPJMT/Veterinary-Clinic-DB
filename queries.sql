/* Querries on the 'animals' table of 'vet_clinic' */

-- Find all animals whoes name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List the names and escape attempts of animals that weight more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered
SELECT * FROM animals WHERE neutered = TRUE;

-- Find all animals not name Gabumon
SELECT * FROM animals WHERE name != 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg
  (Including the animals with the weight that equals precisely 10.4kg or 17.3kg)
*/
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Begin a transaction
BEGIN;

-- Update the 'animals' table by setting the species column to unspecified
UPDATE animals SET species = 'unspecified';

-- Verify changes was made
SELECT * FROM animals;

-- Roll back the changes to the state before the trasaction.
ROLLBACK;

-- Verify the 'species' columns went back to the state before the transaction.
SELECT * FROM animals;

-- Update the 'animals' table by setting the 'species' column to 'digimon' for all animals that have a name ending in 'mon'.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the 'animals' table by setting the 'species' column to 'pokemon' for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Commit the transaction
COMMIT;

--Begin a transaction
BEGIN;

--Delete all records in the 'animals' table
DELETE FROM animals;

-- Roll back the changes to the state before the trasaction.
ROLLBACK;

--Begin a transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction
SAVEPOINT POINT1;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO POINT1;

-- Update all animals' weight that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit transaction
COMMIT;

-- Query to find how many animals there are
SELECT COUNT(*) from animals;

-- Query to find how many animals have never tried to escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- Query to know the average weight of animals
SELECT AVG(weight_kg) FROM animals;

-- Query to know who escapes the most, neutered or not nautered animals
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- Query to know the minimum and maximum weight of each type os animal
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

/* Query to know the everage number of escape attempts per animals
   type of those born betweeen 1990 and 2000 */
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;