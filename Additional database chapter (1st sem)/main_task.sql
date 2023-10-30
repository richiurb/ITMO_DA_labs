CREATE TABLE cinema
(
    id integer PRIMARY KEY,
    name text NOT NULL,
    address text,
    phone_number text CHECK(REGEXP_LIKE(phone_number, '^\d{11}$'))
);

CREATE TABLE hall
(
    id integer PRIMARY KEY,
    hall_number text NOT NULL,
    cinema_id integer,
    capacity integer CHECK(capacity > 0),
    CONSTRAINT cinema_id FOREIGN KEY (cinema_id)
        REFERENCES cinema (id)
);

CREATE TABLE film
(
    id bigint PRIMARY KEY,
    name text NOT NULL,
    genre text,
    rating numeric CHECK(rating > 0.0 AND rating <= 10.0),
    duration interval NOT NULL
);

CREATE TABLE sessions
(
    id bigint PRIMARY KEY,
    film_id bigint,
    hall_id integer,
    session_start timestamp without time zone NOT NULL,
    seats_sold integer CHECK(seats_sold >= 0),
    FOREIGN KEY (film_id)
        REFERENCES film (id),
    FOREIGN KEY (hall_id)
        REFERENCES hall (id)
);

INSERT INTO cinema (id, name, address, phone_number)
VALUES
(1, 'Аврора', 'адрес_1', '78120000001'),
(2, 'Тест_2', 'адрес_2', '78120000002'),
(3, 'Тест_3', 'адрес_3', '78120000003');


INSERT INTO hall (id, hall_number, cinema_id, capacity)
VALUES
(1, '1', 1, 87),
(2, '2', 1, 75),
(3, '3', 1, 103),
(4, '1', 2, 70),
(5, '2', 2, 130),
(6, '3', 2, 130),
(7, '4', 2, 100),
(8, '5', 2, 100),
(9, '1', 3, 53),
(10, '2', 3, 49);


INSERT INTO film (id, name, genre, rating, duration)
VALUES
(1, 'Переводчик', 'боевик', 7.9, '02:03:00'),
(2, 'После', 'мелодрама', 5.4, '01:33:00'),
(3, 'Леди Баг и Супер-Кот', 'мультфильм', 6.1, '01:45:00'),
(4, 'Фильм_4', 'драма', 6.5, '01:53:00'),
(5, 'Фильм_5', 'комедия', 5.1, '01:37:00'),
(6, 'Фильм_6', 'фантастика', 7.3, '02:16:00'),
(7, 'Фильм_7', 'детектив', 6.8, '01:52:00'),
(8, 'Фильм_8', 'документальный', 5.5, '02:34:00'),
(9, 'Фильм_9', 'спортивный', 6.1, '01:49:00'),
(10, 'Фильм_10', 'боевик', 4.4, '01:28:00'),
(11, 'Фильм_11', 'вестерн', 3.9, '01:35:00');


INSERT INTO sessions (id, film_id, hall_id, session_start, seats_sold)
VALUES
(1, 1, 2, '2023-09-15 15:15:00', 0),
(2, 1, 2, '2023-09-15 18:40:00', 0),
(3, 1, 2, '2023-09-15 21:55:00', 0),
(4, 1, 4, '2023-09-15 14:30:00', 0),
(5, 1, 5, '2023-09-15 15:50:00', 0),
(6, 1, 4, '2023-09-15 17:45:00', 0),
(7, 1, 5, '2023-09-15 19:10:00', 0),
(8, 1, 4, '2023-09-15 21:00:00', 0),
(9, 1, 5, '2023-09-15 22:25:00', 0),
(10, 1, 4, '2023-09-15 23:55:00', 0),
(11, 2, 1, '2023-09-15 20:40:00', 0),
(12, 2, 6, '2023-09-15 19:15:00', 0),
(13, 2, 6, '2023-09-15 21:40:00', 0),
(14, 2, 9, '2023-09-15 21:25:00', 0),
(15, 3, 1, '2023-09-15 11:15:00', 0),
(16, 3, 1, '2023-09-15 14:00:00', 0),
(17, 3, 6, '2023-09-15 12:20:00', 0),
(18, 4, 1, '2023-09-15 16:45:00', 0),
(19, 8, 3, '2023-09-15 12:25:00', 0),
(20, 9, 3, '2023-09-15 16:20:00', 0),
(21, 6, 3, '2023-09-15 20:05:00', 0),
(22, 11, 5, '2023-09-15 10:40:00', 0),
(23, 6, 7, '2023-09-15 12:50:00', 0),
(24, 10, 7, '2023-09-15 18:10:00', 0),
(25, 5, 7, '2023-09-15 20:45:00', 0),
(26, 7, 7, '2023-09-15 23:20:00', 0),
(27, 4, 8, '2023-09-15 17:35:00', 0),
(28, 6, 8, '2023-09-15 20:50:00', 0),
(29, 6, 9, '2023-09-15 16:40:00', 0),
(30, 9, 10, '2023-09-15 14:30:00', 0),
(31, 6, 10, '2023-09-15 19:05:00', 0),
(32, 4, 10, '2023-09-15 22:45:00', 0);

