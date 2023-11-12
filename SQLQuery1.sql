select *
from [dbo].[Complete_Top_1000_Movies]

Alter table [dbo].[Complete_Top_1000_Movies]
Drop column column11, column12
--I drop the column11 and column12 from the datatable.

Select Gross_M
from [dbo].[Complete_Top_1000_Movies]
where Gross_M = '-'
--I select all the '-' values in the Gross_M column.

update [dbo].[Complete_Top_1000_Movies]
set Gross_M = REPLACE (Gross_M, '-', '0')
-- I replaced all the '-' values for '0'

Select *
from [dbo].[Complete_Top_1000_Movies]

Select *
into Gross_M_whitout_0
from [dbo].[Complete_Top_1000_Movies]
where 1 = 2
-- I create a new table callew Gross_M_whitout_0 where will have no 0 values.

Select *
from Gross_M_whitout_0

insert into Gross_M_whitout_0 (Rank, Movie_Name, Year_of_Release, Watch_Time, Movie_Rating, Meatscore_of_movie, Gross_M, Genre, Director, MPAA_Rating)
Select Rank, Movie_Name, Year_of_Release, Watch_Time, Movie_Rating, Meatscore_of_movie,Gross_M, Genre, Director, MPAA_Rating
from [dbo].[Complete_Top_1000_Movies]
--I copied the infromation from Complete_Top_1000_Movies table to Gross_M_whitout_0

delete
from Gross_M_whitout_0
where Gross_M = '0'
-- I delete all the values that has 0 in the Gross_M column, at this point my Gross_M_whitout_0 is 
-- clean

select *
from Gross_M_whitout_0
where Gross_M = '0'
-- I select the data just whit 0 to verify the query

Select * 
from Gross_M_whitout_0

Select sum (Gross_M)
from Gross_M_whitout_0

alter table Gross_M_whitout_0
ADD Gross_M_1 float(25)
-- I add a new column to change the datatype

update Gross_M_whitout_0
set Gross_M_1 = Gross_M
-- I copied the data from Gross_M to Gross_M_1 to change the data type

create table Total_Gross_M
(Total_Gross float (25))
-- I create a new table Total_Gross_M to keep the total gross

insert into Total_Gross_M (Total_Gross)
Select sum (Gross_M_1)
from Gross_M_whitout_0 
--I perform the sum of the total gross and put it in the new table

select *
from Total_Gross_M
-- I verified that the query was succesfull

alter table Total_Gross_M 
add Average_Gross float(25)
-- I added a new column to calculate the average

insert into Total_Gross_M (Average_Gross)
select AVG (Gross_M_1)
from Gross_M_whitout_0
-- I calculated the avg for the Gross

Select *
from Total_Gross_M
-- I verified that the query is succesfull

Select Average_Gross
into Average_Gross
From Total_Gross_M
-- I join the two columns in the datable

alter table Total_Gross_M
drop column  Average_Gross
-- i drop the Average column

select * 
from Average_Gross
where Average_Gross is not null

Select * 
from Total_Gross_M
where Total_Gross is not null

Create table Average_and_Total_Gross (
Average_Gross float (25),
Total_Gross float (25))

insert into Average_and_Total_Gross
Select*
From Average_Gross Cross Join Total_Gross_M
where Average_Gross is not null and
Total_Gross is not null
-- I created a table where I have the average and the total gross values.

select *
from Average_and_Total_Gross
-- I verified that the query was succesfull

Select *
From Gross_M_whitout_0

alter table Gross_M_whitout_0
drop column Gross_M

Select distinct Genre
from Gross_M_whitout_0

alter table Average_and_Total_Gross
add Average_Time float (25)
-- I create a new column in existing table

alter table Average_and_Total_Gross
alter column Average_Time SMALLINT
-- I changed the data type for Average_Time column

insert into Average_and_Total_Gross (Average_Time) 
select AVG (Watch_Time)
from Gross_M_whitout_0
-- I calculate the average of the watch time and insert into the Average_and_Total_Gross table

alter table Average_and_Total_Gross
drop column Average_Time
-- I droped the column Average_Time because Im going to create a new table then I will join the
-- existing table with the new one so i will not have any null values.

create table Average_Watch_Time(
Average_Time float (25))
-- I created a table Average_Watch_Time 

