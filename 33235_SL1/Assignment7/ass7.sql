z-- Create order summary table
create table order_summary (order_id integer NOT NULL,total_cost integer NOT NULL,PRIMARY KEY (order_id));

mysql> insert into order_summary (order_id,total_cost)
    -> select order_id, sum(total_cost) from orders group by order_id;
Query OK, 7 rows affected (0.04 sec)

-- Get order details of products which are not from electronics and sports category.
-- 1.
select * from orders
natural join food_item
natural join category
having cat_name not in ('snacks','chinese');

--2.
-- select order_id,sum(total_cost) as Bill from orders
-- natural join food_item
-- natural join category
-- group by order_id
-- having cat_name not in ('snacks','chinese');

-- 3.
select * from orders 
join food_item on orders.item_id = food_item.item_id 
join category on food_item.cat_id = category.cat_id 
where category.cat_name not in ('snacks') 
order by order_id;
-- +----------+---------+---------+---------------+----------+---------------+------------+------+---------+--------------------+------+--------+--------+-------------+
-- | order_id | cust_id | item_id | date_of_order | quantity | cost_per_item | total_cost | city | item_id | item_name          | cost | cat_id | cat_id | cat_name    |
-- +----------+---------+---------+---------------+----------+---------------+------------+------+---------+--------------------+------+--------+--------+-------------+
-- |        1 |       1 |       1 | 2019-07-08    |        2 |            40 |         80 | pune |       1 | Masala papad       |   40 |      2 |      2 | STARTERS    |
-- |        2 |       1 |       9 | 2019-07-15    |        3 |           150 |        450 | pune |       9 | Chicken Biryani    |  150 |      3 |      3 | MAIN COURSE |
-- |        4 |       3 |       7 | 2019-07-18    |        3 |           150 |        450 | pune |       7 | Paneer Chingara    |  150 |      3 |      3 | MAIN COURSE |
-- |        4 |       3 |       1 | 2019-07-18    |        3 |            40 |        120 | pune |       1 | Masala papad       |   40 |      2 |      2 | STARTERS    |
-- |        5 |       4 |      10 | 2019-07-18    |        2 |            90 |        180 | pune |      10 | manchurian         |   90 |      5 |      5 | chinese     |
-- |        5 |       4 |      12 | 2019-07-18    |        3 |           110 |        330 | pune |      12 | chicken fried rice |  130 |      5 |      5 | chinese     |
-- |        6 |       1 |      10 | 2019-07-18    |        4 |            90 |        360 | pune |      10 | manchurian         |   90 |      5 |      5 | chinese     |
-- |        6 |       1 |      12 | 2019-07-18    |        2 |           130 |        260 | pune |      12 | chicken fried rice |  130 |      5 |      5 | chinese     |
-- +----------+---------+---------+---------------+----------+---------------+------------+------+---------+--------------------+------+--------+--------+-------------+
-- 8 rows in set (0.00 sec)


select item_name from food_item where cost > (select cost from food_item where item_name = 'Maggi');
-- +--------------------+
-- | item_name          |
-- +--------------------+
-- | Veg lollipop       |
-- | Veg 65             |
-- | Paneer Chingara    |
-- | Chicken masala     |
-- | Chicken Biryani    |
-- | manchurian         |
-- | hakka noodles      |
-- | chicken fried rice |
-- +--------------------+

