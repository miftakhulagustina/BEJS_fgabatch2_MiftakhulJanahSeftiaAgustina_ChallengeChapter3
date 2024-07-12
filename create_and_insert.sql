create extension if not exists "uuid-ossp"

--Create Table	 ----
create table customer(
	customer_id BIGSERIAL primary key not null,
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
	customer_id int not null,
	foreign key (address_type_id) references address_type(address_type_id),
	foreign key (customer_id) references customer(customer_id)
);

create table account_type(
	account_type_id BIGSERIAL primary key not null,
	account_type_name varchar(255) unique not null,
	description varchar(255)
);

create table account(
	account_id BIGSERIAL primary key not null,
	account_name varchar(255) unique not null,
	account_number uuid default uuid_generate_v4(),
	account_balance decimal(15) default 0,
	created_at timestamp default current_timestamp,
	account_type_id int not null,
	customer_id int not null,
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
	account_id int not null,
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
('Jalan Bendul Merisi',3,1), 
('Jalan Margorejo',4,1), 
('Jalan Sidosermo',3,2),
('Jalan Sidosermo',3,3);

insert into account_type(account_type_name, description) 
values 
('Saving','A savings account for storing money with interest'),
('Checking','A checking account for daily transactions'),
('Deposito','A fixed-term deposit account offering higher interest rates for a set period'),
('Credit', 'A credit account for borrowing money');

insert into account(account_name, account_balance, account_type_id, customer_id)
values ('miftakhul_1', 1000000, 1, 1),
('miftakhul_2', 2000000, 2, 1),
('rendy_1', 150000, 3, 2),
('aldi_1', 1000000, 2, 3);

insert into transaction_type(trans_type_name) 
values 
('Deposit'), 
('Withdrawal'), 
('Transfer'),
('Top-Up')

insert into transaction(description, amount , account_id, trans_type_id) 
values
('ATM Withdrawal', '200000', 1, 2),
('Top-up e-walet', '100000', 3, 4),
('Bank transfer from ABC to BCE','300000', 4,3)



--Show table --
select * from customer 
select * from address
select * from address_type
select * from account
select * from account_type 
select * from transaction
select * from transaction_type 
