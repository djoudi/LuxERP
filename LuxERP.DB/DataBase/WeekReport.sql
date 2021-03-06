USE [LUXERP]
GO
/****** Object:  StoredProcedure [dbo].[WeekReport]    Script Date: 09/03/2013 09:37:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Procedure [dbo].[WeekReport]
(
	@year	as nvarchar(4) = '2013',
	@week	as int = 35
)
AS
BEGIN
declare @date datetime
declare @s datetime
declare @e datetime
set @date = getdate()
if YEAR(@date) <> @year
	set @date = @year + '-01-01'

set @s = dateadd(week,datediff(week,0,dateadd(week,@week-1,dateadd(year,datediff(year,0,@date),0))),0)	 
if @week = 52
begin
	set @e = @year + '-12-31'
end
else
begin
	set @e = @s + 6
end

-- 过滤每周的原始数据
select *,case when N=0 then 0 else cast(SubTotal as float)/N  * 100 end as Per from
(select Region, 
Finish_Level1_Focus, Finish_Level1_IFocus, Finish_Level2_Focus, Finish_Level2_IFocus, 
Finish_Level3_Focus, Finish_Level3_IFocus, Finish_Vender_Focus,	Finish_Vender_IFocus,
Finish_Level1_Focus+Finish_Level1_IFocus+Finish_Level2_Focus+Finish_Level2_IFocus+Finish_Level3_Focus+Finish_Level3_IFocus+Finish_Vender_Focus+Finish_Vender_IFocus as SubFinish,  
Opening_Level1_Focus, Opening_Level1_IFocus, Opening_Level2_Focus, Opening_Level2_IFocus, 
Opening_Level3_Focus, Opening_Level3_IFocus, Opening_Vender_Focus, Opening_Vender_IFocus,
Opening_Level1_Focus+Opening_Level1_IFocus+Opening_Level2_Focus+Opening_Level2_IFocus+Opening_Level3_Focus+Opening_Level3_IFocus+Opening_Vender_Focus+Opening_Vender_IFocus as SubOpening,  
Finish_Level1_Focus+Finish_Level1_IFocus+Finish_Level2_Focus+Finish_Level2_IFocus+Finish_Level3_Focus+Finish_Level3_IFocus+Finish_Vender_Focus+Finish_Vender_IFocus+  
Opening_Level1_Focus+Opening_Level1_IFocus+Opening_Level2_Focus+Opening_Level2_IFocus+Opening_Level3_Focus+Opening_Level3_IFocus+Opening_Vender_Focus+Opening_Vender_IFocus as SubTotal,  
SUM(Finish_Level1_Focus+Finish_Level1_IFocus+Finish_Level2_Focus+Finish_Level2_IFocus+Finish_Level3_Focus+Finish_Level3_IFocus+Finish_Vender_Focus+Finish_Vender_IFocus+  
Opening_Level1_Focus+Opening_Level1_IFocus+Opening_Level2_Focus+Opening_Level2_IFocus+Opening_Level3_Focus+Opening_Level3_IFocus+Opening_Vender_Focus+Opening_Vender_IFocus) over() as N
from
(select Region,
MAX(case when Status+Level+StoreType='FinishLevel 1Focus' then M else 0 end) as [Finish_Level1_Focus],
MAX(case when Status+Level+StoreType='FinishLevel 1IFocus' then M else 0 end) as [Finish_Level1_IFocus],
MAX(case when Status+Level+StoreType='FinishLevel 2Focus' then M else 0 end) as [Finish_Level2_Focus],
MAX(case when Status+Level+StoreType='FinishLevel 2IFocus' then M else 0 end) as [Finish_Level2_IFocus],
MAX(case when Status+Level+StoreType='FinishLevel 3Focus' then M else 0 end) as [Finish_Level3_Focus],
MAX(case when Status+Level+StoreType='FinishLevel 3IFocus' then M else 0 end) as [Finish_Level3_IFocus],
MAX(case when Status+Level+StoreType='FinishVenderFocus' then M else 0 end) as [Finish_Vender_Focus],
MAX(case when Status+Level+StoreType='FinishVenderIFocus' then M else 0 end) as [Finish_Vender_IFocus],
MAX(case when Status+Level+StoreType='OpeningLevel 1Focus' then M else 0 end) as [Opening_Level1_Focus],
MAX(case when Status+Level+StoreType='OpeningLevel 1IFocus' then M else 0 end) as [Opening_Level1_IFocus],
MAX(case when Status+Level+StoreType='OpeningLevel 2Focus' then M else 0 end) as [Opening_Level2_Focus],
MAX(case when Status+Level+StoreType='OpeningLevel 2IFocus' then M else 0 end) as [Opening_Level2_IFocus],
MAX(case when Status+Level+StoreType='OpeningLevel 3Focus' then M else 0 end) as [Opening_Level3_Focus],
MAX(case when Status+Level+StoreType='OpeningLevel 3IFocus' then M else 0 end) as [Opening_Level3_IFocus],
MAX(case when Status+Level+StoreType='OpeningVenderFocus' then M else 0 end) as [Opening_Vender_Focus],
MAX(case when Status+Level+StoreType='OpeningVenderIFocus' then M else 0 end) as [Opening_Vender_IFocus]
from
(select distinct * from
 (select *, COUNT(*) over(partition by Region,Status,Level,StoreType) as M 
  from (select b.Region, case when a.EventState in('0','100','200','300') then 'Finish' else 'Opening' end as Status,ISNULL(a.ResolvedBy,a.HandingBy) Level,b.StoreType
	    from dbo.tb_EventLogs a left join dbo.tb_Stores b on a.StoreNo = b.StoreNo
	    where EventTime between @s and @e
	    ) a
  ) b
 ) c group by c.Region
) d
) e
 
END