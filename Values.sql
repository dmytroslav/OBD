--insert into apartmentType  (TypeID, TypeNames,TypePrice) values
--(1 ,'room',200),
--(2 ,'warehouse',500);
--select* from apartmentType;
--insert into apartment (ApartmentID, ApartmentNumber,ApartmentArea,TypeID) values (1, 1, 150,1);
--insert into apartment (ApartmentID, ApartmentNumber,ApartmentArea,TypeID) values (2, 2,100,1);
--insert into apartment (ApartmentID, ApartmentNumber,ApartmentArea,TypeID) values (3,3,200,2);
--select* from apartment;
--insert into bank  (BankID, BankName,Registrationcod) values (1, 'Privat24',4567);
--insert into bank (BankID, BankName,Registrationcod) values (2,'Oshad', 1234);
--select* from bank;
--insert into tenant (TenantID, TenantNames,TenantlegalAddress,BankID,BankDirector,Characteristic) values (1, 'BTS','Україна, **1, місто Львів, Вулиця Дорошенка, будинок **А',1,'Petrenko Dmytro Tarasovych',' ');
--insert into tenant (TenantID, TenantNames,TenantlegalAddress,BankID,BankDirector,Characteristic) values (2,'AKA','Україна, **1, місто Київ, ВУЛИЦЯ Героїв УПА, будинок **Д', 2, 'Ochkivskyi Danylo Olegovych','  ');
--select* from tenant;
--insert into counts (CountsID, CountsSumma,CountsData,CountsPenia,TenantID) values 
--(231,20203,'2022-04-04',0,1),
--(432,30250,'2022-03-04',0,1);
--select*from counts;



--insert into rent1 (RentID, TenantID,ApartmentID,Termfrom,Termupto) values 
--(1,1,2,'2022-02-03','2023-02-03'),
--(2,2,1,'2021-02-03','2022-02-03'),
--(3,2,2,'2021-09-07','2022-07-09');    
--select*from rent1; 

  
--insert into rent  (RentID, TenantID,ApartmentID,Termfrom,Termupto) values  
--(1,1,2,'2022-02-03','2023-02-03'),
--(2,2,2,'2021-02-03','2022-02-03');