insert into Average_Watch_Time
select AVG (Watch_Time)
from Gross_M_whitout_0
-- I calculated the AVG from the Watch_Time column from Gross_M_whitout_0 table and insert it into 
--the Average_Watch_Time table.

Create table Average_Total_Gross_and_Average_Time (
Average_Gross float (25),
Total_Gross float (25),
Average_Watch_Time float (25))
-- I created a new table Average_Total_Gross_and_Average_Time with 3 columns: Average_Gross, 
-- Total_Gross and Average_Watch_Time

Alter table Average_Total_Gross_and_Average_Time
RENAME column Average_Watch_Time to Average_Watch_Time_1;

select *
from Average_Total_Gross_and_Average_Time
-- I confirm the new table

insert into Average_Total_Gross_and_Average_Time
select *
from Average_and_Total_Gross Cross join Average_Watch_Time
where Average_Gross is not null and 
Total_Gross is not null and 
Average_Time is not null
--I join the three tables with a cross join statement into one table called 
--Average_Total_Gross_and_Average_Time whitout null values.

Select*
from Average_Total_Gross_and_Average_Time
-- I confirm the table

Select distinct MPAA_Rating
from Gross_M_whitout_0
-- I verified the distincts values that I have in the column MPAA_Rating

Create table MPAA_Rating_Count (
MPAA_Rating varchar (25),
How_many float (25),)
-- I create a table where I put the MPAA_Rating and the count of each distinct value.

select *
from MPAA_Rating_Count
-- I verified the new table created MPAA_Rating_Count

select count(MPAA_Rating)
From Gross_M_whitout_0
where MPAA_Rating = 'A'
-- Count how many A. R=120

select count(MPAA_Rating)
From Gross_M_whitout_0
where MPAA_Rating = 'PG'
-- Count how many PG. R=126

select count(MPAA_Rating)
From Gross_M_whitout_0
where MPAA_Rating = 'PG-13'
-- Count how many PG-13. R=228

select count(MPAA_Rating)
From Gross_M_whitout_0
where MPAA_Rating = 'Not Rated'
-- Count how many Not Rated. R=72

select count(MPAA_Rating)
From Gross_M_whitout_0
where MPAA_Rating = 'G'
-- Count how many G. R=23

select count(MPAA_Rating)
From Gross_M_whitout_0
where MPAA_Rating = 'R'
-- Count how many R. R=376

Insert into MPAA_Rating_Count
Values 
('A', '120'),
('PG', '126'),
('PG-13', '228'),
('NotRated', '72'),
('G', '23'),
('R', '376');
-- I insert into the table the distinct values for Rating and the count of each rating value.

Select *
from MPAA_Rating_Count
-- I verified the new table created

Select SUM (How_many)
from MPAA_Rating_Count
-- I sum all the values to confirm that the calculation of each Rating is correct.

select MPAA_Rating, Gross_M_1
from Gross_M_whitout_0
where MPAA_Rating = 'A'

