## Drop the database / schema - Movies in case it already exists
drop schema if exists `movies`;

## Create the database / schema - Movies
CREATE SCHEMA `movies`;

## Setting 'Movies' schema to default, so that the query does not need to refer to the schema
use movies;

## Drop the table - movie_names in case it already exists
DROP TABLE IF EXISTS `movie_names`;

## Create the table - movie_names - This will be a kind of look up table or main table which stores all the movies which are being rated in this exercise
CREATE TABLE `movie_names` (
  `movie_id` varchar(2) NOT NULL,
  `movie_name` varchar(30) NOT NULL,
   PRIMARY KEY(`movie_id`),
    UNIQUE KEY(`movie_name`)
) ;

## Inserting data into the table - movie_names
INSERT INTO `movie_names` VALUES
("M1","Incredibles 2"), ("M2","Crazy Rich Asians"), ("M3","Avengers: Infinity War"), ("M4","Deadpool 2"), ("M5", "The Predator"), ("M6", "Searching")
;

## Drop the table - person in case it already exists
DROP TABLE IF EXISTS `person`;

## Create the table - person - This will be a kind of look up table or main table which stores all the people IDs which have given ratings for this exercise
CREATE TABLE `person` (
  `person_id` varchar(3) NOT NULL,
   PRIMARY KEY(`person_id`)
) ;

## Inserting data into the table - person
INSERT INTO `person` VALUES
("P1"), ("P2"), ("P3"), ("P4"), ("P5"), ("P6"),("P7")
;

## Drop the table - movie_ratings in case it already exists
DROP TABLE IF EXISTS `movie_ratings`;

## Create the table - movie_ratings - which has all the ratings given for the movies given in the table - movie_names, by the persons given in the table - person
CREATE TABLE `movie_ratings` (
  `movie_id` varchar(2) NOT NULL,
  `person_id` varchar(3) NOT NULL,
  `movie_rating` varchar(1) NOT NULL,
  PRIMARY KEY (`movie_id`,`person_id`),
  FOREIGN KEY (movie_id)
        REFERENCES movie_names(movie_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	  FOREIGN KEY (person_id)
        REFERENCES person(person_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ;

## Inserting data into the table - movie_ratings. This is the main data which gives the movie rating observations
INSERT INTO `movie_ratings`	VALUES ("M1","P1","4"), ("M2","P1","2"), ("M3","P1","3"), ("M4","P1","3"), ("M5", "P1","3"), ("M6","P1","3"),
							("M1","P2","3"), ("M2","P2","3"), ("M3","P2","3"), ("M4","P2","4"), ("M5", "P2","3"), ("M6","P2","2"),
                            ("M1","P3","5"), ("M2","P3","3"), ("M3","P3","5"), ("M4","P3","4"), ("M5", "P3","3"), ("M6","P3","3"),
                            ("M1","P4","5"), ("M2","P4","3"), ("M3","P4","4"), ("M4","P4","3"), ("M5", "P4","2"), ("M6","P4","4"),
                            ("M1","P5","4"), ("M2","P5","2"), ("M3","P5","5"), ("M4","P5","3"), ("M5", "P5","3"), ("M6","P5","5"),
                            ("M1","P6","4"), ("M2","P6","3"), ("M3","P6","5"), ("M4","P6","3"), ("M5", "P6","2"), ("M6","P6","4"),
                            ("M1","P7","3"), ("M2","P7","4"), ("M3","P7","4"), ("M4","P7","3"), ("M5", "P7","3"), ("M6","P7","4")
;

## Please noe the below code snippen must run after the MySQL my.ini file has been changed manually to refer to mysql_native_password for the default_authentication_plugin
## The below code will ensure that a temporary password has been given to read the database from R so that the R code is completely reproducible
## If the below code is not given, then the user who runs a copy of this SQL file in his / her own personal computer will have to change the password in R code given along with this SQL file to the root password of the local machine
## Hence the below code is for complete reproducibility
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test1234';