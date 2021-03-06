USE [LUXERP]
GO
/****** Object:  StoredProcedure [dbo].[MonthPercent]    Script Date: 07/25/2013 11:45:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Procedure [dbo].[MonthPercent]
(
	@year	as nvarchar(4) = '2013'
)
AS
BEGIN
declare @s datetime
declare @e datetime

set @s = @year+'-01-01'
set @e = @year+'-12-31'

select m, Level1, Level2, Level3, Vender, Level1+Level2+Level3+Vender Total, 
       case when Level1+Level2+Level3+Vender=0 then 0 else ROUND(CAST(Level1 as float) / CAST((Level1+Level2+Level3+Vender) as float),4) * 100 end as Level1Per,
       case when Level1+Level2+Level3+Vender=0 then 0 else ROUND(CAST(Level2 as float) / CAST((Level1+Level2+Level3+Vender) as float),4) * 100 end as Level2Per,
       case when Level1+Level2+Level3+Vender=0 then 0 else ROUND(CAST(Level3 as float) / CAST((Level1+Level2+Level3+Vender) as float),4) * 100 end as Level3Per,
       case when Level1+Level2+Level3+Vender=0 then 0 else ROUND(CAST(Vender as float) / CAST((Level1+Level2+Level3+Vender) as float),4) * 100 end as VenderPer
from (select m, MAX(case when Level='Level 1' then n else 0 end) as Level1, MAX(case when Level='Level 2' then n else 0 end) as Level2,
	  MAX(case when Level='Level 3' then n else 0 end) as Level3, MAX(case when Level='Vender' then n else 0 end) as Vender
from (select MONTH(EventTime) m, ISNULL(a.ResolvedBy,a.HandingBy) Level, COUNT(*) n
	  from dbo.tb_EventLogs a left join dbo.tb_Stores b on a.StoreNo = b.StoreNo
	  where TypeCode not in('9000','9999','8888') and EventTime between @s and @e
	  group by MONTH(EventTime), ISNULL(a.ResolvedBy,a.HandingBy)
	 ) a group by m
	 ) b
 
END