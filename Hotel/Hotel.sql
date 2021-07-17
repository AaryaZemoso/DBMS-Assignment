drop database if exists `Hotel Booking`;

create database `Hotel Booking`;
use `Hotel Booking`;

create table `Hotel`(

	HotelID int primary key,
    HotelName varchar(45),
    HotelPhone varchar(10),
    HotelEmail varchar(30),
    HotelAddress varchar(200)

);

create table Customer(

	CustomerID int primary key,
    CustomerName varchar(45),
    CustomerEmail varchar(30),
    CustomerPhone varchar(10)

);

create table `Booking`(
	
    HotelID int,
    CustomerID int,
    
    foreign key (HotelID) references `Hotel`(HotelID),
    foreign key (CustomerID) references `Customer`(CustomerID)
);


create table `CustomerType`(
	TypeID int primary key,
    TypeName varchar(30)
);

insert into `CustomerType` values(1, 'First Time'), (2, 'Loyal');


create table `Visited`(

    HotelID int,
    CustomerID int,
	TypeOfCustomer int,
  
    primary key(HotelID, CustomerID),
    
    foreign key (HotelID) references `Hotel`(HotelID),
    foreign key (CustomerID) references `Customer`(CustomerID),
    foreign key (TypeOfCustomer) references `CustomerType`(TypeID)
);





delimiter $$

-- Check if the customer is already booked in another hotel.
-- NOTE : We are assuming that the customer record gets deleted from Booking table once he checksout. 

create trigger `CheckIfAlreadyBooked` before insert on `Booking`
for each row
	begin
		if (HotelID, CustomerID) in (select HotelID, CustomerID from `Booking`) then
			signal sqlstate '45000' set message_text = "Already Booked";
        end if;
    end;
    
$$

-- Setting the customer to First time if the record doesnt exist in the Visited Table
-- Or Updating the value to Loyal Customer if the record already exists in the Visited Table. 

create trigger `ChangeCustomerType` before insert on `Booking`
for each row 
	begin
		if (HotelID, CustomerID) in (select HotelID, CustomerID from `Visited`) then
			update `Visited` set TypeOfCustomer = 2;
		else
			insert into `Visited` values (HotelID, CustomerID, 1);
        end if;
    end;
    
$$