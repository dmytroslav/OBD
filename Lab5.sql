-- Створення ролі "Агент нерухомості"
CREATE ROLE agent_role;

-- Створення ролі "Банкір"
CREATE ROLE banker_role;

-- Створення ролі "Орендар"
CREATE ROLE tenant_role;



-- Привілеї на таблицю "apartmentType"
GRANT INSERT, UPDATE, SELECT ON apartmentType TO agent_role;

-- Привілеї на таблицю "apartment"
GRANT INSERT, UPDATE, SELECT ON apartment TO agent_role;

-- Привілеї на таблицю "bank"
GRANT INSERT, UPDATE, SELECT ON bank TO banker_role;

-- Привілеї на таблицю "tenant"
GRANT INSERT, UPDATE, SELECT ON tenant TO tenant_role;

-- Привілеї на таблицю "rent"
GRANT SELECT ON rent TO tenant_role;

-- Привілеї на таблицю "counts"
GRANT SELECT ON counts TO tenant_role;



-- Створення користувача
CREATE LOGIN agent_user WITH PASSWORD = 'password';

-- Створення облікового запису користувача в базі даних
CREATE USER agent_user FOR LOGIN agent_user;

-- Надання ролі "Агент нерухомості" користувачу
EXEC sp_addrolemember 'agent_role', 'agent_user';

-- Створення користувача
CREATE LOGIN banker_user WITH PASSWORD = 'password';

-- Створення облікового запису користувача в базі даних
CREATE USER banker_user FOR LOGIN banker_user;

-- Надання ролі "Банкір" користувачу
EXEC sp_addrolemember 'banker_role', 'banker_user';

-- Створення користувача
CREATE LOGIN tenant_user WITH PASSWORD = 'password';

-- Створення облікового запису користувача в базі даних
CREATE USER tenant_user FOR LOGIN tenant_user;

-- Надання ролі "Орендар" користувачу
EXEC sp_addrolemember 'tenant_role', 'tenant_user';



-- Відкликати привілеї у користувача "agent_user", які були призначені через роль "agent_role"
REVOKE SELECT, INSERT, UPDATE, DELETE ON apartment FROM agent_user;
REVOKE SELECT, INSERT, UPDATE, DELETE ON tenant FROM agent_user;
REVOKE SELECT, INSERT, UPDATE, DELETE ON rent FROM agent_user;
REVOKE SELECT, INSERT, UPDATE, DELETE ON counts FROM agent_user;

-- Відкликати привілеї у користувача "banker_user", які були призначені через роль "banker_role"
REVOKE SELECT, INSERT, UPDATE, DELETE ON bank FROM banker_user;

-- Відкликати привілеї у користувача "tenant_user", які були призначені через роль "tenant_role"
REVOKE SELECT, INSERT, UPDATE, DELETE ON rent FROM tenant_user;
REVOKE SELECT, INSERT, UPDATE, DELETE ON counts FROM tenant_user;

-- Відкликати роль "Агент нерухомості" у користувача "agent_user"
ALTER ROLE agent_role DROP MEMBER agent_user;

-- Відкликати роль "Банкір" у користувача "banker_user"
ALTER ROLE banker_role DROP MEMBER banker_user;

-- Відкликати роль "Орендар" у користувача "tenant_user"
ALTER ROLE tenant_role DROP MEMBER tenant_user;



-- Видалення користувача "agent_user"
DROP USER agent_user;

-- Видалення користувача "banker_user"
DROP USER banker_user;

-- Видалення користувача "tenant_user"
DROP USER tenant_user;