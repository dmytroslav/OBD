SELECT CountsSumma, CountsData, CountsPenia 
From counts
WHERE (CountsData = '2022-04-04' OR CountsData = '2022-03-04')
AND CountsSumma > 2000 -- ������ ����, ���� �� ���� � ������� "counts", �� ���� � '2022-04-04' ��� '2022-03-04', � ���� ����� �� 2000.
SELECT CountsSumma, CountsData, CountsPenia, CountsSumma * CountsPenia as debt from counts -- ������ ����, ����, ���� �� �������� ������������� (���� ��������� �� ����) � ������� "counts".
SELECT *
FROM counts
INNER JOIN tenant ON counts.TenantID = tenant.TenantID
WHERE (counts.CountsSumma = '1020 ' OR tenant.TenantNames = 'NAP')
AND counts.CountsData = '2020-08-04'
ORDER BY CountsSumma ASC; -- ������ �� ���� � ������� "counts" � "tenant", �� ���� ������� ������� '1020' ��� ����� �������� � 'NAP', � ����� ���� ������� � '2020-08-04', ����� �� ���������� ����.
SELECT *
FROM tenant
LEFT JOIN rent ON tenant.TenantID = rent.TenantID; -- ������ �� ���� � ������� "tenant" � "rent", ������� ��� �'������� �� ����� "TenantID".
SELECT *
FROM bank
WHERE BankName LIKE '%Oshad%'-- ������ �� ���� � ������� "bank", �� ����� ����� ������ ����� 'Oshad'.
SELECT *
FROM rent
WHERE Termfrom BETWEEN '2021-03-03' AND '2022-02-03';
SELECT *
FROM apartment
WHERE ApartmentArea IN ('150', '100'); -- ������ �� ���� � ������� "apartment", �� ����� �������� � '150' ��� '100'.
SELECT *
FROM counts p
WHERE EXISTS (
      SELECT 1
      FROM counts
      WHERE CountsData > '2021-08-01' AND CountsID = p.CountsID); -- ������ �� ���� � ������� "counts" � ���������� "p", �� ���� ����� � ������� "counts", �� ���� ����� �� '2021-08-01
SELECT *
FROM apartment
WHERE TypeID = ALL (SELECT TypeID FROM apartmentType WHERE TypeNames LIKE 'room'); -- ������ �� ���� � ������� "apartment", �� ���� "TypeID" ������� ��� ���������, ��������� � ��������, ���� ������ "TypeID" � ������� "apartmentType" � ������, �� "TypeNames" ������ ����� 'room'.
SELECT *
FROM apartment
WHERE ApartmentID = ANY (SELECT TypeID FROM apartmentType WHERE ApartmentArea = '100'); -- ������ �� ���� � ������� "apartment", �� ���� "ApartmentID" ������� ����-����� ��������, ���������� � ��������, ���� ������ "TypeID" � ������� "apartmentType" � ������, �� "ApartmentArea" ������� '100'.

SELECT CountsSumma, SUM (CountsPenia) as total
FROM  counts
GROUP BY CountsSumma -- ������ ���� ������� � ���� ��� � ������� "counts" �� ��'���� ������ �� ��������� "CountsSumma".

SELECT TenantNames, TenantlegalAddress, Characteristic
FROM tenant
WHERE BankID IN (SELECT BankID FROM bank WHERE BankName = 'Privat24'); -- ������ ���� "TenantNames", "TenantlegalAddress" � "Characteristic" � ������� "tenant", �� �������� "BankID" �������� � �������, ���� ������ "BankID" � ������� "bank" � ������, �� "BankName" ������� 'Privat24'.

SELECT t1.CountsSumma, t2.total
FROM counts t1, (SELECT SUM(TypePrice) as total FROM apartmentType) t2; -- ������ ���� "CountsSumma" � ������� "counts" � ���������� "t1" � ���� "total" � ��������, ���� �������� �������� ���� "TypePrice" � ������� "apartmentType" � ���������� "t2".-- ������ ���� "CountsSumma" � ������� "counts" � ���������� "t1" � ���� "total" � ��������, ���� �������� �������� ���� "TypePrice" � ������� "apartmentType" � ���������� "t2".



WITH apartment_tree AS (
  SELECT ApartmentID, ApartmentNumber, ApartmentArea, TypeID FROM apartment WHERE ApartmentID = 1
  UNION ALL
  SELECT c.ApartmentID, c.ApartmentNumber, c.ApartmentArea, c.TypeID
  FROM apartment c
  JOIN apartment_tree s ON c.TypeID = s.TypeID
)

SELECT * FROM apartment_tree; -- ����������� ����������� CTE ��� ��������� �������� �������, ��������� � �������� � ID



SELECT
  Characteristic,
  SUM(CASE WHEN TenantNames = 'VDS' AND TenantlegalAddress = '������, **1, ���� ���, ������ ������������, ������� **�' THEN TenantID ELSE 0 END) AS "VDS - ������, **1, ���� ���, ������ ������������, ������� **�",
  SUM(CASE WHEN TenantNames = 'NAP' AND TenantlegalAddress = '������, **1, ���� ���, ������ ������������, ������� **�' THEN TenantID ELSE 0 END) AS "NAP - ������, **1, ���� ���, ������ ������������, ������� **�"
  
FROM  tenant
GROUP BY Characteristic; -- ������ ��������������, �������� ���� TenantID ��� �������� "VDS" �� "NAP" � �������� �������, ����� �� ���������������.

UPDATE counts
SET CountsPenia = CountsPenia + 5
WHERE CountsID = 2; -- ������� �������� ���� "CountsPenia" � ������� "counts", ������� 5 �� ��������� ��������, ��� ������ � "CountsID" ����� 2.

UPDATE counts
SET CountsSumma = CountsSumma + 5
FROM tenant
WHERE tenant.TenantID = counts.TenantID AND tenant.TenantNames = 'VDS';  -- ������� �������� ���� �� ������ ����� � ������


insert into bank (BankID, BankName, Registrationcod)
values (3,'Maths', 4789);	

insert into apartmentType(TypeID, TypeNames, TypePrice) 
select 4, ApartmentNumber, 1020
from apartment
where ApartmentID = 2;

DELETE FROM apartmentType;

DELETE FROM apartment
WHERE ApartmentNumber = 2; -- ������� �� ����� � �������
