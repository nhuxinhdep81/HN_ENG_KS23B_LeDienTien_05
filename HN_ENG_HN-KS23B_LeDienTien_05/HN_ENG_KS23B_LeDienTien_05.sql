-- ===============DE 05===============

create database hackathon05;

use hackathon05;

-- phan 1 cau 2: tao bang va chinh sua csdl

create table tbl_customers(
	customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    phone varchar(20) not null unique,
    email varchar(100) not null unique
);

create table tbl_customer_info(
	customer_id int ,
    foreign key (customer_id) references tbl_customers(customer_id),
    primary key(customer_id),
    membership_level enum('Standard', 'VIP', 'VVIP'),
    registration_date date,
    total_spent decimal(10,2)
);

create table tbl_movies(
	movie_id int primary key auto_increment,
    movie_name varchar(255) not null,
    genre varchar(100),
    duration int,
    release_date date
);

create table tbl_showtimes(
	showtime_id int primary key auto_increment,
    movie_id int,
    foreign key (movie_id) references tbl_movies(movie_id),
    show_date datetime,
    price decimal(10,2)
);

create table tbl_tickets (
	ticket_id int primary key auto_increment,
    showtime_id int,
    foreign key (showtime_id) references tbl_showtimes(showtime_id),
    customer_id int,
    foreign key (customer_id) references tbl_customers(customer_id),
    seat_number varchar(10),
    booking_date datetime,
    status enum('Confirmed', 'Cancelled')
);

-- yeu cau chinh sua csdl

-- 1
alter table tbl_movies
add column rating decimal(2,1);

-- 2
alter table tbl_customers 
modify phone varchar(15);

-- 3
alter table tbl_movies
drop release_date;

-- ===============Phan 2 =================
-- it nhat 1 phim hanh dong 1 phim hoat hinh
-- cau 3
insert into tbl_movies (movie_name, genre, duration, rating )
values
('Qua nhanh qua nguy hiem 2', 'Hanh dong', 120, 4.1),
('Cuoc chien tranh giua cac vi sao', 'Hanh dong', 200, 4.5),
('Tom and Jerry', 'Hoat hinh', 100, 3.2),
('Cong vien ky jura', 'Khoa hoc', 120, 2.1);

insert into tbl_customers (customer_name, phone, email)
values
('Dien Tien', 0943157831, 'tien2005@gmail.com'),
('Gia Thieu', 0987646232, 'thieu2k5@gmail.com'),
('Dac Son', 0986425354, 'sondepzai@gmail.com'),
('Xuan Quang', 0987642686, 'quanXN@gmail.com');

insert into tbl_customer_info(customer_id,membership_level, registration_date, total_spent)
values
(1,'VVIP','2025-01-02',100000),
(2,'VIP', '2024-03-25', 98989),
(3,'Standard', '2024-07-20', 70000),
(4,'VIP', '2024-08-28', 40000);

insert into tbl_showtimes(movie_id, show_date,price)
values
(1,'2025-01-2 00:00:00', 40000),
(2,'2025-01-5 00:00:00', 50000),
(3,'2025-01-8 00:00:00', 60000),
(4,'2025-01-10 00:00:00', 70000);

insert into tbl_tickets(showtime_id, customer_id, seat_number, booking_date, status)
values
(1,1,'A1', '2025-01-1 00:00:00', 'Confirmed'),
(2,2,'B2', '2025-01-4 00:00:00', 'Confirmed'),
(3,3,'C3', '2025-01-6 00:00:00', 'Cancelled'),
(4,4,'D4', '2025-01-8 00:00:00', 'Cancelled');

--  cau 4

-- a

select movie_id as MãPhim, movie_name as TênPhim, genre as ThểLoại, duration as ThờiLượng from tbl_movies;

-- b
select distinct * from tbl_customers; 

-- cau 5

-- a 
select st.show_date as NgayChieu, m.movie_name as TenPhim, count( ticket_id) as SoLuongVeDaBan 
from tbl_showtimes st join tbl_movies m on st.movie_id = m.movie_id
join tbl_tickets t on st.showtime_id = t.showtime_id
group by st.show_date, m.movie_name;

-- cau 6
-- a

select m.movie_name as TenPhim, count( st.movie_id) as SoLuongVeDaBan from tbl_movies m
group by m.movie_name;

-- b 
select showtime_id as MaPhim, count( distinct ticket_id) as SoLuongVe from tbl_tickets
group by showtime_id
having SoLuongVe > 100;

-- cau 8
select c.customer_name as TenKhacHang, ci.total_spent as TongTienDaChi 
from tbl_customer_info ci
join tbl_customers c on ci.customer_id = c.customer_id; 



