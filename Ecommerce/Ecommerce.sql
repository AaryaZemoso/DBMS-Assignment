drop database if exists `Ecommerce`;

create database `Ecommerce`;
use `Ecommerce`;

create table `Supplier`(

	SupplierID int primary key,
    SupplierName varchar(45),
    SupplierAddress varchar(200),
    SupplierPhone varchar(10)
);

create table `Customer`(

	CustomerID int primary key,
    CustomerName varchar(45),
    CustomerPhone varchar(10),
    CustomerAddress varchar(200)
    
);

create table `Items`(

	ItemID int primary key,
    ItemName varchar(45),
    ItemPrice float
    
);

create table `Order`(

	OrderID int primary key,
    PaymentMethod varchar(30),
    Discount float
);

create table `SupplierItems`(

	SupplierID int,
    ItemID int,
    Quantity int,
    
    primary key(SupplierID, ItemID),
    
    foreign key (SupplierID) references `Supplier`(SupplierID),
    foreign key (ItemID) references `Items`(ItemID)
);

create table `CustomerOrders`(

	CustomerID int,
    OrderID int,
    
    primary key(CustomerID, OrderID),
    
    foreign key (CustomerID) references `Customer`(CustomerID),
    foreign key (OrderID) references `Order`(OrderID)
);

create table `OrderItems`(

	OrderID int,
    ItemID int,
    Quantity int,
    
    primary key(OrderID, ItemID),
    
    foreign key (OrderID) references `Order`(OrderID),
    foreign key (ItemID) references `Items`(ItemID)
);