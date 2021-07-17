drop database if exists `IRCTC`;

create database `IRCTC`;

use `IRCTC`;

create table `Train`(
	
    TrainID int primary key,
    TrainName varchar(30),
    StartStation varchar(30),
    EndStation varchar(30),
    SeatsAvailable int

);

create table `Customer`(
	
    CustomerID int primary key,
    CustomerName varchar(30),
    CustomerPhone varchar(10),
    CustomerEmail varchar(30)

);

create table `Ticket`(
	
    TicketID int primary key,
    FromStation varchar(30),
    ToStation varchar(30)
    
);

create table `ReservedTicket`(
	
    TicketID int,
    CustomerID int,
    TrainID int,
    
    CoachNo varchar(5),
    SeatNo varchar(3),
    Berth varchar(15),
    
    foreign key (TicketID) references `Ticket`(TicketID),
    foreign key (CustomerID) references `Customer`(CustomerID),
    foreign key (TrainID) references `Train`(TrainID),
    
    primary key(TicketID, CustomerID, TrainID)
);

create table `UnreservedTicket`(

	TicketID int,
    CustomerID int,
    
    primary key(TicketID, CustomerID),
    
    foreign key (TicketID) references `Ticket`(TicketID),
    foreign key (CustomerID) references `Customer`(CustomerID)

);

-- Checking if the Customer has already booked using triggers before adding it into the reserved table
-- Raising an exception so that it halts the execution  

drop trigger if exists `CheckIfCustomerAlreadyBooked`;

delimiter $$

create trigger `CheckIfCustomerAlreadyBooked` before insert
on `ReservedTicket`
for each row 
	begin
		if CustomerID in (select CustomerID from `ReservedTicket`) then
			signal sqlstate '45000' set message_text = "Already Booked a ticket";
		end if;
	end;
	
$$

delimiter ;