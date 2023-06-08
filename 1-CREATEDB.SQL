create database DEECPRD;
create user DBADEEC with encrypted password '1234';
grant all privileges on database DEECPRD to DBADEEC;

CREATE SCHEMA IF NOT EXISTS dbadeec;