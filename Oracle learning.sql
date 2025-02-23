/* tablo olusturma */
create table deneme (
isim     varchar(50), 
soyisim  varchar(50),
yas      number(3) NOT NULL,
mail     varchar(100) PRIMARY KEY
);

create table veri_tipi (
tc_no char(11),
telefon char(200)
);

/* tabloya veri ekleme */
INSERT INTO veri_tipi(telefon) VALUES ('05074865868');
