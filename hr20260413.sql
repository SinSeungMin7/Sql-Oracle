------------------------------------------------------------
-- 부프로그램 , 프로시저, 함수
1. 프로시저 ( PROCEDURE ) -- SUBROUTINE : 함수보다 더 많이 사용한다
  : 리턴값이 0 개 이상
  STORED PROCEDURE : 저장 프로시저
2. 함수 ( FUNCTION )  
  : 반드시 리턴값이 1 개
  
USER DEFINE FUNCTION - 사용자 정의 함수, 우리가 함수를 만든다
------------------------------------------------------------
제약조건(CONSTRAINS)
 - Primary_key, Unique,
------------------------------------------------------------
-- 107번 직원의 이름과 월급 조회
SELECT employee_id                    사번,
       first_name || ' ' || last_name 이름,
       salary                         월급
FROM   EMPLOYEES 
WHERE  EMPLOYEE_ID = 107;

익명 블럭
SET SERVEROUTPUT ON;
DECLARE
    V_NAME  VARCHAR2(46);
    V_SAL   NUMBER(8, 2); -- NUMBER 전체 8자리중 소수이하 2자리
BEGIN
    V_NAME  := '카리나';
    V_SAL   := 10000;
    DBMS_OUTPUT.PUT_LINE(V_NAME);
    DBMS_OUTPUT.PUT_LINE(V_SAL);
    IF V_SAL >= 10000 THEN
        DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Not Good');
    END IF;
END;
/

저장 프로시저( IN : INPUT, OUT : OUTPUT, INOUT : INPUTOUT)
CREATE OR REPLACE PROCEDURE GET_EMPSAL( IN_EMPID IN NUMBER )
IS 
   V_NAME  VARCHAR2( 46 );
   V_SAL   NUMBER(8, 2);
      BEGIN
            SELECT first_name || ' ' || last_name, salary
            INTO   V_NAME                        , V_SAL
            FROM   EMPLOYEES 
            WHERE  EMPLOYEE_ID = IN_EMPID;
            
     DBMS_OUTPUT.PUT_LINE('이름:' || V_NAME );
     DBMS_OUTPUT.PUT_LINE('월급:' || V_SAL );
  END;
/

-- ORCLE 로 프로시저를 생성한다

-- 부서번호입력, 해당부서의 최고월급자의 이름, 월급 출력
SELECT  first_name || ' ' || last_name 이름,
        salary                         월급,
        department_id                  부서번호
FROM    EMPLOYEES
WHERE   SALARY = (
          SELECT  MAX( SALARY )
          FROM    EMPLOYEES
          WHERE   DEPARTMENT_ID = 30
           )
AND   DEPARTMENT_ID = 30;      


-- 90 번 부서번호입력, 직원들 출력
SELECT  employee_id                    사번,
        first_name || ' ' || last_name 이름,
        department_id                  부서번호
FROM    EMPLOYEES 
WHERE   DEPARTMENT_ID = 90;


























