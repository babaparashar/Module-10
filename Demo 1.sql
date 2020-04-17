Use tempdb

CREATE FUNCTION dbo.EndOfPreviousMonth (@DateToTest date)
RETURNS date
AS BEGIN
  RETURN DATEADD(day, 0 - DAY(@DateToTest), @DateToTest);
END;


SELECT dbo.EndOfPreviousMonth(SYSDATETIME());


SELECT dbo.EndOfPreviousMonth('2017-06-01');



SELECT OBJECTPROPERTY(OBJECT_ID('dbo.EndOfPreviousMonth'),'IsDeterministic');



DROP FUNCTION dbo.EndOfPreviousMonth;



Create function dbo.CalculateEndDate(@StartDate date)
returns date
AS BEGIN
return EOMONTH(@StartDate);
END;


SELECT dbo.CalculateEndDate(SYSDATETIME());
SELECT dbo.CalculateEndDate('2018-03-01');



DROP FUNCTION dbo.CalculateEndDate


