USE master;

CREATE LOGIN TestContext 
WITH PASSWORD = 'Alex@123',
CHECK_POLICY = OFF;

USE AdventureWorks2016


CREATE USER TestContext FOR LOGIN TestContext;


CREATE FUNCTION dbo.CheckContext()
RETURNS TABLE
AS
RETURN ( SELECT * FROM sys.user_token);


SELECT * FROM dbo.CheckContext();


ALTER FUNCTION dbo.CheckContext()
RETURNS TABLE
WITH EXECUTE AS 'TestContext'
AS
RETURN ( SELECT * FROM sys.user_token);



DROP FUNCTION dbo.CheckContext;


CREATE FUNCTION dbo.CheckContext()
RETURNS @UserTokenList TABLE (principal_id int, sid varbinary(85), type nvarchar(128), usage nvarchar(128),name nvarchar(128))
WITH EXECUTE AS 'TestContext'
AS BEGIN
INSERT @UserTokenList 
SELECT principal_id, sid, type, usage, name 
FROM sys.user_token;
RETURN 
END;


SELECT * FROM dbo.CheckContext();

DROP FUNCTION dbo.CheckContext;

DROP USER TestContext;

DROP LOGIN TestContext;


