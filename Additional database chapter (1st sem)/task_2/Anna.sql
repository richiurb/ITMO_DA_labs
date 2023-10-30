CREATE TABLE Anna
(
	id serial PRIMARY KEY,
	distance integer CHECK(distance >= 0),
	stop_count integer CHECK(stop_count >= 0),
	cost integer CHECK(cost >= 0),
	fitness integer CHECK(fitness >= 0),
	internet integer CHECK(internet >= 0),
	additional_info text
);

COPY Anna FROM 'D:\RICHI_URB239\STUDY\master_1\Database\task_2\Anna.csv' DELIMITER ',' CSV HEADER;

CREATE OR REPLACE FUNCTION dog_friendly_coef(additional_info text)
RETURNS decimal
LANGUAGE 'sql'
AS $body$
SELECT CASE WHEN REGEXP_LIKE(additional_info, 'собак', 'i') OR 
		REGEXP_LIKE(additional_info, 'животн', 'i') OR 
		REGEXP_LIKE(additional_info, 'четвероног', 'i') OR 
		REGEXP_LIKE(additional_info, 'dog', 'i') THEN 1.0
	WHEN REGEXP_LIKE(additional_info, 'парк', 'i') THEN 0.5
	WHEN REGEXP_LIKE(additional_info, 'инфраструктур', 'i') THEN 0.3
	ELSE 0.0
END;
$body$;

CREATE VIEW max_min AS
SELECT 
MIN(distance) as min_distance,
MAX(distance) as max_distance,
MIN(stop_count) as min_stop_count,
MAX(stop_count) as max_stop_count,
MIN(cost) as min_cost,
MAX(cost) as max_cost,
MIN(fitness) as min_fitness,
MAX(fitness) as max_fitness,
MIN(internet) as min_internet,
MAX(internet) as max_internet
FROM Anna;

CREATE OR REPLACE FUNCTION norm(cur integer, max_val integer, min_val integer)
RETURNS decimal
LANGUAGE 'sql'
AS $body$
SELECT (cur - min_val)::decimal / (max_val - min_val)::decimal;
$body$;


SELECT id,
(3.0 * norm(distance, (SELECT max_distance FROM max_min)::integer, (SELECT min_distance FROM max_min)::integer) +
	2.0 * norm(stop_count, (SELECT max_stop_count FROM max_min)::integer, (SELECT min_stop_count FROM max_min)::integer) +
	5.0 * (1 - norm(cost, (SELECT max_cost FROM max_min)::integer, (SELECT min_cost FROM max_min)::integer)) +
	2.0 * norm(fitness, (SELECT max_fitness FROM max_min)::integer, (SELECT min_fitness FROM max_min)::integer) +
	1.0 * norm(internet, (SELECT max_internet FROM max_min)::integer, (SELECT min_internet FROM max_min)::integer) +
	5.0 * dog_friendly_coef(additional_info)) / 18.0 AS rent_coef,
cost, dog_friendly_coef(additional_info) AS dog_friendly_coef
FROM Anna
WHERE (internet > 0)
ORDER BY rent_coef DESC
LIMIT 10