/*
SELECT (s.session_start + f.duration) AS end_time FROM sessions AS s
LEFT JOIN film as f
ON s.film_id = f.id
*/

/*
SELECT name FROM film
WHERE id IN
    (SELECT film_id FROM sessions
    WHERE hall_id IN
        (SELECT id FROM hall
        WHERE cinema_id =
            (SELECT id FROM cinema
            WHERE name = 'Аврора')));
*/
  
/* 
 SELECT h.hall_number, c.name FROM hall AS h
INNER JOIN cinema AS c
ON h.cinema_id = c.id
WHERE h.id IN
    (SELECT DISTINCT hall_id FROM sessions
    WHERE film_id IN
        (SELECT id FROM film
        WHERE name = 'Переводчик'))
*/
   
/*
SELECT f.name, COUNT(*) AS frequency
FROM sessions as s
LEFT JOIN film as f
ON s.film_id = f.id
GROUP BY f.name
ORDER BY COUNT(*) DESC
LIMIT 10
*/

/*
SELECT name FROM cinema
WHERE id NOT IN
    (SELECT DISTINCT cinema_id FROM hall
    WHERE id IN
        (SELECT DISTINCT hall_id FROM sessions
        WHERE film_id IN
            (SELECT id FROM film
            WHERE name = 'Переводчик')))
*/

CREATE OR REPLACE FUNCTION cinemaNameByHallId(h_id integer)
RETURNS text
LANGUAGE 'sql'
AS $body$
SELECT name FROM cinema 
WHERE id = 
(
	SELECT cinema_id FROM hall WHERE id = h_id
);
$body$;

CREATE OR REPLACE FUNCTION playbill(datebill date)
RETURNS TABLE (film_name text, datetime timestamp without time zone, cinema_name text)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	SELECT f.name, s.session_start, cinemaNameByHallId(s.hall_id) FROM sessions AS s
	LEFT JOIN film AS f
	ON s.film_id = f.id
	WHERE s.session_start::date = datebill;
END;$$;

CREATE VIEW aurora_timeline AS
SELECT f.name, s.session_start FROM sessions AS s
LEFT JOIN film AS f
ON s.film_id = f.id
WHERE hall_id IN 
(
	SELECT id FROM hall
	WHERE cinema_id = 
	(
		SELECT id FROM cinema
		WHERE name = 'Аврора'
	)
);

CREATE MATERIALIZED VIEW top_10_films AS
SELECT name, rating FROM film
ORDER BY rating DESC
LIMIT 10;

CREATE SEQUENCE film_serial START 12;
INSERT INTO film VALUES (nextval('film_serial'), 'Фильм_12', 'драма', 5.7, '01:48:00');

CREATE SEQUENCE sessions_serial START 33;
INSERT INTO sessions VALUES (nextval('sessions_serial'), 1, 2, '2023-09-16 15:15:00', 0);

/* триггер для обновления materialized view про топ 10 фильмов */
CREATE OR REPLACE FUNCTION f_refresh_top_list()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
REFRESH MATERIALIZED VIEW top_10_films;
RETURN NEW;
END;
$$;

CREATE TRIGGER t_refresh_top_list
AFTER INSERT OR UPDATE
ON film
FOR STATEMENT
EXECUTE PROCEDURE f_refresh_top_list();

/*
INSERT INTO film VALUES (nextval('film_serial'), 'Фильм_13', 'боевик', 6.3, '01:38:00');

SELECT * FROM top_10_films;
*/

/* триггер для проверки возможности проведения сеанса */
CREATE OR REPLACE FUNCTION session_end(session_start TIMESTAMP WITHOUT TIME ZONE, film_id BIGINT)
RETURNS TIMESTAMP WITHOUT TIME ZONE
LANGUAGE 'sql'
AS $body$
SELECT (session_start + film.duration) FROM film
WHERE film_id = film.id
$body$;

