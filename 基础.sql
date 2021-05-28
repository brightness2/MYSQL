----------------- 单表查询 ----------------------------------------

-- SELECT 列名*N FROM WHERE 查询条件 AND/OR c查询条件2 GROUP BY 列 HAVING 分组条件 ORDER BY 排序
-- 查询
SELECT * FROM emp ;
SELECT * FROM emp WHERE sal > 1000;
SELECT * FROM emp WHERE sal > 1000 AND deptno > 20;
SELECT * FROM emp WHERE sal > 1000 AND deptno > 20 OR deptno = 10 ;
SELECT * FROM emp WHERE sal > 1000 AND deptno > 20 OR deptno = 10 GROUP BY mgr;
SELECT * FROM emp WHERE sal > 1000 AND deptno > 20 OR deptno = 10 GROUP BY mgr HAVING sal >=800;
SELECT * FROM emp WHERE sal > 1000 AND deptno > 20 OR deptno = 10 GROUP BY mgr HAVING sal >=800 ORDER BY hiredate;

-- in
SELECT * FROM emp WHERE empno IN (2,3);

-- not in
SELECT * FROM emp WHERE empno NOT IN (2,3);

-- IS NULL
SELECT * FROM emp WHERE comm IS NULL;

-- IS NOT NULL 
SELECT * FROM emp WHERE comm IS NOT NULL;

-- LIKE
SELECT * FROM emp WHERE ename LIKE '%M';
SELECT * FROM emp WHERE ename LIKE '_M';
SELECT * FROM emp WHERE ename LIKE '\%M';

-- 别名
SELECT ename 姓名 FROM emp ;

-- 运算
SELECT sal * 12 年薪 FROM emp ;

-- 排序
SELECT * FROM emp ORDER BY sal ASC;
SELECT * FROM emp ORDER BY sal DESC;
SELECT * FROM emp ORDER BY sal,job DESC;

-- 分页
SELECT * FROM emp LIMIT 3;
SELECT * FROM emp LIMIT 0,3;
SELECT * FROM emp LIMIT 3 OFFSET 1;
SELECT * FROM emp LIMIT 3,3;

-- 单行函数
----拼接 CONCAT
SELECT CONCAT(ename,'的薪资是 ',sal) 员工薪资 FROM emp ;
----长度 length
SELECT LENGTH(ename) FROM emp ;
----截取 substr(开始位置，截取长度)
SELECT SUBSTR(ename,1,3) FROM emp ;
----大小写 LOWER，UPPER
SELECT LOWER(ename),UPPER(job) FROM emp ;
----替换 REPLACE(要替换的字符,新的字符)
SELECT REPLACE(ename,'M','-') FROM emp ;
---- 数值
SELECT ABS(-10) ,CEIL(3.2),FLOOR(3.6), POWER(2,3);
---- 日期
SELECT
	NOW( ),
	CURRENT_DATE ( ),
	EXTRACT( YEAR FROM '2020-05-9' ),
	DATE_FORMAT( '2020-05-9 16:35:6', '%Y年%m月%d日 %H时%i分%s秒' ),
	ADDDATE( '2020-05-9',- 1 ),
	LAST_DAY( NOW( ) );
---- 空值
SELECT 800 + IFNULL(null,0);
---- 加密
SELECT MD5('123456');
---- 转换
SELECT STR_TO_DATE('10月2020年16日','%m月%Y年%d日');
DATE_FORMAT( '2020-05-9 16:35:6', '%Y年%m月%d日 %H时%i分%s秒' );

--多行函数
---- 最大值
SELECT MAX(sal) FROM emp ;
---- 最小值
SELECT MIN(sal) FROM emp ;
---- 求和
SELECT SUM(sal) FROM emp ;
---- 平均值
SELECT AVG(sal) FROM emp ;
---- 总条数
SELECT COUNT(empno) FROM emp ; 

-- 分组 group by，where 是行级过滤，having 组级过滤
SELECT job,MAX(sal) FROM emp GROUP BY job; 
SELECT deptno,MIN(sal) FROM emp GROUP BY deptno; 
SELECT deptno,AVG(sal) FROM emp where sal <2000 GROUP BY deptno ORDER BY sal desc;
SELECT deptno,AVG(sal) FROM emp   GROUP BY deptno HAVING AVG(sal) > 1500;
SELECT deptno, SUM(comm) FROM emp WHERE comm IS NOT NULL  GROUP BY deptno HAVING SUM(comm) > 100;
SELECT
	deptno,
	job,
	AVG( sal ) 
