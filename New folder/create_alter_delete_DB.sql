/*
	To create a new database
	------------------------
	Right click on Databases folder and click on "New Database..."

	this will create the database. 
	this will also create a .mdf and a .ldf file 
	.mdf is the actual database file 
	.ldf is the log file

	---- 
	database is can also be created using the command:
	create database [Database Name]
*/


use master 
go
if DB_ID('TestDB') is not null drop database TestDB; -- the database will be deleted if the it exists
go
if DB_ID('Test_DB') is null create database Test_DB -- the database will be created if the is deosn't exit

go 

/*
	to rename a database just right click the data base and click on "rename"
	--
	or using the command:
	alter database database_name Modify name = new_databbase_name
	or 
	using the stored procedure :
	sp_renameDB 'database_name','new_database_name'
*/

if DB_ID('Test_DB') is not null alter database Test_DB Modify name= TestDB_Altered; 
go
sp_renameDB 'TestDB_Altered','TestDB'

/*
	to delete the dabase sinply right click on the database and click on delete
	or 
	use the command:
	drop database TestDB;

	important!!!
	if the database is in use by another user the database will not be deleted
	in this situation the database needs to be put into single user mode
	
	to put the database into single user mode use the following command:
	Alter Database database_name set SINGLE_USER with rollback immediate


	system databases cannot be dropped


*/


Alter Database TestDB set SINGLE_USER with rollback immediate;
go
if DB_ID('TestDB') is not null drop database TestDB; -- the database will be deleted if the it exists
go



