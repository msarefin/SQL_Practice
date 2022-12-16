use tsql2012; 
go 

select country, year(hiredate) yearhired, count(*) as 'Number of employees'
from hr.Employees
where hiredate>='20030101'
group by country, year(hiredate)
having count(*) >1
order by country, yearhired desc

go 

select 
	custid, orderid
from sales.orders

select 
	custid, max(orderid) as maxoederid
from sales.orders
group by custid; 

go 

select shipperid, sum(freight) as totalfreight 
from sales.orders
group by shipperid
having sum(freight)>20000.00
;
go 

select freight from sales.orders; 

go 

select empid, firstname +N' '+lastname as 'name' 
from hr.employees; 

go 
-- Distinct keyword
select distinct country, region, city 
from hr.Employees

select * from hr.Employees where lastname like 'D%'

/*
	int, numeric
	char, varchar
	Nchar, Nvarchar
	Float, Real
	Binary, Varbunary
	Date, Time, Datetime2, smallDatetime, datetime, datetimeoffset
*/

use tsql2012; 
go 

declare @a as varchar(20)='375';
print cast(@a as varbinary); 

declare @f as float = '29545428.022495'; 
select cast (@f as numeric(28,14)) as value; 

/*
	cast
	convert
	parse 
	try_cast
	try_convert
	try_parse
*/

print cast(1 as bit)
print cast( 4000000000 as float)


print parse('10/22/2022' as date using 'en-US'); 

/*
	getdate 
	current_timestamp
	getutcdate
	sysdatetime
	sysutcdatetime
	sysdatetimeoffset
*/

select getdate() as date
union all
select current_timestamp as date
union all
select GETUTCDATE() as date
union all
select SYSDATETIME() as date
union all
select SYSUTCDATETIME() as date
union all
select SYSDATETIMEOFFSET() as date


select DATEFROMPARTS('2020','10','12') as date

select eomonth(SYSDATETIME()) as date; 


select DATEADD(year, 1,GETDATE()) as 'next year';
select DATEDIFF(year, '2000',GETDATE()) age; 

select SWITCHOFFSET(getdate(),'-08:00') 'switchoffset',TODATETIMEOFFSET(getdate(),'-08:00') 'todatetimeoffset'

use TSQL2012;
go

select e.empid, e.country, e.region, e.city, e.country+N','+e.region+N','+e.city as 'location'
from hr.Employees as e;


select empid, country,region, city,country+coalesce(N','+region,N'')+N','+city as 'location'
from hr.Employees

select e.empid, e.country,e.region, e.city, concat(country,N','+e.region,N','+e.city) as location
from hr.Employees as e; 


/*
	substring('abcd',1,3)
*/

select 
	SUBSTRING(city,1,3) 'substring', 
	left(city,4) 'left', 
	right(city, 4) 'right'
from hr.Employees

declare @name Nvarchar(50) = 'Daniel Thompson'

select left(@name, charindex(' ',@name)-1) 'nome'
select charindex(' ',@name)'nome'

select len(@name) 'string length'

select DATALENGTH(@name) 'byte size'

/*
	replace
	replicate
	stuff
*/



declare @today date =  convert(date, getdate())