FROM
	emp 
WHERE
	deptno IN ( 10, 20 ) 
	AND MONTH( hiredate ) = 12 
GROUP BY
	deptno,
	job 
HAVING
	AVG( sal ) > 1000;

-- DQL 单表关键字执行顺序
-- SELECT 
-- 	要查询的字段
-- FROM
-- 	表名
-- WHERE
-- 	筛选条件
-- GROUP BY
-- 	分组字段
-- HAVING
-- 	组筛选条件
-- ORDER BY
-- 	排序字段

-- 顺序：	from -》 where -》 group by -》having -》 select -》 order by


-------------------------- 多表查询 ---------------------------------------------
---- 推荐99语法 ----
-- 等值关联
SELECT * FROM emp e,dept d WHERE e.deptno = d.deptno;-- 92语法
SELECT * FROM emp e  JOIN dept d USING(deptno);-- 99语法
-- 非等值关联
SELECT * FROM emp e, salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal;-- 92语法
SELECT * FROM emp e  JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;-- 99语法

-- 三表联查，一般最多三个表
SELECT * FROM emp e  JOIN dept d USING(deptno)  JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- 左联，以emp表为主
SELECT * FROM emp e LEFT JOIN dept d USING(deptno);

-- 右联，以dept表为主
SELECT * FROM emp e RIGHT  JOIN dept d USING(deptno) ;

-- union
SELECT ename ,sal FROM emp WHERE deptno = 10
UNION
SELECT ename ,sal FROM emp WHERE deptno = 20;

-- 自联
SELECT e.ename,m.ename FROM emp e JOIN emp m ON e.mgr = m.empno;

-- 子查询，一个查询结果当做条件，且子查询只查询一列

SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp);--子查询返回一条数据

SELECT * FROM emp WHERE sal < ALL(SELECT sal FROM emp WHERE deptno = 20);-- 子查询返回多条数据，all 满足全部

SELECT * FROM emp WHERE sal < SOME(SELECT sal FROM emp WHERE deptno = 20);-- some 满足部分

-- 伪表查询，在子查询查询多列的情况
SELECT
	* 
FROM
	emp e
	JOIN ( SELECT deptno, AVG( sal ) avgsal FROM emp GROUP BY deptno ) da ON ( da.deptno = e.deptno AND e.sal > da.avgsal );

------------------------------------- DML --------------------------------------

-- 插入
INSERT INTO dept VALUES(50,'hello','shanghai');
INSERT INTO dept(dname,loc) VALUES('world','guangzhou');
INSERT INTO dp SELECT * FROM dept;--相当于复制数据

-- 删除
DELETE FROM dept WHERE deptno = 51;

-- 修改
UPDATE dept SET loc = 'hangzhou' WHERE deptno = 50;
UPDATE dept SET loc = 'guangzhou',dname='world' WHERE deptno = 50;

------------------------------------ 事务 -------------------------------------------
-- 开启事务
START TRANSACTION;
---- 或者
BEGIN;
---- 操作
-- 回滚/提交
ROLLBACK;
COMMIT;

-- 事务特征 ACID 原则
---- 原子性：事务操作数据是最小单元，不可再分。
---- 一致性：事务提交之后，整个数据库所看到的数据是最新的；所有人看到的数据都一致。
---- 隔离性：别人无法访问到未提交的数据，而且一旦这个数据被修改，别人无法进行操作
---- 持久性：事务一旦提交，数据库就进入一个全新的状态；数据再也不能回到上一个状态。

------------------------------------ DDL -------------------------------------------
-- 库的操作
---- 创建数据库
CREATE DATABASE 数据库名称 CHARSET utf8;
---- 查看数据库
SHOW DATABASES;
---- 选择数据库
USE 数据库名称
---- 删除数据库
DROP DATABASE 数据库名称
---- 修改数据库
ALTER DATABASE 数据库名称

-- 表操作
---- 创建表
CREATE TABLE tablename
---- 修改表
ALTER TABLE tablename