--create database web_scraping;
select * from jakarta_hotel;

-- Hotel harga terjangkau dengan kualitas tinggi
SELECT "Name", "Total_Rating", "Price_in_IDR", "Reputation", "Category"
FROM jakarta_hotel jh
WHERE "Stars" >= 4.0
	AND "Price_in_IDR" < 150000
ORDER BY "Price_in_IDR" ASC;

-- How much money is saved from the discount
SELECT 
  "Name", 
  "Discount_in_%",
  "Original_Price", 
  "Price_in_IDR",
  ("Original_Price" - "Price_in_IDR") AS money_saved
FROM jakarta_hotel jh
ORDER BY money_saved DESC;

-- Jumlah hotel per lokasi
SELECT "Location", COUNT(*) AS jumlah_hotel
FROM jakarta_hotel jh
GROUP BY "Location"
ORDER BY jumlah_hotel DESC;

-- Rata-rata rating dan harga per kategori hotel
SELECT "Category",
       ROUND(AVG("Total_Rating"), 2) AS avg_rating,
       ROUND(AVG("Price_in_IDR")) AS avg_price
FROM jakarta_hotel jh
GROUP BY "Category"
ORDER BY avg_rating DESC;

-- Hotel dengan reputasi tertinggi
SELECT "Name", "Reputation", "Stars"
FROM jakarta_hotel jh
WHERE "Reputation" IN ('Excellent', 'Fabulous')
	and "Stars" > 4.0
order by "Stars" desc;

-- Category of hotel price
WITH price_category AS (
  SELECT 
    "Name", 
    "Price_in_IDR",
    CASE 
      WHEN "Price_in_IDR" < 100000 THEN 'Low'
      WHEN "Price_in_IDR" BETWEEN 100000 AND 200000 THEN 'Medium'
      ELSE 'High'
    END AS price_tier
  FROM jakarta_hotel
)
SELECT price_tier, COUNT(*) AS jumlah_hotel
FROM price_category
GROUP BY price_tier;

-- cek yang diskonnya paling tinggi di tiap lokasi tertentu/unik
SELECT *
FROM (
  SELECT 
    "Name", 
    "Location", 
    "Discount_in_%",
    RANK() OVER (PARTITION BY "Location" ORDER BY "Discount_in_%" DESC) AS rank_diskon
  FROM jakarta_hotel
) AS ranked
WHERE rank_diskon = 1;

-- urutkan hotel berdasarkan harga tiap kategori
SELECT *
FROM (
  SELECT 
    "Name", 
    "Category", 
    "Price_in_IDR",
    ROW_NUMBER() OVER (PARTITION BY "Category" ORDER BY "Price_in_IDR" ASC) AS row_num
  FROM jakarta_hotel
) AS ranked
WHERE row_num <= 3;

-- hotel dg rating/review tertinggi, more frequently rated or visited
SELECT *
FROM (
  SELECT 
    "Name",
    "Total_Rating",
    "Stars",
    "Price_in_IDR",
    DENSE_RANK() OVER (ORDER BY "Total_Rating" DESC) AS rank_rating
  FROM jakarta_hotel
) AS ranked
WHERE rank_rating <= 5;

-- subquery, lokasi dg avg price tertinggi
SELECT address, avg_price
FROM (
  SELECT 
    "Location" as address, 
    ROUND(AVG("Price_in_IDR")) AS avg_price
  FROM jakarta_hotel
  GROUP BY "Location"
) AS avg_per_loc
ORDER BY avg_price ASC;
