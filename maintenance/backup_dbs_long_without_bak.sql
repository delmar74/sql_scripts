-- Список баз данных с количеством часов, которое прошло с последней сделанной резервной копии
-- Базы, которые резервировались за последние 24 часа, в список не попадают

SELECT
   CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server,
   msdb.dbo.backupset.database_name,
   MAX(msdb.dbo.backupset.backup_finish_date) AS last_db_backup_date,
   DATEDIFF(hh, MAX(msdb.dbo.backupset.backup_finish_date), GETDATE()) AS [Backup Age (Hours)]
FROM  master.dbo.sysdatabases AS M LEFT JOIN msdb.dbo.backupset ON M.Name =  msdb.dbo.backupset.database_name
WHERE     msdb.dbo.backupset.type = 'D'
GROUP BY msdb.dbo.backupset.database_name
HAVING      (MAX(msdb.dbo.backupset.backup_finish_date) < DATEADD(hh, - 24, GETDATE()))

UNION

SELECT
   CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server,
   M.NAME AS database_name,
   NULL AS [Last Data Backup Date],
   9999 AS [Backup Age (Hours)]
FROM
   master.dbo.sysdatabases AS M LEFT JOIN msdb.dbo.backupset
       ON M.name  = msdb.dbo.backupset.database_name
WHERE msdb.dbo.backupset.database_name IS NULL AND M.name <> 'tempdb'
ORDER BY
   msdb.dbo.backupset.database_name