select replace(@today,'-','/') [Today's Date]


select replicate('*',10);

select stuff(',x,y,z',1,1,'A') col

/*
	upper 
	lower 
	ltrim 
	rtrim 
	format
*/
declare @todayDate datetime = convert(date, getdate()), @format varchar(6) = 'en-us';

select format(@todayDate,'d', @format) today
union all 
select format(@todayDate,'D', @format) today
union all 
select format(@todayDate,'MM/dd/yy', @format) today
union all 
select format(@todayDate,'dd-MM-yy', @format) today
union all 
select format(@todayDate,'dd-MM-yyyy', @format) today

select format(18885552525, '#-###-###-####') [phone number]


declare @currentDate varchar(8) = '19880105';
select format(CONVERT(date,@currentDate),'D','en-us') today, format(CONVERT(date,@currentDate),'MM/dd/yyy','en-us') [date]

select 
	len(e.firstname+' '+e.lastname) 
from hr.employees e; 


-- case statement

use tsql2012; 
go 

select productid, productname, unitprice, discontinued,
case discontinued 
	when 0 then 'No'
	when 1 then 'yes'
	else 'unknown'
	end as discontinued_desc
from production.products p;

use TSQL2012; 
go
select productid, productname, unitprice, 
case 
	when unitprice <20.00 then 'low'
	when unitprice <40.00 then 'medium'
	when unitprice >=40.00 then 'high'
	else 'unknown'
end as pricerange
from production.products
order by pricerange

/*
	coalesce - standard
	nullif - standard
	isnull 
	iff
	choose
*/

declare 
	@x as varchar(3) = null, 
	@y as varchar(10) ='1234567890';

	select 
		coalesce(@x, @y) as [Coalesce], 
		isnull(@x, @y) as [isnull],
		nullif(@y,@y) as [nullif]

declare @num int = 100;
select iif(@num>50, 'True', 'False') [True or false]

select choose(3,'a','b','c','d','e','f','g','h') as choice 

select newid() as [GUID]


use tsql2012
go 

select * 
from hr.employees
where country = N'USA'; 

select * from hr.Employees where country <> N'USA'
select empid, firstname, lastname, country from hr.employees where country != N'USA'

select 
	empid, 
	firstname, 
	lastname, 
	region, 
	country
from hr.employees
where region <> N'WA' or Region is null; 


declare @d date = '20060716'

select * 
from sales.orders
where shippeddate = @d; 
go 

declare @d date = '20060716'
select orderid, orderdate, empid 
from sales.orders
where coalesce(shippeddate, '19000101') = coalesce(@d, '19000101');

go
--- this is prefered
declare @d date = '20060716'

select orderid, orderdate, empid
from sales.orders
where shippeddate = @d or (shippeddate is null and @d is null);

go 

select * from hr.employees where not region = N'WA' or region is null


/*
	like operator

	Wildcards
	----------
	D%
	_D%
	[AC]%
	[A-D]% , [0-9]%
	[^A-D]% , [^0-9]% 
*/

select firstname, lastname from hr.employees where firstname like N'D%'; 

go 

declare @s_date date = '20070201', @e_date date = '20070225' 

select orderdate,count(orderdate) 'number of orders'
from sales.orders 
where orderdate >=@s_date and orderdate <@e_date
group by orderdate
order by orderdate; 


select orderdate,count(orderdate) 'number of orders'
from sales.orders
where orderdate between @s_date and @e_date
group by orderdate
order by orderdate;


select empid, firstname, lastname, city, month(birthdate) as 'Birth month'
from hr.employees
where country = N'USA' and region = N'WA'
order by firstname desc
;

go 

select orderid, shippeddate
from sales.orders 
where custid = 20
order by shippeddate;

/*
	TOP 
	Fetch-offset
*/
go 

select top(3) orderid, orderdate, custid, empid
from sales.orders
order by orderdate desc;

go 

select top(1) percent orderid, orderdate, custid, empid
from sales.orders
order by orderdate desc;

go 

declare @n as bigint  = 5; 

select top(@n) orderid, orderdate, custid, empid
from sales.orders
order by orderdate desc; 

select top(3) orderid, orderdate, custid, empid
from sales.orders
order by (select null); 

go 

select top(3) with ties orderid, orderdate, custid, empid 
from sales.orders order by orderdate desc, orderid desc; 


go 
use tsql2012; 
go 
select orderid, orderdate, custid, empid
from sales.orders
order by orderdate desc, orderid desc
offset 50 rows fetch next 10 rows only; 

go 

use tsql2012
go 
select orderid, orderdate, custid, empid 
from sales.orders
order by orderdate desc, orderid desc
offset 0 rows fetch next 10 rows only;


/*
	Cross join
	self join
	inner join
	left join 
	right join
	full join
*/
go
use tsql2012; 
go
if not exists (select * from Production.Suppliers where companyname = N'supplier XYZ')
insert into Production.Suppliers (companyname, contactname, contacttitle, address, city, postalcode, country, phone)
values(N'Supplier XYZ', N'Jiru',N'Head of Security',N'42 Sekimai Musashino-shi', N'Tokyo', N'01759',N'japan',N'(02)4311-2609');

select * from production.suppliers where companyname like '%XYZ'; 

go 

select  d.n as theday , s.n shiftno
from dbo.nums d 
cross join dbo.nums s 
where d.n <=7
and s.n<=3; 

go
use tsql2012; 
go
select 
	s.companyname as supplier, s.country,
	p.productid, p.productname, p.unitprice
from production.suppliers as s 
inner join production.products as p
on s.supplierid = p.supplierid
where s.country = N'Japan'

-- self join
go 
use tsql2012; 
go 

select e.empid,
	e.firstname+N' '+e.lastname as employee, 
	m.firstname+N' '+m.lastname as manager,e.mgrid
from hr.employees as e 
inner join hr.employees as m 
on e.mgrid = m.empid
;

go 
use tsql2012; 
go 

select
	concat(e.firstname,N' ',e.lastname) as employee, e.empid, m.mgrid,
	concat(m.firstname,N' ',m.lastname) as manager 
from hr.employees as e inner join hr.employees as m
on e.mgrid = m.empid
;

go 
use tsql2012; 
go
select concat(e.firstname,N' ',e.lastname) as employees, e.empid, e.mgrid, concat(m.firstname,N' ',m.lastname) as managers
from hr.employees as e inner join hr.employees as m on e.mgrid = m.empid
; 

use tsql2012; 
go 

select 
	e.empid,
	e.title, 
	concat(e.titleofcourtesy,N' ', e.firstname, N' ', e.lastname) as employees, 
	e.mgrid, 
	concat(m.titleofcourtesy,N' ',m.firstname,N' ', m.lastname) manager, 
	m.title
from hr.employees e, hr.employees m where e.mgrid = m.empid; 


go 
use tsql2012; 
go 

select 
	s.companyname as supplier, s.country, 
	p.productid, p.productname, p.unitprice
from Production.suppliers as s 
left outer join Production.Products as p
on s.supplierid = p.supplierid
where s.country = N'Japan';


select s.companyname as supplier, s.country,p.productid, p.productname, p.unitprice
from production.products as p, production.suppliers  as s where s.supplierid = p.supplierid and 
s.country = N'Japan' 

select companyname, country from production.suppliers where country =N'japan'; 

select 
	s.companyname as supplier,
	s.country, 
	p.productid, 
	p.productname, 
	p.unitprice, 
	s.supplierid, 
	p.supplierid 
from production.suppliers as s 
left outer join production.Products as p 
on s.supplierid = p.supplierid and s.country = N'japan'
order by s.country;

select 
	s.companyname as supplier,
	s.country, 
	p.productid, 
	p.productname, 
	p.unitprice, 
	s.supplierid, 
	p.supplierid 
from production.suppliers as s 
left outer join production.Products as p 
on s.supplierid = p.supplierid 
where s.country = N'japan'
order by s.country;

select e.title, e.firstname employee , m.firstname manager,m.title
from hr.employees as e 
left outer join hr.employees as m 
on m.empid = e.mgrid; 

go 
use tsql2012; 
go 
select s.companyname as supplier, s.country,
p.productid, p.productname, p.unitprice, 
c.categoryname
from production.Suppliers as s 
left outer join production.products as p
on s.supplierid = p.supplierid
inner join production.Categories as c
on c.categoryid = p.categoryid
where s.country= N'japan'
;


select 
	s.companyname, s.city, s.country,
	p.productid, p.productname,p.unitprice, 
	c.categoryname
from Production.suppliers  as s 
left join Production.products as p on s.supplierid = p.supplierid
inner join Production.Categories c on p.categoryid = c.categoryid 
where country =N'japan'; 


select 
	s.companyname as supplier, s.country,
	p.productid, p.productname, p.unitprice, 
	c.categoryname
from production.suppliers as s 
	left outer join 
		(Production.products as p 
			inner join Production.categories as c 
			on p.categoryid= c.categoryid)
	on s.supplierid = p.supplierid 
where s.country = N'Japan'


/*
	Sub-query
	corelated subquery
	table expression 
		Derived tables 
		Common table expressions 
		views 
		inline table valued functions
	apply operator
*/


go 
use tsql2012; 
go 

select * from production.products 
where unitprice = (select min(unitprice) from production.products)

go 

select * from production.suppliers where null = null; 
select * from production.products where null = null; 
select * from production.categories where null = null; 

select s.supplierid, s.contactname,s.city, s.country, count(s.country) 'Number of orders'
from Production.suppliers as s inner join production.products as p on s.supplierid= p.supplierid
where p.unitprice >(
select min(unitprice) from production.products)
group by s.country, s.supplierid, s.contactname, s.city
;

go 
use tsql2012; 
go
select * 
from production.products as p 
where p.supplierid in(select supplierid from production.suppliers where country =N'japan');

-- coorelated subquery

select * from production.Categories; 
select * from Production.products; 
select * from Production.Suppliers


go 
use tsql2012; 
go
select p.categoryid, p.unitprice 
from production.products p 
group by p.categoryid, p.unitprice
having p.categoryid in 
(
	select c.categoryid 
	from production.Categories c 
	where p.categoryid = c.categoryid 
	group by c.categoryid
	having p.unitprice = avg(p.unitprice)	
)


select c.custid, c.companyname 
from sales.customers as c 
where exists (select * from sales.orders as o where o.custid = c.custid and o.orderdate ='20070212')
;

select c.custid, c.companyname
from sales.customers as c 
where not exists(select * from sales.orders as o where o.custid = c.custid and orderdate ='20070712')


go 
use tsql2012; 
go 

select categoryID, productid, productname, unitprice, rownum 
from (
select 
row_number() over(partition by categoryid order by unitprice, productid) as rownum, 
categoryid, productid, productname, unitprice
from production.products
) as d
order by rownum
;


go 
use tsql2012; 
go 

with C as 
(select row_number() over(partition by categoryid order by unitprice, productid) as rownum, 
	categoryid, productid, productname, unitprice
from production.products)
select c.categoryid, c.productid, c.productname, unitprice 
from C
where rownum <=2; 

go 
use tsql2012; 
go 

select * from hr.employees; 

declare @n int = 9;
with empCTE as 
(
	select empid, mgrid, firstname, lastname, 0 as distance
	from hr.employees
	where empid = @n
	union all 
	select m.empid, m.mgrid, m.firstname, m.lastname, s.distance+1 as distance 
	from empCTE as s
	inner join HR.Employees as m 
	on s.mgrid=m.empid
)
select empid, mgrid, firstname, lastname, distance 
from empCTE; 


-- views and inline table values functions 
go
use tsql2012;
go
if object_id('Sales.RankedProducts','V') is not null drop view Sales.RankedProducts;
go 
create view Sales.RankedProducts 
as 
select 
	row_number()over(partition by categoryid order by unitprice, productid) as rownum, 
	categoryid, productid, productname, unitprice
from Production.products; 
go 
print 'Sales.RankedProducts view was created!!'
go
use tsql2012; 
go 
if object_id('Sales.RankedProducts','V') is not null 
	select categoryid, productid, productname, unitprice, rownum
	from Sales.RankedProducts
	where rownum <=2
	
else print 'Table not found!!!!!'


--inline table valued function


go 
use tsql2012; 
go 

if object_id('HR.GetManagers','IF') is not null drop function HR.GetManagers; 
go


create function HR.GetManagers(@empid int) returns table
as
return
with EmpCTE as 
(
	select empid, mgrid, title, firstname, lastname, 0 as distance 
	from HR.Employees where empid = @empid

	union all

	select m.empid, m.mgrid, m.title, m.firstname, m.lastname, s.distance+1 as distance 
	from EmpCTE as s inner join HR.Employees as m on s.mgrid = m.empid 
)

select * from EmpCTE;
go

print 'HR.GetManagers function is created!!!'

select  * from HR.GetManagers(9);

/*
	Cross apply and outer apply
*/

go 
use tsql2012; 
go 

select productid, productname, unitprice 
from Production.products as p 
where p.supplierid = 1
order by unitprice, productid
offset 0 rows fetch first 2 rows only; 

go 
use tsql2012; 
go 

select s.supplierid, s.companyname as suppliers, A.*
from production.Suppliers as s 
cross apply (
	select p.productid, p.productname, p.unitprice 
	from Production.Products as p 
	where p.supplierid = s.supplierid
	order by unitprice, productid 
	offset 0 rows fetch first 2 rows only
) as A 
where s.country = N'japan';

go 

select a.supplierid, a.companyname as suppliers, p.productid, p.productname, p.unitprice from production.products as p 
cross apply(
	select * from production.suppliers as s
	where s.supplierid = p.supplierid and s.country = N'japan'
	order by p.unitprice, p.productid
	offset 0 rows fetch first 2 rows only
) as a 


select s.supplierid,s.companyname as suppliers, a.productid, a.productname, a.unitprice 
from production.suppliers as s 
outer apply (
	select * from production.products as p 
	where s.supplierid = p.supplierid
	order by p.unitprice, p.productid
	offset 0 rows fetch first 2 rows only
) as a
where s.country = N'japan'

/*
	Set operators
		UNION and UNION ALL
		INTERSECT 
		EXCEPT
*/

--union
go 
use tsql2012; 
go
select country, region, city
from HR.Employees

union 

select country, region, city
from Sales.Customers;

--union all
go 
use tsql2012; 
go
select country, region, city
from HR.Employees

union all

select country, region, city
from Sales.Customers;


--intersect
go 
use tsql2012
go 

select country, region, city
from HR.employees 

intersect 

select country, region, city
from sales.customers
;

--except

go 
use tsql2012; 
go 

select country, region, city 
from HR.employees

except

select country, region, city
from Sales.Customers; 

/*
	grouping set
*/

go 
use TSQL2012; 
go 
select count(*)
from sales.orders; 

go 
use tsql2012
go 

select shipperid, count(*) as numorders
from sales.orders
group by shipperid; 

go 
use tsql2012; 
go 

select shipperid,year(shippeddate) as ShippedYear, count(*) as numorders
from sales.orders
where shippeddate is not null
group by shipperid, year(shippeddate)
having count(*) <100

go 
use tsql2012; 
go 

select
	shipperid,
	count(*) as numorders, 
	count(shippeddate) as shippedorders, 
	min(shippeddate) as firstshippeddate, 
	max(shippeddate) as lastshippeddate,
	sum(val) as totalvalue
from sales.ordervalues
group by shipperid; 

go 

use tsql2012; 
go 

select shipperid, count (distinct shippeddate) as numshippingdates 
from sales.orders
group by shipperid;


select shipperid, convert(date,shippeddate), count(distinct shippeddate) as numberofshippedorders
from sales.orders
group by shipperid, shippeddate; 


use tsql2012; 
go 

select s.shipperid, s.companyname, count(*) as numorders
from sales.shippers as s join sales.orders as o 
on s.shipperid = o.shipperid
group by s.shipperid, s.companyname; 


go 
use tsql2012; 
go 

select s.shipperid, max(s.companyname) companyname, count(*) as numorders 
from sales.shippers as s join sales.orders  as o 
on s.shipperid = o.shipperid 
group by s.shipperid


go 
use tsql2012; 
go 

with cte as 
(
	select shipperid, count(*) as numorders
	from sales.orders
	group by shipperid
)
select s.shipperid, s.companyname, numorders
from sales.shippers as s 
inner join cte 
on s.shipperid = cte.shipperid; 

go 


/*
group by 
	Grouping sets
	cube
	rollup
*/

-- grouping set
use tsql2012; 
go 

select shipperid, year(shippeddate) as shipyear, count(*) as numorders
from sales.orders
group by grouping sets
(
	(shipperid, year(shippeddate)),
	(shipperid),(year(shippeddate)),
	()
);

-- cube
/*
	select a, b avg(sal)
	from t 
	Grouping By Grouping set 
	(
		(a,b),
		(a),(b),
		()
	)
*/

go 
use tsql2012; 
go 

select shipperid, year(shippeddate) as shipyear, count(*) as numorders
from sales.orders
group by cube(shipperid, year(shippeddate)); 

go 

select shipperid, year(shippeddate) as shipyear, count(*) as numorders
from sales.orders
group by rollup(shipperid, year(shippeddate)); 


-- rollup 
/*
	select a, b avg(sal)
	from t 
	Grouping By Grouping set 
	(
		(a,b),
		(a),
		()
	)
*/
select shipcountry, shipregion, shipcity, count(*) as numorders
from sales.orders
group by rollup(shipcountry, shipregion, shipcity)
;

select shipperid, year(shippeddate) as shipyear, count(*) as numorders
from sales.orders
group by rollup(shipperid, year(shippeddate)); 

use tsql2012; 
go 
select 
	shipcountry, grouping(shipcountry) as grpcountry, -- returns 0 when the element is part of the grouping set and 1 when it is not
	shipregion, grouping(shipregion) as grpregion, 
	shipcity, grouping(shipcity) as grpcity, 
	count(*) as numorder
from sales.orders
group by rollup(shipcountry, shipregion, shipcity)
;

select grouping_id(shipcountry,shipregion, shipcity) as grp_id,
shipcountry, shipregion, shipcity, count(*) as numorder
from sales.orders 
group by rollup(shipcountry, shipregion, shipcity);

/*
	Pivoting and unpivoting Data
*/

/*
	WITH PivotData AS
(
  SELECT
    < grouping column >,
    < spreading column >,
    < aggregation column >
  FROM < source table >
)
SELECT < select list >
FROM PivotData
  PIVOT( < aggregate function >(< aggregation column >)
    FOR < spreading column > IN (< distinct spreading values >) ) AS P;
*/


with pivotData as 
(
	select custid, shipperid, freight
	from sales.orders 
)
select custid,[1],[2],[3] 
from pivotData 
pivot(sum(freight) for shipperid in ([1],[2],[3])) as p 

go 
use tsql2012; 
go 

with empPivot as (
	select e.title, e.city, e.country
	from HR.Employees as e 
) 
select title, [USA],[UK]
from empPivot as e
pivot(count(e.city) for country in ([USA],[UK])) as p

use tsql2012; 
go 

with pivotCTE as 
(select custid, shipperid, freight from sales.orders)

select * from pivotCTE
pivot(sum(freight) for shipperid in ([1],[2],[3])) as p


--Dynamic pivot query

declare 
	@query nvarchar(max), 
	@column nvarchar(max)

set @column = stuff(
(
select distinct ','+quotename(shipperid) as shipid
from sales.orders
for xml path(''),type
).value('.','NVARCHAR(MAX)'), 1, 1, '')
; 

set @query = 
'select shipcountry,'+ @column+' from
(select shipperid,shipcountry, freight from sales.orders) as t 
pivot
(sum(freight) for shipperid in ('+@column+')) as p'


print @query; 

exec sp_executesql @query; 

-- unpivot table 

use tsql2012; 
go 

if object_id('sales.FreightsTotals') is not null 
drop table sales.FreightsTotals;

go 

with pivotData as
(
	select custid, shipperid, freight from sales.Orders
)
select * into sales.FreightsTotals
from pivotData
pivot(sum(freight) for shipperid in([1],[2],[3])) as p;

select * from sales.FreightsTotals;


select custid, shipperid, freight 
from sales.FreightsTotals
unpivot(freight for shipperid in([1],[2],[3])) as u; 


/*
	Windowing Function
*/

select * from sales.ordervalues order by custid;


use tsql2012
go
select custid, orderid, orderdate, val, 
sum(val) over (partition by custid order by custid rows between unbounded preceding and current row) as RunningTotalRows,
sum(val) over (partition by custid order by custid range between unbounded preceding and current row) as RunningTotalRange,
sum(val) over(partition by custid) as custtotal, 
sum(val) over() as grandtotal
from sales.ordervalues 
order by custid, orderdate
;

use tsql2012; 
go 

select custid, orderid, orderdate, val, 
	sum(val) over(partition by custid 
					order by orderdate, orderid 
					rows between unbounded preceding 
						and current row) as runningtotal
from sales.ordervalues; 

use tsql2012; 
go

with RunningTotals as 
(
	select custid, orderid, orderdate, val, 
	SUM(val) OVER(partition by custid
					order by orderdate, orderid
					rows between unbounded preceding and current row) 
	as runningtotal
	from sales.ordervalues
)
select * from RunningTotals
where runningtotal<1000.00; 


select custid, orderid, orderdate, val, 
sum(val) over(partition by custid order by orderdate, orderid rows between unbounded preceding and current row) as runningtotal
from sales.ordervalues

--- Row vs range

use tsql2012; 
go
select custid, orderid, orderdate, val,
sum(val) over(order by val) as Runnintotal
from sales.OrderValues

use tsql2012; 
go
select custid, orderid, orderdate, val,
sum(val) over(partition by custid order by val) as Runnintotal
from sales.OrderValues


use tsql2012; 
go 
select custid, orderid, orderdate, val, 
sum(val) over(order by val range between unbounded preceding and current row) as RunningTotal
from sales.ordervalues

use tsql2012; 
go 
select custid, orderid, orderdate, val, 
sum(val) over(order by val rows between unbounded preceding and current row) as runningtotal
from sales.ordervalues; 

use tsql2012; 
go 
select custid, orderid, orderdate, val, 
sum(val) over(order by val rows between unbounded preceding and unbounded following) as grandtotal
from sales.ordervalues; 

use tsql2012; 
go 

select custid, orderid, orderdate, val, 
sum(val) over(partition by custid order by val rows between unbounded preceding and unbounded following) grandTotal
from sales.ordervalues; 

select custid, orderid, orderdate, val, 
sum(val) over(order by val rows between 1 preceding and 1 following) [1 row before + current row + 1 row after ]
from sales.ordervalues; 
