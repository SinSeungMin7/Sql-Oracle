SELECT * FROM tab;
-------------------------------------------------------
SUBQUERY : SQL 문안에 SQL 문을 넣어서 실행한 방법
         : 반드시 () 안에 있어야 한다
         : () 안에는 ORDER BY 를 사용불가 
         : WHERE 조건에 맞도록 작성한다
-------------------------------------------------------

-- IT 부서의 직원정보를 출력하시오
1) IT 부서의 부서번호를 찾는다 : 60
SELECT   DEPARTMENT_ID
FROM     DEPARTMENTS
WHERE    DEPARTMENT_NAME = 'IT';

2) 60번 부서의 직원 정보를 출력한다
SELECT employee_id                   사번,
       first_name || ' ' ||last_name 이름,
       department_id                 부서번호
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID = 60;

1 + 2)
SELECT employee_id                   사번,
       first_name || ' ' ||last_name 이름,
       department_id                 부서번호
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID = (
        SELECT   DEPARTMENT_ID      
        FROM     DEPARTMENTS
        WHERE    DEPARTMENT_NAME = 'IT'
       );


-- 평균월급보다 많은 월급을 받는 사람의 명단