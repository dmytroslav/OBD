--CREATE TRIGGER trg_apartmentType_Insert ON apartmentType AFTER INSERT AS
--BEGIN    UPDATE apartmentType    SET UCR = SYSTEM_USER, DCR = GETDATE(), ULC = SYSTEM_USER, DLC = GETDATE()
--    FROM apartmentType    INNER JOIN inserted ON apartmentType.TypeID = inserted.TypeID;END;

--CREATE TRIGGER trg_apartment_Insert ON apartment
--AFTER INSERT AS
--BEGIN
--    UPDATE apartment    SET UCR = SYSTEM_USER, DCR = GETDATE(), ULC = SYSTEM_USER, DLC = GETDATE()
--    FROM apartment    INNER JOIN inserted ON apartment.ApartmentID = inserted.ApartmentID;
--END;

--CREATE TRIGGER trg_bank_Insert ON bank
--AFTER INSERT AS
--BEGIN
--    UPDATE bank    SET UCR = SYSTEM_USER, DCR = GETDATE(), ULC = SYSTEM_USER, DLC = GETDATE()
--    FROM bank    INNER JOIN inserted ON bank.BankID = inserted.BankID;
--END;

--CREATE TRIGGER trg_apartmentType_Update ON apartmentType
--AFTER UPDATE AS
--BEGIN
--    UPDATE apartmentType    SET ULC = SYSTEM_USER, DLC = GETDATE()
--    FROM apartmentType    INNER JOIN inserted ON apartmentType.TypeID = inserted.TypeID;
--END;

--CREATE TRIGGER trg_apartment_Update ON apartment
--AFTER UPDATE AS
--BEGIN
--    UPDATE apartment    SET ULC = SYSTEM_USER, DLC = GETDATE()
--    FROM apartment    INNER JOIN inserted ON apartment.ApartmentID = inserted.ApartmentID;
--END;

--CREATE TRIGGER trg_bank_Update ON bank
--AFTER UPDATE AS
--BEGIN
--    UPDATE bank    SET ULC = SYSTEM_USER, DLC = GETDATE()
--    FROM bank    INNER JOIN inserted ON bank.BankID = inserted.BankID;
--END;

--CREATE TRIGGER trg_counts_Insert_id ON counts INSTEAD OF INSERT AS
--BEGIN  SET NOCOUNT ON;        
--    INSERT INTO counts  (CountsID, CountsSumma, CountsData, CountsPenia, TenantID)    SELECT NEXT VALUE FOR counts_id_sequence, CountsSumma, CountsData, CountsPenia, TenantID    FROM inserted;
--END;

--CREATE SEQUENCE counts_id_sequence START WITH 1 INCREMENT BY 1;

--CREATE TRIGGER check_duplicate_rent
--ON rent
--INSTEAD OF INSERT
--AS
--BEGIN
--    IF EXISTS (
--        SELECT 1
--        FROM rent r
--        INNER JOIN inserted i ON r.ApartmentID = i.ApartmentID
--        WHERE r.Termfrom <= i.Termupto AND r.Termupto >= i.Termfrom
--    )
--    BEGIN
--        RAISERROR ('The apartment is already rented by another tenant.', 16, 1);
--        ROLLBACK TRANSACTION;
--        RETURN;
--    END;

--    INSERT INTO rent (RentID, TenantID, ApartmentID, Termfrom, Termupto)
--    SELECT RentID, TenantID, ApartmentID, Termfrom, Termupto
--    FROM inserted;
--END;

--CREATE TRIGGER TenantCheckRent
--ON rent1
--INSTEAD OF INSERT
--AS
--BEGIN
--    DECLARE @totalDebt INT;
--    DECLARE @rentSum INT;

--    -- Знаходимо загальний борг орендаря
--    SELECT @totalDebt = SUM(CountsSumma + CountsPenia)
--    FROM counts
--    WHERE TenantID IN (SELECT TenantID FROM inserted);
    
--    -- Знаходимо суму трьохмісячної оренди
--    SELECT @rentSum = TypePrice
--    FROM apartment
--    JOIN apartmentType ON apartment.TypeID = apartmentType.TypeID
--    WHERE ApartmentID IN (SELECT ApartmentID FROM inserted);
    
--    SET @rentSum = @rentSum * 3;
    
--    -- Перевіряємо, чи борг більший, ніж сума трьохмісячної оренди
--    IF @totalDebt > @rentSum
--    BEGIN
--        RAISERROR('Орендар має борг більший, ніж сума трьохмісячної оренди. Отримання нових приміщень в оренду заборонено.', 16, 1);
--        ROLLBACK TRANSACTION;
--        RETURN;
--    END

--    -- Вставка даних
--    INSERT INTO rent1 (RentID, TenantID, ApartmentID, Termfrom, Termupto)
--    SELECT RentID, TenantID, ApartmentID, Termfrom, Termupto
--    FROM inserted;
    
--    COMMIT TRANSACTION;
--END;