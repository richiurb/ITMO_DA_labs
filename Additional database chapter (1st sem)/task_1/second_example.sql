CREATE TABLE client(
	id BIGINT PRIMARY KEY,
	name TEXT NOT NULL,
	phone_number CHAR(11) CHECK(REGEXP_LIKE(phone_number, '^7\d{10}$'))
);

/* good example */
INSERT INTO client (id, name, phone_number)
VALUES 
(24152, 'Yaroslav', '79214291393');

/*bad example */
INSERT INTO client (id, name, phone_number)
VALUES 
(24153, 'Ivan', '9115920138');