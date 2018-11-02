USE master;
GO

CREATE TRIGGER [os_Trigger_Notification_CreateDrop_Database]
ON ALL SERVER FOR CREATE_DATABASE, DROP_DATABASE
AS
 declare @results varchar(max)
 declare @subjectText varchar(max)
 declare @subjectBegin varchar(255)
 declare @databaseName VARCHAR(255)
BEGIN
 SET NOCOUNT ON;
 SET @results = (SELECT EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)'))
 SET @databaseName = (SELECT EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'VARCHAR(255)'))

 SET @subjectBegin = 'Создана'
 IF (LEFT(@results,4) = 'DROP') SET @subjectBegin = 'Удалена'
 SET @subjectText = @subjectBegin + ' база данных на сервере ' + @@SERVERNAME + ' пользователем ' + SUSER_SNAME()

 EXEC msdb.dbo.sp_send_dbmail
 @profile_name = 'MailProfile',
 @recipients = 'user@example.ru',
 @body = @results,
 @subject = @subjectText;

END

-- * DROP TRIGGER:
-- DROP TRIGGER [os_Trigger_Notification_CreateDrop_Database] ON ALL SERVER;
-- GO
