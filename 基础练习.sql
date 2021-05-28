-- 练习数据 scott.sql --
-- 1、找出各月倒数第三天受雇的所有员工
---- 方法一
SELECT * FROM emp WHERE (EXTRACT( DAY FROM LAST_DAY(hiredate)) - EXTRACT(DAY FROM hiredate) ) = 2;
-- 方法二
SELECT * FROM emp WHERE hiredate =  ADDDATE(LAST_DAY(hiredate),-2);

-- 2、找出早于12年前受雇的员工
---- 方法一
SELECT * FROM emp WHERE (EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM hiredate)) > 12;
---- 方法二
SELECT * FROM emp WHERE (YEAR(NOW()) - YEAR(hiredate))  > 12;

-- 3、以首字母大小显示员工名称
---- 方法一
SELECT CONCAT(UPPER(SUBSTR(ename ,1,1)),LOWER(SUBSTR(ename ,2))) name FROM emp;
---- 方法二
SELECT CONCAT(UPPER(LEFT(ename ,1)),LOWER(SUBSTR(ename ,2))) name FROM emp;

-- 4、显示正好为5个字符的员工的姓名
SELECT ename FROM emp WHERE LENGTH(ename) = 5; 

-- 5、显示不带有“R”的员工的姓名
SELECT ename FROM emp WHERE ename NOT LIKE '%R%'; 

-- 6、显示所有员工姓名的三个字符
SELECT SUBSTR(ename,1,3) FROM emp ; 

-- 7、显示所有员工的姓名，用a替换所有的A
SELECT REPLACE(ename,'A','a') FROM emp ; 

-- 8、显示员工的详细资料，按姓名排序
SELECT * FROM emp ORDER BY ename; 

-- 9、显示所有员工的薪资和受雇日期，按薪资降序排序，同薪资的按受雇日期升序排序
SELECT ename,sal,hiredate FROM emp ORDER BY sal desc,hiredate; 

-- 10、显示员工加入公司的天数
SELECT datediff(NOW(),hiredate) FROM emp ; 


