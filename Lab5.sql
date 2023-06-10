-- ��������� ��� "����� ����������"
CREATE ROLE agent_role;

-- ��������� ��� "�����"
CREATE ROLE banker_role;

-- ��������� ��� "�������"
CREATE ROLE tenant_role;



-- ������ �� ������� "apartmentType"
GRANT INSERT, UPDATE, SELECT ON apartmentType TO agent_role;

-- ������ �� ������� "apartment"
GRANT INSERT, UPDATE, SELECT ON apartment TO agent_role;

-- ������ �� ������� "bank"
GRANT INSERT, UPDATE, SELECT ON bank TO banker_role;

-- ������ �� ������� "tenant"
GRANT INSERT, UPDATE, SELECT ON tenant TO tenant_role;

-- ������ �� ������� "rent"
GRANT SELECT ON rent TO tenant_role;

-- ������ �� ������� "counts"
GRANT SELECT ON counts TO tenant_role;



-- ��������� �����������
CREATE LOGIN agent_user WITH PASSWORD = 'password';

-- ��������� ��������� ������ ����������� � ��� �����
CREATE USER agent_user FOR LOGIN agent_user;

-- ������� ��� "����� ����������" �����������
EXEC sp_addrolemember 'agent_role', 'agent_user';

-- ��������� �����������
CREATE LOGIN banker_user WITH PASSWORD = 'password';

-- ��������� ��������� ������ ����������� � ��� �����
CREATE USER banker_user FOR LOGIN banker_user;

-- ������� ��� "�����" �����������
EXEC sp_addrolemember 'banker_role', 'banker_user';

-- ��������� �����������
CREATE LOGIN tenant_user WITH PASSWORD = 'password';

-- ��������� ��������� ������ ����������� � ��� �����
CREATE USER tenant_user FOR LOGIN tenant_user;

-- ������� ��� "�������" �����������
EXEC sp_addrolemember 'tenant_role', 'tenant_user';



-- ³�������� ������ � ����������� "agent_user", �� ���� ��������� ����� ���� "agent_role"
REVOKE SELECT, INSERT, UPDATE, DELETE ON apartment FROM agent_user;
REVOKE SELECT, INSERT, UPDATE, DELETE ON tenant FROM agent_user;
REVOKE SELECT, INSERT, UPDATE, DELETE ON rent FROM agent_user;
REVOKE SELECT, INSERT, UPDATE, DELETE ON counts FROM agent_user;

-- ³�������� ������ � ����������� "banker_user", �� ���� ��������� ����� ���� "banker_role"
REVOKE SELECT, INSERT, UPDATE, DELETE ON bank FROM banker_user;

-- ³�������� ������ � ����������� "tenant_user", �� ���� ��������� ����� ���� "tenant_role"
REVOKE SELECT, INSERT, UPDATE, DELETE ON rent FROM tenant_user;
REVOKE SELECT, INSERT, UPDATE, DELETE ON counts FROM tenant_user;

-- ³�������� ���� "����� ����������" � ����������� "agent_user"
ALTER ROLE agent_role DROP MEMBER agent_user;

-- ³�������� ���� "�����" � ����������� "banker_user"
ALTER ROLE banker_role DROP MEMBER banker_user;

-- ³�������� ���� "�������" � ����������� "tenant_user"
ALTER ROLE tenant_role DROP MEMBER tenant_user;



-- ��������� ����������� "agent_user"
DROP USER agent_user;

-- ��������� ����������� "banker_user"
DROP USER banker_user;

-- ��������� ����������� "tenant_user"
DROP USER tenant_user;