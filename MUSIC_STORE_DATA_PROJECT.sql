use weekdays;

-- Q1. Who is the senior most employee based on the job title :
select * from employee;

select * from employee
order by levels 
desc limit 1;

-- Q2. Which countries have the most invoices:
select * from invoice;

select count(*) as billing_data, billing_country 
from invoice
group by billing_country
order by billing_data desc;

-- Q3. What are top 3 values of invoice :

select * from invoice;

select total from invoice
order by total desc
limit 3;

/* Q4. Whicy city has the best customers? we would like to throw a promotional music festival in the city we made the most money.
Write a query that returns one city that has the highest sum of invoices total. Return both the city name and sum of all invoice 
totals */

select * from invoice;

select sum(total) as total_invoice, billing_city from invoice
group by billing_city
order by total_invoice desc;

/* Q5. Who is the best customer? The customer who has spent the most money will be declared as the best customer.
Write a query which returns the customer who has spent the most money */

select * from customer;

select * from invoice;

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total 
from customer
join
invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id,customer.first_name, customer.last_name,invoice.total
order by total desc
limit 1;

-- Q6. Write query to return email,first name, last name & Genre of all rock music listeners.
-- Return your list ordered by alphabetically by email starting with A.

select distinct customer.first_name,customer.last_name,customer.email
from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in(
select track_id from track
join genre on track.genre_id=genre.genre_id
where genre.name like 'rock'
)
order by email;

-- Q7. Let's invite the artists who have written the most rock music in our dataset.
-- Write a query that returns the artist name and total track count of the top 10 rock bands.

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album2 on album2.album_id=track.track_id
join artist on artist.artist_id=album2.artist_id
join genre on genre.genre_id=track.genre_id
where genre.name like 'rock'
group by artist.artist_id, artist.name
order by number_of_songs desc
limit 10;

-- Q8. Return all the track names that have a song length longer than the average song length. Return the name and milliseconds of each track. 
-- Order by the song length with longest sing listed first.

select * from track;

select name, milliseconds
from track
where milliseconds > 
(
select avg(milliseconds) as avg_track_length
from track
)
order by milliseconds desc;

