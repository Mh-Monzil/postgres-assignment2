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
  (2, 4, '2023-08-01 10:00:00', 'Himalayas', 'Spotted in the Himalayas');


  --1
  INSERT INTO rangers (name, region)
  VALUES ('Derek Fox', 'Coastal Plains');

  --2 
  SELECT COUNT(DISTINCT species_id) AS unique_species_count  FROM sightings;

  --3 
  SELECT * FROM sightings
  WHERE location LIKE '%Pass%';

  --4
  SELECT name, COUNT(*) AS total_sightings FROM rangers
  JOIN sightings USING (ranger_id)
  GROUP BY name;

  --5
  SELECT common_name FROM species
    WHERE species_id NOT IN (SELECT species_id FROM sightings);

  --6
  SELECT * FROM sightings
  ORDER BY sighting_time DESC
  LIMIT 2;

  --7
  UPDATE species
  set conservation_status = 'Historic'
  WHERE discovery_date < '1800-01-01';


SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;