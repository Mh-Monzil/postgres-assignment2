-- Active: 1747538163412@@127.0.0.1@5432@conservation_db
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  region VARCHAR(50) NOT NULL
);

CREATE TABLE species (
  species_id SERIAL PRIMARY KEY,
  common_name VARCHAR(100) NOT NULL,
  scientific_name VARCHAR(150) NOT NULL,
  discovery_date DATE NOT NULL,
  conservation_status VARCHAR(50) NOT NULL
);

CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INTEGER NOT NULL,
  species_id INTEGER NOT NULL,
  sighting_time TIMESTAMP NOT NULL,
  location VARCHAR(100) NOT NULL,
  notes TEXT,
  FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
  FOREIGN KEY (species_id) REFERENCES species(species_id)
);

INSERT INTO rangers (name, region)
VALUES
  ('Alice Green', 'Northern Hills'),
  ('Bob White', 'River Delta'),
  ('Carol King', 'Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES
  ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
  ('Bengal Tiger', 'Panthera tigris', '1758-01-01', 'Endangered'),
  ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
  ('Asiatic Elephant', 'Elephas maximus', '1758-01-01', 'Endangered');


INSERT INTO sightings (ranger_id, species_id, sighting_time, location, notes)
VALUES
  (1, 1, '2022-01-01', 'Mountain Peak', 'Sighting of a Snow Leopard'),
  (2, 2, '2022-02-01', 'River Bank', 'Sighting of a Bengal Tiger'),
  (3, 3, '2022-03-01', 'Forest Clearing', 'Sighting of a Red Panda'),
  (1, 4, '2022-04-01', 'Desert Oasis', 'Sighting of an Asiatic Elephant');


SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;