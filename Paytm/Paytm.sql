drop database if exists `Paytm`;

create database `Paytm`;
use `Paytm`;


create table `Customer`(

	CustomerID int primary key,
    CustomerName varchar(40),
    CustomerAddress varchar(200),
    CustomerPhone varchar(10),
    CustomerEmail varchar(50)
    
);

create table `Account`(

	AccountID int primary key,
    AccountNumber varchar(15),
    AccountBalance float
);

create table `Branch`(
	
    BranchID int primary key,
    BranchName varchar(30),
    BranchCode varchar(5),
    BranchManager varchar(40),
    BranchContact varchar(10)
    
);

create table `BankingAccounts`(

	BranchID int not null,
    AccountID int not null,
    PrimaryCustomerID int not null,
    
    SecondaryCustomerID int,
    
    primary key (BranchID, AccountID, PrimaryCustomerID),
    
    foreign key (BranchID) references `Branch`(BranchID),
    foreign key (AccountID) references `Account`(AccountID),
    foreign key (PrimaryCustomerID) references `Customer`(CustomerID),
    
    foreign key (SecondaryCustomerID) references `Customer`(CustomerID)
);