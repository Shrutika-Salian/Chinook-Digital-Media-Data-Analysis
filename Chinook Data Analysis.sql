select sum(total) as Sales_via_invoice from invoice;

select sum(unitprice*quantity) as TotalSales_via_InvoiceLine from invoiceLine;

select count(trackid) as Tracks_Sold from invoiceLine;select concat(customer.LastName, ',', customer.FirstName) as Customer_Name, customer.country, sum(total) as Total_Sales from invoice join customer on invoice.customerId=customer.customerId group by Customer_Name, customer.country, state, customer.city
             order by Total_Sales desc;

select concat(customer.LastName, ',', customer.FirstName) as Customer_Name, customer.country, 
ifnull(customer.state,'Not Specified') as state,customer.city, sum(total) as Total_Sales from invoice join customer on invoice.customerId=customer.customerId group by Customer_Name, customer.country, state,
 	customer.city order by Total_Sales desc;

select concat(customer.LastName, ',', customer.FirstName) as Customer_Name, sum(invoice.total) as Total_Sales from customer
join invoice on customer.customerId=invoice.customerId
group by Customer_Name order by Total_Sales desc;

select ifNull(customer.company, 'Others') as Company, sum(total) as Total_Sales from customer join invoice on customer.customerId=invoice.customerId 
group by Company order by Total_Sales desc;

select ifNull(artist.Name, 'Unknown') as Artist_Name, sum(invoiceLine.unitprice*invoiceLine.quantity) as Total_Sales from artist 
join album on artist.artistId=album.artistId 
join track on album.albumId=track.albumId
join invoiceLine on track.trackId=invoiceLine.trackId
group by Artist_Name order by Total_Sales desc;

select ifNull(artist.Name, 'Unknown') as Artist_Name, sum(invoiceLine.unitprice*invoiceLine.quantity) as Total_Sales from artist 
join album on artist.artistId=album.artistId 
join track on album.albumId=track.albumId
join invoiceLine on track.trackId=invoiceLine.trackId
group by Artist_Name order by Total_Sales desc limit 10;

select ifNull(album.Title, 'Unknown') as Album_Name, sum(invoiceLine.unitprice*invoiceLine.quantity) as Total_Sales from album 
join track on album.albumId=track.albumId
join invoiceLine on track.trackId=invoiceLine.trackId
group by Album_Name order by Total_Sales desc;

select concat(employee.LastName, ',', employee.FirstName) as Employee_Name, sum(total) as Total_Sales from employee
join customer on employee.employeeId=customer.supportRepId 
join invoice on customer.customerId = invoice.customerId
group by Employee_Name;

select MediaType.Name as Media_Type, sum(invoiceLine.unitprice*invoiceLine.quantity) as Total_Sales from MediaType
join Track on MediaType.MediaTypeId=Track.MediaTypeId
join InvoiceLine on track.trackid=InvoiceLine.trackId
group by Media_Type;

select Genre.Name as Genres, sum(invoiceLine.unitprice*invoiceLine.quantity) as Total_Sales from Genre
join Track on Genre.GenreId=Track.GenreId
join InvoiceLine on track.trackid=InvoiceLine.trackId
group by Genres order by Total_Sales desc;

select year(InvoiceDate) as Years, sum(total) as Total_Sales from invoice group by Years;

select year(InvoiceDate) as Years,DATE_FORMAT(InvoiceDate, "%M") as Months, sum(total) as Total_Sales from invoice 
group by Years, Months;

select concat(employee.LastName, ',', employee.FirstName) as Employee_Name, employee.title, date(employee.BirthDate) as BirthDate,
date(employee.HireDate) as HireDate, TIMESTAMPDIFF(YEAR, employee.HireDate, "2013-12-31") as Years_Of_Work,
ifNull(concat(manager.LastName, ',', manager.FirstName),'MANAGER THEMSELF') as Manager_Name, employee.title as Manager_Title, employee.address, 
employee.city, employee.state, employee.country
	from employee left join employee as manager on employee.employeeId=manager.ReportsTo;

select concat(employee.LastName, ',', employee.FirstName) as Employee_Name, 
TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate) as Age_At_InvoiceDate, sum(total) as Total_Sales from employee
join customer on employee.employeeId=customer.supportRepId 
join invoice on customer.customerId = invoice.customerId
group by Employee_Name, Age_At_InvoiceDate;

select concat(employee.LastName, ',', employee.FirstName) as Employee_Name, 
sum(case when (TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate)>=30 and TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate)<=39) then invoice.total  else 'N/A' end) as 'Sales_at_30s',
sum(case when (TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate)>=40 and TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate)<=49) then invoice.total else 'N/A' end) as 'Sales_at_40s',
sum(case when (TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate)>=50 and TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate)<=59) then invoice.total else 'N/A' end) as 'Sales_at_50s',
sum(case when (TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate)>=60 
and TIMESTAMPDIFF(YEAR, employee.BirthDate, invoice.InvoiceDate)<=69) then invoice.total else 'N/A' end) as 'Sales_at_60s'             
from employee
join customer on employee.employeeId=customer.supportRepId 
join invoice on customer.customerId = invoice.customerId
group by Employee_Name;



