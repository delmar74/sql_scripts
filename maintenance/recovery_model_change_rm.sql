-- Изменить RECOVERY MODEL для множества баз данных

EXEC sp_MSforeachdb 'if ''?'' not in (''master'', ''model'', ''msdb'', ''tempdb'') ALTER DATABASE [?] SET RECOVERY SIMPLE'
