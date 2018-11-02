SELECT name,DATABASEPROPERTYEX(name,'Recovery')
FROM sysdatabases

-- OR
-- SELECT name,recovery_model_desc
-- FROM sys.databases
