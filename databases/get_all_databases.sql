SELECT
 t2.database_id as "ID",
 t2.name as "Имя базы данных",
 t3.size as "Размер (Мб)",
 t2.create_date as "Создан",
 suser_sname(t2.owner_sid) as "Владелец",
 t1.filename as "Файл данных",
 t2.collation_name as "Сортировка (Collation)",
 t2.compatibility_level "Уровень совместимости базы",
 t2.recovery_model_desc as "Модель восстановления"
FROM sys.sysdatabases as t1 left join sys.databases as t2 on t1.dbid=t2.database_id
left join (SELECT v1.database_id, REPLACE(CAST(sum(CAST(v2.size as decimal(24,2)))/128  as decimal(24,2)) ,'.',',') as size FROM sys.databases as v1 LEFT OUTER JOIN sys.master_files AS v2 ON v1.database_id = v2.database_id GROUP BY v1.database_id) as t3 on t1.dbid=t3.database_id
WHERE t2.name NOT IN ('master', 'model', 'msdb', 'tempdb')
ORDER BY t2.name
