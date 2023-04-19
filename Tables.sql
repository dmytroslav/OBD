CREATE TABLE apartmentType(
TypeID INT PRIMARY KEY not null,
TypeNames VARCHAR(200)not null,
TypePrice int not null,
)
CREATE TABLE apartment(
ApartmentID INT PRIMARY KEY not null,
ApartmentNumber VARCHAR(200) not null,
ApartmentArea FLOAT not null,
TypeID INT not null,
foreign key (TypeID) references apartmentType(TypeID)
)
create table bank(
BankID INT PRIMARY KEY not null,
BankName VARCHAR(200),
Registrationcod int unique not null
)
CREATE TABLE tenant(
TenantID INT PRIMARY KEY not null,
TenantNames VARCHAR(200) not null,
TenantlegalAddress varchar(200) unique not null,
BankID int not null,
BankDirector varchar(200) not null,
Characteristic varchar,
foreign key(BankID)references bank(BankID)
)
CREATE TABLE rent(
RentID INT PRIMARY KEY not null,
TenantID int not null,
ApartmentID int not null,
Termfrom date not null,
Termupto date not null,
foreign key(TenantID)references tenant(TenantID),
foreign key(ApartmentID)references apartment(ApartmentID)

)

create table counts(
CountsID INT PRIMARY KEY not null,
CountsSumma int not null,
CountsData date not null,
CountsPenia int not null,
TenantID int not null,
foreign key(TenantID)references tenant(TenantID)
)