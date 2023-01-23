use sales
call all_data

DELIMITER $$
create function add_to_col (a INT)
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE b INT;
	set b=a+10;
    return b;
end $$

select add_to_col(15)

select add_to_col(quantity) from sales1

DELIMITER $$
create function final_profit (profit int, discount int)
RETURNS int
DETERMINISTIC
BEGIN 
	DECLARE final_profit int;
    set final_profit = profit-discount;
    return final_profit;
end $$

select profit,discount,final_profit(profit,discount) from sales1

# Here, discount is in %. So, create function with sales*discount 

DELIMITER $$
create function final_profit_real (profit decimal(20,8), discount decimal(20,8) , sales decimal(20,8))
RETURNS int
DETERMINISTIC
BEGIN 
	DECLARE final_profit_real int;
    set final_profit_real = profit- sales* discount;
    return final_profit_real;
end $$

select sales,profit,discount,final_profit_real(profit,discount,sales) from sales1
DELIMITER $$
create function add_to_col (a INT)
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE b INT;
	set b=a+10;
    return b;
end $$
## create function to convert int. to varchar datatype
DELIMITER $$
create function int_to_varchar(a int)
returns varchar(50)
DETERMINISTIC
BEGIN
	DECLARE b varchar(50);
    set b=a;
    return b;
end$$

call all_data
select int_to_varchar(45) 

select int_to_varchar(quantity) from sales1

# create sub-devide categories product by the sales
1  - 100 - super affordable product 
100-300 - affordable 
300 - 600 - moderate price 
600 + - expensive 

DELIMITER &&
create function mark_sales(sales int)
returns varchar(50)
DETERMINISTIC
begin
declare flag_sales varchar(50);
if sales <=100 then
	set flag_sales = "super affordable product";
elseif sales>100 and sales <300 then
	set flag_sales = "affordable";
elseif sales>300 and sales<600 then
	set flag_sales = "moderate price";
else
	set flag_sales = "expensive";
end if;
return flag_sales;
end &&

select mark_sales(60)
select mark_sales(700)

select sales, mark_sales(sales) from sales1

## LOOP

# create global variable
set@var=10;
generate_data: loop
set@var=@var+1;
if @var=100 then
	leave generate_data;
end if;
end loop generate_data;

###Create table to save loop data
create table loop_table(val int)

Delimiter $$
create procedure insert_data()
Begin
set @var  = 10 ;
generate_data : loop
insert into loop_table values (@var);
set @var = @var + 1  ;
if @var  = 100 then 
	leave generate_data;
end if ;
end loop generate_data;
End $$

call insert_data()

select * from loop_table

create table loop_table1(val int)

Delimiter $$
create procedure insert_data2()
Begin
set @var  = 10 ;
generate_data : loop
insert into loop_table1 values (@var);
set @var = @var + 2  ;
if @var  = 100 then 
	leave generate_data;
end if ;
end loop generate_data;
End $$

call insert_data2()

select * from loop_table1
