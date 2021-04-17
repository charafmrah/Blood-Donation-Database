--drop table patient cascade constraints;
--drop table profile cascade constraints;
--drop table profile_phone_number cascade constraints;
--drop table login cascade constraints;
--drop table blood_stock cascade constraints;
--drop table donor cascade constraints;
--drop table blood_given cascade constraints;
--drop table donated cascade constraints;

CREATE TABLE patient (
    patient_id VARCHAR2(6) PRIMARY KEY,
    blood_type VARCHAR2(2) NOT NULL
);

CREATE TABLE profile (
    user_id VARCHAR2(10) PRIMARY KEY,
    fname VARCHAR2(20) NOT NULL,
    lname VARCHAR2(20) NOT NULL,
    date_of_birth DATE NOT NULL,
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

CREATE TABLE donor (
    donor_id VARCHAR2(6) PRIMARY KEY,
    blood_type VARCHAR2(2) NOT NULL
);

CREATE TABLE blood_given (
    patient_id VARCHAR2(6) REFERENCES patient(patient_id),
    blood_id VARCHAR2(6) REFERENCES blood_stock(blood_id)
);

CREATE TABLE donated (
    blood_id VARCHAR2(6) REFERENCES blood_stock(blood_id),
    donor_id VARCHAR2(6) REFERENCES donor(donor_id)
);

------------------------------------------

