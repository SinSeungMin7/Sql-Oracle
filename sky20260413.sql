DDL : data definition language
 구조를 생성, 변경, 제거
 
CREATE 
ALTER
DROP

CMD
계정생성
 아이디   : SKY
 비밀번호 : 1234
 CMD
 
Microsoft Windows [Version 10.0.19045.6466]
(c) Microsoft Corporation. All rights reserved.

C:\Users\GG>sqlplus /nolog

SQL*Plus: Release 21.0.0.0.0 - Production on 월 4월 13 14:06:14 2026
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

SQL> conn sys/1234 as sysdba
연결되었습니다.

SQL> show user
USER은 "SYS"입니다

SQL> ALTER SESSION SET "_ORACLE_SCRIPT"=true;
세션이 변경되었습니다.

SQL> CREATE USER SKY IDENTIFIED BY 1234;
사용자가 생성되었습니다.

SQL> GRANT CONNECT, RESOURCE TO SKY;
권한이 부여되었습니다.

SQL> ALTER USER SKY DEFAULT TABLESPACE
  2  USERS QUOTA UNLIMITED ON USERS;
사용자가 변경되었습니다.

SQL> CONN SKY/1234
연결되었습니다.

SQL> SHOW USER
USER은 "SKY"입니다

SQL>
-------------------------------------------------------------------------
새 계정으로 접속한 뒤에 작업

sky 에서 hr 계정의 data 를 가져온다
sqlplus 에서 작업
1. 먼저 hr 로 로그인한다
window + R : cmd
C:\>sqlplus hr/1234

2. hr 에서 다른계정인 sky 에게 select 할 수 있는 권한을 부여
SQL> GRANT SELECT ON EMPLOYEES TO SKY;
권한이 부여되었습니다.

3. sky 로 로그인한다
SQL> CONN SKY/1234
연결되었습니다.
SQL> SHOW USER
USER은 "SKY"입니다
SQL> SELECT * FROM TAB;
선택된 레코드가 없습니다.

4. sky에서 hr 계정의 Employees 를 조회
SQL> SELECT * FROM HR.EMPLOYEES; -- 조회 성공
SELECT * FROM HR.DEPARTMENTS;    -- 조회 실패

----------------------------------------------------------------------------
ORACLE 의 TABLE 을 복사하기
HR 의 EMPLOYEES TABLE 을 복사해서 SKY 로 가져온다

[1] 테이블 생성
1. 테이블 복사
  대상 : 테이블 구조, 데이터 (제약 조건의 일부만 복사(NO NULL))
  
  1) 구조, 데이터 다 복사, 제약조건은 일부만 복사(NULL 관련) -- 10 건 
    CREATE TABLE EMP1 -- 테이블 이름
    AS 
        SELECT * FROM HR.EMPLOYEES;
        
  2) 구조, 데이터 다 복사, 50번 80번 부서만 복사 -- 59 건
    CREATE TABLE EMP2 -- 테이블 이름
    AS 
        SELECT * FROM HR.EMPLOYEES
        WHERE DEPARTMENT_ID IN(50, 80);

  3) DATA 빼고 구조만 복사
   CREATE TABLE EMP3 -- 테이블 이름
    AS 
        SELECT * FROM HR.EMPLOYEES
        WHERE 1 = 0;  -- FALSE 문 (TRUE 문이아니라 FALSE를 써야하기때문 DATA를 뺄려면)
        
  4) 구조만 복사된 TABLE EMP3 에 DATA만 추가하는 방법 
   CREATE TABLE EMP4 -- 테이블 이름
    AS 
        SELECT * FROM HR.EMPLOYEES
        WHERE 1 = 0;  -- FALSE 문 
        
    -- DATA 만 추가
    INSERT INTO EMP4 -- 테이블 이름
      SELECT * FROM HR.EMPLOYEES;
      COMMIT;
   
  5) 일부 칼럼만 복사해서 새로운 테이블 생성
   CREATE TABLE EMP5 -- 테이블 이름
    AS
        SELECT  EMPLOYEE_ID                    EMPID,
                FIRST_NAME || ' ' || LAST_NAME ENAME,
                SALARY                         SAL,
                SALARY * COMMISSION_PCT        BONUS,
                MANAGER_ID                     MGR,
                DEPARTMENT_ID                  DEPTID
        FROM    HR.EMPLOYEES;



















