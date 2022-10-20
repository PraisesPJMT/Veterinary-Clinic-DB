/* Inserting four (4) values into 'animals' table
Each value having id, name, date_of_birth,
escape_attempts, neutered,  and weight_kg
*/

insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) values (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23);
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) values (2, 'Gabumon', '2018-11-15', 2, TRUE, 8);
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) values (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) values (4, 'Devimon', '2017-05-12', 5, TRUE, 11);

-- Adding more data to the animals table
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
values  (5, 'Charmander', '2020-02-08', 0, FALSE, -11),
        (6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7),
        (7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13),
        (8, 'Angemon', '2005-06-12', 1, TRUE, -45),
        (9, 'Boarmon', '2005-06-07', 7, TRUE, 20.4),
        (10, 'Blossom', '1998-10-13', 3, TRUE, 17),
        (11, 'Ditto', '2022-05-14', 4, TRUE, 22);

/* Inserting six(6) data into the 'owners' table
   Each data having a name and age
*/
INSERT INTO owners (full_name, age)
VALUES  ('Sam Smith', 34), ('Jennifer Orwell', 19),
        ('Bob', 45), ('Melody Pond', 77),
        ('Dean Winchester', 14), ('Jodie Whittaker', 38);

-- Inserting two(2) data into the 'species' table
INSERT INTO species (name) VALUE ('Pokemon'), ('Digimon');

/* Modifying 'species_id' in 'animals' table with the following values:
   If the name ends in 'mon', it will be 'Digimon'
   All other animals are 'Pokemon'
*/
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- Modifying 'owner_id' in animals to reflect the following info
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

/* Inserting four(4) data into the 'vets' table
   Each data having a name, age, and date_of_graduation
*/
INSERT INTO vets (name, age, date_of_graduation)
VALUES  ('William Tatcher', 45, '2000-04-23'), ('Maisy Smith', 26, '2019-01-17'),
        ('Stephanie Mendez', 64, '1981-05-04'), ('Jack Harkness', 38, '2008-06-08');

/* Inserting three(3) data into the 'specialties' table
   Each data having a specie, and vet
*/
INSERT INTO specialties (vet, specie)
VALUES  ('William Tatcher', 'Pokemon'), ('Stephanie Mendez', 'Digimon'),
        ('Stephanie Mendez', 'Pokemon'), ('Jack Harkness', 'Digimon');

/* Inserting twenty(20) data into the 'visits' table
   Each data having a animal, vet, and date_visited
*/
INSERT INTO visits (animal, vet, date_visited)
VALUES  ('Boarmon', 'Maisy Smith', '2019-01-24'), ('Boarmon', 'Maisy Smith', '2019-05-15'),
        ('Squirtle', 'Stephanie Mendez', '2019-09-29'), ('Plantmon', 'Maisy Smith', '2019-12-21'),
        ('Pikachu', 'Maisy Smith', '2020-01-05'), ('Boarmon', 'Maisy Smith', '2020-02-27'),
        ('Pikachu', 'Maisy Smith', '2020-03-08'), ('Pikachu', 'Maisy Smith', '2020-05-14'),
        ('Agumon', 'William Tatcher', '2020-05-24'), ('Blossom', 'Stephanie Mendez', '2020-05-24'),
        ('Agumon', 'Stephanie Mendez', '2020-07-22'), ('Boarmon', 'Maisy Smith', '2020-08-03'),
        ('Plantmon', 'William Tatcher', '2020-08-10'), ('Angemon', 'Jack Harkness', '2020-10-03'),
        ('Angemon', 'Jack Harkness', '2020-11-04'), ('Blossom', 'William Tatcher', '2021-01-11'),
        ('Gabumon', 'Jack Harkness', '2021-02-02'), ('Charmander', 'Jack Harkness', '2021-02-24'),
        ('Plantmon', 'Maisy Smith', '2021-04-07'), ('Devimon', 'Stephanie Mendez', '2021-05-04');