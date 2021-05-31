----------------------------------------- 视图 -----------------------------------------
-- 创建视图 CREATE VIEW 视图名称 AS 查询语句
CREATE VIEW v_dept AS SELECT deptno,dname FROM dept ;
-- 修改视图
ALTER VIEW v_dept AS SELECT deptno,dname FROM dept ;
-- 删除视图
DROP  VIEW IF EXISTS v_dept;
-- 查看视图数据
SELECT * FROM v_dept
---------------------------------------- 三范式 ---------------------------------------
-- 第一范式：数据表的每一列都是不可分割的原子数据项，而不是集合，数组。
-- 第二范式：数据库中每一行数据必须依赖于主键，每一行数据都要有主键；主键是每一行数据的唯一性标识。
-- 第三范式：表中非主键的列要完全依赖于主键，不能出现部分属性依赖于其他属性；当出现传递依赖的时候要将非依赖于主键的列专门创建一张表进行管理。

--------------------------------------- 存储过程 ---------------------------------------
-- 创建存储过程
CREATE PROCEDURE p_hello_world()
BEGIN
    ---- sql语句
END

-- 调用存储过程
CALL p_hello_world();

-- 删除存储过程
DROP PROCEDURE p_hello_world;

-- 带参数的存储过程
CREATE PROCEDURE p_hello(in var_empno int)
BEGIN
	SELECT * FROM emp WHERE empno = var_empno	;
END;

----调用
CALL p_hello(1);

-- 变量定义与赋值

CREATE PROCEDURE p_hello()
BEGIN
	DECLARE var_number INT;
	DECLARE var_varchar VARCHAR(32);
	
	SET var_number = 1;
	SET var_varchar = 'hello world';
	
	SELECT var_number;
	SELECT var_char;
END;

-- 条件语句

CREATE PROCEDURE p_hello2(in var_no int)
BEGIN
	IF(var_no > 0) THEN
			SELECT 'var_no > 0';
	ELSEIF(var_no = 0) THEN
			SELECT 'var_no = 0';
	ELSE
			SELECT 'var_no < 0';
	END IF;
END;	

-- 循环语句
CREATE PROCEDURE p_while_do()
BEGIN
	DECLARE i int;
    SET i = 1;
	WHILE i < 10 DO
		SELECT CONCAT('index:',i);
		SET i = i + 1;
	END WHILE;
END;

------------------------------------------- 静态游标 （相当于指针） -------------------------------------------------------
CREATE PROCEDURE p_cursor()
BEGIN
    ------定义变量
	DECLARE empno INT;
	DECLARE ename VARCHAR(256);
	DECLARE result VARCHAR(4000) DEFAULT '';
	------定义游标
	DECLARE cursor_emp CURSOR FOR SELECT e.empno , e.ename FROM emp e;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET empno = NULL;
    ------开启游标
	OPEN cursor_emp;
	    FETCH cursor_emp INTO empno,ename;
        WHILE (empno IS NOT NULL) DO
                SET result = CONCAT(result,'empno:',empno,',ename:',ename,';');
                FETCH cursor_emp INTO empno,ename;
        END WHILE;
    ------关闭游标
	CLOSE cursor_emp;
    ------输出结果
	SELECT result;
	
END;

----------------------------------------- 触发器 -----------------------------------------------------------
-- 语法
CREATE TRIGGER <触发器名> <BEFORE | AFTER>
<INSERT | UPDATE | DELETE>
ON <表名> FOR EACH ROW <触发器主体>

-- 例子
---- 创建触发器
CREATE TRIGGER tr_salsum BEFORE 
INSERT 
ON emp 
FOR EACH ROW 
SET @sum = @sum + NEW.sal;
---- 触发
SET @sum = 0;
INSERT INTO emp VALUES(5,'MILLER','CLERK',3,'2020-5-20',1300,NULL,10);
SELECT @sum;-- 1300

----------------------------------------- 事件 -----------------------------------------------------------------
-- 查看全局事件功能是否开启
SHOW VARIABLES LIKE '%event_scheduler%';
-- 临时开启全局事件功能
SET GLOBAL event_scheduler = ON;
-- 永久开启全局事件功能，修改my.ini 中的 [mysqld]数据
event_scheduler=ON
-- 创建事件
---- 事件调度

---- 事件动作

-- 语法
CREATE 
	[DEFINER = {ueser | CURRENT_USER}]
	EVENT
	[IF NOT EXIT]
	event_name
	ON SCHEDULE schedule
	[ON COMPLETION [NOT] PRESERVE]
	[ENABLE | DISABLE |DISABLE ON SLAVE]
	[COMMIT 'comment']
	DO event_body;
	
	schedule:
		AT TIMESTAMP [+ INTERVAL interval] ...
		|
		EVENT interval
		[STARTS TIMESTAMP  [+ INTERVAL interval] ...]
		[ENDS TIMESTAMP  [+ INTERVAL interval] ...]
		
		interval:
			quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE | WEEK | SECOND | YEAR_MONTH |
             DAY_HOUR | DAY_MINUTE | DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}
	
	