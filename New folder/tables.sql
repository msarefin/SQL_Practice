if DB_ID('practice') is not null 
drop database practice; 
go 

if DB_ID('practice') is null 
create database practice;
go 

use practice; 
go 

create table hr.employees 
(ID int primary key );