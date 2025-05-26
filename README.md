# PostgreSQL

## \#Primary Key এবং Foreign Key ধারণা

### Primary Key (প্রাইমারি কী):

`Primary Key` হলো একটি টেবিলের এমন একটি কলাম বা কলামের সমন্বয় যা প্রতিটি রেকর্ডকে অনন্যভাবে চিহ্নিত করে। এটি টেবিলের প্রতিটি সারির জন্য একটি অনন্য পরিচয়পত্রের মতো কাজ করে।

### Primary Key এর বৈশিষ্ট্য:

- অবশ্যই Unique হতে হবে
- NULL মান থাকতে পারবে না
- একটি টেবিলে শুধুমাত্র একটি Primary Key থাকতে পারে
- Primary Key এর মান পরিবর্তন করা উচিত নয়

```sql
-- Single column Primary Key
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,  -- এটি একটি Primary Key
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Composite Primary Key (একাধিক কলামের সমন্বয়)
CREATE TABLE enrollments (
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)  -- দুটি কলামের সমন্বয়ে Primary Key
);
```

### Foreign Key (ফরেইন কী):

`Foreign Key` হলো একটি টেবিলের এমন একটি কলাম বা কলামের সমন্বয় যা অন্য একটি টেবিলের Primary Key কে রেফারেন্স করে। এটি দুটি টেবিলের মধ্যে সম্পর্ক স্থাপন করে।

### Foreign Key এর উদ্দেশ্য:

- Data Integrity বজায় রাখা
- টেবিলগুলোর মধ্যে সম্পর্ক তৈরি করা
- Referential Integrity নিশ্চিত করা

```sql
-- Parent টেবিল (যেখানে Primary Key আছে)
CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

-- Child টেবিল (যেখানে Foreign Key আছে)
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INTEGER,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
        ON DELETE CASCADE  -- Department মুছে গেলে Employee গুলোও মুছে যাবে
        ON UPDATE CASCADE  -- Department এর ID পরিবর্তন হলে Employee এর রেফারেন্সও পরিবর্তন হবে
);
```

## \#VARCHAR এবং CHAR ডেটা টাইপের পার্থক্য

### VARCHAR (Variable Character):

`VARCHAR` হলো পরিবর্তনীয় দৈর্ঘ্যের ক্যারেক্টার ডেটা টাইপ। এটি নির্দিষ্ট সর্বোচ্চ দৈর্ঘ্য পর্যন্ত যেকোনো সাইজের টেক্সট সংরক্ষণ করতে পারে।

### VARCHAR এর বৈশিষ্ট্য:

- পরিবর্তনীয় দৈর্ঘ্য
- শুধুমাত্র প্রকৃত ডেটার জন্য স্থান ব্যবহার করে
- স্টোরেজ দক্ষ
- সর্বোচ্চ ১ GB পর্যন্ত ডেটা সংরক্ষণ করতে পারে

```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50),      -- সর্বোচ্চ ৫০ ক্যারেক্টার
    email VARCHAR(255),        -- সর্বোচ্চ ২৫৫ ক্যারেক্টার
    bio VARCHAR               -- কোনো সীমা নেই (TEXT এর মতো)
);
```

### CHAR (Character):

`CHAR` হলো নির্দিষ্ট দৈর্ঘ্যের ক্যারেক্টার ডেটা টাইপ। এটি সবসময় নির্দিষ্ট পরিমাণ স্থান ব্যবহার করে, প্রয়োজনে ডানে স্পেস যোগ করে।

### CHAR এর বৈশিষ্ট্য:

- নির্দিষ্ট দৈর্ঘ্য
- সবসময় পূর্ণ স্থান ব্যবহার করে
- ছোট, নির্দিষ্ট সাইজের ডেটার জন্য উপযুক্ত
- তুলনা অপারেশন দ্রুততর

```sql
CREATE TABLE country_codes (
    id SERIAL PRIMARY KEY,
    country_code CHAR(2),      -- সবসময় ২ ক্যারেক্টার (BD, US, UK)
    currency_code CHAR(3),     -- সবসময় ৩ ক্যারেক্টার (BDT, USD)
    country_name VARCHAR(100)
);
```

## \#SELECT স্টেটমেন্টে WHERE ক্লজের উদ্দেশ্য

`WHERE` ক্লজ হলো SQL এর একটি অত্যন্ত গুরুত্বপূর্ণ অংশ যা ডেটা ফিল্টার করার জন্য ব্যবহৃত হয়। এটি নির্দিষ্ট শর্ত অনুযায়ী রেকর্ড নির্বাচন করে।

