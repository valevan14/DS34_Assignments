--create table students (
--	id int primary KEY,
--	nama VARCHAR,
--	institute VARCHAR,
--	berat_badan FLOAT,
--	tinggi_badan FLOAT
--);

-- drop table students;

-- Tambahkan setidaknya 5 baris data baru
--INSERT INTO students (id, nama, institute, berat_badan, tinggi_badan) VALUES
--    (123001, 'Bella',   'Fisika',            55.2, 165),
--    (123002, 'Chandra', 'Teknik Elektro',    68.0, 180),
--    (123003, 'Devi',    'Matematika',        50.5, 158),
--    (123004, 'Eric',    'Biologi',           72.3, 185),
--    (123005, 'Farah',   'Teknik Informatika',58.4, 170);


-- dvdrental
select 
	first_name, 
	last_name 
from actor 
where first_name in ('Jennifer', 'Nick', 'Ed');

-- Hitung total pembayaran (amount) untuk setiap payment_id yang lebih besar dari 5.99.
select 
	payment_id,
--	customer_id,
	sum(amount) amount
	from payment p 
where amount > 5.99
group by 1
order by 2 desc;

-- Kelompokkan film berdasarkan durasi menjadi 4 kategori:
-- > 100 menit, 87 <= durasi <= 100 menit, 72 <= durasi <= 86 menit, < 72 menit
-- film_id, title, description, release_year
-- select * from film limit 5;
select
	f.film_id,
	f.title,
	f.length,
	case
		when f.length > 100 then '> 100 minutes'
		when f.length <= 100 and f.length >= 87 then '87-100 minutes'
		when f.length <= 86 and f.length >= 72 then '72-86 minutes'
		else '< 72 minutes'
	end as duration
from film f
order by 2;

-------------------------------------------------------------

select * from rental limit 5;
-- rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update
select * from payment limit 5;
-- payment_id, rental_id, customer_id, staff_id, payment_date

-- Gabungkan data dari tabel rental dan payment untuk menampilkan 
-- rental_id, rental_date, payment_id, dan amount, urutkan berdasarkan amount secara ascending.

select 
	r.rental_id,
	r.rental_date,
	p.payment_id,
	p.amount
from payment p
inner join rental r
	on p.rental_id = r.rental_id
order by p.amount asc;

select * from address limit 5;
-- address_id, address, address2, district, city_id, postal_code, phone, last_update
select * from city limit 5;
-- city_id, city, country_id, last_update

-- Gunakan UNION untuk menggabungkan alamat (address) 
-- yang memiliki city_id = 42 dengan city_id = 300.

select 
	address,
	city_id
from address 
where city_id = 42
union all
select
	address,
	city_id
from address
where city_id = 300
order by 1;

--
