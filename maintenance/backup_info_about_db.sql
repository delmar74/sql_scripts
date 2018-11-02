-- Информация по резервированию для указанной базы за последние n-дней

-- Имя базы данных
DECLARE @database_name char(100) ='NameDatabase'

-- Сколько дней от текущей даты нужно анализировать
DECLARE @day int = 1

SELECT
   CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server,
   msdb.dbo.backupset.database_name as 'Database name',
   CASE msdb..backupset.type
       WHEN 'D' THEN 'Database'
       WHEN 'L' THEN 'Log'
   END AS backup_type,
   msdb.dbo.backupset.backup_size,
   convert(varchar, dateadd(s, datediff (s, msdb.dbo.backupset.backup_start_date, msdb.dbo.backupset.backup_finish_date), convert(datetime2, '0001-01-01')), 108) as backup_duration,
   msdb.dbo.backupset.backup_start_date AS Start_backup,
   msdb.dbo.backupset.backup_finish_date AS Finish_backup,
   msdb.dbo.backupmediafamily.physical_device_name,
   msdb.dbo.backupmediafamily.logical_device_name,
   msdb.dbo.backupset.name AS backupset_name,
   msdb.dbo.backupset.description,
   msdb.dbo.backupset.expiration_date AS Expiration_backup
FROM   msdb.dbo.backupmediafamily
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id
WHERE  (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE() - @day) and msdb.dbo.backupset.database_name = @database_name
ORDER BY
   msdb.dbo.backupset.database_name,
   msdb.dbo.backupset.backup_finish_date desc
