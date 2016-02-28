create database sample;
use sample;

create table range (
  id int IDENTITY(1,1) PRIMARY key,
  begin_at datetime,
  end_at   datetime
)

create table event (
  id int IDENTITY(1,1) PRIMARY key,
  event_at datetime
)


create table rel (
  id int IDENTITY(1,1) PRIMARY KEY,
  event_id int UNIQUE,
  range_id int
)

create table rel_improved (
  id int IDENTITY(1,1) PRIMARY KEY,
  event_id int UNIQUE,
  range_id int
)
