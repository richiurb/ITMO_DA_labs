CREATE TABLE teams(
	id BIGINT PRIMARY KEY,
	name TEXT NOT NULL,
	abbreviation CHAR(3) CHECK(REGEXP_LIKE(abbreviation, '^[A-Z]{1,3}$'))
);

/* good example */
INSERT INTO teams (id, name, abbreviation)
VALUES 
(6, 'BestTeamITMO', 'BTI');

/*bad example */
INSERT INTO teams (id, name, abbreviation)
VALUES 
(7, 'LikeAG6', 'G6');