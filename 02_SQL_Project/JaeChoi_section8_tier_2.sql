/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */
SELECT f.name
FROM Facilities AS f
WHERE `membercost` >0;

/* Q2: How many facilities do not charge a fee to members? */
SELECT 
	CASE WHEN f.membercost >0 THEN "Membership fee"
		 ELSE "No fee"
END AS category, COUNT( name ) AS counter
FROM Facilities AS f
GROUP BY category;
-- ANSWER: 4 free charge out of 9 facilities.


/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost < ( monthlymaintenance ) * 0.2;
-- ANSWER: all the facillities' member cost is less than 20% of their monthly maintenance costs.

/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */
SELECT *
FROM Facilities
WHERE facid BETWEEN 1 AND 5
ORDER BY facid;

/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */
Select name, monthlymaintenance,
	Case When monthlymaintenance>100 Then "expensive"
		 Else "cheap" End As label
From Facilities;

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */
Select M.firstname, M.surname, B.starttime
From Members As M
Join Bookings As B 
On M.memid=B.memid
WHERE B.starttime=(SELECT Max(starttime) FROM Bookings);
-- ANSWER: GUEST and Henry Worthington-Smytth at 2012-09-30 19:30:00


/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
Select Distinct M.memid, concat(M.firstname, ' ', M.surname) As name, F.name As fac_name
From Members As M
Join Bookings As B
Join Facilities As F
Where F.name Like "Tennis%"
Order By name;

/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */
SELECT F.name AS fac_name, 
	   CONCAT( M.firstname, ' ', M.surname ) AS mem_name,
	   F.membercost+30 AS new_mem_fee,
	   B.memid
FROM Members AS M
JOIN Bookings AS B ON M.memid = B.memid
JOIN Facilities AS F ON B.facid = F.facid
Where Extract(Year From B.starttime)=2012 And Extract(Month From B.starttime)=9 And Extract(Day From B.starttime)=14 And B.memid!=0
Order By new_mem_fee Desc;

/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SELECT sub.fac_name, 
	   sub.mem_name,
	   sub.new_mem_fee,
	   sub.memid
FROM (
	Select F.name AS fac_name,CONCAT( M.firstname, ' ', M.surname ) AS mem_name,F.membercost+30 AS new_mem_fee,B.memid
    From Members AS M
	JOIN Bookings AS B ON M.memid = B.memid
	JOIN Facilities AS F ON B.facid = F.facid
	Where Extract(Year From B.starttime)=2012 And Extract(Month From B.starttime)=9 And Extract(Day From B.starttime)=14 And B.memid!=0) As sub
Order By new_mem_fee Desc;

-- CHECK my .ipynb file.
/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  

QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */


/* Q12: Find the facilities with their usage by member, but not guests */


/* Q13: Find the facilities usage by month, but not guests */

