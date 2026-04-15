시퀀스 : SEQUENCE : 번호자동 증가
-- 번호 칼럼에 자동으로 번호를 증가

CREATE TABLE TABLE1 (
    ID     NUMBER(6)      PRIMARY KEY,
    TITLE  VARCHAR2(400),
    MEMO   VARCHAR2(4000)
);


--INSERT INTO TABLE1 VALUES(1, 'A', 'AAAA');
--INSERT INTO TABLE1 VALUES(2, 'B', 'ㅋㅋㅋㅋ');
--INSERT INTO TABLE1 VALUES(3, 'A', 'ㅇㅇ');

CREATE SEQUENCE   SEQ_ID;
SEQ_ID.NEXTVAL
SEQ_ID.CURRVAL

-- 잘 사용하지는 않는다
SELECT SEQ_ID.CURRVAL FROM DUAL; --  9 시퀀스의 현재번호
SELECT SEQ_ID.NEXTVAL FROM DUAL; -- 10 시퀀스의 새로운 번호를 발급받는다
-- 중간에 데이터의 삭제가 되면 빈 번호공간이 생긴다
-- 대체방안 : (SELECT NVL(MAX(ID),0)+1 FROM TABLE1)

INSERT INTO TABLE1 VALUES(SEQ_ID.NEXTVAL, 'A', 'AAAA');
INSERT INTO TABLE1 VALUES(SEQ_ID.NEXTVAL, 'B', 'ㅋㅋㅋㅋ');
INSERT INTO TABLE1 VALUES(SEQ_ID.NEXTVAL, 'A', 'ㅇㅇ');
INSERT INTO TABLE1 VALUES((SELECT NVL(MAX(ID),0)+1 FROM TABLE1), 'A', 'AAAA');

COMMIT;

DELETE FROM TABLE1;

번호 자동 증가
MSSQL : IDENTITY(), SEQUENCE
    CREATE TABLE ATABLE (
        ID  INT  IDENTITY(1, 1) -- 1부터 시작해서 1씩 증가
    )
    
MYSQL, MARIADB
    CREATE TABLE ATABLE (
        ID  INT  AUTO_INCREMENT
    )
-----------------------------------------------------------
PRIMARY KEY 값 수정가능 / 불가능
-- 외래키 설정이 되어있지 않아 수정가능
UPDATE TABLE1
SET   ID = 1
WHERE ID = 7;

SELECT * FROM TABLE1;

-- 외래키 설정이 되어있어 수정불가능 : 오류 발생
UPDATE STUDENT   -- ORA-02292: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
SET    STID = 7
WHERE  STID = 1;
--------------------------------------------------
인덱스 : INDEX
검색할때 해당칼럼에 인덱스를 사용하면 검색이 빨라진다
단, INSERT, DELETE, UPDATE 를 사용할때 새로 인덱스를 고쳐야하므로
    추가, 수정같은 작업이 많으면 더 느려질 수 있다
    
-- 사용하는곳 : 
 WHERE 문에 사용하는 컬럼이나 JOIN ON 에 사용하는 칼럼에 설정   
 PRIMARY KEY, UNIQUE -> 자동으로 인덱스 생성된다 
 인덱스는 검색을 자주하는 칼럼에 적용하는 것이다.
 
-- 예제
CREATE TABLE emp_big AS
SELECT
    e.employee_id + (lv * 100000) AS employee_id,
    e.first_name,
    e.last_name,
    e.email || lv AS email,
    e.phone_number,
    e.hire_date,
    e.job_id,
    e.salary,
    e.commission_pct,
    e.manager_id,
    e.department_id
FROM hr.employees e
CROSS JOIN (
    SELECT LEVEL AS lv
    FROM dual
    CONNECT BY LEVEL <= 10000
);

SELECT COUNT(*) FROM EMP_BIG; -- 1090000

-- 인덱스가 지정된 칼럼으로 조건을 걸어서 검색할때 작동
SET TIMING ON; -- SQL문이 실행되는데 걸린 시간
SELECT *
FROM   EMP_BIG
WHERE EMAIL LIKE 'SKING5000';-- 경과 시간: 00:00:00.096

-- 인덱스 생성
CREATE INDEX IDX_EMAIL
 ON EMP_BIG( EMAIL );
 
 CREATE INDEX IDX_NAME
 ON EMP1(FIRST_NAME || ' ' || LAST_NAME );

-------------------------------------------------------------
트리거 TRIGGER 방아쇠
  회원정보가 추가되면 로그에 기록을 남기는 작업을 해야할때
  
  상황
  1) INSERT 회원정보
  2) INSERT 로그기록
  두번실행
  -- TRIGGER(예약) 로 만들면
  자동화
  1) INSERT 회원정보 -> TRIGGER 가 INSERT 로그기록 명령을 호출해서 실행
  
  단점 : 로직추적이 쉽지 않다
         트리거를 남발하지 말라
         
  BEFORE TRIGGER
  AFTER  TRIGGER -> INSTEAD OF 
  
  -- 사용방법 SAMPLE 
  CREATE OR REPLACE TRIGGER TRG_EMP
  AFTER INSERT ON EMP_BIG -- EMP_BIG테이블의 인서트가 작동할때마다 각줄에대해서 INSERT로그 를 실행한다
  FOR EACH ROW
  BEGIN
    INSERT 로그
  END;
  /
  
------------------------------------------------------------------------------
  트랜잭션 : (TRANSACTION)

 송금 
   1) 내계좌에서 금액   -
   2) 상대계좌에서 금액 +
   
   
   1) UPDATE MTABLE
       SET   내계좌 = 내계좌 - 100
       
   2) UPDATE MTABLE
       SET   내계좌 = 내계좌 + 100
       
   1)번 종료 후 문제 발생시 2)번이 실행되지 않으면 문제 발생
   
   BEGIN TRAN
     UPDATE MTABLE
       SET   내계좌 = 내계좌 - 100
     UPDATE MTABLE
       SET   내계좌 = 내계좌 + 100
    COMMIT;
   EXCEPTION
    ROLLBACK;
   END;
    
    1) 2)번을  한개의 작업단위로 묶어서  처리
     문제 발생시 처음 돌아간다
     
-------------------------------------------------------------------------------------
LOCK : DB 잠금 - 상태

INSERT INTO TABLE1 VALUES ( 10, 'C', 'ㅎㅎ' )
SELECT * FROM TABLE1;

WINDOW + R : CMD
> SQLPLUS SKY/1234
SQL> INSERT INTO TABLE1 VALUES ( 10, 'C', 'ㅎㅎ' );
컴퓨터 화면이 멈춤 : RECORD LOCK 걸린상태가 된다

SQLDEVELOPER 에서 돌아가서
COMMIT;
화면

SQLPLUS 화면에서
SQL> INSERT INTO TABLE1 VALUES ( 10, 'C', 'ㅎㅎ' );
INSERT INTO TABLE1 VALUES ( 10, 'C', 'ㅎㅎ' )
*
1행에 오류:
ORA-00001: 무결성 제약 조건(SKY.SYS_C008402)에 위배됩니다

SQL>