CREATE FUNCTION f_check_session_time()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
declare 
    line record;
BEGIN
FOR line IN SELECT s.session_start AS session_start FROM sessions AS s WHERE s.hall_id = NEW.hall_id
LOOP
  IF (NEW.session_start, session_end(NEW.session_start, NEW.film_id)) OVERLAPS (line.session_start, session_end(line.session_start, NEW.film_id))
  THEN
    RAISE EXCEPTION 'intersection in the schedule';
  END IF;
END LOOP;
RETURN NEW;
EXCEPTION 
    WHEN OTHERS THEN
    PERFORM to_log('f_check_session_time', 'intersection in the schedule');
RETURN NEW;
END;
$$;

CREATE TRIGGER t_check_session_time
BEFORE INSERT OR UPDATE
ON sessions
FOR EACH ROW
EXECUTE PROCEDURE f_check_session_time();

/*
INSERT INTO sessions VALUES (nextval('sessions_serial'), 1, 2, '2023-09-16 16:15:00', 0);

INSERT INTO sessions VALUES (nextval('sessions_serial'), 1, 2, '2023-09-16 18:15:00', 0);
*/

CREATE FUNCTION f_solded_seats()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
declare 
BEGIN
IF NEW.seats_sold > (SELECT capacity FROM hall WHERE id = NEW.hall_id)
THEN
  RAISE EXCEPTION 'it is impossible to sell so many tickets: limitation of capacity';
END IF;
RETURN NEW;
EXCEPTION 
    WHEN OTHERS THEN
    PERFORM to_log('f_solded_seats', 'it is impossible to sell so many tickets: limitation of capacity');
RETURN NEW;
END;
$$;

CREATE TRIGGER t_solded_seats
BEFORE INSERT OR UPDATE
ON sessions
FOR EACH ROW
EXECUTE PROCEDURE f_solded_seats();

/*
INSERT INTO sessions VALUES (nextval('sessions_serial'), 1, 2, '2023-09-17 15:15:00', 12);

INSERT INTO sessions VALUES (nextval('sessions_serial'), 1, 2, '2023-09-18 15:15:00', 1200);
*/

/* 5 задание */

CREATE TABLE test_log (
   id INT GENERATED ALWAYS AS IDENTITY,
   procedure_name TEXT,
   what TEXT,
   time TIMESTAMP,
   user_id text 
);

CREATE OR REPLACE FUNCTION to_log(procedure_name text, p_sqlstate text) RETURNS boolean AS 
$$
BEGIN 
       INSERT INTO test_log(procedure_name,what,time,user_id) VALUES (procedure_name, p_sqlstate, now(), current_user);
       RETURN true;
END;
$$ LANGUAGE plpgsql;

/* 6
таблицы

SELECT * FROM pg_tables
WHERE NOT(tableowner = 'postgres')
ORDER BY schemaname, tablename;

CREATE OR REPLACE VIEW tables_info
AS
SELECT oid, relname FROM pg_class
WHERE relname IN
(
  SELECT tablename FROM pg_tables
  WHERE NOT(tableowner = 'postgres') AND NOT(tablename = 'demo')
);

SELECT ti.relname AS table_name, att.attname AS column_name, att.atttypid::regtype AS COLUMN_TYPE FROM pg_attribute AS att
RIGHT JOIN tables_info AS ti
ON att.attrelid = ti.oid
WHERE attnum > 0;

SELECT * FROM pg_indexes
WHERE tablename not like 'pg%' AND tablename NOT LIKE 'demo'
ORDER BY schemaname, tablename;

SELECT * FROM pg_sequences
WHERE sequencename NOT LIKE 'demo%';

SELECT * FROM pg_views
WHERE NOT(viewowner = 'postgres');

SELECT * FROM pg_matviews
  WHERE NOT(matviewowner = 'postgres');

SELECT ti.relname AS table_name, tg.tgname FROM pg_trigger AS tg
INNER JOIN tables_info AS ti
ON tg.tgrelid = ti.oid;

SELECT * FROM pg_proc
WHERE pronamespace = 2200;

индексы:

SELECT * FROM pg_stat_all_indexes
WHERE schemaname = 'public';

текущий процесс:

SELECT pid, query, state, wait_event, wait_event_type, pg_blocking_pids(pid)
FROM pg_stat_activity;

*/
