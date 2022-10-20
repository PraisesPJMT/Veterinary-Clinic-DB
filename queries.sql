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

-- Query to know what animals belong to 'Melody Pond'
SELECT animals.id, name AS animal, owners.full_name AS owner FROM animals
    JOIN owners ON owners.id = animals.owner_id
    WHERE owners.full_name = 'Melody Pond';

-- Query to list all animals that are 'Pokemon'
SELECT animals.id, animals.name AS animal, species.name AS species_name FROM animals
    JOIN species ON species.id = animals.species_id
    WHERE species.name = 'Pokemon';

-- Query to list all owners and their animals
SELECT animals.id, owners.full_name AS owner, animals.name AS animal FROM owners
    JOIN animals ON owners.id = animals.owner_id;

-- Query to know how many animals are there grouped by species
SELECT species.name AS species_name, COUNT(*) FROM species
    JOIN animals ON species.id = animals.species_id
    GROUP BY species.name;

-- Query to list all 'Digimon' owned by 'Jennifer Orwell'
SELECT animals.id, animals.name AS animal, species.name, owners.full_name FROM animals
    JOIN owners ON owners.id = animals.owner_id
    JOIN species ON species.id = animals.species_id
    WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- Query to list all animals owned by 'Dean Winchester' that haven't tried to escape
SELECT animals.id, animals.name AS animal, animals.escape_attempts, owners.full_name AS owner FROM animals
    JOIN owners ON owners.id = animals.owner_id
    WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Query to know who owns the most animals
SELECT owners.full_name AS owner, COUNT(animals.name) AS animal_count FROM animals
    JOIN owners ON owners.id = animals.owner_id
    GROUP BY owners.full_name ORDER BY animal_count DESC LIMIT 1;

-- Query to know who was the last animal seen by William Tatcher
SELECT animals.name AS "Animal", vets.name AS "Vet", date_visited as "Visit" FROM visits
    JOIN vets ON visits.vet_id = vets.id
    JOIN animals ON visits.animal_id = animals.id
    WHERE vets.name = 'William Tatcher'
    ORDER BY date_visited DESC LIMIT 1;

-- Query to know how many different animals did Stephenie Mendez see
SELECT vets.name as "Vet", COUNT(animal_id) AS "Animal Count" FROM visits
    JOIN vets ON visits.vet_id = vets.id
    GROUP BY vets.name HAVING vets.name = 'Stephanie Mendez';

-- Query to list all vets and their specializations, including vets with no specializations
SELECT vets.name AS "Vet", species.name AS "Specialization" FROM vets
    LEFT JOIN specializations ON vets.id = vet_id
    LEFT JOIN species ON specializations.species_id = species.id;

-- Query to list all animals that visited Stephenie Mendez between April 1st and August 30th, 2020
SELECT vets.name AS "Vet", animals.name as "Animal", date_visited as "Visits" FROM visits
    JOIN vets ON visits.vet_id = vets.id
    JOIN animals ON visits.animal_id = animals.id
    WHERE vets.name = 'Stephanie Mendez' AND date_visited BETWEEN '2020-04-01' AND '2020-08-30';

-- Query to know what animal has the most visits to vets
SELECT animals.name as "Animal", COUNT(date_visited) AS "Visits" FROM visits
    JOIN animals ON visits.animal_id = animals.id
    GROUP BY animals.name ORDER BY COUNT(date_visited) DESC LIMIT 1;

-- Query to know who was Maisy Smith's first visite
SELECT animals.name AS "Animal", vets.name as "Vet", date_visited AS "Visit" FROM visits
    JOIN vets ON visits.vet_id = vets.id
    JOIN animals ON visits.animal_id = animals.id
    WHERE vets.name = 'Maisy Smith' ORDER BY date_visited LIMIT 1;

-- Query to show details for the most recent visit animal information, vet information, and date of visited
SELECT animals.id AS "Animal ID", animals.name AS "Animal", date_of_birth AS "Date of Birth",
    escape_attempts AS "Ecapes", neutered AS "Neutered", weight_kg as "Weight", species.name AS "Specie",
    owners.full_name AS "Owner", vets.id AS "Vet ID", vets.name AS "Vet", date_of_graduation AS "Graduation",
    date_visited AS "Visits" FROM animals
    JOIN owners ON owners.id = animals.owner_id
    JOIN species ON species.id = animals.species_id
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON vets.id = visits.vet_id
    ORDER BY date_visited DESC LIMIT 1;

-- Query to know how many visits where a vet that did not specialize in that animals species
SELECT COUNT(*) AS "None Spec Visit Count" FROM animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
    JOIN species ON species.id = animals.species_id
    JOIN specializations ON specializations.vet_id = vets.id
    WHERE animals.species_id != specializations.species_id;

-- Query to know what specialty should Maisy Smith consider getting: Based on species she gets the most.
SELECT vets.name AS Vet, species.name AS "Animal Specie", COUNT(species.name) AS "No of Visits" FROM vets
    JOIN visits ON visits.vet_id = vets.id
    JOIN animals ON animals.id = visits.animal_id
    JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name, vets.name ORDER BY COUNT(species.name) DESC LIMIT 1;
