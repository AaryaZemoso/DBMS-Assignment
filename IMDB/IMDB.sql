drop database if exists `IMDB`;

create database `IMDB`;
use `IMDB`;

create table `Actor`(

	ActorID int primary key,
    ActorName varchar(50),
    ActorOriginalName varchar(50),
    ActorContact varchar(10)
    
);


create table `Movie`(
	
    MovieID int primary key,
    MovieName varchar(40),
    MovieDirector varchar(100),
    MovieLength varchar(20)    
);

create table `TVSeries`(

	TVSeriesID int primary key,
    TVSeriesName varchar(50),
    TVSeriesNoOfSeasons int,
    TVSeriesNoOfEpisodes int,
    TVSeriesAirDate date
);

create table `MovieActors`(
	
    MovieID int primary key,
    ActorID int unique,
    
    foreign key (MovieID) references `Movie`(MovieID),
    foreign key (ActorID) references `Actor`(ActorID)
    
);

create table `TVSeriesActors`(

	TVSeriesID int primary key,
    ActorID int unique,
    
    foreign key (TVSeriesID) references `TVSeries`(TVSeriesID),
    foreign key (ActorID) references `Actor`(ActorID)
);