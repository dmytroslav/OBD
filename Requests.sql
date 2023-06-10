SELECT CountsSumma, CountsData, CountsPenia 
From counts
WHERE (CountsData = '2022-04-04' OR CountsData = '2022-03-04')
AND CountsSumma > 2000 -- ¬ибираЇ суму, дату та пеню з таблиц≥ "counts", де дата Ї '2022-04-04' або '2022-03-04', а сума б≥льша за 2000.
SELECT CountsSumma, CountsData, CountsPenia, CountsSumma * CountsPenia as debt from counts -- ¬ибираЇ суму, дату, пеню та обчислюЇ заборгован≥сть (сума помножена на пеню) з таблиц≥ "counts".
SELECT *
FROM counts
INNER JOIN tenant ON counts.TenantID = tenant.TenantID
WHERE (counts.CountsSumma = '1020 ' OR tenant.TenantNames = 'NAP')
AND counts.CountsData = '2020-08-04'
ORDER BY CountsSumma ASC; -- ¬ибираЇ вс≥ пол€ з таблиць "counts" ≥ "tenant", де сума рахунку дор≥внюЇ '1020' або назва орендар€ Ї 'NAP', а також дата рахунку Ї '2020-08-04', сортуЇ за зростанн€м суми.
SELECT *
FROM tenant
LEFT JOIN rent ON tenant.TenantID = rent.TenantID; -- ¬ибираЇ вс≥ пол€ з таблиць "tenant" ≥ "rent", зд≥йснюЇ л≥ве з'Їднанн€ за полем "TenantID".
SELECT *
FROM bank
WHERE BankName LIKE '%Oshad%'-- ¬ибираЇ вс≥ пол€ з таблиц≥ "bank", де назва банку м≥стить р€док 'Oshad'.
SELECT *
FROM rent
WHERE Termfrom BETWEEN '2021-03-03' AND '2022-02-03';
SELECT *
FROM apartment
WHERE ApartmentArea IN ('150', '100'); -- ¬ибираЇ вс≥ пол€ з таблиц≥ "apartment", де площа квартири Ї '150' або '100'.
SELECT *
FROM counts p
WHERE EXISTS (
      SELECT 1
      FROM counts
      WHERE CountsData > '2021-08-01' AND CountsID = p.CountsID); -- ¬ибираЇ вс≥ пол€ з таблиц≥ "counts" з псевдон≥мом "p", де ≥снуЇ запис з таблиц≥ "counts", де дата б≥льша за '2021-08-01
SELECT *
FROM apartment
WHERE TypeID = ALL (SELECT TypeID FROM apartmentType WHERE TypeNames LIKE 'room'); -- ¬ибираЇ вс≥ пол€ з таблиц≥ "apartment", де поле "TypeID" дор≥внюЇ вс≥м значенн€м, отриманим з п≥дзапиту, €кий вибираЇ "TypeID" з таблиц≥ "apartmentType" з умовою, що "TypeNames" м≥стить р€док 'room'.
SELECT *
FROM apartment
WHERE ApartmentID = ANY (SELECT TypeID FROM apartmentType WHERE ApartmentArea = '100'); -- ¬ибираЇ вс≥ пол€ з таблиц≥ "apartment", де поле "ApartmentID" дор≥внюЇ будь-€кому значенню, отриманому з п≥дзапиту, €кий вибираЇ "TypeID" з таблиц≥ "apartmentType" з умовою, що "ApartmentArea" дор≥внюЇ '100'.

SELECT CountsSumma, SUM (CountsPenia) as total
FROM  counts
GROUP BY CountsSumma -- ¬ибираЇ суму рахунку ≥ суму пен≥ з таблиц≥ "counts" та об'ЇднуЇ записи за значенн€м "CountsSumma".

