/*****************************
** Copyright IWOOO, Inc. 2013
** All Rights Reserved.
** ���ݿⲿ��ű�
** 2013-06-15
******************************/
use master
go

if exists(select * from sys.sysdatabases where name = 'LUXERP')
	drop database LUXERP
go

declare @device_directory nvarchar(520)
select @device_directory = SUBSTRING(filename, 1, CHARINDEX(N'master.mdf', lower(filename)) - 1)
from sys.sysaltfiles where dbid = 1 and fileid = 1

execute (N'create database LUXERP 
	on primary (name = N''LUXERP'', filename = N''' + @device_directory + N'luxerp.mdf'')
	log on (name = ''LUXERP_log'', filename = N''' + @device_directory + N'luxerp.ldf'')')
go

--set quoted_identifier on
--go

use LUXERP
go
-- 0xf = 3 table
-- 0xf = 4 procedure
-- 0xf = 2 view
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.sp_GetSolutionByID') and sysstat & 0xf = 4)
--	drop procedure dbo.sp_GetSolutionByID
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.sp_UpdateSolution') and sysstat & 0xf = 4)
--	drop procedure dbo.sp_UpdateSolution
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_EventTypes') and sysstat & 0xf = 3)
--	drop table dbo.tb_EventTypes
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_EventLogs') and sysstat & 0xf = 3)
--	drop table dbo.tb_EventLogs
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_EventSteps') and sysstat & 0xf = 3)
--	drop table dbo.tb_EventSteps
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Solutions') and sysstat & 0xf = 3)
--	drop table dbo.tb_Solutions
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Stores') and sysstat & 0xf = 3)
--	drop table dbo.tb_Stores
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_AddStocks') and sysstat & 0xf = 3)
--	drop table dbo.tb_AddStocks
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_OutStockDemands') and sysstat & 0xf = 3)
--	drop table dbo.tb_OutStockDemands
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Stocks') and sysstat & 0xf = 3)
--	drop table dbo.tb_Stocks
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_OutStocks') and sysstat & 0xf = 3)
--	drop table dbo.tb_OutStocks
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_AllotStocks') and sysstat & 0xf = 3)
--	drop table dbo.tb_AllotStocks
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Express') and sysstat & 0xf = 3)
--	drop table dbo.tb_Express
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_SceneSteps') and sysstat & 0xf = 3)
--	drop table dbo.tb_SceneSteps
--go
----if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_States') and sysstat & 0xf = 3)
----	drop table dbo.tb_States
----go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Machings') and sysstat & 0xf = 3)
--	drop table dbo.tb_Machings
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Brands') and sysstat & 0xf = 3)
--	drop table dbo.tb_Brands
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Models') and sysstat & 0xf = 3)
--	drop table dbo.tb_Models
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Parameters') and sysstat & 0xf = 3)
--	drop table dbo.tb_Parameters
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_Suppliers') and sysstat & 0xf = 3)
--	drop table dbo.tb_Suppliers
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_TypeOnes') and sysstat & 0xf = 3)
--	drop table dbo.tb_TypeOnes
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_TypeTwos') and sysstat & 0xf = 3)
--	drop table dbo.tb_TypeTwos
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_TypeThrees') and sysstat & 0xf = 3)
--	drop table dbo.tb_TypeThrees
--go
--if exists(select * from sys.sysobjects where id = OBJECT_ID('dbo.tb_TypeFours') and sysstat & 0xf = 3)
--	drop table dbo.tb_TypeFours
--go

--�¼�����
create table tb_EventTypes
(
	TypeCode	nvarchar(50) not null primary key,
	TypeOne		nvarchar(50),
	TypeTwo		nvarchar(50),
	TypeThree	nvarchar(50),
	TypeFour	nvarchar(50),
	EventLevel	nvarchar(50)
)

-- ����
create table tb_Stores
(
	StoreNo			nvarchar(50) not null primary key,
	TopStore		nvarchar(50),
	StoreType		nvarchar(50),
	Region			nvarchar(50),
	Rating			nvarchar(50),
	StoreName		nvarchar(50),
	City			nvarchar(50),
	StoreAddress	nvarchar(50),
	StoreTel		nvarchar(50),
	ContractArea	nvarchar(50),
	OpeingDate		date,
	StoreState		nvarchar(50)
)

-- �¼���¼
create table tb_EventLogs
(
    ID				int identity,
	EventNo			nvarchar(50) not null primary key,
	EventTime		datetime,
	StoreNo			nvarchar(50),
	TypeCode		nvarchar(50),
	EventDescribe	nvarchar(50),
	ToResolvedTime	datetime,
	EventState		nvarchar(50),
	ResolvedTime	datetime,
	ResolvedBy		nvarchar(50),
	LogBy			nvarchar(50),
	HandingBy		nvarchar(50)
)

-- �¼�����
create table tb_EventSteps
(
	ID				int identity primary key,
	EventNo			nvarchar(50) references dbo.tb_EventLogs(EventNo),
	StepDescribe	nvarchar(50),
	StepTime		datetime,
	StepState		nvarchar(50),
	StepBy			nvarchar(50)
)

-- �������
create table tb_Solutions
(
	TypeCode		nvarchar(50) references dbo.tb_EventTypes(TypeCode),
	Content			text
)

-- �����ʷ
create table tb_AddStocks
(
	ID				int not null primary key identity,
	EventNo			nvarchar(50) references dbo.tb_EventLogs(EventNo),
	WarehouseNo		nvarchar(50),
	Maching			nvarchar(50),
	Brand			nvarchar(50),
	Model			nvarchar(50),
	SerialNo		nvarchar(50),
	Parameter		nvarchar(50),
	EpcTags			nvarchar(50),
	SapNo			nvarchar(50),
	PurchaseDate	datetime,
	GuaranteeTime	datetime,
	RepairsNo		nvarchar(50),
	Supplier		nvarchar(50),
	AddStockDate	datetime,
	Operator		nvarchar(50)	
)

-- ��������
create table tb_OutStockDemands
(
	DemandNo		int not null primary key identity,
	EventNo			nvarchar(50),
	Maching			nvarchar(50),
	Brand			nvarchar(50),
	Model			nvarchar(50),
	Parameter		nvarchar(50)
)

-- ���
create table tb_Stocks
(
	ID					int not null primary key identity,
	EventNo				nvarchar(50),
	DemandNo			int,
	WarehouseStoreNo	nvarchar(50),
	Maching				nvarchar(50),
	Brand				nvarchar(50),
	Model				nvarchar(50),
	SerialNo			nvarchar(50),
	Parameter			nvarchar(50),
	EpcTags				nvarchar(50),
	SapNo				nvarchar(50),
	PurchaseDate		datetime,
	GuaranteeTime		datetime,
	RepairsNo			nvarchar(50),
	Supplier			nvarchar(50),
	AddStockDate		datetime,
	OutStockDate		datetime,
	Operator			nvarchar(50),
	StockType			nvarchar(50),
	MachingState		nvarchar(50)
)

-- �����
create table tb_ScrapStocks
(
	ID					int not null primary key identity,
	WarehouseNo			nvarchar(50),
	Maching				nvarchar(50),
	Brand				nvarchar(50),
	Model				nvarchar(50),
	SerialNo			nvarchar(50),
	Parameter			nvarchar(50),
	EpcTags				nvarchar(50),
	PurchaseDate		datetime,
	GuaranteeTime		datetime,
	RepairsNo			nvarchar(50),
	Supplier			nvarchar(50),
	AddScrapStockDate	datetime,
	Operator			nvarchar(50),
	LastWarehouseNo		nvarchar(50),
	ScrapReason			nvarchar(50)
)

-- ������ʷ
create table tb_OutStocks
(
	ID				int not null primary key identity,
	EventNo			nvarchar(50) references dbo.tb_EventLogs(EventNo),
	WarehouseNo		nvarchar(50),
	StoreNo			nvarchar(50),
	Maching			nvarchar(50),
	Brand			nvarchar(50),
	Model			nvarchar(50),
	SerialNo		nvarchar(50),
	Parameter		nvarchar(50),
	EpcTags			nvarchar(50),
	SapNo			nvarchar(50),
	PurchaseDate	datetime,
	GuaranteeTime	datetime,
	RepairsNo		nvarchar(50),
	Supplier		nvarchar(50),
	OutStockDate	datetime,
	Operator		nvarchar(50),
	OutStocksState	nvarchar(50)
)

-- ������ʷ
create table tb_AllotStocks
(
	ID					int not null primary key identity,
	EventNo				nvarchar(50) references dbo.tb_EventLogs(EventNo),
	WarehouseStoreNoA	nvarchar(50),
	WarehouseStoreNoB	nvarchar(50),
	Maching				nvarchar(50),
	Brand				nvarchar(50),
	Model				nvarchar(50),
	SerialNo			nvarchar(50),
	Parameter			nvarchar(50),
	AllotStockDate		datetime,
	Operator			nvarchar(50),
	AllotStockState		nvarchar(50)
)

-- �����Ϣ
create table tb_Express
(
	ID				int not null primary key identity,
	EventNo			nvarchar(50) references dbo.tb_EventLogs(EventNo),
	ExpressCo		nvarchar(50),
	ExpressNo		nvarchar(50),
	GetOrSend		int,
	ExpressState	int
)

---- ����״̬
create table tb_SceneState
(
	EventNo			nvarchar(50) references dbo.tb_EventLogs(EventNo),
	SceneState		nvarchar(50)
)

-- ԤԼ����ʦ
create table tb_AppointEngineers
(
	ID				int not null primary key identity,
	EventNo			nvarchar(50) references dbo.tb_EventLogs(EventNo),
	Name			nvarchar(50),
	Phone			nvarchar(50),
	Email			nvarchar(50),
	SceneTime		datetime,
	AppointState	nvarchar(50)
	
)

---- ״̬��
--create table tb_States
--(
--	StateNo			nvarchar(50) not null primary key,
--	StateName		nvarchar(50),
--	StateDateDiff	nvarchar(50),
--	StateNote		nvarchar(50)	
--)

-- ������ʷ
create table tb_HistoryService
(
	EventNo				nvarchar(50),
	Maching				nvarchar(50),
	Brand				nvarchar(50),
	Model				nvarchar(50),
	SerialNo			nvarchar(50),
	Parameter			nvarchar(50),
	PurchaseDate		datetime,
	Supplier			nvarchar(50),
	ServiceDate			datetime
)

-- ��Ա��Ϣ
create table tb_People
(
	Position			nvarchar(50),
	Name				nvarchar(50),
	Sex					nvarchar(50),
	Phone				nvarchar(50),
	Email				nvarchar(50)
)

-- �豸������Ϣ
create table tb_Facility
(
	ID					int identity(1,1) not null,
	Maching				nvarchar(50),
	Brand				nvarchar(50),
	Model				nvarchar(50),
	Parameter			nvarchar(50)
)

-- ��������
create table tb_Machings
(
	ID		int identity(1,1) not null,
	Maching nvarchar(50)
)

-- Ʒ��
create table tb_Brands
(
	ID		int identity(1,1) not null,
	Brand	nvarchar(50)
)

-- �ͺ�
create table tb_Models
(
	ID		int identity(1,1) not null,
	Model	nvarchar(50)
)

-- ���ò���
create table tb_Parameters
(
	ID		int identity(1,1) not null,
	Parameter	nvarchar(50)
)

-- ��Ӧ
create table tb_Suppliers
(
	ID		int identity(1,1) not null,
	Supplier	nvarchar(50)
)

-- ����1
create table tb_TypeOnes
(
	ID			int identity(1,1) not null,
	TypeOne		nvarchar(50)
)

-- ����2
create table tb_TypeTwos
(
	ID			int identity(1,1) not null,
	TypeTwo		nvarchar(50)
)

-- ����3
create table tb_TypeThrees
(
	ID			int identity(1,1) not null,
	TypeThree	nvarchar(50)
)

-- ����4
create table tb_TypeFours
(
	ID			int identity(1,1) not null,
	TypeFour	nvarchar(50)
)

-- �����/��֯
create table tb_Solver
(
	ID			int identity(1,1) not null,
	Solver		nvarchar(50),
	SMTP		nvarchar(50),
	Email		nvarchar(50),
	EPassword	nvarchar(50),
	Note		nvarchar(50)
)

-- ��ݹ�˾
create table tb_ExpressCo
(
	ID			int identity(1,1) not null,
	ExpressCo	nvarchar(50)
)

-- �¼�״̬
create table tb_EventState
(
	StateID			int primary key,
	StateName		nvarchar(50),
	StateDay		int
)

-- ϵͳ�û�
create table tb_SystemUser
(
	UserName		nvarchar(50) primary key,
	[Password]		nvarchar(50),
	CreateTime		datetime,
	LastLogOnTime	datetime,
	UserState		int,
	UserIP			nvarchar(50)
)

-- Ȩ��
create table tb_Permission
(
	UserName			nvarchar(50) references dbo.tb_SystemUser(UserName),
	[Admin]				int,
	[Index]				int,
	UpdateSolution		int,
	EventQuery			int,
	CreateEvent			int,
	ReportFormsEvent	int,
	AddStock			int,
	StockQuery			int,
	OutStockQuery		int,
	AllotStockQuery		int,
	AddStockQuery		int,
	AlterStore			int,
	EventTypes			int,
	FacilityManage		int,
	PeopleManage		int,
	SynthesisManage		int,
	EventState			int,
	InitialStores		int,
	InitialStocks		int,
	[ScrapStocks]		int
)




-- �洢����
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***************************TypeOne***************************/
/**Add**/
Create Procedure [dbo].[AddTypeOne]
(
	@typeOne  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select TypeOne from tb_TypeOnes where TypeOne='''+@typeOne+''') insert into tb_TypeOnes(TypeOne) values('''+@typeOne+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetTypeOne]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select TypeOne from tb_TypeOnes order by TypeOne'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelTypeOne]
(
	@typeOne  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_TypeOnes where TypeOne ='''+@typeOne+''''
print @sql
EXEC(@sql)
Go
/***************************TypeOne***************************/

/***************************TypeTwo***************************/
/**Add**/
Create Procedure [dbo].[AddTypeTwo]
(
	@typeTwo  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select TypeTwo from tb_TypeTwos where TypeTwo='''+@typeTwo+''') insert into tb_TypeTwos(TypeTwo) values('''+@typeTwo+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetTypeTwo]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select TypeTwo from tb_TypeTwos order by TypeTwo'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelTypeTwo]
(
	@typeTwo  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_TypeTwos where TypeTwo ='''+@typeTwo+''''
print @sql
EXEC(@sql)
Go
/***************************TypeTwo***************************/

/***************************TypeThree***************************/
/**Add**/
Create Procedure [dbo].[AddTypeThree]
(
	@typeThree  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select TypeThree from tb_TypeThrees where TypeThree='''+@typeThree+''') insert into tb_TypeThrees(TypeThree) values('''+@typeThree+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetTypeThree]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select TypeThree from tb_TypeThrees order by TypeThree'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelTypeThree]
(
	@typeThree  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_TypeThrees where TypeThree ='''+@typeThree+''''
print @sql
EXEC(@sql)
Go
/***************************TypeThree***************************/

/***************************TypeFour***************************/
/**Add**/
Create Procedure [dbo].[AddTypeFour]
(
	@typeFour  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select TypeFour from tb_TypeFours where TypeFour='''+@typeFour+''') insert into tb_TypeFours(TypeFour) values('''+@typeFour+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetTypeFour]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select TypeFour from tb_TypeFours order by TypeFour'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelTypeFour]
(
	@typeFour  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_TypeFours where TypeFour ='''+@typeFour+''''
print @sql
EXEC(@sql)
Go
/***************************TypeFour***************************/

/***************************Solver***************************/
/**Add**/
Create Procedure [dbo].[AddSolver]
(
	@solver  nvarchar(50)
)
as
begin
if not exists(select Solver from tb_Solver where Solver=@solver) insert into tb_Solver(Solver,SMTP,Email,EPassword,Note) values(@solver,NULL,NULL,NULL,NULL)
end
Go
/**Get**/
Create Procedure [dbo].[GetAllSolver]

AS
begin
select Solver,SMTP,Email,EPassword,Note from tb_Solver order by Solver
end
Go
Create Procedure [dbo].[GetSolverByEventType]
(
	@typeCode	nvarchar(50)
)
AS
declare @email1		nvarchar(50)
declare @email2		nvarchar(50)
declare @solver1	nvarchar(50)
declare @solver2	nvarchar(50)
declare	@smtp		nvarchar(50)
declare	@ePassword	nvarchar(50)
declare @note		nvarchar(50)
declare @eventName	nvarchar(50)
begin
select top 1 @solver1=Solver, @email1=Email, @smtp=SMTP, @ePassword=EPassword from tb_Solver where SMTP<>'' and SMTP is not null and EPassword <> '' and EPassword is not null
select @solver2=EventLevel from tb_EventTypes where TypeCode=@typeCode
select @note=Note from tb_Solver where Solver=@solver2
select @email2=Email from tb_Solver where Solver=@note
select @eventName=TypeOne+'-'+TypeTwo+'-'+TypeThree+'-'+TypeFour from tb_EventTypes where TypeCode=@typeCode
select @email1,@smtp,@ePassword,@email2,@note,@solver2,@eventName from tb_Solver
end
Go
Create Procedure [dbo].[GetSolverChangeHandingBy]
(
	@handingBy	nvarchar(50),
	@typeCode	nvarchar(50)
)
AS
declare @email1		nvarchar(50)
declare @email2		nvarchar(50)
declare @solver1	nvarchar(50)
declare	@smtp		nvarchar(50)
declare	@ePassword	nvarchar(50)
declare @note		nvarchar(50)
declare @eventName	nvarchar(50)
begin
select top 1 @solver1=Solver, @email1=Email, @smtp=SMTP, @ePassword=EPassword from tb_Solver where SMTP<>'' and SMTP is not null and EPassword <> '' and EPassword is not null
select @note=Note from tb_Solver where Solver=@handingBy
select @email2=Email from tb_Solver where Solver=@note
select @eventName=TypeOne+'-'+TypeTwo+'-'+TypeThree+'-'+TypeFour from tb_EventTypes where TypeCode=@typeCode
select @email1,@smtp,@ePassword,@email2,@note,@eventName from tb_Solver
end
Go
Create Procedure [dbo].[GetSolver]

AS
begin
select Solver from tb_Solver order by Solver
end
Go
/**Update**/
Create Procedure [dbo].[UpdateSolver]
(
	@solver		nvarchar(50),
	@smtp		nvarchar(50),
	@email		nvarchar(50),
	@epassword  nvarchar(50),
	@note		nvarchar(50)
)
AS
begin
Update tb_Solver set SMTP=@smtp, Email=@email, EPassword=@epassword ,Note=@note where Solver=@solver
end
Go
/**Del**/
Create Procedure [dbo].[DelSolver]
(
	@solver  nvarchar(50)
)
AS
begin	
delete from tb_Solver where Solver =@solver
end
Go
/***************************Solver***************************/

/***************************EventState***************************/
insert tb_EventState(StateID,StateName,StateDay) values(99,'������',0)
insert tb_EventState(StateID,StateName,StateDay) values(0,'�����',0)
insert tb_EventState(StateID,StateName,StateDay) values(100,'��ɿ���',0)
insert tb_EventState(StateID,StateName,StateDay) values(200,'��ɹص�',0)
insert tb_EventState(StateID,StateName,StateDay) values(300,'���װ��',0)
insert tb_EventState(StateID,StateName,StateDay) values(999,'Ԥ����',0)
insert tb_EventState(StateID,StateName,StateDay) values(998,'��װ��',0)
insert tb_EventState(StateID,StateName,StateDay) values(997,'Ԥ�ص�',0)
insert tb_EventState(StateID,StateName,StateDay) values(900,'Ӫҵ��',0)
Go
/**Add**/
Create Procedure [dbo].[AddEventState]
(
	@stateName		nvarchar(50),
	@stateDay		int,
	@stateType		nvarchar(50)
)
as
begin
declare @min int
if @stateType='1'
begin
	if (select COUNT(StateID) from tb_EventState where StateID>=101 and StateID<=199) >0
	begin
		select @min=MIN(StateID)-1 from tb_EventState where StateID>=101 and StateID<=199
	end
	else
	begin
		set @min=199
	end
insert into tb_EventState(StateID,StateName,StateDay) values(@min,@stateName,@stateDay)
end
if @stateType='2'
begin
	if (select COUNT(StateID) from tb_EventState where StateID>=201 and StateID<=299) >0
	begin
		select @min=MIN(StateID)-1 from tb_EventState where StateID>=201 and StateID<=299
	end
	else
	begin
		set @min=299
	end
insert into tb_EventState(StateID,StateName,StateDay) values(@min,@stateName,@stateDay)
end
if @stateType='3'
begin
	if (select COUNT(StateID) from tb_EventState where StateID>=301 and StateID<=399) >0
	begin
		select @min=MIN(StateID)-1 from tb_EventState where StateID>=301 and StateID<=399
	end
	else
	begin
		set @min=399
	end
insert into tb_EventState(StateID,StateName,StateDay) values(@min,@stateName,@stateDay)
end
end
Go
/**Get**/
Create Procedure [dbo].[GetEventState]
(
	@stateType		nvarchar(50)
)
AS
begin
if @stateType='1'
select row_number()over(order by StateID desc) as RowNum,StateID,StateName,StateDay from tb_EventState where StateID>=100 and StateID<=199 order by StateID desc
if @stateType='2'
select row_number()over(order by StateID desc) as RowNum,StateID,StateName,StateDay from tb_EventState where StateID>=200 and StateID<=299 order by StateID desc
if @stateType='3'
select row_number()over(order by StateID desc) as RowNum,StateID,StateName,StateDay from tb_EventState where StateID>=300 and StateID<=399 order by StateID desc
end
Go
Create Procedure [dbo].[GetEventStateByStateID]
(
	@stateType		nvarchar(50),
	@stateID		int
)
AS
begin
if @stateType='0'
select StateID,StateName,StateDay from tb_EventState where StateID>=0 and StateID<=@stateID order by StateID desc
if @stateType='1'
select StateID,StateName,StateDay from tb_EventState where StateID>=100 and StateID<=@stateID order by StateID desc
if @stateType='2'
select StateID,StateName,StateDay from tb_EventState where StateID>=200 and StateID<=@stateID order by StateID desc
if @stateType='3'
select StateID,StateName,StateDay from tb_EventState where StateID>=300 and StateID<=@stateID order by StateID desc
end
Go
Create Procedure [dbo].[GetMinEventState]
(
	@stateType		nvarchar(50)
)
AS
begin
if @stateType='1'
select min(StateID) from tb_EventState where StateID>=101 and StateID<=199
if @stateType='2'
select min(StateID) from tb_EventState where StateID>=201 and StateID<=299
if @stateType='3'
select min(StateID) from tb_EventState where StateID>=301 and StateID<=399
end
Go
/**Del**/
Create Procedure [dbo].[DelEventState]
(
	@stateType		nvarchar(50),
	@stateID		int
)
AS
begin
declare @count int
declare @n	   int
set @n=0
delete from tb_EventState where StateID=@stateID
if @stateType='1'
begin
if @stateID <> 199
begin
select @count=COUNT(StateID) from tb_EventState where StateID>=101 and StateID<=@stateID
while @n<@count
begin
update tb_EventState set StateID=@stateID-@n where StateID=@stateID-@n-1
set @n=@n+1
end
end
end
if @stateType='2'
begin
if @stateID <> 299
begin
select @count=COUNT(StateID) from tb_EventState where StateID>=201 and StateID<=@stateID
while @n<@count
begin
update tb_EventState set StateID=@stateID-@n where StateID=@stateID-@n-1
set @n=@n+1
end
end
end
if @stateType='3'
begin
if @stateID <> 399
begin
select @count=COUNT(StateID) from tb_EventState where StateID>=301 and StateID<=@stateID
while @n<@count
begin
update tb_EventState set StateID=@stateID-@n where StateID=@stateID-@n-1
set @n=@n+1
end
end
end
end
Go
/**Uptate**/
Create Procedure UpdateEventStateByStateID
(
	@stateID		int,
	@stateName		nvarchar(50),
	@stateDay		int
)
as
begin
	update tb_EventState set StateName=@stateName,StateDay=@stateDay where StateID = @stateID
end
go
/**ChangeUp**/
Create Procedure [dbo].[ChangeUpEventState]
(
	@stateID  int
)
AS
begin
if @stateID<>199 and @stateID<>299 and @stateID<>399
begin
update tb_EventState set StateID=9999 where StateID=@stateID+1
update tb_EventState set StateID=@stateID+1 where StateID=@stateID
update tb_EventState set StateID=@stateID where StateID=9999
end
end
Go
/**ChangeDown**/
Create Procedure [dbo].[ChangeDownEventState]
(
	@stateID  int
)
AS
begin
if @stateID<>101 and @stateID<>201 and @stateID<>301
begin
update tb_EventState set StateID=9999 where StateID=@stateID-1
update tb_EventState set StateID=@stateID-1 where StateID=@stateID
update tb_EventState set StateID=@stateID where StateID=9999
end
end
Go
/***************************EventState***************************/

/***************************ExpressCo***************************/
/**Add**/
Create Procedure [dbo].[AddExpressCo]
(
	@expressCo  nvarchar(50)
)
as
begin
if not exists(select ExpressCo from tb_ExpressCo where ExpressCo=@expressCo) insert into tb_ExpressCo(ExpressCo) values(@expressCo)
end
Go
/**Get**/
Create Procedure [dbo].[GetExpressCo]

AS
begin
select ExpressCo from tb_ExpressCo order by ExpressCo
end
Go
/**Del**/
Create Procedure [dbo].[DelExpressCo]
(
	@expressCo  nvarchar(50)
)
AS
begin	
delete from tb_ExpressCo where ExpressCo =@expressCo
end
Go
/***************************ExpressCo***************************/

/***************************EventTypes***************************/
/**Add**/

--�̶�ֵ���Ͳ���
go
if not exists(select TypeCode from tb_EventTypes where TypeCode='9999') insert into tb_EventTypes(TypeCode,TypeOne,TypeTwo,TypeThree,TypeFour) values('9999','����','����','����','����')
if not exists(select TypeCode from tb_EventTypes where TypeCode='9000') insert into tb_EventTypes(TypeCode,TypeOne,TypeTwo,TypeThree,TypeFour) values('9000','�ص�','�ص�','�ص�','�ص�')
if not exists(select TypeCode from tb_EventTypes where TypeCode='8888') insert into tb_EventTypes(TypeCode,TypeOne,TypeTwo,TypeThree,TypeFour) values('8888','����װ��','����װ��','����װ��','����װ��')

go
Create Procedure [dbo].[AddEventTypes]
(
	@typeCode	nvarchar(50),
	@typeOne	nvarchar(50),
	@typeTwo	nvarchar(50),
	@typeThree  nvarchar(50),
	@typeFour	nvarchar(50),
	@eventLevel	nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select TypeCode from tb_EventTypes where TypeCode='''+@typeCode+''') insert into tb_EventTypes(TypeCode,TypeOne,TypeTwo,TypeThree,TypeFour,EventLevel) values('''+@typeCode+''','''+@typeOne+''','''+@typeTwo+''','''+@typeThree+''','''+@typeFour+''','''+@eventLevel+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetEventTypes]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select TypeCode,TypeOne,TypeTwo,TypeThree,TypeFour,EventLevel, row_number() over(partition by left(TypeCode,3) order by cast(right(TypeCode,len(TypeCode)-3) as float)) from tb_EventTypes where TypeCode not in(''9999'',''9000'',''8888'')'
print @sql
EXEC(@sql)
Go
Create Procedure [dbo].[GetEventTypesByTypeCode]
(
	@typeCode		nvarchar (50)
)

AS
begin	
select TypeOne,TypeTwo,TypeThree,TypeFour,EventLevel from tb_EventTypes where TypeCode= @typeCode
end
Go
Create Procedure [dbo].[GetEventLevelByTypeCode]
(
	@typeCode		nvarchar (50)
)

AS
begin	
select EventLevel from tb_EventTypes where TypeCode= @typeCode
end
Go
/**Del**/
Create Procedure [dbo].[DelEventTypes]
(
	@typeCode  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_EventTypes where TypeCode ='''+@typeCode+''''
print @sql
EXEC(@sql)
Go
/***************************EventTypes***************************/

/***************************People***************************/
/**Add**/
Create Procedure [dbo].[AddPeople]
(
	@position	nvarchar(50),
	@name		nvarchar(50),
	@sex		nvarchar(50),
	@phone		nvarchar(50),
	@email		nvarchar(50)
)
AS
begin
	if not exists(select Name from tb_People where Name=@name) insert into tb_People(Position,Name,Sex,Phone,Email) values(@position,@name,@sex,@phone,@email)
end
Go
/**Get**/
Create Procedure [dbo].[GetPeople]

AS
begin
select Name,Position,Sex,Phone,Email from tb_People order by Name
end
Go
Create Procedure [dbo].[GetNameByPosition]
(
	@position		nvarchar (50)
)

AS
begin	
select Name from tb_People where Position=@position order by Name
end
Go
/**Del**/
Create Procedure [dbo].[DelPeople]
(
	@name  nvarchar(50)
)
as
begin
delete from tb_People where Name =@name
end
Go
/***************************People***************************/

/***************************Solutions***************************/
/**Add**/
create proc dbo.sp_AddSolution
(
	@TypeCode nvarchar(50)=''
)
as
begin
	if not exists(select TypeCode from tb_Solutions where TypeCode=@TypeCode) insert into tb_Solutions(TypeCode) values(@TypeCode)
end
go
/**Get**/
create proc dbo.sp_GetSolutionByID
(
	@TypeCode nvarchar(50) = ''
)
as
begin
	declare @sql   nvarchar(4000)
	declare @where nvarchar(4000)
	
	set @TypeCode = RTRIM(LTRIM(@TypeCode))
	set @where = ' where 1=1 '
if @TypeCode<>'' and @TypeCode<>' '
	set @where = @where + ' and TypeCode=''' + @TypeCode + ''''
else
	set @where = ' where 1<>1 '

set @sql = 'select Content from dbo.tb_Solutions ' + @where + ''

if exists(select TypeCode from dbo.tb_Solutions where TypeCode = @TypeCode)
	exec sp_executesql @sql
else
	select '���������û�����������޸ģ�����'
end
go
/**Uptate**/
create proc dbo.sp_UpdateSolution
(
	@TypeCode nvarchar(50) = '',
	@Content text = ''
)
as
begin
	update dbo.tb_Solutions set Content = @Content where TypeCode = @TypeCode
end
go
/**Del**/
Create Procedure [dbo].[sp_DelSolution]
(
	@TypeCode  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_Solutions where TypeCode ='''+@TypeCode+''''
print @sql
EXEC(@sql)
Go
/***************************Solutions***************************/

/***************************EventLogs***************************/
/**Add**/
Create Procedure [dbo].[AddEventLogs]
(
	@eventNo		nvarchar(50),
	@eventTime		nvarchar(50),
	@storeNo		nvarchar(50),
	@typeCode		nvarchar(50),
	@eventDescribe	nvarchar(50),
	@toResolvedTime	nvarchar(50),
	@eventState		nvarchar(50),
	@logBy			nvarchar(50)
)
AS
DECLARE	 @sql					nvarchar (1000)
DECLARE  @eventDateTime			datetime
DECLARE  @toResolvedDateTime	datetime
DECLARE	 @handingBy				nvarchar(50)
	SET @eventDateTime = cast(@eventTime as datetime)
	select @handingBy=EventLevel from tb_EventTypes where TypeCode=@typeCode
IF @toResolvedTime <> ''
BEGIN
	SET @toResolvedDateTime = cast(@toResolvedTime as datetime)
END
ELSE
BEGIN
	SET @toResolvedDateTime = null
END
BEGIN
	if exists(select TypeCode from tb_EventTypes where TypeCode = @typeCode)
	begin
	if exists(select StoreNo from tb_Stores where StoreNo = @storeNo) 
	insert into tb_EventLogs(EventNo,EventTime,StoreNo,TypeCode,EventDescribe,ToResolvedTime,EventState,LogBy,HandingBy) values(@eventNo,@eventDateTime,@storeNo,@typeCode,@eventDescribe,@toResolvedDateTime,@eventState,@logBy,@handingBy)
	end
END
Go
/**Get**/
create Procedure [dbo].[GetEventLogsByEventNo]
(
	@eventNo		nvarchar(50)
)
AS
begin	
select EventNo,EventTime,StoreNo,TypeCode,EventDescribe,convert(nvarchar(10),ToResolvedTime,111) ToResolvedTime,EventState,LogBy,ResolvedBy,ResolvedTime from tb_EventLogs where EventNo = @eventNo
end
Go
create Procedure [dbo].[GetTopTenEventLogsByStoreNo]
(
	@storeNo		nvarchar(50)
)
AS
begin	
select top 10 EventNo,EventTime,StoreNo,TypeCode,EventDescribe,ResolvedBy,convert(nvarchar(10),ToResolvedTime,127) ToResolvedTime,StateName as EventState,LogBy from tb_EventLogs left join tb_EventState on tb_EventLogs.EventState=tb_EventState.StateID where StoreNo = @storeNo order by EventTime desc
end
Go
create Procedure [dbo].[GetEventLogsInNormalEvent]
(
	@eventTimeA		nvarchar(50),
	@eventTimeB		nvarchar(50),
	@storeNo		nvarchar(50),
	@typeCode		nvarchar(50),
	@eventState		nvarchar(50)
)
AS
DECLARE  @where   nvarchar(500)
DECLARE  @sql   nvarchar(1000)
	
	
	SET @where=' where 1=1 '
if @eventTimeA<>''
begin
	SET @where=@where+' and EventTime >= '''+@eventTimeA+''''
end
if @eventTimeB<>''
begin
	SET @where=@where+' and EventTime <= '''+@eventTimeB+''''
end
if @storeNo<>''
begin
	SET @where=@where+' and StoreNo= '''+@storeNo+''''
end
if @typeCode<>''
begin
	if @typeCode<>'9999' and @typeCode<>'9000' and @typeCode<>'8888'
	begin
		SET @where=@where+' and TypeCode= '''+@typeCode+''' '
	end
	if @typeCode='9999'
	begin
		SET @where=@where+' and TypeCode= ''9999'' '
	end
	if @typeCode='9000'
	begin	
		SET @where=@where+' and TypeCode= ''9000'' '
	end
	if @typeCode='8888'
	begin
		SET @where=@where+' and TypeCode= ''8888'' '	
	end
end
else
begin
	SET @where=@where+' and TypeCode<> ''9999'' and TypeCode<> ''9000'' and TypeCode<> ''8888'' '
end
if @eventState<>''
begin
	SET @where=@where+' and EventState= '''+@eventState+''''
end

set @sql='select EventNo,EventTime,StoreNo,TypeCode,EventDescribe,ResolvedBy,convert(nvarchar(10),ToResolvedTime,127) ToResolvedTime,StateName as EventState,LogBy from tb_EventLogs left join tb_EventState on tb_EventLogs.EventState=tb_EventState.StateID '+ @where +' order by EventTime desc'
EXEC(@sql)
Go
create Procedure [dbo].[GetHandingByByEventNo]
(
	@eventNo		nvarchar(50)
)
AS
begin	
select HandingBy from tb_EventLogs where EventNo = @eventNo
end
Go
/**Update**/
Create Procedure UpdateEventState
(
	@eventState nvarchar(50),
	@eventNo	nvarchar(50)
)
as
begin
	update tb_EventLogs set EventState=@eventState where EventNo=@eventNo
end
go
Create Procedure UpdateEventStateByShutUpShop
(
	@storeNo		nvarchar(50),
	@stepDescribe	nvarchar(50),
	@stepTime		nvarchar(50),
	@stepState		nvarchar(50),
	@stepBy			nvarchar(50)
)
as
declare @count		int
declare @eventNo	nvarchar(50)
begin

	select @eventNo=(select top 1 EventNo from tb_EventLogs where StoreNo=@storeNo and EventState='99') 
	while @eventNo is not null
	begin
	update tb_EventLogs set EventState='0' where StoreNo=@storeNo and EventNo=@eventNo
	insert into tb_EventSteps(EventNo,StepDescribe,StepTime,StepState,StepBy) values(@eventNo,@stepDescribe,@stepTime,@stepState,@stepBy)
	select @eventNo=(select top 1 EventNo from tb_EventLogs where StoreNo=@storeNo and EventState='99') 
	end
	delete from tb_Stores where StoreNo=@storeNo
end
go
Create Procedure UpdateResolvedByAndTime
(
	@resolvedBy nvarchar(50),
	@resolvedTime nvarchar(50),
	@eventNo	nvarchar(50)
)
as
if @resolvedTime=''
begin
 set @resolvedTime = null
end
begin
	update tb_EventLogs set ResolvedBy=@resolvedBy,ResolvedTime=@resolvedTime where EventNo = @eventNo
end
go
Create Procedure UpdateTypeCode
(
	@typeCode	nvarchar(50),
	@eventNo	nvarchar(50)
)
as
begin
	if exists(select TypeCode from tb_EventTypes where TypeCode=@typeCode) update tb_EventLogs set TypeCode=@typeCode where EventNo = @eventNo
end
go
Create Procedure UpdateHandingBy
(
	@handingBy	nvarchar(50),
	@eventNo	nvarchar(50)
)
as
begin
if exists(select HandingBy from tb_EventLogs where EventNo=@eventNo and HandingBy is null)
begin
	update tb_EventLogs set HandingBy=@handingBy where EventNo=@eventNo
end
else
begin
	update tb_EventLogs set HandingBy=@handingBy where EventNo=@eventNo and HandingBy<>@handingBy
end
end
go
Create Procedure UpdateToResolvedTime
(
	@toResolvedTime nvarchar(50),
	@eventNo	nvarchar(50)
)
as
begin
	update tb_EventLogs set ToResolvedTime=@toResolvedTime where EventNo=@eventNo
end
go
/***************************EventLogs***************************/

/***************************EventSteps***************************/
/**Add**/
Create Procedure [dbo].[AddEventSteps]
(
	@eventNo		nvarchar(50),
	@stepDescribe	nvarchar(50),
	@stepTime		nvarchar(50),
	@stepState		nvarchar(50),
	@stepBy			nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)
DECLARE  @stepDateTime   datetime
SET @stepDateTime = cast(@stepTime as datetime)
BEGIN
	if exists(select EventNo from tb_EventLogs where EventNo=@eventNo) insert into tb_EventSteps(EventNo,StepDescribe,StepTime,StepState,StepBy) values(@eventNo,@stepDescribe,@stepDateTime,@stepState,@stepBy)
END
Go
/**Get**/
Create Procedure [dbo].[GetEventStepsByEventNo]
(		
	@eventNo		nvarchar(50)
)
AS
begin	
select ID,StepTime,StepDescribe,StepBy,case StepState when 0 then '�Ѵ���' else 'δ����' end as StepState from tb_EventSteps where EventNo = @eventNo order by ID
end
Go
/**Uptate**/
Create Procedure UpdateEventSteps
(
	@id				int,
	@stepDescribe	nvarchar(50),
	@stepState		nvarchar(50)
)
as
begin
	update tb_EventSteps set StepDescribe=@stepDescribe, StepState=@stepState where ID = @id
end
go
/***************************EventSteps***************************/

/***************************Stores***************************/
/*Add*/
create proc dbo.AddStores
(
	@storeNo		nvarchar(50),
    @topStore		nvarchar(50),
    @storeType		nvarchar(50),
    @region			nvarchar(50),
    @rating			nvarchar(50),
    @storeName		nvarchar(50),
    @city			nvarchar(50),
    @storeAddress	nvarchar(50),
    @storeTel		nvarchar(50),
    @contractArea	nvarchar(50),
    @opeingDate		nvarchar(50),
    @storeState		nvarchar(50)
)
as
begin
if @opeingDate =''
	set @opeingDate=NULL
if not exists(select StoreNo from dbo.tb_Stores where StoreNo=@storeNo)
insert into dbo.tb_Stores 
select @storeNo, @topStore, @storeType, @region, @rating, @storeName, @city, @storeAddress,
	   @storeTel, @contractArea, @opeingDate, @storeState 

end
go
/**Get**/
Create Procedure [dbo].[GetRegionByStoreNo]
(
	@storeNo		nvarchar(50)
)

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select Region from tb_Stores where StoreNo='''+@storeNo+''''
print @sql
EXEC(@sql)
Go
Create Procedure [dbo].[GetStoresByStoreNo]
(
	@storeNo		nvarchar(50)
)
AS
begin	
select StoreNo,TopStore,StoreType,Region,Rating,StoreName,City,StoreAddress,StoreTel,ContractArea,OpeingDate,StateName as StoreState from tb_Stores left join tb_EventState on tb_Stores.StoreState=tb_EventState.StateID where StoreNo = @storeNo
end
Go
create proc dbo.GetStores
(
	@storeNo	nvarchar(50),
	@topStore	nvarchar(50),
	@storeType	nvarchar(50),
	@region		nvarchar(50),
	@rating		nvarchar(50),
	@opeingDateF nvarchar(50),
	@opeingDateT nvarchar(50),
	@storeState nvarchar(50)
)
as
begin
declare @sql nvarchar(4000)
declare @where nvarchar(4000)

set @storeNo = RTRIM(LTRIM(@storeNo))
set @topStore = RTRIM(LTRIM(@topStore))
set @storeType = RTRIM(LTRIM(@storeType))
set @region = RTRIM(LTRIM(@region))
set @rating = RTRIM(LTRIM(@rating))
set @storeState = RTRIM(LTRIM(@storeState))

if @opeingDateF<>''
	set @opeingDateF = CONVERT(nvarchar(10),@opeingDateF,127)
if @opeingDateT<>''
	set @opeingDateT = CONVERT(nvarchar(10),@opeingDateT,127)
	
set @where = ' where 1=1 '
if @storeNo<>''
	set @where = @where + ' and StoreNo ='''+@storeNo+''''
if @topStore<>''
	set @where = @where + ' and TopStore ='''+@topStore+''''
if @storeType<>''
	set @where = @where + ' and StoreType ='''+@storeType+''''
if @region<>''
	set @where = @where + ' and Region ='''+@region+''''
if @rating<>''
	set @where = @where + ' and Rating ='''+@rating+''''
if @opeingDateF<>''
	set @where = @where + ' and OpeingDate >='''+@opeingDateF+''''
if @opeingDateT<>''
	set @where = @where + ' and OpeingDate <='''+@opeingDateT+''''
if @storeState<>''
begin
	set @storeState = replace(@storeState,',',''',''')
	set @where = @where + ' and StoreState in ('''+@storeState+''')'
end
	
set @sql = ' select StoreNo,TopStore,StoreType,Region,Rating,StoreName,City,StoreAddress,StoreTel,ContractArea,
   convert(nvarchar(10),OpeingDate,127) OpeingDate,StateName as StoreState from dbo.tb_Stores left join tb_EventState on tb_Stores.StoreState=tb_EventState.StateID' + @where + ''
exec sp_executesql @sql
end
go

/**Del**/
Create Procedure [dbo].[DelStores]
(
	@storeNo  nvarchar(50)
)
AS
begin
delete from tb_Stores where StoreNo=@storeNo
end
Go
/**Update**/
create proc dbo.UpdateStores
(
	@storeNo		nvarchar(50),
    @topStore		nvarchar(50),
    @storeType		nvarchar(50),
    @region			nvarchar(50),
    @rating			nvarchar(50),
    @storeName		nvarchar(50),
    @city			nvarchar(50),
    @storeAddress	nvarchar(50),
    @storeTel		nvarchar(50),
    @contractArea	nvarchar(50),
    @opeingDate		nvarchar(50),
    @storeState		nvarchar(50)
)
as
begin
declare @sql nvarchar(2000)
declare @set nvarchar(3000)
declare @n   int
set @set=''
if ltrim(rtrim(@storeNo))<>''
 set @set=@set+' StoreNo='''+@storeNo+''', '
if ltrim(rtrim(@topStore))<>''
 set @set=@set+' TopStore='''+@topStore+''', '
if ltrim(rtrim(@storeType))<>''
 set @set=@set+' StoreType='''+@storeType+''', '
if ltrim(rtrim(@region))<>''
 set @set=@set+' Region='''+@region+''', '
if ltrim(rtrim(@rating))<>''
 set @set=@set+' Rating='''+@rating+''', '
if ltrim(rtrim(@storeName))<>''
 set @set=@set+' StoreName='''+@storeName+''', '
if ltrim(rtrim(@city))<>''
 set @set=@set+' City='''+@city+''', '
if ltrim(rtrim(@storeAddress))<>''
 set @set=@set+' StoreAddress='''+@storeAddress+''', '
if ltrim(rtrim(@storeTel))<>''
 set @set=@set+' StoreTel='''+@storeTel+''', '
if ltrim(rtrim(@contractArea))<>''
 set @set=@set+' ContractArea='''+@contractArea+''', '
if ltrim(rtrim(@opeingDate))<>''
 set @set=@set+' OpeingDate='''+@opeingDate+''', '
if ltrim(rtrim(@storeState))<>''
begin
 set @set=@set+' StoreState='''+@storeState+''' '
end
else
begin
	set @n = len(@set)
	set @set=substring(@set,1,@n-1)
end
if @storeState='997'
begin	
	set @sql = ' update dbo.tb_Stores set '+@set+' 
				 where StoreNo ='''+@storeNo+''' and StoreState<>'''+@storeState+''' and StoreState<>''999'' ' 
end
else
begin
	set @sql = ' update dbo.tb_Stores set '+@set+' 
				 where StoreNo ='''+@storeNo+''' ' 
end
          
exec sp_executesql @sql
end
go
/***************************Stores***************************/

/***************************Facility***************************/
/**Add**/
Create Procedure [dbo].[AddFacility]
(
	@maching	nvarchar(50),
	@brand		nvarchar(50),
	@model		nvarchar(50),
	@parameter	nvarchar(50)
	
)
AS
DECLARE	 @sql	 nvarchar (2000)
if	@maching <>'' and @brand <>'' and @model <>'' and @parameter <>''
begin
SET @sql = 'if not exists(select Maching from tb_Facility where Maching='''+@maching+''' and Brand='''+@brand+''' and Model='''+@model+''' and Parameter='''+@parameter+''') 
			insert into tb_Facility(Maching,Brand,Model,Parameter) values('''+@maching+''','''+@brand+''','''+@model+''','''+@parameter+''')'
print @sql
EXEC(@sql)
end
Go
/**Get**/
Create Procedure [dbo].[GetMachingFromFacility]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select distinct Maching from tb_Facility order by Maching'
print @sql
EXEC(@sql)
Go
Create Procedure [dbo].[GetBrandFromFacility]
(
	@maching	nvarchar(50)
	
)
AS
DECLARE	 @sql	 nvarchar (1000)
if	@maching <>''
begin
SET @sql = 'select distinct Brand from tb_Facility  where Maching='''+@maching+''' order by Brand'
print @sql
EXEC(@sql)
end
Go
Create Procedure [dbo].[GetModelFromFacility]
(
	@maching	nvarchar(50),
	@brand		nvarchar(50)
	
)
AS
DECLARE	 @sql	 nvarchar (1000)	
if	@maching <>'' and @brand <>''
begin
SET @sql = 'select distinct Model from tb_Facility  where Maching='''+@maching+''' and Brand='''+@brand+''' order by Model'
print @sql
EXEC(@sql)
end
Go
Create Procedure [dbo].[GetParameterFromFacility]
(
	@maching	nvarchar(50),
	@brand		nvarchar(50),
	@model		nvarchar(50)	
)
AS
DECLARE	 @sql	 nvarchar (1000)
if	@maching <>'' and @brand <>'' and @model <>''
begin
SET @sql = 'select distinct Parameter from tb_Facility  where Maching='''+@maching+''' and Brand='''+@brand+''' and Model='''+@model+''' order by Parameter'
print @sql
EXEC(@sql)
end
Go
/**Del**/
Create Procedure [dbo].[DelFacility]
(
	@maching	nvarchar(50),
	@brand		nvarchar(50),
	@model		nvarchar(50),
	@parameter	nvarchar(50)
	
)
AS
DECLARE	 @sql	 nvarchar (2000)
if	@maching <>'' and @brand <>'' and @model <>'' and @parameter <>''
begin
SET @sql = 'delete from tb_Facility where Maching='''+@maching+''' and Brand='''+@brand+''' and Model='''+@model+''' and Parameter='''+@parameter+''' '
print @sql
EXEC(@sql)
end
Go
/***************************Facility***************************/

/***************************Maching***************************/
/**Add**/
create Procedure [dbo].[AddMaching]
(
	@maching  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select maching from tb_Machings where maching='''+@maching+''') insert into tb_Machings(maching) values('''+@maching+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetMaching]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select maching from tb_Machings order by maching'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelMaching]
(
	@maching  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_Machings where maching ='''+@maching+''''
print @sql
EXEC(@sql)
Go
/***************************Maching***************************/

/***************************Brand***************************/
/**Add**/
create Procedure [dbo].[AddBrand]
(
	@brand  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select brand from tb_Brands where brand='''+@brand+''') insert into tb_Brands(brand) values('''+@brand+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetBrand]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select brand from tb_Brands order by brand'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelBrand]
(
	@brand  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_Brands where brand ='''+@brand+''''
print @sql
EXEC(@sql)
Go
/***************************Brand***************************/

/***************************Model***************************/
/**Add**/
create Procedure [dbo].[AddModel]
(
	@model  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select model from tb_Models where model='''+@model+''') insert into tb_Models(model) values('''+@model+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetModel]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select model from tb_Models order by model'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelModel]
(
	@model  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_Models where model ='''+@model+''''
print @sql
EXEC(@sql)
Go
/***************************Model***************************/

/***************************Parameter***************************/
/**Add**/
create Procedure [dbo].[AddParameter]
(
	@parameter  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select parameter from tb_Parameters where parameter='''+@parameter+''') insert into tb_Parameters(parameter) values('''+@parameter+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetParameter]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select parameter from tb_Parameters order by parameter'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelParameter]
(
	@parameter  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_Parameters where parameter ='''+@parameter+''''
print @sql
EXEC(@sql)
Go
/***************************Parameter***************************/

/***************************Supplier***************************/
/**Add**/
Create Procedure [dbo].[AddSupplier]
(
	@supplier nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'if not exists(select supplier from tb_Suppliers where supplier='''+@supplier+''') insert into tb_Suppliers(supplier) values('''+@supplier+''')'
print @sql
EXEC(@sql)
Go
/**Get**/
Create Procedure [dbo].[GetSupplier]

AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'select supplier from tb_Suppliers order by supplier'
print @sql
EXEC(@sql)
Go
/**Del**/
Create Procedure [dbo].[DelSupplier]
(
	@supplier  nvarchar(50)
)
AS
DECLARE	 @sql	 nvarchar (1000)	
SET @sql = 'delete from tb_Suppliers where supplier ='''+@supplier+''''
print @sql
EXEC(@sql)
Go
/***************************Supplier***************************/

/***************************OutStockDemands***************************/
/**Add**/
Create Procedure [dbo].[AddOutStockDemands]
(
	@eventNo		nvarchar(50),
	@maching		nvarchar(50),
	@brand			nvarchar(50),
	@model			nvarchar(50),
	@parameter		nvarchar(50)
)
AS
BEGIN
 insert into tb_OutStockDemands(EventNo,Maching,Brand,Model,Parameter) values(@eventNo,@maching,@brand,@model,@parameter)
END
Go
/**Get**/
Create Procedure [dbo].[GetOutStockDemandsByEventNo]
(
	@eventNo		nvarchar(50)
)
AS
BEGIN
 select  DemandNo,EventNo,Maching,Brand,Model,Parameter from tb_OutStockDemands where EventNo=@eventNo order by Maching
END
Go
Create Procedure [dbo].[GetNoMatchingByEventNo]
(
	@eventNo		nvarchar(50)
)
AS
BEGIN
 select DemandNo,EventNo,Maching,Brand,Model,Parameter from tb_OutStockDemands where EventNo=@eventNo and DemandNo not in(select DemandNo from tb_Stocks where DemandNo is not null) order by Maching
END
Go
/**Del**/
Create Procedure [dbo].[DelOutStockDemands]
(
	@demandNo	int
)
AS
BEGIN
 delete from tb_OutStockDemands where DemandNo=@demandNo
 update tb_Stocks set EventNo=NULL,DemandNo=NULL where DemandNo=@demandNo
END
Go
/**Update**/
Create Procedure [dbo].[UptateOutStockDemands]
(
	@eventNo	nvarchar(50),
	@demandNo	int,
	@id			int
)
AS
BEGIN
 update tb_Stocks set EventNo=NULL,DemandNo=NULL where DemandNo=@demandNo
 update tb_Stocks set EventNo=@eventNo,DemandNo=@demandNo where ID=@id
END
Go

/***************************OutStockDemands***************************/

/***************************AddStocks***************************/
Create Procedure [dbo].[GetAddStocks]
(
	@warehouseNo			nvarchar(50),
	@maching				nvarchar(50),
	@brand					nvarchar(50),
	@model					nvarchar(50),
	@parameter				nvarchar(50),
	@supplier				nvarchar(50),
	@addStockDateA			nvarchar(50),
	@addStockDateB			nvarchar(50)
)
AS
begin
declare @where nvarchar(300)
declare @sql nvarchar(1000)
set @where=' where 1=1 '

if @warehouseNo<>''
	set @where=@where+' and WarehouseNo = '''+@warehouseNo+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @supplier<>''
	set @where=@where+' and Supplier = '''+@supplier+''' '
if @addStockDateA<>''
	set @where=@where+' and AddStockDate >= '''+@addStockDateA+''' '
if @addStockDateB<>''
	set @where=@where+' and AddStockDate <= '''+@addStockDateB+''' '


set @sql='select ID,WarehouseNo,Maching,Brand,Model,Parameter,SerialNo,EpcTags,SapNo,convert(varchar(20),PurchaseDate,111) as PurchaseDate,convert(varchar(20),GuaranteeTime,111) as GuaranteeTime,RepairsNo,Supplier,convert(varchar(20),AddStockDate,111) as AddStockDate from tb_AddStocks '+@where 
exec sp_executesql @sql
end
go
/***************************AddStocks***************************/

/***************************Stocks***************************/
/**Add**/
Create proc dbo.AddStocks
(

      @WarehouseStoreNo		nvarchar(50),
      @Maching				nvarchar(50),
      @Brand				nvarchar(50),
      @Model				nvarchar(50),
      @SerialNo				nvarchar(50),
      @Parameter			nvarchar(50),
      @EpcTags				nvarchar(50),
      @SapNo				nvarchar(50),
      @PurchaseDate			nvarchar(50),
      @GuaranteeTime		nvarchar(50),
      @RepairsNo			nvarchar(50),
      @Supplier				nvarchar(50),
      @AddStockDate			nvarchar(50),
      @OutStockDate			nvarchar(50),     
      @Operator				nvarchar(50),
      @StockType			nvarchar(50),
      @MachingState			nvarchar(50)
)
as
begin
if @AddStockDate=''
	set @AddStockDate=NULL
if @OutStockDate=''
	set @OutStockDate=NULL
--declare @sql nvarchar(4000)
--if not exists(select WarehouseStoreNo from dbo.tb_Stocks where WarehouseStoreNo = '''+@WarehouseStoreNo+''')
if not exists(select Maching from dbo.tb_Stocks where Maching = @Maching and SerialNo = @SerialNo)
insert tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,OutStockDate,Operator,StockType,MachingState)
		values(@WarehouseStoreNo,@Maching,@Brand,@Model,@SerialNo,@Parameter,@EpcTags,@SapNo,@PurchaseDate,@GuaranteeTime,@RepairsNo,@Supplier,@AddStockDate,@OutStockDate,@Operator,@StockType,@MachingState)
--set @sql = ' if not exists(select Maching from dbo.tb_Stocks where Maching = '''+@Maching+''' and SerialNo = '''+@SerialNo+''')
--			insert into dbo.tb_Stocks
--			select null,null,'''+@WarehouseStoreNo+''','''+@Maching+''','''+@Brand+''',
--			 '''+@Model+''','''+@SerialNo+''','''+@Parameter+''','''+@EpcTags+''','''+@SapNo+''',
--			 '''+@PurchaseDate+''','''+@GuaranteeTime+''','''+@RepairsNo+''','''+@Supplier+''','''+@AddStockDate+''',
--			 '''+@Operator+''','''+@StockType+''','''+@MachingState+''' '

--exec sp_executesql @sql	
end
go
CREATE proc dbo.AddStocksCommitHistory
(
      @WarehouseStoreNo		nvarchar(50),
      @Maching				nvarchar(50),
      @Brand				nvarchar(50),
      @Model				nvarchar(50),
      @SerialNo				nvarchar(50),
      @Parameter			nvarchar(50),
      @EpcTags				nvarchar(50),
      @SapNo				nvarchar(50),
      @PurchaseDate			nvarchar(50),
      @GuaranteeTime		nvarchar(50),
      @RepairsNo			nvarchar(50),
      @Supplier				nvarchar(50),
      @AddStockDate			nvarchar(50),
      @Operator				nvarchar(50),
      @StockType			nvarchar(50),
      @MachingState			nvarchar(50)
      
)
as
begin
--declare @sql nvarchar(4000)

if not exists(select Maching from dbo.tb_Stocks where Maching = @Maching and SerialNo = @SerialNo)
begin
insert tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,Operator,StockType,MachingState)
		values(@WarehouseStoreNo,@Maching,@Brand,@Model,@SerialNo,@Parameter,@EpcTags,@SapNo,@PurchaseDate,@GuaranteeTime,@RepairsNo,@Supplier,@AddStockDate,@Operator,@StockType,@MachingState)
--set @sql = ' if not exists(select Maching from dbo.tb_Stocks where Maching = '''+@Maching+''' and SerialNo = '''+@SerialNo+''')
--			insert into dbo.tb_Stocks
--			select null,null,'''+@WarehouseStoreNo+''','''+@Maching+''','''+@Brand+''',
--			 '''+@Model+''','''+@SerialNo+''','''+@Parameter+''','''+@EpcTags+''','''+@SapNo+''',
--			 '''+@PurchaseDate+''','''+@GuaranteeTime+''','''+@RepairsNo+''','''+@Supplier+''','''+@AddStockDate+''',
--			 '''+@Operator+''','''+@StockType+''','''+@MachingState+''' '
			 
--exec sp_executesql @sql	

insert tb_AddStocks(WarehouseNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,Operator)
values(@WarehouseStoreNo,@Maching,@Brand,@Model,@SerialNo,@Parameter,@EpcTags,@SapNo,@PurchaseDate,@GuaranteeTime,@RepairsNo,@Supplier,@AddStockDate,@Operator)
end
end
go
/**Get**/
Create Procedure [dbo].[GetStocks]
(
	@eventNo				nvarchar(50),
	@warehouseStoreNo		nvarchar(50),
	@maching				nvarchar(50),
	@brand					nvarchar(50),
	@model					nvarchar(50),
	@parameter				nvarchar(50),
	@supplier				nvarchar(50),
	@addStockDateA			nvarchar(50),
	@addStockDateB			nvarchar(50),
	@outStockDateA			nvarchar(50),
	@outStockDateB			nvarchar(50),
	@stockType				nvarchar(50),
	@machingState			nvarchar(50)
)
AS
begin
declare @where nvarchar(300)
declare @sql nvarchar(1000)
set @where=' where 1=1 '
if @eventNo<>''
begin
 if @eventNo='0'
	begin
		set @where=@where+' and tb_Stocks.EventNo is null '
	end
	else
	begin
		set @where=@where+' and tb_Stocks.EventNo = '''+@eventNo+''' '
	end
end
if @warehouseStoreNo<>''
	set @where=@where+' and tb_Stocks.WarehouseStoreNo = '''+@warehouseStoreNo+''' '
if @maching<>''
	set @where=@where+' and tb_Stocks.Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and tb_Stocks.Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and tb_Stocks.Model =	'''+@model+''' '
if @parameter<>''
	set @where=@where+' and tb_Stocks.Parameter = '''+@parameter+''' '
if @supplier<>''
	set @where=@where+' and tb_Stocks.Supplier = '''+@supplier+''' '
if @addStockDateA<>''
	set @where=@where+' and tb_Stocks.AddStockDate >= '''+@addStockDateA+''' '
if @addStockDateB<>''
	set @where=@where+' and tb_Stocks.AddStockDate <= '''+@addStockDateB+''' '
if @outStockDateA<>''
	set @where=@where+' and tb_Stocks.OutStockDate >= '''+@outStockDateA+''' '
if @outStockDateB<>''
	set @where=@where+' and tb_Stocks.OutStockDate <= '''+@outStockDateB+''' '
if @stockType<>''
	set @where=@where+' and tb_Stocks.StockType = '''+@stockType+''' '
if @machingState<>''
	set @where=@where+' and tb_Stocks.MachingState = '''+@machingState+''' '
set @sql='SELECT * FROM (
select tb_Stocks.ID,tb_Stocks.EventNo,tb_Stocks.DemandNo,tb_Stocks.WarehouseStoreNo,tb_Stocks.Maching,tb_Stocks.Brand,tb_Stocks.Model,
tb_Stocks.Parameter,tb_Stocks.SerialNo,tb_Stocks.EpcTags,tb_Stocks.SapNo,convert(varchar(20),tb_Stocks.PurchaseDate,111) as PurchaseDate,
convert(varchar(20),tb_Stocks.GuaranteeTime,111) as GuaranteeTime,tb_Stocks.RepairsNo,tb_Stocks.Supplier,
convert(varchar(20),tb_Stocks.AddStockDate,111) as AddStockDate,convert(varchar(20),tb_Stocks.OutStockDate,111) as OutStockDate,convert(varchar(20),tb_OutStocks.OutStockDate,111) as OutStockDateT,
tb_OutStocks.EventNo as EventNoT, ROW_NUMBER() OVER(PARTITION BY tb_Stocks.SerialNo ORDER BY tb_OutStocks.OutStockDate DESC) N
from tb_Stocks left join tb_OutStocks on tb_Stocks.SerialNo=tb_OutStocks.SerialNo 
'+@where+'
) A WHERE A.N = 1 ' 
exec sp_executesql @sql
end
go
Create Procedure [dbo].[GetStocksInID]
(
	@idTemp nvarchar(100)
)
AS
declare @temp nvarchar(50)
declare @sql nvarchar(1000)
declare @n int

begin
begin
	set @n = len(@idTemp)
	set @temp=substring(@idTemp,1,@n-1)
end
set @sql='select ID,DemandNo,WarehouseStoreNo,Maching,Brand,Model,Parameter,SerialNo,EpcTags,SapNo,convert(varchar(20),PurchaseDate,111) as PurchaseDate,convert(varchar(20),GuaranteeTime,111) as GuaranteeTime,RepairsNo,Supplier,convert(varchar(20),AddStockDate,111) as AddStockDate,convert(varchar(20),OutStockDate,111) as OutStockDate from tb_Stocks where ID in ('+@idTemp+')' 
print(@sql)
exec(@sql)
end
go
Create Procedure [dbo].[DelStocksToScrapInID]
(
	@idTemp				nvarchar(100),
	@addScrapStockDate	nvarchar(50),
	@operator			nvarchar(50),
	@scrapReason		nvarchar(50)
)
AS
declare @temp nvarchar(50)
declare @sql nvarchar(1000)
declare @n int

begin
begin
	--set @n = len(@idTemp)
	--if @n>1
	--begin
	--	set @temp=substring(@idTemp,1,@n-1)
	--end
	--else
	--begin
		set @temp=@idTemp
	--end
end
set @sql='insert into tb_ScrapStocks(WarehouseNo,Maching,Brand,Model,SerialNo,Parameter,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddScrapStockDate,Operator,LastWarehouseNo,ScrapReason)
 select WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,'''+@addScrapStockDate+''','''+@operator+''',WarehouseStoreNo,'''+@scrapReason+'''
 from tb_Stocks where ID in ('+@temp+') 
 delete from tb_Stocks where ID in ('+@temp+')'
print(@sql)
exec(@sql)
end
go

/**Mutual**/
Create Procedure [dbo].[UpdateStocksMutualOutStockDemands]
(
	@eventNo	nvarchar(50),
	@temp		nvarchar(50)
)
AS
begin
select a.DemandNo into #Temp from (select DemandNo from tb_OutStockDemands where EventNo=@eventNo and DemandNo not in(select DemandNo from tb_Stocks where DemandNo is not null))a
declare @demandNo int
declare @num int
declare @count int
set @num=0
set @count = (select count(DemandNo) from #Temp)
while @num<@count
begin
set @num=@num+1
;with rownum_cte as
(
	select  DemandNo,row_number()over(order by DemandNo)as Rownum from #Temp
)
select @demandNo=DemandNo from rownum_cte where Rownum=@num

if @temp='0'
begin
with upd_cte as
(
	select top 1 a.EventNo,a.DemandNo
	from tb_Stocks a,tb_OutStockDemands b 
	where a.Maching=b.Maching and a.Brand=b.Brand and a.Model=b.Model and a.Parameter=b.Parameter and b.DemandNo=@demandNo and a.DemandNo is null and a.StockType='0' and MachingState=0 
	order by a.PurchaseDate
)
update upd_cte set EventNo=@eventNo,DemandNo=@demandNo
end
else
begin
with upd_cte as
(
	select top 1 a.EventNo,a.DemandNo
	from tb_Stocks a,tb_OutStockDemands b 
	where a.Maching=b.Maching and a.Brand=b.Brand and a.Model=b.Model and a.Parameter=b.Parameter and b.DemandNo=@demandNo and a.DemandNo is null and a.StockType='0'  
	order by a.PurchaseDate
)
update upd_cte set EventNo=@eventNo,DemandNo=@demandNo
end
end
drop table #Temp
end
Go
Create Procedure [dbo].[UpdateStocksMutualFacilityAllot]
(
	@eventNo	nvarchar(50),
	@rowID		nvarchar(500)
)
as
declare @sql	nvarchar(1000)
begin
	set @sql='update tb_Stocks set EventNo='''+@eventNo+''' where ID in('+@rowID+')'
end
exec sp_executesql @sql
go
/**Del**/
Create Procedure [dbo].[DelStocksMutualFacilityAllot]
(
	@eventNo	nvarchar(50)
)
as
begin
	update tb_Stocks set EventNo=null where EventNo=@eventNo and StockType='1'
end
go
Create Procedure [dbo].[DelStocksBack]
(
	@eventNo	nvarchar(50)
)
as
begin
	update tb_Stocks set EventNo=null,DemandNo=null where EventNo=@eventNo
end
go
Create Procedure [dbo].[DelStocks]
(
	@id	nvarchar(50)
)
as
begin
	delete tb_Stocks where ID=@id
end
go
/***************************Stocks***************************/

/***************************Express***************************/
/**Add**/
Create Procedure [dbo].[AddExpress]
(
	@eventNo		nvarchar(50),
	@expressCo		nvarchar(50),
	@expressNo		nvarchar(50),
	@getOrSend		int,
	@expressState	int
)
AS
BEGIN
 insert into tb_Express(EventNo,ExpressCo,ExpressNo,GetOrSend,ExpressState) values(@eventNo,@expressCo,@expressNo,@getOrSend,@expressState)
END
Go
/**Get**/
Create Procedure [dbo].[GetExpressByEventNo]
(
	@eventNo		nvarchar(50),
	@getOrSend		int
)
AS
BEGIN
 select ID,ExpressCo,ExpressNo,ExpressState from tb_Express where EventNo=@eventNo and GetOrSend=@getOrSend order by ID
END
Go
/**Uptate**/
Create Procedure UpdateExpressState
(
	@id int,
	@expressState nvarchar(50)
)
as
begin
	update tb_Express set ExpressState=@expressState where ID = @id
end
go
/***************************Express***************************/

/***************************OutStocks***************************/
/**Add**/
CREATE Procedure [dbo].[AddAllOutStocksFromStocks]
(
	@eventNo		nvarchar(50),
	@storeNo		nvarchar(50),
	@outStockDate	nvarchar(50),
	@operator		nvarchar(50),
	@outStocksState	nvarchar(50)
)
AS
BEGIN
--declare		@num		int
--declare		@count	int
--set @count = (select count(EventNo) from tb_Stocks where EventNo=@eventNo)
--set @num=0
--while @num<@count
--begin
-- set @num=@num+1
 insert into tb_OutStocks(EventNo,WarehouseNo,StoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,OutStockDate,Operator,OutStocksState) 
 select EventNo,WarehouseStoreNo,@storeNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,@outStockDate,@operator,@outStocksState  
 from tb_Stocks where EventNo=@eventNo and StockType='0'
--end
 update tb_Stocks set EventNo=NULL,DemandNo=NULL,WarehouseStoreNo=@storeNo,StockType='1',OutStockDate=@outStockDate where EventNo=@eventNo
END
Go
Create Procedure [dbo].[AddOutStocksFromStocks]
(
	@id				nvarchar(50),
	@storeNo		nvarchar(50),
	@outStockDate	nvarchar(50),
	@operator		nvarchar(50),
	@outStocksState	nvarchar(50),
	@scrapReason	nvarchar(50)
)
AS
BEGIN
 insert into tb_OutStocks(EventNo,WarehouseNo,StoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,OutStockDate,Operator,OutStocksState) 
 select EventNo,WarehouseStoreNo,@storeNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,@outStockDate,@operator,@outStocksState 
 from tb_Stocks where ID=@id 
 insert into tb_ScrapStocks(WarehouseNo,Maching,Brand,Model,SerialNo,Parameter,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddScrapStockDate,Operator,LastWarehouseNo,ScrapReason)
 select WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,@outStockDate,@operator,WarehouseStoreNo,@scrapReason
 from tb_Stocks where ID=@id 
 delete from tb_Stocks where ID=@id
END
Go
/**Get**/
Create Procedure [dbo].[GetOutStocks]
(
	@eventNo		nvarchar(50)
)
AS
declare @where nvarchar(300)
declare @sql nvarchar(1000)
set @where=' where 1=1 '
if @eventNo<>''
begin
	set @where=@where+' and EventNo = '''+@eventNo+''' order by Maching '
end
else
begin
	set @where=@where+' order by OutStockDate desc '
end
set @sql = 'select EventNo,WarehouseNo,StoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,convert(varchar(20),PurchaseDate,111) as PurchaseDate,convert(varchar(20),GuaranteeTime,111) as GuaranteeTime,RepairsNo,Supplier,convert(varchar(20),OutStockDate,111) as OutStockDate,Operator,OutStocksState 
 from tb_OutStocks' + @where
exec sp_executesql @sql
Go
Create Procedure [dbo].[GetCountOutStocksState]
(
	@eventNo		nvarchar(50)
)
AS
BEGIN
 select COUNT(OutStocksState) from tb_OutStocks where EventNo=@eventNo and OutStocksState='1'
END
Go
/***************************OutStocks***************************/

/***************************AllotStocks***************************/
/**Add**/
Create Procedure [dbo].[AddAllAllotStocksFromStocks]
(
	@eventNo				nvarchar(50),
	@warehouseStoreNoB		nvarchar(50),
	@allotStockDate			nvarchar(50),
	@operator				nvarchar(50),
	@allotStockState		nvarchar(50)
)
AS
BEGIN
--declare		@num		int
--declare		@count	int
--set @count = (select count(EventNo) from tb_Stocks where EventNo=@eventNo)
--set @num=0
--while @num<@count
--begin
-- set @num=@num+1
 insert into tb_AllotStocks(EventNo,WarehouseStoreNoA,WarehouseStoreNoB,Maching,Brand,Model,SerialNo,Parameter,AllotStockDate,Operator,AllotStockState) 
 select EventNo,WarehouseStoreNo,@warehouseStoreNoB,Maching,Brand,Model,SerialNo,Parameter,@allotStockDate,@operator,@allotStockState   
 from tb_Stocks where EventNo=@eventNo and StockType='1'
--end
 update tb_Stocks set EventNo=NULL,WarehouseStoreNo=@warehouseStoreNoB,StockType='0',MachingState='1' where EventNo=@eventNo
END
Go
Create Procedure [dbo].[AddAllotStocksFromStocks]
(
	@id						nvarchar(50),
	@warehouseStoreNoB		nvarchar(50),
	@allotStockDate			nvarchar(50),
	@operator				nvarchar(50),
	@allotStockState		nvarchar(50),
	@scrapReason			nvarchar(50)
)
AS
BEGIN
 insert into tb_AllotStocks(EventNo,WarehouseStoreNoA,WarehouseStoreNoB,Maching,Brand,Model,SerialNo,Parameter,AllotStockDate,Operator,AllotStockState) 
 select EventNo,WarehouseStoreNo,@warehouseStoreNoB,Maching,Brand,Model,SerialNo,Parameter,@allotStockDate,@operator,@allotStockState   
 from tb_Stocks where ID=@id 
 insert into tb_ScrapStocks(WarehouseNo,Maching,Brand,Model,SerialNo,Parameter,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddScrapStockDate,Operator,LastWarehouseNo,ScrapReason)
 select @warehouseStoreNoB,Maching,Brand,Model,SerialNo,Parameter,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,@allotStockDate,@operator,WarehouseStoreNo,@scrapReason
 from tb_Stocks where ID=@id  
 delete from tb_Stocks where ID=@id
END
Go
/**Get**/
Create Procedure [dbo].[GetAllotStocks]
(
	@eventNo		nvarchar(50)
)
AS
declare @where nvarchar(300)
declare @sql nvarchar(1000)
set @where=' where 1=1 '
if @eventNo<>''
begin
	set @where=@where+' and EventNo = '''+@eventNo+''' order by Maching '
end
else
begin
	set @where=@where+' order by AllotStockDate desc '
end
set @sql = 'select EventNo,WarehouseStoreNoA,WarehouseStoreNoB,Maching,Brand,Model,SerialNo,Parameter,convert(varchar(20),AllotStockDate,111) as AllotStockDate,Operator,AllotStockState 
 from tb_AllotStocks' + @where
exec sp_executesql @sql
Go
Create Procedure [dbo].[GetCountAllotStocksState]
(
	@eventNo		nvarchar(50)
)
AS
BEGIN
 select COUNT(AllotStockState) from tb_AllotStocks where EventNo=@eventNo and AllotStockState='1'
END
Go
/***************************AllotStocks***************************/

/***************************AppointEngineers***************************/	
/**Add**/
create Procedure [dbo].[AddAppointEngineers]
(
	@eventNo		nvarchar(50),
	@name			nvarchar(50),
	@appointState	nvarchar(50)
	
)
AS
BEGIN
 declare @phonevalue	nvarchar(50)
 declare @email			nvarchar(50)
 select @phonevalue=Phone,@email=Email from tb_People where Name=@name
 insert into tb_AppointEngineers(EventNo,Name,Phone,Email,SceneTime,AppointState) values(@eventNo,@name,@phonevalue,@email,NULL,@appointState)
END
Go
/**Get**/
Create Procedure [dbo].[GetAppointEngineersByEventNo]
(
	@eventNo		nvarchar(50)
)
AS
BEGIN
 select ID,Name,Phone,Email,SceneTime,AppointState from tb_AppointEngineers where EventNo=@eventNo order by ID
END
Go
Create Procedure [dbo].[GetEmailFromEngineers]
(
	@eventNo	nvarchar(50)
)
AS
declare @email1		nvarchar(50)
declare @email2		nvarchar(50)
declare @solver1	nvarchar(50)
declare	@smtp		nvarchar(50)
declare	@ePassword	nvarchar(50)
declare @name		nvarchar(50)
declare @typeCode	nvarchar(50)
declare @eventName	nvarchar(50)
declare @sceneTime	nvarchar(50)
begin
select top 1 @solver1=Solver, @email1=Email, @smtp=SMTP, @ePassword=EPassword from tb_Solver where SMTP<>'' and SMTP is not null and EPassword <> '' and EPassword is not null
select top 1 @name=Name,@email2=Email,@sceneTime=convert(varchar(20),SceneTime,120) from tb_AppointEngineers where AppointState='2' and EventNo=@eventNo order by ID desc
select @typeCode=TypeCode from tb_EventLogs where EventNo=@eventNo
select @eventName=TypeOne+'-'+TypeTwo+'-'+TypeThree+'-'+TypeFour from tb_EventTypes where TypeCode=@typeCode
select @email1,@smtp,@ePassword,@name,@email2,@eventName,@sceneTime,@typeCode from tb_AppointEngineers
end
Go
/**Uptate**/
Create Procedure UpdateAppointState
(
	@id int,
	@appointState	nvarchar(50),
	@sceneTime		nvarchar(50)
)
as
begin
if @sceneTime=''
begin
set @sceneTime=NULL
end
	update tb_AppointEngineers set AppointState=@appointState,SceneTime=@sceneTime where ID = @id
end
go
/***************************AppointEngineers***************************/

/***************************SceneState***************************/
/**Add**/
Create Procedure [dbo].[AddSceneState]
(
	@eventNo		nvarchar(50),
	@sceneState		nvarchar(50)
)
AS
BEGIN
 insert into tb_SceneState(EventNo,SceneState) values(@eventNo,@sceneState)
END
Go
/**Get**/
Create Procedure [dbo].[GetSceneStateByEventNo]
(
	@eventNo		nvarchar(50)
)
AS
BEGIN
 select SceneState from tb_SceneState where EventNo=@eventNo
END
Go
/**Uptate**/
Create Procedure UpdateSceneState
(
	@eventNo		nvarchar(50),
	@sceneState		nvarchar(50)
)
as
begin
	update tb_SceneState set SceneState=@sceneState where EventNo = @eventNo
end
go
/***************************AppointEngineers***************************/

/***************************HistoryService***************************/
/**Add**/
Create Procedure [dbo].[AddHistoryServiceFromStocks]
(
	@eventNo				nvarchar(50),
	@serviceDate			nvarchar(50)
)
AS
BEGIN
--declare		@num		int
--declare		@count		int
--set @count = (select count(EventNo) from tb_Stocks where EventNo=@eventNo)
--set @num=0
--while @num<@count
--begin
-- set @num=@num+1
 insert into tb_HistoryService(EventNo,Maching,Brand,Model,SerialNo,Parameter,PurchaseDate,Supplier,ServiceDate) 
 select EventNo,Maching,Brand,Model,SerialNo,Parameter,PurchaseDate,Supplier,@serviceDate from tb_Stocks where EventNo=@eventNo
--end
 update tb_Stocks set EventNo=NULL where EventNo=@eventNo
END
Go
/**Get**/
Create Procedure [dbo].[GetHistoryServiceByEventNo]
(
	@eventNo		nvarchar(50)
)
AS
BEGIN
 select EventNo,Maching,Brand,Model,SerialNo,Parameter,convert(varchar(20),PurchaseDate,111)as PurchaseDate,Supplier,convert(varchar(20),ServiceDate,111)as ServiceDate from tb_HistoryService where EventNo=@eventNo
END
Go
/***************************HistoryService***************************/

/***************************Paging***************************/
Create PROCEDURE [dbo].[GetPageOfRecords]
  @pageSize int = 3,           --��ҳ��С
  @currentPage int = 2 ,            --�ڼ�ҳ
  @columns nvarchar(4000) = '', --��Ҫ�õ����ֶ� 
  @tableName nvarchar(4000) = '',      --��Ҫ��ѯ�ı�    
  @condition nvarchar(4000) = '',--��ѯ����, ���ü�where�ؼ���
  @ascColumn nvarchar(4000) = '', --������ֶ��� (�� order by column asc/desc)
  @bitOrderType bit = 0,        --��������� (0Ϊ����,1Ϊ����)
  @pkColumn nvarchar(50) = ''    --��������

AS
BEGIN                                                                                   
DECLARE @strTemp varchar(300)
DECLARE @strSql varchar(5000)                            
DECLARE @strOrderType varchar(1000)              

IF @bitOrderType = 1 
  BEGIN
    SET @strOrderType = ' ORDER BY '+@ascColumn+' DESC'
    SET @strTemp = '<(SELECT min'
  END
ELSE    
  BEGIN
    SET @strOrderType = ' ORDER BY '+@ascColumn+' ASC'
    SET @strTemp = '>(SELECT max'
  END

IF @currentPage = 1
  BEGIN
    IF @condition <> ''
      SET @strSql = 'SELECT TOP '+STR(@pageSize)+' '+@columns+' FROM '+@tableName+' WHERE '+@condition+@strOrderType
    ELSE
      SET @strSql = 'SELECT TOP '+STR(@pageSize)+' '+@columns+' FROM '+@tableName+@strOrderType
  END
ELSE        
  BEGIN
    IF @condition <>''
      SET @strSql = 'SELECT TOP '+STR(@pageSize)+' '+@columns+' FROM '+@tableName+ ' WHERE '+@condition+' AND '+@pkColumn+@strTemp+'('+@pkColumn+')'+' FROM (SELECT TOP '+STR((@currentPage-1)*@pageSize)+
      ' '+@pkColumn+' FROM '+@tableName+' where '+@condition+@strOrderType+') AS TabTemp)'+@strOrderType
    ELSE
      SET @strSql = 'SELECT TOP '+STR(@pageSize)+' '+@columns+' FROM '+@tableName+
      ' WHERE '+@pkColumn+@strTemp+'('+@pkColumn+')'+' FROM (SELECT TOP '+STR((@currentPage-1)*@pageSize)+' '+@pkColumn+
      ' FROM '+@tableName+@strOrderType+') AS TabTemp)'+@strOrderType
  END

print @strSql
EXEC (@strSql)
END  
Go
Create Procedure [dbo].[GetAllotStocksPaged]
(
	@eventNo				nvarchar(50)='',
	@storeNoA				nvarchar(50)='',
	@storeNoB				nvarchar(50)='',
	@maching				nvarchar(50)='',
	@brand					nvarchar(50)='',
	@model					nvarchar(50)='',
	@serialNo				nvarchar(50)='',	
	@parameter				nvarchar(50)='',	
	@allotStockDateA		nvarchar(50)='',
	@allotStockDateB		nvarchar(50)='',
	@operator				nvarchar(50)='',
	@allotStockState		nvarchar(50)='',
	@pageSize				int = 3,
	@pageIndex				int = 2
)
AS
declare @where nvarchar(300)
declare @sql nvarchar(1000)
set @where=' 1=1 '
if @eventNo<>''
	set @where=@where+' and EventNo = '''+@eventNo+''' '
if @storeNoA<>''
	set @where=@where+' and WarehouseStoreNoA = '''+@storeNoA+''' '
if @storeNoB<>''
	set @where=@where+' and WarehouseStoreNoB = '''+@storeNoB+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @serialNo<>''
	set @where=@where+' and SerialNo =	'''+@serialNo+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @allotStockDateA<>''
	set @where=@where+' and AllotStockDate >= '''+@allotStockDateA+''' '
if @allotStockDateB<>''
	set @where=@where+' and AllotStockDate <= '''+@allotStockDateB+''' '
if @operator<>''
	set @where=@where+' and Operator =	'''+@operator+''' '
if @allotStockState<>''
	set @where=@where+' and AllotStockState = '''+@allotStockState+''' '	

	
set @sql = ' ID,EventNo
      ,WarehouseStoreNoA
      ,WarehouseStoreNoB
      ,Maching
      ,Brand
      ,Model
      ,SerialNo
      ,Parameter
      ,convert(varchar(20),AllotStockDate,111) AllotStockDate
      ,Operator
      ,case AllotStockState when 0 then ''����'' else ''�쳣'' end as AllotStockState'
      
exec dbo.GetPageOfRecords @pageSize, @pageIndex, @sql, 'dbo.tb_AllotStocks', @where, 'ID', 1, 'ID'
Go
Create Procedure [dbo].[GetAllotStocksTotal]
(
	@eventNo				nvarchar(50)='',
	@storeNoA				nvarchar(50)='',
	@storeNoB				nvarchar(50)='',
	@maching				nvarchar(50)='',
	@brand					nvarchar(50)='',
	@model					nvarchar(50)='',
	@serialNo				nvarchar(50)='',	
	@parameter				nvarchar(50)='',	
	@allotStockDateA		nvarchar(50)='',
	@allotStockDateB		nvarchar(50)='',
	@operator				nvarchar(50)='',
	@allotStockState		nvarchar(50)=''
)
AS
declare @where nvarchar(300)
declare @sql nvarchar(1000)
set @where=' where 1=1 '
if @eventNo<>''
	set @where=@where+' and EventNo = '''+@eventNo+''' '
if @storeNoA<>''
	set @where=@where+' and WarehouseStoreNoA = '''+@storeNoA+''' '
if @storeNoB<>''
	set @where=@where+' and WarehouseStoreNoB = '''+@storeNoB+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @serialNo<>''
	set @where=@where+' and SerialNo =	'''+@serialNo+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @allotStockDateA<>''
	set @where=@where+' and AllotStockDate >= '''+@allotStockDateA+''' '
if @allotStockDateB<>''
	set @where=@where+' and AllotStockDate <= '''+@allotStockDateB+''' '
if @operator<>''
	set @where=@where+' and Operator =	'''+@operator+''' '
if @allotStockState<>''
	set @where=@where+' and AllotStockState = '''+@allotStockState+''' '	

	
set @sql = 'select ID,EventNo
      ,WarehouseStoreNoA
      ,WarehouseStoreNoB
      ,Maching
      ,Brand
      ,Model
      ,SerialNo
      ,Parameter
      ,convert(varchar(20),AllotStockDate,111) AllotStockDate
      ,Operator
      ,case AllotStockState when 0 then ''����'' else ''�쳣'' end as AllotStockState
 from tb_AllotStocks' + @where
exec sp_executesql @sql
Go
Create Procedure [dbo].[GetStocksPaged]
(	
	@warehouseStoreNo		nvarchar(50)='',
	@maching				nvarchar(50)='',
	@brand					nvarchar(50)='',
	@model					nvarchar(50)='',
	@parameter				nvarchar(50)='',
	@supplier				nvarchar(50)='',
	@addStockDateA			nvarchar(50)='',
	@addStockDateB			nvarchar(50)='',	
	@machingState			nvarchar(50)='',
	@pageSize				int = 3,
	@pageIndex				int = 1
)
AS
begin
declare @where nvarchar(2000)
declare @sql nvarchar(2000)
set @where=' 1=1 and StockType=0 '
if @warehouseStoreNo<>''
	set @where=@where+' and WarehouseStoreNo = '''+@warehouseStoreNo+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @supplier<>''
	set @where=@where+' and Supplier = '''+@supplier+''' '
if @addStockDateA<>''
	set @where=@where+' and AddStockDate >= '''+@addStockDateA+''' '
if @addStockDateB<>''
	set @where=@where+' and AddStockDate <= '''+@addStockDateB+''' '
if @machingState<>''
	set @where=@where+' and MachingState = '''+@machingState+''' '
	
set @sql=' ID, WarehouseStoreNo, Maching, Brand, Model, Parameter, SerialNo, EpcTags, SapNo, convert(varchar(20),PurchaseDate,111) as PurchaseDate,
convert(varchar(20),GuaranteeTime,111) as GuaranteeTime, RepairsNo, Supplier, convert(varchar(20),AddStockDate,111) as AddStockDate,
convert(varchar(20),OutStockDate,111) as OutStockDate '

exec dbo.GetPageOfRecords @pageSize, @pageIndex, @sql, 'dbo.tb_Stocks', @where, 'ID', 1, 'ID'
end
Go

Create Procedure [dbo].[GetAddStocksPaged]
(	
	@warehouseNo			nvarchar(50)='',
	@maching				nvarchar(50)='',
	@brand					nvarchar(50)='',
	@model					nvarchar(50)='',
	@parameter				nvarchar(50)='',
	@supplier				nvarchar(50)='',
	@addStockDateA			nvarchar(50)='',
	@addStockDateB			nvarchar(50)='',
	@pageSize				int = 3,
	@pageIndex				int = 1
)
AS
begin
declare @where nvarchar(2000)
declare @sql nvarchar(2000)
set @where=' 1=1 '
if @warehouseNo<>''
	set @where=@where+' and WarehouseNo = '''+@warehouseNo+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @supplier<>''
	set @where=@where+' and Supplier = '''+@supplier+''' '
if @addStockDateA<>''
	set @where=@where+' and AddStockDate >= '''+@addStockDateA+''' '
if @addStockDateB<>''
	set @where=@where+' and AddStockDate <= '''+@addStockDateB+''' '

	
set @sql=' ID, WarehouseNo, Maching, Brand, Model, Parameter, SerialNo, EpcTags, SapNo, convert(varchar(20),PurchaseDate,111) as PurchaseDate,
convert(varchar(20),GuaranteeTime,111) as GuaranteeTime, RepairsNo, Supplier, convert(varchar(20),AddStockDate,111) as AddStockDate '

exec dbo.GetPageOfRecords @pageSize, @pageIndex, @sql, 'dbo.tb_AddStocks', @where, 'ID', 1, 'ID'
end
Go

Create Procedure [dbo].[GetOutStocksTotal]
(
	@eventNo				nvarchar(50)='',
	@warehouseNo			nvarchar(50)='',
	@storeNo				nvarchar(50)='',
	@maching				nvarchar(50)='',
	@brand					nvarchar(50)='',
	@model					nvarchar(50)='',	
	@parameter				nvarchar(50)='',
	@supplier				nvarchar(50)='',
	@outStockDateA			nvarchar(50)='',
	@outStockDateB			nvarchar(50)='',
	@outStocksState			nvarchar(50)=''
)
AS
declare @where nvarchar(300)
declare @sql nvarchar(1000)
set @where=' where 1=1 '
if @eventNo<>''
	set @where=@where+' and EventNo = '''+@eventNo+''' '
if @warehouseNo<>''
	set @where=@where+' and WarehouseNo = '''+@warehouseNo+''' '
if @storeNo<>''
	set @where=@where+' and StoreNo = '''+@storeNo+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @supplier<>''
	set @where=@where+' and Supplier = '''+@supplier+''' '
if @outStockDateA<>''
	set @where=@where+' and OutStockDate >= '''+@outStockDateA+''' '
if @outStockDateB<>''
	set @where=@where+' and OutStockDate <= '''+@outStockDateB+''' '
if @outStocksState<>''
	set @where=@where+' and OutStocksState <= '''+@outStocksState+''' '
		

	
set @sql = 'select ID, EventNo, WarehouseNo, StoreNo, Maching, Brand, Model, Parameter, SerialNo, EpcTags, SapNo, convert(varchar(20),PurchaseDate,111) as PurchaseDate,
convert(varchar(20),GuaranteeTime,111) as GuaranteeTime, RepairsNo, Supplier, convert(varchar(20),OutStockDate,111) as OutStockDate,case OutStocksState when 0 then ''����'' else ''�쳣'' end as OutStocksState 
 from tb_OutStocks' + @where
exec sp_executesql @sql
Go
Create Procedure [dbo].[GetOutStocksPaged]
(	
	@eventNo				nvarchar(50)='',
	@warehouseNo			nvarchar(50)='',
	@storeNo				nvarchar(50)='',
	@maching				nvarchar(50)='',
	@brand					nvarchar(50)='',
	@model					nvarchar(50)='',	
	@parameter				nvarchar(50)='',
	@supplier				nvarchar(50)='',
	@outStockDateA			nvarchar(50)='',
	@outStockDateB			nvarchar(50)='',
	@outStocksState			nvarchar(50)='',
	@pageSize				int = 3,
	@pageIndex				int = 1
)
AS
begin
declare @where nvarchar(2000)
declare @sql nvarchar(2000)
set @where=' 1=1 '
if @eventNo<>''
	set @where=@where+' and EventNo = '''+@eventNo+''' '
if @warehouseNo<>''
	set @where=@where+' and WarehouseNo = '''+@warehouseNo+''' '
if @storeNo<>''
	set @where=@where+' and StoreNo = '''+@storeNo+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @supplier<>''
	set @where=@where+' and Supplier = '''+@supplier+''' '
if @outStockDateA<>''
	set @where=@where+' and OutStockDate >= '''+@outStockDateA+''' '
if @outStockDateB<>''
	set @where=@where+' and OutStockDate <= '''+@outStockDateB+''' '
if @outStocksState<>''
	set @where=@where+' and OutStocksState <= '''+@outStocksState+''' '
	
set @sql='ID, EventNo, WarehouseNo, StoreNo, Maching, Brand, Model, Parameter, SerialNo, EpcTags, SapNo, convert(varchar(20),PurchaseDate,111) as PurchaseDate,
convert(varchar(20),GuaranteeTime,111) as GuaranteeTime, RepairsNo, Supplier, convert(varchar(20),OutStockDate,111) as OutStockDate,case OutStocksState when 0 then ''����'' else ''�쳣'' end as OutStocksState  '

exec dbo.GetPageOfRecords @pageSize, @pageIndex, @sql, 'dbo.tb_OutStocks', @where, 'ID', 1, 'ID'
end
Go
Create Procedure [dbo].[GetEventLogsTotal]
(
	@eventTimeA		nvarchar(50)='',
	@eventTimeB		nvarchar(50)='',
	@storeNo		nvarchar(50)='',
	@typeCode		nvarchar(50)='',
	@eventState		nvarchar(50)='',
	@eventNo		nvarchar(50)=''
)
AS
begin
DECLARE  @where   nvarchar(500)
DECLARE  @sql   nvarchar(1000)
	
	
	SET @where=' where 1=1 '
if @eventTimeA<>''
begin
	SET @where=@where+' and EventTime >= '''+@eventTimeA+''''
end
if @eventTimeB<>''
begin
	SET @where=@where+' and EventTime <= '''+@eventTimeB+''''
end
if @storeNo<>''
begin
	SET @where=@where+' and StoreNo= '''+@storeNo+''''
end
if @typeCode<>''
begin
	if @typeCode<>'9999' and @typeCode<>'9000' and @typeCode<>'8888'
	begin
		SET @where=@where+' and TypeCode= '''+@typeCode+''' '
	end
	if @typeCode='9999'
	begin
		SET @where=@where+' and TypeCode= ''9999'' '
	end
	if @typeCode='9000'
	begin	
		SET @where=@where+' and TypeCode= ''9000'' '
	end
	if @typeCode='8888'
	begin
		SET @where=@where+' and TypeCode= ''8888'' '	
	end
end
else
begin
	SET @where=@where+' and TypeCode<> ''9999'' and TypeCode<> ''9000'' and TypeCode<> ''8888'' '
end
if @eventState<>''
begin
	SET @where=@where+' and EventState= '''+@eventState+''''
end
if @eventNo<>''
begin
	SET @where=@where+' and EventNo= '''+@eventNo+''''
end

set @sql='select EventNo,EventTime,StoreNo,TypeCode,EventDescribe,ResolvedBy,convert(nvarchar(10),ToResolvedTime,127) ToResolvedTime,StateName as EventState,LogBy from tb_EventLogs left join tb_EventState on tb_EventLogs.EventState=tb_EventState.StateID '+ @where +' order by EventTime desc '
exec sp_executesql @sql
end
Go
Create Procedure [dbo].[GetEventLogsPaged]
(
	@eventTimeA		nvarchar(50)='',
	@eventTimeB		nvarchar(50)='',
	@storeNo		nvarchar(50)='',
	@typeCode		nvarchar(50)='',
	@eventState		nvarchar(50)='',
	@eventNo		nvarchar(50)='',
	@pageSize		int = 3,
	@pageIndex		int = 1
)
AS
begin
DECLARE  @where   nvarchar(500)
DECLARE  @sql   nvarchar(1000)
	
	
	SET @where='  1=1 '
if @eventTimeA<>''
begin
	SET @where=@where+' and EventTime >= '''+@eventTimeA+''''
end
if @eventTimeB<>''
begin
	SET @where=@where+' and EventTime <= '''+@eventTimeB+''''
end
if @storeNo<>''
begin
	SET @where=@where+' and StoreNo= '''+@storeNo+''''
end
if @typeCode<>''
begin
	if @typeCode<>'9999' and @typeCode<>'9000' and @typeCode<>'8888'
	begin
		SET @where=@where+' and TypeCode= '''+@typeCode+''' '
	end
	if @typeCode='9999'
	begin
		SET @where=@where+' and TypeCode= ''9999'' '
	end
	if @typeCode='9000'
	begin	
		SET @where=@where+' and TypeCode= ''9000'' '
	end
	if @typeCode='8888'
	begin
		SET @where=@where+' and TypeCode= ''8888'' '	
	end
end
else
begin
	SET @where=@where+' and TypeCode<> ''9999'' and TypeCode<> ''9000'' and TypeCode<> ''8888'' '
end
if @eventState<>''
begin
	SET @where=@where+' and EventState= '''+@eventState+''''
end
if @eventNo<>''
begin
	SET @where=@where+' and EventNo= '''+@eventNo+''''
end

set @sql=' EventNo,EventTime,StoreNo,TypeCode,EventDescribe,ResolvedBy,convert(nvarchar(10),ToResolvedTime,127) ToResolvedTime,StateName as EventState,LogBy '

exec dbo.GetPageOfRecords @pageSize, @pageIndex, @sql, 'dbo.tb_EventLogs left join tb_EventState on tb_EventLogs.EventState=tb_EventState.StateID', @where, 'ID', 1, 'ID'
end
Go
----------
Create Procedure [dbo].[GetScrapStocksTotal]
(
	@warehouseNo			nvarchar(50)='',
	@maching				nvarchar(50)='',
	@brand					nvarchar(50)='',
	@model					nvarchar(50)='',	
	@parameter				nvarchar(50)='',
	@supplier				nvarchar(50)='',
	@addScrapStockDateA		nvarchar(50)='',
	@addScrapStockDateB		nvarchar(50)=''
)
AS
declare @where nvarchar(300)
declare @sql nvarchar(1000)
set @where=' where 1=1 '
if @warehouseNo<>''
	set @where=@where+' and WarehouseNo = '''+@warehouseNo+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @supplier<>''
	set @where=@where+' and Supplier = '''+@supplier+''' '
if @addScrapStockDateA<>''
	set @where=@where+' and AddScrapStockDate >= '''+@addScrapStockDateA+''' '
if @addScrapStockDateB<>''
	set @where=@where+' and AddScrapStockDate <= '''+@addScrapStockDateB+''' '	

	
set @sql = 'select ID, WarehouseNo, Maching, Brand, Model, Parameter, SerialNo, EpcTags,
RepairsNo, Supplier, convert(varchar(20),AddScrapStockDate,111) as AddScrapStockDate,Operator,LastWarehouseNo,ScrapReason
 from tb_ScrapStocks' + @where
exec sp_executesql @sql
Go
Create Procedure [dbo].[GetScrapStocksPaged]
(	
	@warehouseNo			nvarchar(50)='',
	@maching				nvarchar(50)='',
	@brand					nvarchar(50)='',
	@model					nvarchar(50)='',	
	@parameter				nvarchar(50)='',
	@supplier				nvarchar(50)='',
	@addScrapStockDateA		nvarchar(50)='',
	@addScrapStockDateB		nvarchar(50)='',	
	@pageSize				int = 3,
	@pageIndex				int = 1
)
AS
begin
declare @where nvarchar(1000)
declare @sql nvarchar(2000)
set @where=' 1=1 '
if @warehouseNo<>''
	set @where=@where+' and WarehouseNo = '''+@warehouseNo+''' '
if @maching<>''
	set @where=@where+' and Maching = '''+@maching+''' '
if @brand<>''
	set @where=@where+' and Brand = '''+@brand+''' '
if @model<>''
	set @where=@where+' and Model =	'''+@model+''' '
if @parameter<>''
	set @where=@where+' and Parameter = '''+@parameter+''' '
if @supplier<>''
	set @where=@where+' and Supplier = '''+@supplier+''' '
if @addScrapStockDateA<>''
	set @where=@where+' and AddScrapStockDate >= '''+@addScrapStockDateA+''' '
if @addScrapStockDateB<>''
	set @where=@where+' and AddScrapStockDate <= '''+@addScrapStockDateB+''' '
	
set @sql='ID, WarehouseNo, Maching, Brand, Model, Parameter, SerialNo, EpcTags,
RepairsNo, Supplier, convert(varchar(20),AddScrapStockDate,111) as AddScrapStockDate,Operator,LastWarehouseNo,ScrapReason '

exec dbo.GetPageOfRecords @pageSize, @pageIndex, @sql, 'dbo.tb_ScrapStocks', @where, 'ID', 1, 'ID'
end
Go
/***************************Paging***************************/

/***************************IndexCount***************************/
Create Procedure [dbo].[CountNormalEventLog]

AS
BEGIN
 select count(EventNo) from tb_EventLogs where EventState='99'
END
Go
Create Procedure [dbo].[CountSetUpShopEventLog]

AS
BEGIN
 select count(EventNo) from tb_EventLogs where EventState>='101' and EventState<='199'
END
Go
Create Procedure [dbo].[CountShutUpShopEventLog]

AS
BEGIN
 select count(EventNo) from tb_EventLogs where EventState>='201' and EventState<='299'
END
Go
Create Procedure [dbo].[CountStoreRenovationEventLog]

AS
BEGIN
 select count(EventNo) from tb_EventLogs where EventState>='301' and EventState<='399'
END
Go
Create Procedure [dbo].[GetUrgentNormalEventLog]

AS
BEGIN
	select * from (select tb_EventLogs.EventNo,EventTime,StoreNo,TypeCode,EventDescribe,StateName as EventState,LogBy,StepDescribe,row_number() over (partition by tb_EventLogs.EventNo order by tb_EventSteps.ID desc) as rn 
	from tb_EventLogs 
	left join tb_EventState on tb_EventLogs.EventState=tb_EventState.StateID  
	left join tb_EventSteps on tb_EventLogs.EventNo=tb_EventSteps.EventNo 
	where EventState<>'0') tm where tm.rn=1  
	order by tm.EventTime desc 
END
Go
Create Procedure [dbo].[GetUrgentSetUpShopEventLog]

AS
BEGIN
	select * from (select tb_EventLogs.EventNo,EventTime,StoreNo,TypeCode,EventDescribe,convert(nvarchar(10),ToResolvedTime,127) ToResolvedTime,StateName as EventState,LogBy,StepDescribe,row_number() over (partition by tb_EventLogs.EventNo order by tb_EventSteps.ID desc) as rn 
	from tb_EventLogs 
	left join tb_EventState on tb_EventLogs.EventState=tb_EventState.StateID 
	left join tb_EventSteps on tb_EventLogs.EventNo=tb_EventSteps.EventNo 
	where TypeCode='9999' and EventState<>'100' and tb_EventState.StateDay >= DATEDIFF(dd,getdate(),convert(nvarchar(10),tb_EventLogs.ToResolvedTime,127)) ) tm where tm.rn=1 
	order by EventTime desc
END
Go
Create Procedure [dbo].[GetUrgentShutUpShopEventLog]

AS
BEGIN
	select * from (select tb_EventLogs.EventNo,EventTime,StoreNo,TypeCode,EventDescribe,convert(nvarchar(10),ToResolvedTime,127) ToResolvedTime,StateName as EventState,LogBy,StepDescribe,row_number() over (partition by tb_EventLogs.EventNo order by tb_EventSteps.ID desc) as rn 
	from tb_EventLogs 
	left join tb_EventState on tb_EventLogs.EventState=tb_EventState.StateID 
	left join tb_EventSteps on tb_EventLogs.EventNo=tb_EventSteps.EventNo 
	where TypeCode='9000' and EventState<>'200' and tb_EventState.StateDay >= DATEDIFF(dd,getdate(),convert(nvarchar(10),tb_EventLogs.ToResolvedTime,127)) ) tm where tm.rn=1 
	order by EventTime desc
END
Go
Create Procedure [dbo].[GetUrgentStoreRenovationEventLog]

AS
BEGIN
	select * from (select tb_EventLogs.EventNo,EventTime,StoreNo,TypeCode,EventDescribe,convert(nvarchar(10),ToResolvedTime,127) ToResolvedTime,StateName as EventState,LogBy,StepDescribe,row_number() over (partition by tb_EventLogs.EventNo order by tb_EventSteps.ID desc) as rn 
	from tb_EventLogs 
	left join tb_EventState on tb_EventLogs.EventState=tb_EventState.StateID 
	left join tb_EventSteps on tb_EventLogs.EventNo=tb_EventSteps.EventNo
	where TypeCode='8888' and EventState<>'300' and tb_EventState.StateDay >= DATEDIFF(dd,getdate(),convert(nvarchar(10),tb_EventLogs.ToResolvedTime,127)) ) tm where tm.rn=1
	order by EventTime desc
END
Go

/***************************IndexCount***************************/

/***************************SystemUser***************************/
insert into tb_SystemUser(UserName,[Password],CreateTime,UserState) values('SystemAdmin','SystemAdmin',GETDATE(),1)
insert into tb_Permission(UserName,[Admin],[Index],UpdateSolution,EventQuery,CreateEvent,ReportFormsEvent,AddStock,StockQuery,OutStockQuery,AllotStockQuery,AddStockQuery,AlterStore,EventTypes,FacilityManage,PeopleManage,SynthesisManage,EventState,InitialStores,InitialStocks,[ScrapStocks])values('SystemAdmin',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
Go
/**Add**/
Create Procedure [dbo].[AddSystemUser]
(
	@userName		nvarchar(50),
	@password		nvarchar(50),
	@createTime		datetime
)
as
begin
if not exists(select UserName from tb_SystemUser where UserName=@userName)
begin 
insert into tb_SystemUser(UserName,[Password],CreateTime,UserState) values(@userName,@password,@createTime,0)
insert into tb_Permission(UserName,[Admin],[Index],UpdateSolution,EventQuery,CreateEvent,ReportFormsEvent,AddStock,StockQuery,OutStockQuery,AllotStockQuery,AddStockQuery,AlterStore,EventTypes,FacilityManage,PeopleManage,SynthesisManage,EventState,InitialStores,InitialStocks,[ScrapStocks])
						values(@userName,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
end
end
Go
/**Get**/
Create Procedure [dbo].[GetSystemUser]

AS
begin
select row_number()over(order by UserName) as RowNum,UserName,[Password],convert(nvarchar(10),CreateTime,127) as CreateTime,convert(nvarchar(10),LastLogOnTime,127) as LastLogOnTime,case UserState when 0 then '������' else '������' end as UserState from tb_SystemUser where UserName<>'SystemAdmin' order by UserName
end
Go
Create Procedure [dbo].[GetCheckSystemUserPassword]
(
	@userName		nvarchar(50),
	@password		nvarchar(50)
)
AS
begin
select count(UserName) from tb_SystemUser where UserName =@userName	and [Password]=@password and UserState=1
end
Go
Create Procedure [dbo].[GetUserIP]
(
	@userName			nvarchar(50),
	@userIP				nvarchar(50)
)
AS
begin
select UserIP from tb_SystemUser where UserName = @userName and UserIP=@userIP
end
Go
/**Del**/
Create Procedure [dbo].[DelSystemUser]
(
	@userName  nvarchar(50)
)
AS
begin
delete from tb_Permission where UserName =@userName	
delete from tb_SystemUser where UserName =@userName
end
Go
/**Update**/
Create Procedure [dbo].[UpdateSystemUserByUserName]
(
	@userName		nvarchar(50),
	@password		nvarchar(50)
)
AS
begin
update tb_SystemUser set [Password]=@password where UserName =@userName
end
Go
Create Procedure [dbo].[UpdateUserStateByUserName]
(
	@userName		nvarchar(50),
	@userState		int
)
AS
begin
update tb_SystemUser set UserState=@userState where UserName =@userName
end
Go
Create Procedure [dbo].[UpdateLogOnByUserName]
(
	@userName			nvarchar(50),
	@userIP				nvarchar(50)
)
AS
begin
update tb_SystemUser set LastLogOnTime=GETDATE(),UserIP=@userIP where UserName =@userName
end
Go
/***************************SystemUser***************************/

/***************************Permission***************************/
/**Get**/
Create Procedure [dbo].[GetOnePermission]
(
	@userName			nvarchar(50),
	@temp				nvarchar(50)
)
AS
declare @field nvarchar(50)
declare @sql nvarchar(1000)
begin
if @temp='0'
set @field='[Index]'
if @temp='1'
set @field='UpdateSolution'
if @temp='2'
set @field='EventQuery'
if @temp='3'
set @field='CreateEvent'
if @temp='4'
set @field='ReportFormsEvent'
if @temp='5'
set @field='AddStock'
if @temp='6'
set @field='StockQuery'
if @temp='7'
set @field='OutStockQuery'
if @temp='8'
set @field='AllotStockQuery'
if @temp='9'
set @field='AddStockQuery'
if @temp='10'
set @field='AlterStore'
if @temp='11'
set @field='EventTypes'
if @temp='12'
set @field='FacilityManage'
if @temp='13'
set @field='PeopleManage'
if @temp='14'
set @field='SynthesisManage'
if @temp='15'
set @field='EventState'
if @temp='16'
set @field='InitialStores'
if @temp='17'
set @field='InitialStocks'
if @temp='18'
set @field='[Admin]'
if @temp='19'
set @field='[ScrapStocks]'

	
set @sql ='select '+@field+' 
from tb_Permission where UserName = '''+@userName+''' '

exec(@sql)
end
Go
Create Procedure [dbo].[GetPermission]
(
	@userName			nvarchar(50)
)
AS
declare @sql nvarchar(2000)
begin
 set @sql=' select UserName,[Index],UpdateSolution,EventQuery,CreateEvent,ReportFormsEvent,AddStock,StockQuery,OutStockQuery,AllotStockQuery,AddStockQuery,AlterStore,EventTypes,FacilityManage,PeopleManage,SynthesisManage,EventState,InitialStores,InitialStocks,[Admin],[ScrapStocks] 
from tb_Permission where UserName = '''+@userName+''''
exec(@sql)
end
Go
/**Update**/
Create Procedure [dbo].[UpdatePermissionByUserName]
(
	@userName			nvarchar(50),
	@index				int,
	@updateSolution		int,
	@eventQuery			int,
	@createEvent		int,
	@reportFormsEvent	int,
	@addStock			int,
	@stockQuery			int,
	@outStockQuery		int,
	@allotStockQuery	int,
	@addStockQuery		int,
	@alterStore			int,
	@eventTypes			int,
	@facilityManage		int,
	@peopleManage		int,
	@synthesisManage	int,
	@eventState			int,
	@initialStores		int,
	@initialStocks		int,
	@scrapStocks		int
)
AS
begin
update tb_Permission set [Index]=@index,UpdateSolution=@updateSolution,EventQuery=@eventQuery,CreateEvent=@createEvent,
						ReportFormsEvent=@reportFormsEvent,AddStock=@addStock,StockQuery=@stockQuery,OutStockQuery=@outStockQuery,
						AllotStockQuery=@allotStockQuery,AddStockQuery=@addStockQuery,AlterStore=@alterStore,EventTypes=@eventTypes,
						FacilityManage=@facilityManage,PeopleManage=@peopleManage,SynthesisManage=@synthesisManage,EventState=@eventState,
						InitialStores=@initialStores,InitialStocks=@initialStocks,[ScrapStocks]=@scrapStocks where UserName =@userName
end
Go
/***************************Permission***************************/



-------Testing-------

--insert into tb_Stores(StoreNo,TopStore,StoreType,Region,Rating,StoreName,City,StoreAddress,StoreTel,ContractArea,OpeingDate,StoreState)	values('6100','Yes','Focus','BJ','AAA','Fine','TJ','TJ','123456','90',cast('2012-12-20 10:20' as datetime),'998')
--insert into tb_Machings(Maching)values('�ʼǱ�')
--insert into tb_Machings(Maching)values('��ӡ��')
--insert into tb_Brands(Brand)values('����')
--insert into tb_Brands(Brand)values('CANNON')
--insert into tb_Models(Model)values('H4440')
--insert into tb_Models(Model)values('Ho000')
--insert into tb_Parameters(Parameter)values('2G')
--insert into tb_Parameters(Parameter)values('XG')
--insert into tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,OutStockDate,Operator,StockType,MachingState)
--values('000001','�ʼǱ�','����','H4440','ECT100301','2G',NULL,NULL,'2013-10-20','2013-10-20','123456','����','2013-10-20','2013-10-20','��ǰ�û�','0','0')
--insert into tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,OutStockDate,Operator,StockType,MachingState)
--values('000001','�ʼǱ�','����','H4440','ECT100311','2G',NULL,NULL,'2013-10-20','2013-10-20','123456','����','2013-10-20','2013-10-20','��ǰ�û�','0','0')
--insert into tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,OutStockDate,Operator,StockType,MachingState)
--values('000001','�ʼǱ�','����','H4440','ECT100321','2G',NULL,NULL,'2013-10-20','2013-10-20','123456','����','2013-10-20','2013-10-20','��ǰ�û�','0','0')
--insert into tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,OutStockDate,Operator,StockType,MachingState)
--values('000001','�ʼǱ�','���','H4440','NCC100301','2G',NULL,NULL,'2013-10-20','2013-10-20','123456','����','2013-10-20','2013-10-20','��ǰ�û�','0','0')
--insert into tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,OutStockDate,Operator,StockType,MachingState)
--values('000001','�ʼǱ�','����','M5110','ECM100301','2G',NULL,NULL,'2013-10-20','2013-10-20','123456','����','2013-10-20','2013-10-20','��ǰ�û�','0','0')
--insert into tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,OutStockDate,Operator,StockType,MachingState)
--values('000001','��ӡ��','CANNON','Ho000','ECM100351','XG',NULL,NULL,'2013-10-20','2013-10-20','123456','����','2013-10-20','2013-10-20','��ǰ�û�','0','0')
--insert into tb_Stocks(WarehouseStoreNo,Maching,Brand,Model,SerialNo,Parameter,EpcTags,SapNo,PurchaseDate,GuaranteeTime,RepairsNo,Supplier,AddStockDate,OutStockDate,Operator,StockType,MachingState)
--values('000001','�ʼǱ�','����','H4440','ECT100400','2G',NULL,NULL,'2013-10-20','2013-10-20','123456','����','2013-10-20','2013-10-20','��ǰ�û�','0','1')

--go


--select a.DemandNo into #Temp from (select DemandNo from tb_OutStockDemands where DemandNo not in(select DemandNo from tb_Stocks where DemandNo is not null))a
--declare @demandNo int
--declare @num int
--declare @count int
--set @num=0
--set @count = (select count(DemandNo) from #Temp)
--while @num<@count
--begin
--set @num=@num+1
--;with rownum_cte as
--(
--	select  DemandNo,row_number()over(order by DemandNo)as Rownum from #Temp
--)
--select @demandNo=DemandNo from rownum_cte where Rownum=@num

--;with upd_cte as
--(
--	select top 1 a.EventNo,a.DemandNo
--	from tb_Stocks a,tb_OutStockDemands b 
--	where a.Maching=b.Maching and a.Brand=b.Brand and a.Model=b.Model and a.Parameter=b.Parameter and b.DemandNo=@demandNo and a.DemandNo is null and a.StockType='0'
--	order by a.PurchaseDate
--)
--update upd_cte set EventNo='BJ20130427094457',DemandNo=@demandNo
--end
--drop table #Temp