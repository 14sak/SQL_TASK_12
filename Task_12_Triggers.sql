select * from sales
 create table report_table(
	product_id varchar,
	sum_of_sales float,
	sum_of_profit float
 )

select * from report_table

create or replace function update_report()
returns trigger as $$
declare 
  sum_sales float;
  sum_profit float;
  count_report int;
begin
	select sum(sales),sum(profit) into sum_sales,sum_profit from sales
	where product_id=new.product_id;

	select count(*) into count_report from report_table where product_id=new.product_id ;
	if count_report=0 then
	insert into report_table values(new.product_id,sum_sales,sum_profit);
    else 
		update report_table 
		set sum_of_sales= sum_sales, sum_of_profit= sum_profit 
		where product_id=new.product_id;
		end if;
     return new;
end
$$ language plpgsql

create trigger update_report
after insert on sales 
for each row 
execute function update_report()

select * from sales
select sum(sales),sum(profit) from sales where product_id='FUR-BO-10001798'
--1266.9569999999999,-53.3214

insert into sales values(9997,'CA-2016-152157','2024-08-18','2024-08-19','Standard Class','SB-12345','FUR-BO-10001798',300,30,5,40)

select * from sales order by order_line desc
select * from report_table
--FUR-BO-10001798,1566.9569999999999,-13.321399999999997

insert into sales values(9997,'CA-2016-152157','2024-08-18','2024-08-19','Standard Class','SB-12345','FUR-BO-10001798',300,30,5,40)
select * from report_table
--FUR-BO-10001798,1866.9569999999999,26.678600000000003