-- Add new files for TempDB

ALTER DATABASE tempdb
ADD FILE (NAME = tempdev2, FILENAME = 'C:\NewFolder\tempdb2.mdf', SIZE = 256);
ALTER DATABASE tempdb
ADD FILE (NAME = tempdev3, FILENAME = 'C:\NewFolder\tempdb3.mdf', SIZE = 256);
ALTER DATABASE tempdb
ADD FILE (NAME = tempdev4, FILENAME = 'C:\NewFolder\tempdb4.mdf', SIZE = 256);
GO
