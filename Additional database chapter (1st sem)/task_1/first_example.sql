CREATE TABLE parking_cars(
	registration_number CHAR(9) PRIMARY KEY CHECK(REGEXP_LIKE(registraion_number, '^[АВЕКМНОРСТУХ]\d{3}(?<!000)[АВЕКМНОРСТУХ]{2}\d{2,3}$')),
	car_model TEXT
	owner_id BIGINT
);

/* good example */
INSERT INTO parking_cars (registration_number, car_model, owner_id)
VALUES 
('А574КК198', 'KIA K5', 1533382);

/* bad example */
INSERT INTO parking_cars (registration_number, car_model, owner_id)
VALUES 
('X000XX777', 'TOYOTA CAMRY', 2479012);