### WHERE ক্লজের মূল উদ্দেশ্য:

**শর্তসাপেক্ষ ডেটা নির্বাচন:** সব ডেটা না নিয়ে শুধু প্রয়োজনীয় ডেটা নেওয়া যায়।
**পারফরমেন্স উন্নতি:** কম ডেটা প্রসেস করার ফলে কোয়েরি দ্রুত চলে।  
**নির্দিষ্ট বিশ্লেষণ:** বিশেষ মানদণ্ড অনুযায়ী ডেটা বিশ্লেষণ করা যায়।

### WHERE ক্লজের বিভিন্ন ব্যবহার

### সাধারণ তুলনা অপারেটর:

```sql
-- নির্দিষ্ট দামের উপরে পণ্য
SELECT * FROM products WHERE price > 1000;

-- নির্দিষ্ট ক্যাটেগরির পণ্য
SELECT * FROM products WHERE category = 'electronics';

-- কম স্টক আছে এমন পণ্য
SELECT * FROM products WHERE stock_quantity < 20;
```

### BETWEEN অপারেটর:

```sql
-- নির্দিষ্ট দামের রেঞ্জের পণ্য
SELECT product_name, price
FROM products
WHERE price BETWEEN 1000 AND 30000;

-- নির্দিষ্ট তারিখের রেঞ্জের পণ্য
SELECT *
FROM products
WHERE created_date BETWEEN '2024-01-01' AND '2024-02-28';
```

### IN অপারেটর:

```sql
-- একাধিক ক্যাটেগরির পণ্য
SELECT *
FROM products
WHERE category IN ('electronics', 'furniture');

-- নির্দিষ্ট আইডির পণ্য
SELECT *
FROM products
WHERE product_id IN (1, 3, 5);
```

### LIKE অপারেটর (প্যাটার্ন ম্যাচিং):

```sql
-- নামে 'phone' শব্দ আছে এমন পণ্য
SELECT *
FROM products
WHERE product_name LIKE '%phone%';

-- 'm' দিয়ে শুরু হওয়া পণ্য
SELECT *
FROM products
WHERE product_name LIKE 'm%';

-- শেষে 'r' আছে এমন পণ্য
SELECT *
FROM products
WHERE product_name LIKE '%r';
```

### যৌগিক শর্ত (AND, OR):

```sql
-- electronics ক্যাটেগরির এবং ২০০০০ টাকার বেশি দামের পণ্য
SELECT *
FROM products
WHERE category = 'electronics' AND price > 20000;

-- কম স্টক অথবা বেশি দামের পণ্য
SELECT *
FROM products
WHERE stock_quantity < 10 OR price > 40000;

-- জটিল শর্ত
SELECT *
FROM products
WHERE (category = 'electronics' OR category = 'furniture')
AND price BETWEEN 3000 AND 50000;
```

### NULL মান চেক:

```sql
-- যেসব পণ্যের বিবরণ নেই
SELECT * FROM products WHERE description IS NULL;

-- যেসব পণ্যের বিবরণ আছে
SELECT * FROM products WHERE description IS NOT NULL;
```

## \#UPDATE স্টেটমেন্ট দিয়ে ডেটা পরিবর্তন

`UPDATE` স্টেটমেন্ট বিদ্যমান রেকর্ডের মান পরিবর্তন করার জন্য ব্যবহৃত হয়। এটি অত্যন্ত শক্তিশালী কিন্তু সাবধানে ব্যবহার করতে হয়।

### UPDATE এর মূল গঠন:

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

### সাধারণ UPDATE অপারেশন:

```sql
-- একক রেকর্ড আপডেট
UPDATE products
SET price = 47000
WHERE product_name = 'laptop';

-- একাধিক কলাম আপডেট
UPDATE products
SET price = 26000, stock_quantity = 25
WHERE product_name = 'mobile phone';

-- গাণিতিক অপারেশনের মাধ্যমে আপডেট
UPDATE products
SET price = price * 1.10  -- ১০% দাম বৃদ্ধি
WHERE category = 'electronics';
```

### শর্তসাপেক্ষ UPDATE:

