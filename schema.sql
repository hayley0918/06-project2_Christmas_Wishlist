create database wishlist;

create table users(
    id serial primary key,
    email text
);

create table items(
    id serial primary key,
    name text,
    image_url text,
    price real,
    reason text
);

insert into items(name, image_url, price, reason) values('nintendo switch', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQtwxl6foYAyptHHffx6yYwSAtjw66i_32hBvQxpZEfCOlOWrqR&usqp=CAU', 300, 'i want to play animal crossing');
insert into items(name, image_url, price, reason) values('camera', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTR2HpqULp0ufD5dtBUz854Yidy8QOz8WhZ2LC6JacHcMeYBnCN&usqp=CAU', 500, 'i want to make my own youtube channel');
insert into items(name, image_url, price, reason) values('wireless earphones', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQzpfJc8ZmAUzhVsEmizUkK5t9soxH5WQ3t4oP6TVko28UI1zAk&usqp=CAU', 200, 'i want to listen to music comfortably');

alter table users add column password_digest text;
alter table items add column user_id integer;


digest dinasour