select sum (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'A'
-- I calculated the sum of Gross_M_1 for all the MPAA_Rating 'A' values. R=10495.2899

select sum (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'PG'
-- I calculated the sum of Gross_M_1 for all the MPAA_Rating 'PG' values. R=22018.791

select sum (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'PG-13'
-- I calculated the sum of Gross_M_1 for all the MPAA_Rating 'PG-13' values. R=64696.7178

select sum (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'Not Rated'
-- I calculated the sum of Gross_M_1 for all the MPAA_Rating 'Not Rated' values. R=819.8425

select sum (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'G'
-- I calculated the sum of Gross_M_1 for all the MPAA_Rating 'G' values. R=4689.404

select sum (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'R'
-- I calculated the sum of Gross_M_1 for all the MPAA_Rating 'R' values. R=35666.9307

alter table MPAA_Rating_Count
add Total_Gross_By_Rating float (25)
-- I added a new column Total_Gross_By_Rating to the MPAA_Rating_Count table

Select *
from MPAA_Rating_Count

insert into MPAA_Rating_Count (Total_Gross_By_Rating)
values 
(10495.2899),
(22018.791),
(64696.7178),
(819.8425),
(4689.404),
(35666.9307);
--I added the values but the table is showing me NULL values

Insert into MPAA_Rating_Count
Values 
('A', '120', '10495.2899'),
('PG', '126', '22018.791'),
('PG-13', '228', '64696.7178'),
('NotRated', '72', '819.8425'),
('G', '23', '4689.404'),
('R', '376', '35666.9307');
-- I insert the complete values in the table now i have to remove the NULL values.

Select *
from MPAA_Rating_Count
where MPAA_Rating is not null and
How_many is not null and
Total_Gross_By_Rating is not null
-- I have the table without null values.

Select *
from Gross_M_whitout_0

select sum (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'A'
-- I calculated the sum of Watch_Time for all the MPAA_Rating 'A' values. R=13985

select sum (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'PG'
-- I calculated the sum of Watch_Time for all the MPAA_Rating 'PG' values. R=14488

select sum (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'PG-13'
-- I calculated the sum of Watch_Time for all the MPAA_Rating 'PG-13' values. R=28969

select sum (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'Not Rated'
-- I calculated the sum of Watch_Time for all the MPAA_Rating 'Not Rated' values. R=9786

select sum (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'G'
-- I calculated the sum of Watch_Time for all the MPAA_Rating 'R' values. R=2634

select sum (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'R'
-- I calculated the sum of Watch_Time for all the MPAA_Rating 'R' values. R=47189

alter table MPAA_Rating_Count
add Total_Watch_Time_By_Rating float (25)
-- I add a new column Total_Watch_Time_By_Rating.

select*
from MPAA_Rating_Count

Insert into MPAA_Rating_Count
Values 
('A', '120', '10495.2899', '13985'),
('PG', '126', '22018.791', '14488'),
('PG-13', '228', '64696.7178', '28969'),
('NotRated', '72', '819.8425', '9786'),
('G', '23', '4689.404', '2634'),
('R', '376', '35666.9307', '47189');
-- I insert the complete values in the table now i have to remove the NULL values.

Delete from MPAA_Rating_Count	
where Total_Watch_Time_By_Rating is null
--I deleted all the null values from the table.

select *
from MPAA_Rating_Count

Select*
from Gross_M_whitout_0

select avg (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'A'
-- I calculated the avg of Watch_Time for all the MPAA_Rating 'A' values. R=116

select avg (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'PG'
-- I calculated the avg of Watch_Time for all the MPAA_Rating 'PG' values. R=114

select avg (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'PG-13'
-- I calculated the avg of Watch_Time for all the MPAA_Rating 'PG-13' values. R=127

select avg (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'Not Rated'
-- I calculated the avg of Watch_Time for all the MPAA_Rating 'Not Rated' values. R=135

select avg (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'G'
-- I calculated the avg of Watch_Time for all the MPAA_Rating 'G' values. R=114

select avg (Watch_Time)
from Gross_M_whitout_0
where MPAA_Rating = 'R'
-- I calculated the avg of Watch_Time for all the MPAA_Rating 'R' values. R=125

alter table MPAA_Rating_Count
add Average_Watch_Time_By_Rating float (25)
-- I added a new column Average_Watch_Time_By_Rating in the MPAA_Rating_Count table.

Insert into MPAA_Rating_Count
Values 
('A', '120', '10495.2899', '13985', '116'),
('PG', '126', '22018.791', '14488', '114'),
('PG-13', '228', '64696.7178', '28969', '127'),
('NotRated', '72', '819.8425', '9786', '135'),
('G', '23', '4689.404', '2634', '114'),
('R', '376', '35666.9307', '47189', '125');
-- I insert the complete values in the table now i have to remove the NULL values.

Delete from MPAA_Rating_Count	
where Average_Watch_Time_By_Rating is null
--I deleted all the null values from the table.

select *
from MPAA_Rating_Count
-- I confirm the table

select avg (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'A'
-- I calculated the avg of Gross_M_1 for all the MPAA_Rating 'A' values. R=87.4607

select avg (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'PG'
-- I calculated the avg of Gross_M_1 for all the MPAA_Rating 'PG' values. R=174.7523

select avg (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'PG-13'
-- I calculated the avg of Gross_M_1 for all the MPAA_Rating 'PG-13' values. R=283.7575

select avg (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'Not Rated'
-- I calculated the avg of Gross_M_1 for all the MPAA_Rating 'Not Rated' values. R=11.3867

select avg (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'G'
-- I calculated the avg of Gross_M_1 for all the MPAA_Rating 'G' values. R=203.8871

select avg (Gross_M_1)
from Gross_M_whitout_0
where MPAA_Rating = 'R'
-- I calculated the avg of Gross_M_1 for all the MPAA_Rating 'R' values. R=94.8588

alter table MPAA_Rating_Count
add Average_Gross_By_Rating float (25)
-- I added a new column Average_Gross_By_Rating to the table MPAA_Rating_Count.

Insert into MPAA_Rating_Count
Values 
('A', '120', '10495.2899', '13985', '116', '87.4607'),
('PG', '126', '22018.791', '14488', '114', '174.7523'),
('PG-13', '228', '64696.7178', '28969', '127', '283.7575'),
('NotRated', '72', '819.8425', '9786', '135', '11.3867'),
('G', '23', '4689.404', '2634', '114', '203.8871'),
('R', '376', '35666.9307', '47189', '125', '94.8588');
-- I insert the complete values in the table now i have to remove the NULL values.

delete from MPAA_Rating_Count
where Average_Gross_By_rating is null

select*
from MPAA_Rating_Count

select avg (Movie_Rating)
from Gross_M_whitout_0
where MPAA_Rating = 'A'
-- I calculated the avg of Movie_Rating for all the MPAA_Rating 'A' values. R=7.9792

select avg (Movie_Rating)
from Gross_M_whitout_0
where MPAA_Rating = 'PG'
-- I calculated the avg of Movie_Rating for all the MPAA_Rating 'PG' values. R=7.9571

select avg (Movie_Rating)
from Gross_M_whitout_0
where MPAA_Rating = 'PG-13'
-- I calculated the avg of Movie_Rating for all the MPAA_Rating 'PG-13' values. R=7.9509

select avg (Movie_Rating)
from Gross_M_whitout_0
where MPAA_Rating = 'Not Rated'
-- I calculated the avg of Movie_Rating for all the MPAA_Rating 'Not Rated' values. R=8.043

select avg (Movie_Rating)
from Gross_M_whitout_0
where MPAA_Rating = 'G'
-- I calculated the avg of Movie_Rating for all the MPAA_Rating 'G' values. R=8.0087

select avg (Movie_Rating)
from Gross_M_whitout_0
where MPAA_Rating = 'R'
-- I calculated the avg of Movie_Rating for all the MPAA_Rating 'R' values. R=7.9516

alter table MPAA_Rating_Count
add Average_Movie_Rating_By_Rating float (25)
-- I added a column Average_Movie_Rating_By_Rating in the MPAA_Rating_Count table.

Insert into MPAA_Rating_Count
Values 
('A', '120', '10495.2899', '13985', '116', '87.4607', '7.9792'),
('PG', '126', '22018.791', '14488', '114', '174.7523', '7.9571'),
('PG-13', '228', '64696.7178', '28969', '127', '283.7575', '7.9509'),
('NotRated', '72', '819.8425', '9786', '135', '11.3867', '8.043'),
('G', '23', '4689.404', '2634', '114', '203.8871', '8.0087'),
('R', '376', '35666.9307', '47189', '125', '94.8588', '7.9516');
-- I insert the complete values in the table now i have to remove the NULL values.

delete from MPAA_Rating_Count
where Average_Movie_Rating_By_Rating is null
--I delete all the null values from the table.

select *
from MPAA_Rating_Count

select*
from Gross_M_whitout_0

select avg (Meatscore_of_movie)
from Gross_M_whitout_0
where MPAA_Rating = 'A' and 
Meatscore_of_movie <> '0'
-- I calculated the avg of Meatscore_of_movie for all the MPAA_Rating 'A' values. R=83

select avg (Meatscore_of_movie)
from Gross_M_whitout_0
where MPAA_Rating = 'PG' and
Meatscore_of_movie <> '0'
-- I calculated the avg of Meatscore_of_movie for all the MPAA_Rating 'PG' values. R=81

select avg (Meatscore_of_movie)
from Gross_M_whitout_0
where MPAA_Rating = 'PG-13' and
Meatscore_of_movie <> '0'
-- I calculated the avg of Meatscore_of_movie for all the MPAA_Rating 'PG-13' values. R=76

select avg (Meatscore_of_movie)
from Gross_M_whitout_0
where MPAA_Rating = 'Not Rated' and
Meatscore_of_movie <> '0'
-- I calculated the avg of Meatscore_of_movie for all the MPAA_Rating 'Not Rated' values. R=79

select avg (Meatscore_of_movie)
from Gross_M_whitout_0
where MPAA_Rating = 'G' and
Meatscore_of_movie <> '0'
-- I calculated the avg of Meatscore_of_movie for all the MPAA_Rating 'G' values. R=88

select avg (Meatscore_of_movie)
from Gross_M_whitout_0
where MPAA_Rating = 'R' and
Meatscore_of_movie <> '0'
-- I calculated the avg of Meatscore_of_movie for all the MPAA_Rating 'R' values. R=77

alter table MPAA_Rating_Count
add Average_Meatscore_of_movie float (25)
-- I added a column Average_Meatscore_of_movie in the MPAA_Rating_Count table.

Insert into MPAA_Rating_Count
Values 
('A', '120', '10495.2899', '13985', '116', '87.4607', '7.9792', '83'),
('PG', '126', '22018.791', '14488', '114', '174.7523', '7.9571', '81'),
('PG-13', '228', '64696.7178', '28969', '127', '283.7575', '7.9509', '76'),
('NotRated', '72', '819.8425', '9786', '135', '11.3867', '8.043', '79'),
('G', '23', '4689.404', '2634', '114', '203.8871', '8.0087', '88'),
('R', '376', '35666.9307', '47189', '125', '94.8588', '7.9516', '77');
-- I insert the new values Average_Meatscore_of_movie in the MPAA_Rating_Count table.

delete from MPAA_Rating_Count
where Average_Meatscore_of_movie is null
--I delete all the null values from the table.

Select *
from MPAA_Rating_Count

select distinct Genre
from Gross_M_whitout_0

--Action, Adventure, Animation, Biography, Comedy, Crime, Drama, Family, Fantasy, Film-Noir, Horror,
--Mystery, Western, Romance, Sci-Fi, Thriller, Musical, War, Sport, Music, 

Create table Genres (
Genre varchar (25),
Amount float (25))
-- I create a table to analyze the Genres

select count (Genre) as Action
from Gross_M_whitout_0
where Genre like '%Action%'
-- I count how many movies have the 'Action' Genre R=184

select count (Genre) as Adventure
from Gross_M_whitout_0
where Genre like '%Adventure%'
-- I count how many movies have the 'Adventure' Genre R=175

select count (Genre) as Animation
from Gross_M_whitout_0
where Genre like '%Animation%'
-- I count how many movies have the 'Animation' Genre R=79

select count (Genre) as Biography
from Gross_M_whitout_0
where Genre like '%Biography%'
-- I count how many movies have the 'Biography' Genre R=96

select count (Genre) as Comedy
from Gross_M_whitout_0
where Genre like '%Comedy%'
-- I count how many movies have the 'Comedy' Genre R=222

select count (Genre) as Crime
from Gross_M_whitout_0
where Genre like '%Crime%'
-- I count how many movies have the 'Crime' Genre R=202

select count (Genre) as Drama
from Gross_M_whitout_0
where Genre like '%Drama%'
-- I count how many movies have the 'Drama' Genre R=713

select count (Genre) as Family
from Gross_M_whitout_0
where Genre like '%Family%'
-- I count how many movies have the 'Family' Genre R=93

select count (Genre) as Fantasy
from Gross_M_whitout_0
where Genre like '%Fantasy%'
-- I count how many movies have the 'Fantasy' Genre R=111

select count (Genre) as FilmNoir
from Gross_M_whitout_0
where Genre like '%Film-Noir%'
-- I count how many movies have the 'FilmNoir' Genre R=21

select count (Genre) as Horror
from Gross_M_whitout_0
where Genre like '%Horror%'
-- I count how many movies have the 'Horror' Genre R=36

select count (Genre) as Mystery
from Gross_M_whitout_0
where Genre like '%Mystery%'
-- I count how many movies have the 'Mystery' Genre R=126

select count (Genre) as Western
from Gross_M_whitout_0
where Genre like '%Western%'
-- I count how many movies have the 'Western' Genre R=23

select count (Genre) as Romance
from Gross_M_whitout_0
where Genre like '%Romance%'
-- I count how many movies have the 'Romance' Genre R=166

select count (Genre) as SciFi
from Gross_M_whitout_0
where Genre like '%Sci-Fi%'
-- I count how many movies have the 'SciFi' Genre R=104

select count (Genre) as Thriller
from Gross_M_whitout_0
where Genre like '%Thriller%'
-- I count how many movies have the 'Thriller' Genre R=248

select count (Genre) as Musical
from Gross_M_whitout_0
where Genre like '%Musical%'
-- I count how many movies have the 'Msuical' Genre R=33

select count (Genre) as War
from Gross_M_whitout_0
where Genre like '%War%'
-- I count how many movies have the 'War' Genre R=78

select count (Genre) as Sport
from Gross_M_whitout_0
where Genre like '%Sport%'
-- I count how many movies have the 'Sport' Genre R=24

select count (Genre) as Music
from Gross_M_whitout_0
where Genre like '%Music%'
-- I count how many movies have the 'Music' Genre R=69

Insert into Genres
values
('Action', '184'),
('Adventure', '175'),
('Animation', '79'),
('Biography', '96'),
('Comedy', '222'),
('Crime', '202'),
('Drama', '713'),
('Family', '93'),
('Fantasy', '111'),
('FilmNoir', '21'),
('Horror', '36'),
('Mystery', '126'),
('Western', '23'),
('Romance', '166'),
('SciFi', '104'),
('Thriller', '248'),
('Musical', '33'),
('War', '78'),
('Sport', '24'),
('Music', '69');
-- I insert the values into the Genres table

select SUM(Amount) as Total_Genres
from Genres
-- I sum all the genres in the dataset there is a total of 2803 genres in 945 movies.

select*
from Genres

select sum (Gross_M_1) as Action
from Gross_M_whitout_0
where Genre like '%Action%'
-- I sum the Gross of each movie that have the 'Action' Genre R=61812.894

select sum (Gross_M_1) as Adventure
from Gross_M_whitout_0
where Genre like '%Adventure%'
-- I sum the Gross of each movie that have the 'Adventure' Genre R=72270.2606

select sum (Gross_M_1) as Animation
from Gross_M_whitout_0
where Genre like '%Animation%'
-- I sum the Gross of each movie that have the 'Animation' Genre R=22917.293

select sum (Gross_M_1) as Biography
from Gross_M_whitout_0
where Genre like '%Biography%'
-- I sum the Gross of each movie that have the 'Biography' Genre R=11047.127

select sum (Gross_M_1) as Comedy
from Gross_M_whitout_0
where Genre like '%Comedy%'
-- I sum the Gross of each movie that have the 'Comedy' Genre R=33304.1725

select sum (Gross_M_1) as Crime
from Gross_M_whitout_0
where Genre like '%Crime%'
-- I sum the Gross of each movie that have the 'Crime' Genre R=17720.4272

select sum (Gross_M_1) as Drama
from Gross_M_whitout_0
where Genre like '%Drama%'
-- I sum the Gross of each movie that have the 'Drama' Genre R=70518.8916

select sum (Gross_M_1) as Family
from Gross_M_whitout_0
where Genre like '%Family%'
-- I sum the Gross of each movie that have the 'Family' Genre R=29935.8735

select sum (Gross_M_1) as Fantasy
from Gross_M_whitout_0
where Genre like '%Fantasy%'
-- I sum the Gross of each movie that have the 'Fantasy' Genre R=38433.767

select sum (Gross_M_1) as FilmNoir
from Gross_M_whitout_0
where Genre like '%Film-Noir%'
-- I sum the Gross of each movie that have the 'FilmNoir' Genre R=6.552

select sum (Gross_M_1) as Horror
from Gross_M_whitout_0
where Genre like '%Horror%'
-- I sum the Gross of each movie that have the 'Horror' Genre R=1706.7186

select sum (Gross_M_1) as Mystery
from Gross_M_whitout_0
where Genre like '%Mystery%'
-- I sum the Gross of each movie that have the 'Mystery' Genre R=16457.7242

select sum (Gross_M_1) as Western
from Gross_M_whitout_0
where Genre like '%Western%'
-- I sum the Gross of each movie that have the 'Western' Genre R=2493.715

select sum (Gross_M_1) as Romance
from Gross_M_whitout_0
where Genre like '%Romance%'
-- I sum the Gross of each movie that have the 'Romance' Genre R=14673.832

select sum (Gross_M_1) as SciFi
from Gross_M_whitout_0
where Genre like '%Sci-Fi%'
-- I sum the Gross of each movie that have the 'SciFi' Genre R=42384.5576

select sum (Gross_M_1) as Thriller
from Gross_M_whitout_0
where Genre like '%Thriller%'
-- I sum the Gross of each movie that have the 'Thriller' Genre R=30341.2279

select sum (Gross_M_1) as Musical
from Gross_M_whitout_0
where Genre like '%Musical%'
-- I sum the Gross of each movie that have the 'Musical' Genre R=5439.543

select sum (Gross_M_1) as War
from Gross_M_whitout_0
where Genre like '%War%'
-- I sum the Gross of each movie that have the 'War' Genre R=5574.057

select sum (Gross_M_1) as Sport
from Gross_M_whitout_0
where Genre like '%Sport%'
-- I sum the Gross of each movie that have the 'Sport' Genre R=2166.164

select sum (Gross_M_1) as Music
from Gross_M_whitout_0
where Genre like '%Music%'
-- I sum the Gross of each movie that have the 'Msuic' Genre R=9599.672

alter table Genres
add Total_Gross_By_Genre float (25)
-- I added a new column Total_Gross_By_Genre in the Genres table.

Insert into Genres
values
('Action', '184', '61812.894'),
('Adventure', '175', '72270.2606'),
('Animation', '79', '22917.293'),
('Biography', '96', '11047.127'),
('Comedy', '222', '33304.1725'),
('Crime', '202', '17720.4272'),
('Drama', '713', '70518.8916'),
('Family', '93', '29935.8735'),
('Fantasy', '111', '38433.767'),
('FilmNoir', '21', '6.552'),
('Horror', '36', '1706.7186'),
('Mystery', '126', '16457.7242'),
('Western', '23', '2493.715'),
('Romance', '166', '14673.832'),
('SciFi', '104', '42384.5576'),
('Thriller', '248', '30341.2279'),
('Musical', '33', '5439.543'),
('War', '78', '5574.057'),
('Sport', '24', '2166.164'),
('Music', '69', '9599.672');
-- I insert the values into the Genres table

alter table Genres
add Average_Gross_By_Genre float (25)
-- I added a new column Average_Gross_By_Genre in the Genres table.

insert into Genres
select Genre, Amount, Total_Gross_By_Genre, Total_Gross_By_Genre / Amount
from Genres
-- I calculate the Average_Gross_By_Genre and added into the existing table Genres.

delete 
from Genres
where Average_Gross_By_Genre is null
--I delete the null values in the table

alter table Genres
add Percentage_of_Total_Gross_By_Genre float (25)
--I added a new column in the Genres table called Percentage_of_Total_Gross_By_Genre.

select *
from Genres

Select*
from Total_Gross_M

insert into Genres
select Genre, Amount, Total_Gross_By_Genre, Average_Gross_By_Genre, Total_Gross_By_Genre / 138386.9759
from Genres
--I have the division of the Total_Gross_By_Genre by Total_Gross.

delete 
from Genres
where Percentage_of_Total_Gross_By_Genre is null
--I delete the null values from the Percentage_of_Total_Gross_By_Genre column.

alter table Genres
add Percentage_of_Total_Gross_By_Genre_1 float(25)

insert into Genres
select Genre, Amount, Total_Gross_By_Genre, Average_Gross_By_Genre,Percentage_of_Total_Gross_By_Genre, Percentage_of_Total_Gross_By_Genre * 100
from Genres
-- I added the final calculation multiplicating the Percentage_of_Total_Gross_By_Genre times 100
-- and the result is the Percentage_of_Total_Gross_By_Genre_1 column.

alter table Genres
drop column Percentage_of_Total_Gross_By_Genre
-- I droped the column Percentage_of_Total_Gross_By_Genre.

delete 
from Genres
where Percentage_of_Total_Gross_By_Genre_1 is null
-- I delete all the null values from the Percentage_of_Total_Gross_By_Genre_1.

select *
from Genres
-- I verify the datatable

select AVG (Movie_Rating) as Average_Action
from Gross_M_whitout_0
where Genre like '%Action%'
--I calculate the average Movie_Rating for the 'Action' Genre. R=7.9853

select AVG (Movie_Rating) as Average_Adventure
from Gross_M_whitout_0
where Genre like '%Adventure%'
--I calculate the average Movie_Rating for the 'Adventure' Genre. R=7.9788

select AVG (Movie_Rating) as Average_Animation
from Gross_M_whitout_0
where Genre like '%Animation%'
--I calculate the average Movie_Rating for the 'Animation' Genre. R=7.9354

select AVG (Movie_Rating) as Average_Biography
from Gross_M_whitout_0
where Genre like '%Biography%'
--I calculate the average Movie_Rating for the 'Biography' Genre. R=7.9583

select AVG (Movie_Rating) as Average_Comedy
from Gross_M_whitout_0
where Genre like '%Comedy%'
--I calculate the average Movie_Rating for the 'Comedy' Genre. R=7.9

select AVG (Movie_Rating) as Average_Crime
from Gross_M_whitout_0
where Genre like '%Crime%'
--I calculate the average Movie_Rating for the 'Crime' Genre. R=7.9846

select AVG (Movie_Rating) as Average_Drama
from Gross_M_whitout_0
where Genre like '%Drama%'
--I calculate the average Movie_Rating for the 'Drama' Genre. R=7.9733

select AVG (Movie_Rating) as Average_Family
from Gross_M_whitout_0
where Genre like '%Family%'
--I calculate the average Movie_Rating for the 'Family' Genre. R=7.9269

select AVG (Movie_Rating) as Average_Fantasy
from Gross_M_whitout_0
where Genre like '%Fantasy%'
--I calculate the average Movie_Rating for the 'Fantasy' Genre. R=7.9604

select AVG (Movie_Rating) as Average_FilmNoir
from Gross_M_whitout_0
where Genre like '%Film-Noir%'
--I calculate the average Movie_Rating for the 'FilmNoir' Genre. R=7.9952

select AVG (Movie_Rating) as Average_Horror
from Gross_M_whitout_0
where Genre like '%Horror%'
--I calculate the average Movie_Rating for the 'Horror' Genre. R=7.8472

select AVG (Movie_Rating) as Average_Mystery
from Gross_M_whitout_0
where Genre like '%Mystery%'
--I calculate the average Movie_Rating for the 'Mystery' Genre. R=7.9651

select AVG (Movie_Rating) as Average_Western
from Gross_M_whitout_0
where Genre like '%Western%'
--I calculate the average Movie_Rating for the 'Western' Genre. R=7.9913

select AVG (Movie_Rating) as Average_Romance
from Gross_M_whitout_0
where Genre like '%Romance%'
--I calculate the average Movie_Rating for the 'Romance' Genre. R=7.9217

select AVG (Movie_Rating) as Average_SciFi
from Gross_M_whitout_0
where Genre like '%Sci-Fi%'
--I calculate the average Movie_Rating for the 'SciFi' Genre. R=7.9596

select AVG (Movie_Rating) as Average_Thriller
from Gross_M_whitout_0
where Genre like '%Thriller%'
--I calculate the average Movie_Rating for the 'Thriller' Genre. R=7.9447

select AVG (Movie_Rating) as Average_Musical
from Gross_M_whitout_0
where Genre like '%Musical%'
--I calculate the average Movie_Rating for the 'Musical' Genre. R=7.8727

select AVG (Movie_Rating) as Average_War
from Gross_M_whitout_0
where Genre like '%War%'
--I calculate the average Movie_Rating for the 'War' Genre. R=8.0256

select AVG (Movie_Rating) as Average_Sport
from Gross_M_whitout_0
where Genre like '%Sport%'
--I calculate the average Movie_Rating for the 'Sport' Genre. R=7.975

select AVG (Movie_Rating) as Average_Music
from Gross_M_whitout_0
where Genre like '%Music%'
--I calculate the average Movie_Rating for the 'Music' Genre. R=7.8971

alter table Genres
add Average_Movie_Rating_By_Genre float (25)
--I added a new column Average_Movie_Rating_By_Genre in the Genres table.

create table Average_Movie_Rating_By_Genre_Table (
Average_Movie_Rating_By_Genre_1 float (25))
-- I create a table to put the Average_Movie_Rating_By_Genre_Table so i can join it with the Genres table.

insert into Average_Movie_Rating_By_Genre_Table
Values 
('7.9853'),
('7.9788'),
('7.9354'),
('7.9583'),
('7.9'),
('7.9846'),
('7.9733'),
('7.9269'),
('7.9604'),
('7.9952'),
('7.9952'),
('7.9651'),
('7.9913'),
('7.9217'),
('7.9596'),
('7.9447'),
('7.8727'),
('8.0256'),
('7.975'),
('7.8971')
-- I insert the values in the new table created to join them in the Genres table.

insert into Genres
select*
from Genres full join Average_Movie_Rating_By_Genre_Table 
where Genre is not null and
Average_Movie_Rating_By_Genre_1 is not null


Select *
from Average_Movie_Rating_By_Genre_Table

select *
from Genres

delete
from Genres
where Genre is null