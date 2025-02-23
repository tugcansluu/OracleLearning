/* tablo olusturma */
create table deneme (
isim     varchar(50), 
soyisim  varchar(50),
yas      number(3) NOT NULL,
mail     varchar(100) PRIMARY KEY
);

create table veri_tipi (
tc_no char(11),
telefon char(11)
);

/* long kullanımı */
create table veri_tipi_2 (
tc_no long,
telefon number(11)
); /*sadece 1 sütun long içerebilir*/

/* tabloya veri ekleme */
INSERT INTO veri_tipi(telefon) VALUES ('05419999999');

/* küsüratlı sayı */
create table veri_tipi_3 (
uzunluk number(5,2)
);

INSERT INTO veri_tipi_3 VALUES (123.32134);

/* date */
create table tarih_ornek (
dogum_tarihi date
);

INSERT INTO tarih_ornek VALUES ('09-11-2002');
/* sysdate sistemin gosterdigi suanki tarihi alir */
select sysdate "SUANKI TARIH", dogum_tarihi from tarih_ornek;

/* deneme */

create table uygulama(
isim    varchar2(15),
soyisim varchar2(30),
dogum   date,
mail    varchar2(65)  UNIQUE ,
tc      char(11)      PRIMARY KEY ,
boy     number(3)
);

INSERT INTO uygulama VALUES ('Tugcan','Uslu','09-11-2002','tugcanslu@gmail.com',11111111111,178);
INSERT INTO uygulama VALUES ('Alp','Unal','09-12-2003','alpunlx@gmail.com',11111111112,180);

/* DML INSERT UPDATE DELETE */

create table dmlornek (
isim varchar2(20),
tc_numara char(11),
numara number(11)
);

INSERT INTO dmlornek VALUES ('Tugcan' ,12345678912,05419999999);
INSERT INTO dmlornek (isim,numara) VALUES ('Alp',05429999999);
/*----------------------------------------------------------*/
create table personel (
adi varchar2(20),
soyad varchar2(20),
tc_no char (11),
mail_Adresi varchar2(65),
tel_no number (11)
);

INSERT INTO personel VALUES ('Tugcan', 'Uslu', 11111111111, 'tugcanslu@gmail.com', 05419999999) ;

SELECT * FROM personel ;
SELECT adi, mail Adresi FROM personel;

SELECT mail Adresi "Mail" FROM personel;

SELECT DISTINCT * FROM personel; /* benzersiz */