```sql
-- নির্দিষ্ট শর্তে স্টক কমানো
UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1 AND stock_quantity > 0;

-- কম স্টকের পণ্যের জন্য সতর্কতা স্ট্যাটাস
ALTER TABLE products ADD COLUMN status VARCHAR(20) DEFAULT 'available';

UPDATE products
SET status = 'low_stock'
WHERE stock_quantity < 10;

UPDATE products
SET status = 'out_of_stock'
WHERE stock_quantity = 0;
```

### নিরাপদ UPDATE অনুশীলন:

```sql
-- সবসময় প্রথমে SELECT দিয়ে চেক করুন
SELECT * FROM products WHERE category = 'electronics';

-- তারপর UPDATE করুন
UPDATE products
SET price = price * 0.95
WHERE category = 'electronics';

-- আপডেটের পর আবার চেক করুন
SELECT * FROM products WHERE category = 'electronics';
```

## \#PostgreSQL এ Aggregate Functions

`Aggregate Functions` হলো এমন ফাংশন যা একাধিক রো থেকে একটি একক মান ক্যালকুলেট করে। এগুলো ডেটা বিশ্লেষণ এবং রিপোর্টিংয়ের মূল ভিত্তি।

### COUNT() ফাংশন:

`COUNT()` ফাংশন রেকর্ডের সংখ্যা গণনা করে।

```sql
-- মোট রেকর্ড সংখ্যা
SELECT COUNT(*) AS total_records FROM sales_data;

-- নির্দিষ্ট কলামের NULL নয় এমন মানের সংখ্যা
SELECT COUNT(sale_amount) AS non_null_sales FROM sales_data;

-- ইউনিক ভ্যালু গণনা
SELECT COUNT(DISTINCT product_category) AS unique_categories FROM sales_data;
SELECT COUNT(DISTINCT sales_person) AS total_sales_people FROM sales_data;
```

### SUM() ফাংশন:

`SUM()` ফাংশন সংখ্যাসূচক মানগুলোর যোগফল করে।

```sql
-- মোট বিক্রয়ের পরিমাণ
SELECT SUM(sale_amount) AS total_revenue FROM sales_data;

-- ক্যাটেগরি অনুযায়ী মোট বিক্রয়
SELECT
    product_category,
    SUM(sale_amount) AS category_total
FROM sales_data
GROUP BY product_category
ORDER BY category_total DESC;

-- অঞ্চল অনুযায়ী দৈনিক বিক্রয়
SELECT
    region,
    sale_date,
    SUM(sale_amount) AS daily_total
FROM sales_data
GROUP BY region, sale_date
ORDER BY region, sale_date;
```

## AVG() ফাংশন:

`AVG()` ফাংশন গড় মান ক্যালকুলেট করে।

```sql
-- সামগ্রিক গড় বিক্রয়
SELECT AVG(sale_amount) AS average_sale FROM sales_data;

-- ক্যাটেগরি অনুযায়ী গড় বিক্রয়
SELECT
    product_category,
    AVG(sale_amount) AS average_sale,
    COUNT(*) AS number_of_sales
FROM sales_data
GROUP BY product_category
ORDER BY average_sale DESC;

-- বিক্রয়কর্মী অনুযায়ী গড় বিক্রয়
SELECT
    sales_person,
    AVG(sale_amount) AS avg_sale_per_person,
    COUNT(*) AS total_sales,
    SUM(sale_amount) AS total_revenue
FROM sales_data
GROUP BY sales_person
ORDER BY avg_sale_per_person DESC;

-- গড়ের চেয়ে বেশি বিক্রয়ের রেকর্ড
SELECT *
FROM sales_data
WHERE sale_amount > (SELECT AVG(sale_amount) FROM sales_data);
```

### MIN() এবং MAX() ফাংশন:

```sql
-- সর্বনিম্ন এবং সর্বোচ্চ বিক্রয়
SELECT
    MIN(sale_amount) AS lowest_sale,
    MAX(sale_amount) AS highest_sale,
    MAX(sale_amount) - MIN(sale_amount) AS sale_range
FROM sales_data;

-- ক্যাটেগরি অনুযায়ী সর্বোচ্চ এবং সর্বনিম্ন
SELECT
    product_category,
    MIN(sale_amount) AS min_sale,
    MAX(sale_amount) AS max_sale,
    AVG(sale_amount) AS avg_sale
FROM sales_data
GROUP BY product_category;

-- প্রথম এবং শেষ বিক্রয়ের তারিখ
SELECT
    MIN(sale_date) AS first_sale_date,
    MAX(sale_date) AS last_sale_date,
    MAX(sale_date) - MIN(sale_date) AS business_period
FROM sales_data;
```
