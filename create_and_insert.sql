create extension if not exists "uuid-ossp";

--Create Table	 ----
create table customer(
	customer_id uuid primary key default uuid_generate_v4(),
	first_name varchar(255) not null,
	last_name varchar(255),
	birth_of_date date,
	gender varchar(10),
	phone varchar(20) unique not null,
	email varchar(50) unique not null
);

create table address_type(
	address_type_id BIGSERIAL primary key not null,
	address_type_name varchar(255) unique not null
);

create table address(
	address_id BIGSERIAL primary key not null,
	street varchar(255) not null,
	city varchar(50),
	province varchar(50),
	postal_code varchar(10),
	address_type_id int not null,
	customer_id uuid not null,
	foreign key (address_type_id) references address_type(address_type_id),
	foreign key (customer_id) references customer(customer_id)
);

create table account_type(
	account_type_id BIGSERIAL primary key not null,
	account_type_name varchar(255) unique not null,
	description varchar(255)
);

create table account(
	account_id uuid primary key default uuid_generate_v4(),
	account_name varchar(255) unique not null,
	account_number uuid default uuid_generate_v4(),
	account_balance decimal(15) default 0,
	created_at timestamp default current_timestamp,
	account_type_id int not null,
	customer_id uuid not null,
	foreign key (account_type_id) references account_type(account_type_id),
	foreign key (customer_id) references customer(customer_id)
);

create table transaction_type(
	trans_type_id BIGSERIAL primary key not null,
	trans_type_name varchar(20) unique not null
);

create table transaction(
	trans_id BIGSERIAL primary key not null,
	description varchar(255) not null,
	trans_date timestamp default current_timestamp,
	amount decimal(15) default 0,
	account_id uuid not null,
	trans_type_id int not null,
	foreign key (account_id) references account(account_id),
	foreign key (trans_type_id) references transaction_type(trans_type_id)
);

--Insert Data -----

insert into address_type(address_type_name) 
values 
('domisili'),
('ktp'),
('kantor'),
('lainnya')

insert into customer(first_name, last_name, birth_of_date, gender,phone,email)
values 
('miftakhul','agustina','1999-08-31','Perempuan','03747627364','xxx@gmail.com'),
('rendy','','2004-01-01','Laki-Laki','01230908883','xxx123@gmail.com'),
('aldi','faisal','1990-12-11','Laki-laki','08239777777','xxxyyy@gmail.com')

insert into address(street, address_type_id, customer_id) 
values 
('Jalan Bendul Merisi',3,'660ea042-22c8-4246-b6e6-30fc542b574c'), 
('Jalan Margorejo',4,'660ea042-22c8-4246-b6e6-30fc542b574c'), 
('Jalan Sidosermo',3,'123e1c07-1878-413d-bc47-94ea59f049ec'),
('Jalan Sidosermo',3,'4c267b70-c80d-47a8-a2c9-8394a29e550e');

insert into account_type(account_type_name, description) 
values 
('Saving','A savings account for storing money with interest'),
('Checking','A checking account for daily transactions'),
('Deposito','A fixed-term deposit account offering higher interest rates for a set period'),
('Credit', 'A credit account for borrowing money');

insert into account(account_name, account_balance, account_type_id, customer_id)
values ('miftakhul_1', 1000000, 1, '660ea042-22c8-4246-b6e6-30fc542b574c'),
('miftakhul_2', 2000000, 2, '660ea042-22c8-4246-b6e6-30fc542b574c'),
('rendy_1', 150000, 3, '123e1c07-1878-413d-bc47-94ea59f049ec'),
('aldi_1', 1000000, 2, '4c267b70-c80d-47a8-a2c9-8394a29e550e');

insert into transaction_type(trans_type_name) 
values 
('Deposit'), 
('Withdrawal'), 
('Transfer'),
('Top-Up')

insert into transaction(description, amount , account_id, trans_type_id) 
values
('ATM Withdrawal', '200000', 'bd5b91bd-82d3-4993-b962-14889e81a4f2', 2),
('Top-up e-walet', '100000', '5e83aa47-6766-4745-9754-315b532fbe28', 4),
('Bank transfer from ABC to BCE','300000', 'e40eccd4-f8f0-4bd3-abe9-8ac63e65279b',3);

--Update data --
update address set city = 'Surabaya', province = 'Jawa Timur' where address_id = 1;
update address set city = 'Surabaya', province = 'Jawa Timur' where address_id = 3;
update address set city = 'Surabaya' where address_id = 4;
update address set street = 'Jl S. Soepriyadi', city = 'Blitar', province = 'Jawa Timur', postal_code = '66152' where address_id = 1;
update address set postal_code = '60238' where address_id = 2;


--Show table --
select * from customer 
select * from address
select * from address_type
select * from account
select * from account_type 
select * from transaction
select * from transaction_type 


--Query SQL --
--Show customer with address --
select 
	a.first_name, 
	a.last_name, 
	a.birth_of_date, 
	a.gender, 
	a.phone, 
	a.email, 
	b.street, 
	c.address_type_name 
from customer a 
join address b on a.customer_id = b.customer_id 
join address_type c on b.address_type_id = c.address_type_id 

--Show customer with account --
select 
	a.first_name, 
	a.last_name, 
	a.email, 
	b.account_number,
	b.account_balance,
	c.account_type_name 
from customer a 
left join account b on a.customer_id = b.customer_id 
left join account_type c on b.account_type_id = c.account_type_id 

--Show customer with transaction --
select 
	a.first_name, 
	a.last_name, 
	a.email, 
	b.account_number,
	c.description,
	c.trans_date,
	c.amount,
	d.trans_type_name 
from customer a 
left join account b on a.customer_id = b.customer_id 
left join transaction c on b.account_id = c.account_id 
left join transaction_type d on c.trans_type_id = d.trans_type_id 