SELECT TenantNames, TenantlegalAddress, Characteristic
FROM tenant
WHERE BankID IN (SELECT BankID FROM bank WHERE BankName = 'Privat24'); -- ¬ибираЇ пол€ "TenantNames", "TenantlegalAddress" ≥ "Characteristic" з таблиц≥ "tenant", де значенн€ "BankID" м≥ститьс€ в п≥дзапит≥, €кий вибираЇ "BankID" з таблиц≥ "bank" з умовою, що "BankName" дор≥внюЇ 'Privat24'.

SELECT t1.CountsSumma, t2.total
FROM counts t1, (SELECT SUM(TypePrice) as total FROM apartmentType) t2; -- ¬ибираЇ пол€ "CountsSumma" з таблиц≥ "counts" з псевдон≥мом "t1" ≥ поле "total" з п≥дзапиту, €кий обчислюЇ загальну суму "TypePrice" з таблиц≥ "apartmentType" з псевдон≥мом "t2".-- ¬ибираЇ пол€ "CountsSumma" з таблиц≥ "counts" з псевдон≥мом "t1" ≥ поле "total" з п≥дзапиту, €кий обчислюЇ загальну суму "TypePrice" з таблиц≥ "apartmentType" з псевдон≥мом "t2".



WITH apartment_tree AS (
  SELECT ApartmentID, ApartmentNumber, ApartmentArea, TypeID FROM apartment WHERE ApartmentID = 1
  UNION ALL
  SELECT c.ApartmentID, c.ApartmentNumber, c.ApartmentArea, c.TypeID
  FROM apartment c
  JOIN apartment_tree s ON c.TypeID = s.TypeID
)

SELECT * FROM apartment_tree; -- ¬икористовуЇ рекурсивний CTE дл€ створенн€ ≥Їрарх≥њ квартир, починаючи з квартири з ID



SELECT
  Characteristic,
  SUM(CASE WHEN TenantNames = 'VDS' AND TenantlegalAddress = '”крањна, **1, м≥сто  ињв, ¬”Ћ»÷я √–”Ў≈¬—№ ќ√ќ, будинок **ƒ' THEN TenantID ELSE 0 END) AS "VDS - ”крањна, **1, м≥сто  ињв, ¬”Ћ»÷я √–”Ў≈¬—№ ќ√ќ, будинок **ƒ",
  SUM(CASE WHEN TenantNames = 'NAP' AND TenantlegalAddress = '”крањна, **1, м≥сто  ињв, ¬”Ћ»÷я √–”Ў≈¬—№ ќ√ќ, будинок **ƒ' THEN TenantID ELSE 0 END) AS "NAP - ”крањна, **1, м≥сто  ињв, ¬”Ћ»÷я √–”Ў≈¬—№ ќ√ќ, будинок **ƒ"
  
FROM  tenant
GROUP BY Characteristic; -- ¬ибираЇ характеристику, обчислюЇ суму TenantID дл€ орендар≥в "VDS" та "NAP" з вказаною адресою, групуЇ за характеристикою.

UPDATE counts
SET CountsPenia = CountsPenia + 5
WHERE CountsID = 2; -- ќновлюЇ значенн€ пол€ "CountsPenia" у таблиц≥ "counts", додаючи 5 до поточного значенн€, дл€ запису з "CountsID" р≥вним 2.

UPDATE counts
SET CountsSumma = CountsSumma + 5
FROM tenant
WHERE tenant.TenantID = counts.TenantID AND tenant.TenantNames = 'VDS';  -- оновлюЇ значенн€ суми до сплати разом з пеньою


insert into bank (BankID, BankName, Registrationcod)
values (3,'Maths', 4789);	

insert into apartmentType(TypeID, TypeNames, TypePrice) 
select 4, ApartmentNumber, 1020
from apartment
where ApartmentID = 2;

DELETE FROM apartmentType;

DELETE FROM apartment
WHERE ApartmentNumber = 2; -- ¬идал€Ї вс≥ р€дки з таблиц≥
