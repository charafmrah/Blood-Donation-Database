-------------------- DROPPING EXISTING TABLES --------------------
drop table patient cascade constraints;
drop table profile cascade constraints;
drop table profile_phone_number cascade constraints;
drop table login cascade constraints;
drop table blood_stock cascade constraints;
drop table donor cascade constraints;
drop table blood_received cascade constraints;
drop table donated cascade constraints;

-------------------- CREATING TABLES --------------------
CREATE TABLE patient (
    patient_id VARCHAR2(6) PRIMARY KEY,
    blood_type VARCHAR2(3) NOT NULL
);

CREATE TABLE donor (
    donor_id VARCHAR2(6) PRIMARY KEY,
    blood_type VARCHAR2(3) NOT NULL
);

CREATE TABLE profile (
    user_id VARCHAR2(10) PRIMARY KEY,
    fname VARCHAR2(20) NOT NULL,
    lname VARCHAR2(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    donor_id VARCHAR2(6) REFERENCES donor(donor_id),
    patient_id VARCHAR2(6) REFERENCES patient(patient_id)
);

CREATE TABLE profile_phone_number (
    phone_number NUMBER(10) PRIMARY KEY,
    user_id VARCHAR2(10) REFERENCES profile(user_id)
);

CREATE TABLE login (
    username VARCHAR2(30) PRIMARY KEY,
    user_password VARCHAR2(15) NOT NULL,
    user_id VARCHAR2(10) REFERENCES profile(user_id)
);

CREATE TABLE blood_stock (
    blood_id VARCHAR2(6) PRIMARY KEY,
    quantity NUMBER(3) NOT NULL,
    expiration_date DATE NOT NULL
);

CREATE TABLE blood_received (
    patient_id VARCHAR2(6) REFERENCES patient(patient_id),
    blood_id VARCHAR2(6) REFERENCES blood_stock(blood_id)
);

CREATE TABLE donated (
    blood_id VARCHAR2(6) REFERENCES blood_stock(blood_id),
    donor_id VARCHAR2(6) REFERENCES donor(donor_id)
);

-------------------- INSERTING --------------------
INSERT INTO donor VALUES('10001', 'A+');
INSERT INTO profile (user_id, fname, lname, date_of_birth, donor_id) VALUES ('001', 'Dwight', 'Shrute', TO_DATE('03/OCT/1989','DD/MON/YYYY'), '10001');
INSERT INTO profile_phone_number VALUES( '536259875', '001');
INSERT INTO login VALUES ('dwightshrute', 'assistant2', '001');
INSERT INTO blood_stock VALUES('111', 2, TO_DATE('20/JUN/2021','DD/MON/YYYY'));
INSERT INTO donated VALUES ('111', '10001');

INSERT INTO donor VALUES('10002', 'O-');
INSERT INTO profile (user_id, fname, lname, date_of_birth, donor_id) VALUES ('002', 'Michael', 'Scott', TO_DATE('03/OCT/1975','DD/MON/YYYY'), '10002');
INSERT INTO profile_phone_number VALUES( '569842257', '002');
INSERT INTO login VALUES ('bestboss', '1234', '002');
INSERT INTO blood_stock VALUES('222', 3, TO_DATE('18/MAY/2021','DD/MON/YYYY'));
INSERT INTO donated VALUES ('222', '10002');

INSERT INTO patient VALUES('10003', 'B-');
INSERT INTO profile (user_id, fname, lname, date_of_birth, patient_id) VALUES ('003', 'Jim', 'Halpert', TO_DATE('01/OCT/1978','DD/MON/YYYY'), '10003');
INSERT INTO profile_phone_number VALUES('2428942450','003');
INSERT INTO login VALUES('Jim003','Jim1978','003');
INSERT INTO blood_received VALUES('10003','222');

INSERT INTO patient VALUES('10004', 'AB+');
INSERT INTO profile (user_id, fname, lname, date_of_birth, patient_id) VALUES ('004', 'Pam', 'Beesly', TO_DATE('25/MAR/1979','DD/MON/YYYY'), '10004');
INSERT INTO profile_phone_number VALUES('2429007053','004');
INSERT INTO login VALUES('Pam004','Pam1979','004');
INSERT INTO blood_received VALUES('10004','111');
                                                
-------------------- SOME OPERATIONS --------------------
--1 Set operation
SELECT patient_id 
FROM patient
WHERE blood_type = 'B-'
UNION
SELECT patient_id 
FROM patient
WHERE blood_type = 'AB-';

SELECT donor_id
FROM donor
WHERE blood_type = 'A+'
UNION
SELECT donor_id
FROM donor
WHERE blood_type = 'O-';

--2 Join(with condition)
SELECT fname, lname, date_of_birth 
FROM profile NATURAL JOIN donor;

SELECT fname, lname, blood_type
FROM profile NATURAL JOIN patient;

--3 Aggregate operation
SELECT SUM(quantity)
FROM blood_stock;

SELECT MIN(quantity)
FROM blood_stock;

--4 Nested Queries
SELECT blood_type, donor_id
FROM donor
WHERE donor_id = 
    (SELECT donor_id 
    FROM donor
    WHERE blood_type = 'O-');
                                                                                       
SELECT *
FROM   blood_stock
WHERE  blood_id IN
   (SELECT blood_id
   FROM blood_received
   WHERE blood_id = '111');
