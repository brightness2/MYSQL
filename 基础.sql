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