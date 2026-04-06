SELECT * FROM TAB;

DESC EMPLOYEES;

SELECT * FROM EMPLOYEES;

-- 직원번호가 100인 사람을 출력
SELECT    *
    FROM  EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
-- King 이라는 직원 출력하기
SELECT  *
     From EMPLOYEES
     WHERE LAST_NAME = 'King';
 
-- 월급순으로 직원정보를 출력
-- EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY 4개를
-- 테이블 EMPLOYEES 에서 
-- 월급이 5000이상인 직원정보
-- SALARY 기준 내림차순으로 출력
SELECT      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM    EMPLOYEES
    WHERE SALARY >= 5000
    ORDER BY SALARY DESC; -- 58

SELECT      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM    EMPLOYEES
    ORDER BY SALARY DESC; -- 107
    
-- 전화번호에 010이 포함(%)된 직원
SELECT        EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER
    FROM      EMPLOYEES
    WHERE     PHONE_NUMBER LIKE '%010%'
    ORDER BY  EMPLOYEE_ID ASC;

-- 50번 부서의 직원을 출력해라
-- || -> 글자 붙이기
SELECT      EMPLOYEE_ID                      "사  번"    ,  -- 사번 : ALIAS, 별칭, 별명
            FIRST_NAME || ' ' || LAST_NAME   이름    ,
            DEPARTMENT_ID                    "부서  번호"
    FROM    EMPLOYEES
    WHERE   DEPARTMENT_ID = 50
 -- ORDER BY FIRST_NAME || ' ' || LAST_NAME ASC;
    ORDER BY FIRST_NAME ASC, LAST_NAME ASC;
    
-- 부서가 없는 직원을 출력
SELECT      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
    FROM    EMPLOYEES
    WHERE   DEPARTMENT_ID is NULL;
    
    
    