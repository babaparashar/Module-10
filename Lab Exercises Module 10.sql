create function dbo.FormatPhoneNumber
( @PhoneNumberToFormat nvarchar(16))
RETURNS nvarchar(16)
AS
Begin
DECLARE @Digits nvarchar(16) = '';
DECLARE @Remaining nvarchar(16) = @PhoneNumberToFormat;
DECLARE @Character nchar(1);
if left(@Remaining,1) = N'+' RETURN @Remaining;
	
while (LEN(@Remaining) > 0) 
Begin
SET @Character = LEFT(@Remaining,1);
SET @Remaining = SUBSTRING(@Remaining,2,LEN(@Remaining));
IF (@Character >= N'0') AND (@Character <= N'9')
SET @Digits += @Character;
End;
RETURN CASE LEN(@Digits)
WHEN 10 THEN N'(' + SUBSTRING(@Digits,1,3) + N') '+ SUBSTRING(@Digits,4,3) + N'-' + SUBSTRING(@Digits,7,4)
WHEN 8 THEN SUBSTRING(@Digits,1,4) + N'-' + SUBSTRING(@Digits,5,4)
WHEN 6 THEN SUBSTRING(@Digits,1,3) + N'-' + SUBSTRING(@Digits,4,3)ELSE @Digits
End;
End;



SELECT dbo.FormatPhoneNumber('+91 7 9876-5432');
SELECT dbo.FormatPhoneNumber('987 654-3210');
SELECT dbo.FormatPhoneNumber('(91) 9876-5432');
SELECT dbo.FormatPhoneNumber('98765432');
SELECT dbo.FormatPhoneNumber('98-7654');





Create Function dbo.IntegerListToTable
( @InputList nvarchar(MAX),@Delimiter nchar(1) = N',')
RETURNS @OutputTable Table (PositionInList int IDENTITY(1, 1) NOT NULL,IntegerValue int)
As Begin
Insert Into @OutputTable (IntegerValue)
Select Value from STRING_SPLIT ( @InputList , @Delimiter );
RETURN;
END



SELECT * FROM dbo.IntegerListToTable('123,456789,099,7',',');



SELECT * FROM dbo.IntegerListToTable('123|456789|099|7','|');

