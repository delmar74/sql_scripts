USE master
ALTER DATABASE tempdb MODIFY FILE(Name = tempdb, Filename = N'C:\NewFolder\tempdb.mdf')
GO

ALTER DATABASE tempdb MODIFY FILE(Name = templog, Filename = N'C:\NewFolder\templog.ldf')
GO
