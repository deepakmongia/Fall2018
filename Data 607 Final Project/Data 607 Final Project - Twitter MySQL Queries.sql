## Drop the database / schema - twitter in case it already exists
drop schema if exists `twitter`;

## Create the database / schema - twitter
CREATE SCHEMA `twitter`;

## Setting 'twitter' schema to default, so that the query does not need to refer to the schema
use twitter;

## Drop the table - twitter in case it already exists
DROP TABLE IF EXISTS `twitter`;

## Create the table - twitter
CREATE TABLE `twitter` (
  `tweet_text` varchar(1000) NOT NULL
) ;