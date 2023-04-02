--Perform Data Wrangling and cleaning of Shark Attacks dataset
Select * from dbo.attacks

--Checking if Attack  Date or Case number is null
Select * from attacks where
[attack_date] IS NULL
or [Case_number] IS NULL

--Deleting all rows that contain NULL in any of the columns 
Delete from attacks where 
[attack_date] IS NULL
OR [type] IS NULL
OR Activity IS NULL
or Age is null
or Time is null
or location is null
or name is null
or area is null
or injury is null

--Selecting rows with [type] as 'Invalid'
Select * from attacks where [type] = 'Invalid'

--Distinct Types of Shark Attacks - Changing 'boat' to 'boating', since both are same
Select distinct [type] from attacks

Update attacks set [type] = 'boating'
where [type] = 'boat'

--Selecting distinct Activity, many are similar or fall under the same bucket
Select distinct Activity from attacks 
where Activity like 'fishing%'

--Checking Fatal column and updating similar values
Select distinct Fatal from attacks

update attacks set Fatal = 'N' where Fatal = ' N'
update attacks set Fatal = NULL where Fatal NOT IN ('Y','N')

--Finding rows that contain Gender in Name column
Select Distinct [Name] from attacks 

Select [Name] from attacks where [Name] IN ('male','female','boy','girl')

--Checking if values are consistent in both Name and Gender column - Values are consistent
Select [Name],[Sex] from attacks where [Name] IN ('male','female','boy','girl')
ORDER BY [Sex]

--Replace the Gender values in Name column by Unknown
Update attacks set Name = 'Unknown'
where [Name] IN ('male','female','boy','girl')

--Removing Trail spaces from column 'Name'
Select trim(name) from attacks 

Update attacks set Name = trim(name)

--Replacing the NULL/blanks value with 'Unknown' in the 'Species' column
Select Species from attacks where Species = '' OR Species IS NULL 

Update attacks set Species = 'Unknown' where Species = '' OR Species IS NULL 

--Extract Year from Date column
Select year([attack_Date]) from attacks order by Year([attack_Date])

--Wrangling Country Column, changing values from Upper case to Proper Case
Select CONCAT(UPPER(SUBSTRING([Country],1,1)), 
LOWER(SUBSTRING([Country],2,LEN([Country])))) as 'Country Proper Case' from attacks

Update attacks set 
Country = (CONCAT(UPPER(SUBSTRING([Country],1,1)), LOWER(SUBSTRING([Country],2,LEN([Country])))))

--Renaming Sex Column to Gender
sp_rename 'attacks.Sex','Gender','COLUMN'

--Wrangling the Time Column

Select Time from attacks

Select Time, SUBSTRING(Time,1,2) ,
CASE 
	WHEN SUBSTRING(Time,1,2)  < '04' THEN 'Pre-Dawn'
	WHEN SUBSTRING(Time,1,2)  >= '04' AND  SUBSTRING(Time,1,2)  < '07' THEN 'Early Morning'
	WHEN (SUBSTRING(Time,1,2)  = '07' OR  SUBSTRING(Time,1,2)  = '7') OR SUBSTRING(Time,1,2)  < '10' THEN 'Morning'
	WHEN SUBSTRING(Time,1,2)  >= '10' AND  SUBSTRING(Time,1,2)  < '12' THEN 'Early Noon'
	WHEN SUBSTRING(Time,1,2)  >= '12' AND  SUBSTRING(Time,1,2)  < '13' THEN 'Noon'
	WHEN SUBSTRING(Time,1,2)  >= '13' AND  SUBSTRING(Time,1,2)  < '15' THEN 'Afternoon'
	WHEN SUBSTRING(Time,1,2)  >= '15' AND  SUBSTRING(Time,1,2)  < '16' THEN 'Early Evening'
	WHEN SUBSTRING(Time,1,2)  >= '16' AND  SUBSTRING(Time,1,2)  < '18' THEN 'Evening'
	WHEN SUBSTRING(Time,1,2)  >= '18' AND  SUBSTRING(Time,1,2)  < '20' THEN 'Late Evening'
	WHEN SUBSTRING(Time,1,2)  >= '20' AND  SUBSTRING(Time,1,2)  < '22' THEN 'Night'
	WHEN SUBSTRING(Time,1,2)  >= '22' THEN 'Late Night'
ELSE [Time] 
END AS 'Attack_Time' from attacks 
order by Attack_Time

UPDATE attacks SET Time =
(CASE 
	WHEN SUBSTRING(Time,1,2)  < '04' THEN 'Pre-Dawn'
	WHEN SUBSTRING(Time,1,2)  >= '04' AND  SUBSTRING(Time,1,2)  < '07' THEN 'Early Morning'
	WHEN (SUBSTRING(Time,1,2)  = '07' OR  SUBSTRING(Time,1,2)  = '7') OR SUBSTRING(Time,1,2)  < '10' THEN 'Morning'
	WHEN SUBSTRING(Time,1,2)  >= '10' AND  SUBSTRING(Time,1,2)  < '12' THEN 'Early Noon'
	WHEN SUBSTRING(Time,1,2)  >= '12' AND  SUBSTRING(Time,1,2)  < '13' THEN 'Noon'
	WHEN SUBSTRING(Time,1,2)  >= '13' AND  SUBSTRING(Time,1,2)  < '15' THEN 'Afternoon'
	WHEN SUBSTRING(Time,1,2)  >= '15' AND  SUBSTRING(Time,1,2)  < '16' THEN 'Early Evening'
	WHEN SUBSTRING(Time,1,2)  >= '16' AND  SUBSTRING(Time,1,2)  < '18' THEN 'Evening'
	WHEN SUBSTRING(Time,1,2)  >= '18' AND  SUBSTRING(Time,1,2)  < '20' THEN 'Late Evening'
	WHEN SUBSTRING(Time,1,2)  >= '20' AND  SUBSTRING(Time,1,2)  < '22' THEN 'Night'
	WHEN SUBSTRING(Time,1,2)  >= '22' THEN 'Late Night'
ELSE [Time] 
END)

--Renaming Time column to Attack_Time
sp_rename 'attacks.Time','attacks.attack_time','COLUMN'



