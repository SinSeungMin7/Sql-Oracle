SELECT * FROM tab;
-------------------------------------------------------
SUBQUERY : SQL 문안에 SQL 문을 넣어서 실행한 방법
         : 반드시 () 안에 있어야 한다
         : () 안에는 ORDER BY 를 사용불가 
         : WHERE 조건에 맞도록 작성한다
         : 쿼리를 실행하는 순서가 필요할때
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
WHERE  DEPARTMENT_ID in (
        SELECT   DEPARTMENT_ID      
        FROM     DEPARTMENTS
        WHERE    DEPARTMENT_NAME in( 'IT', 'Sales')
       );
       
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
1) 평균월급  -- 6461.831775700934579439252336448598130841
SELECT AVG(SALARY)  
FROM   EMPLOYEES;

2) 월급이 6461.831775700934579439252336448598130841 많은 직원
SELECT employee_id                    사번,
       first_name || ' ' || last_name 이름, 
       salary                         월급
FROM   EMPLOYEES
WHERE  SALARY > 6461.831775700934579439252336448598130841;

1 + 2) 
SELECT employee_id                    사번,
       first_name || ' ' || last_name 이름, 
       salary                         월급
FROM   EMPLOYEES
WHERE  SALARY > (
        SELECT AVG(SALARY)  
        FROM   EMPLOYEES
       );

-- IT부서의 평균 월급보다 많은 월급을 받는 사람의 명단
1) IT 부서의 부서번호 -- 60
SELECT  department_id
FROM    DEPARTMENTS
WHERE   DEPARTMENT_NAME = 'IT';

2) 60번 부서의 평균월급 -- 5760
SELECT AVG(SALARY)
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID = 60;

3) 2)번보다 월급이 많은 사원의 정보를 출력        
SELECT employee_id, first_name, last_name, salary, department_id
FROM   EMPLOYEES
WHERE  SALARY > (
        SELECT AVG(SALARY)
        FROM  EMPLOYEES
        WHERE DEPARTMENT_ID = 60
        );
        
1 + 2)
SELECT AVG(SALARY)
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID = (
        SELECT  department_id
        FROM    DEPARTMENTS
        WHERE   DEPARTMENT_NAME = 'IT'
        );
        
-- IT부서의 평균 월급보다 많은 월급을 받는 사람의 명단        
1 + 2 + 3 ) 
SELECT employee_id, first_name, last_name, salary, department_id
FROM   EMPLOYEES
WHERE  SALARY > (
        SELECT AVG(SALARY)
        FROM  EMPLOYEES
        WHERE DEPARTMENT_ID = (
              SELECT  department_id
              FROM    DEPARTMENTS
              WHERE   DEPARTMENT_NAME = 'IT'
              )
        );

-- 50번 부서의 최고 월급자의 이름을 출력
1) 50 번의 부서의 최고 월급  -- 8200
SELECT MAX(SALARY)
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID = 50;

2) 최고 월급자의 이름 -- 8200 을 갖고 있는 사람 뽑아줌
SELECT employee_id, first_name, last_name, salary, department_id
FROM   EMPLOYEES
WHERE  SALARY = 8200;

1 + 2)
SELECT employee_id, first_name, last_name, salary, department_id
FROM   EMPLOYEES
WHERE  SALARY = (
       SELECT MAX(SALARY)
       FROM   EMPLOYEES
       WHERE  DEPARTMENT_ID = 50
       )
AND DEPARTMENT_ID = 50;

-- SALES 부서의 평균월급보다 많은 월급을 받는 사람의 명단
1) SALES 부서의 부서번호 -- 80
SELECT  department_id
FROM    DEPARTMENTS
WHERE   UPPER(DEPARTMENT_NAME) = 'SALES';

2) 부서번호 80의 평균 연봉  -- 8955.882352941176470588235294117647058824
SELECT  AVG(salary)            
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = 80;

3) 2)보다 많은 월급자의 명단
SELECT employee_id, first_name, last_name, salary
FROM   EMPLOYEES
WHERE  SALARY >8955.882352941176470588235294117647058824;

1 + 2 + 3) SALES 부서의 평균월급보다 많은 월급을 받는 사람의 명단
SELECT employee_id, first_name, last_name, salary
FROM   EMPLOYEES
WHERE  SALARY > (
       SELECT  AVG(salary)
       FROM    EMPLOYEES
       WHERE   DEPARTMENT_ID = (
               SELECT  department_id
               FROM    DEPARTMENTS
               WHERE   UPPER(DEPARTMENT_NAME) = 'SALES'
               )
       );

-- 상관 릴레이티브 co relative
---------------------------------------------
-- 다중 열 서브쿼리
SELECT *
FROM employees A
WHERE (A.job_id, A.salary) IN (
                SELECT job_id, MIN(salary) 그룹별급여
                FROM employees
                GROUP BY job_id
       )
ORDER BY A.salary DESC;
-- 상관 서브쿼리 Correlated Subquery
-- JOB_HISTORY 에 있는 부서번호와 DEPARTMENTS 에 있는 부서번호가 같은 부서를 찾아서
-- DEPARTMENTS에 있는 부서번호와 부서명을 출력
---------------------------------------------
SELECT A.DEPARTMENT_ID, A.DEPARTMENT_NAME
FROM DEPARTMENTS A
WHERE EXISTS(
            SELECT 1
            FROM
            JOB_HISTORY B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
);
-- SHIPPING 부서의 직원명단
SELECT department_id
FROM   DEPARTMENTS
WHERE  UPPER(DEPARTMENT_NAME) = 'SHIPPING';

SELECT e.employee_id, e.first_name, e.last_name, e.department_id
FROM   EMPLOYEES E
WHERE  DEPARTMENT_ID = (
        SELECT department_id
        FROM   DEPARTMENTS
        WHERE  UPPER(DEPARTMENT_NAME) = 'SHIPPING'
);

----------------------------------------------------------------------------
JOIN
----------------------------------------------------------------------------
직원이름, 부서명 -- 출력줄수 109줄
SELECT 109 * 27 FROM DUAL;

ORCLE OLD 문법
1) 카티션프로덕트 : 109 * 27 = 2943개 출력 -> CROSS JOIN : 조건이 없는
SELECT FIRST_NAME || ' ' || LAST_NAME 직원이름,
       DEPARTMENT_NAME             부서명
FROM   EMPLOYEES, DEPARTMENTS;

2) 내부조인 : 양쪽 다 존재 하는 데이터만 출력 (NULL은 제외)
   : 109명 - 3명(부서번호 NULL) = 106개 출력 -> INNER JOIN
   비교조건 필수
SELECT EMPLOYEES.FIRST_NAME || ' ' || EMPLOYEES.LAST_NAME 직원이름,
       DEPARTMENTS.DEPARTMENT_NAME             부서명
FROM   EMPLOYEES, DEPARTMENTS
WHERE  EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;
-- 앞에 테이블이름 붙여준다 둘다 DEPARTMENTS_ID 가 있기 때문

SELECT E.FIRST_NAME || ' ' || E.LAST_NAME 직원이름,
       D.DEPARTMENT_NAME                  부서명
FROM   EMPLOYEES  E, DEPARTMENTS  D
WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID;

3) LEFT OUTER JOIN  -- 기준을 정해서
   모든 직원을 출력하시오 : 109
   부서번호가 NULL이라도 출력
   (+) : 기준(직원)이 되는 조건의 반대방향에 붙인다
         NULL 이 출력될 곳
   
SELECT E.first_name || ' ' || E.last_name 이름,
       D.department_name                부서명
FROM   EMPLOYEES E, DEPARTMENTS D
WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);
   
   
4) RIGHT OUTER JOIN -- 기준을 정해서
SELECT E.first_name || ' ' || E.last_name 이름,
       D.department_name                부서명
FROM   EMPLOYEES E, DEPARTMENTS D
WHERE  D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID;


4) RIGHT OUTER JOIN  -- 기준을 정해서
   모든 부서를 출력하시오 : 122 : (109 - 3) + (27 - 11)
   직원정보가 없더라도 NULL 이라도 출력
   
SELECT E.first_name || ' ' || E.last_name 이름,
       D.department_name                부서명
FROM   EMPLOYEES E, DEPARTMENTS D
WHERE  E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID;

5) FULL OUTER JOIN -- ORACLE OLD 문법에는 존재하지않는 명령
모든 직원과 모든 부서를 출력하시오
-----------------------------------------------------------------------------
표준 SQL 문법
1. CROSS JOIN : 2943
SELECT e.first_name,e.last_name,d.department_name
FROM   EMPLOYEES E CROSS JOIN DEPARTMENTS D;

2. (INNER) JOIN-- 106

SELECT E.first_name, E.last_name,  D.department_name
FROM   EMPLOYEES E INNER JOIN DEPARTMENTS D 
ON     E.DEPARTMENT_ID = D.DEPARTMENT_ID;

3. OUTER JOIN
1) LEFT ( OUTER ) JOIN -- 109
SELECT E.first_name, E.last_name, d.department_name
FROM   EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON     E.DEPARTMENT_ID = D.DEPARTMENT_ID;

2) RIGHT ( OUTER ) JOIN
SELECT E.first_name, E.last_name, d.department_name
FROM   EMPLOYEES E RIGHT JOIN DEPARTMENTS D
ON     E.DEPARTMENT_ID = D.DEPARTMENT_ID;

3) FULL ( OUTER ) JOIN -- 125 : 109 + 27 - 16
SELECT E.first_name, E.last_name, d.department_name
FROM   EMPLOYEES E FULL JOIN DEPARTMENTS D
ON     E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-----------------------------------------------------------
-- INNER OUTER(LEFT, RIGHT, FULL) 활용 예제
-- 직원이름, 담당업무(JOB_TITLE)
1) INNER 109
SELECT e.first_name || ' ' || e.last_name 직원이름,
       j.job_title                        담당업무
FROM   EMPLOYEES E INNER JOIN JOBS J
ON     E.JOB_ID = J.JOB_ID;

2) LEFT 109
SELECT e.first_name || ' ' || e.last_name 직원이름,
       j.job_title                        담당업무
FROM   EMPLOYEES E LEFT JOIN JOBS J
ON     E.JOB_ID = J.JOB_ID;

3) RIGHT 109
SELECT e.first_name || ' ' || e.last_name 직원이름,
       j.job_title                        담당업무
FROM   EMPLOYEES E RIGHT JOIN JOBS J
ON     E.JOB_ID = J.JOB_ID;

4) FULL 109
SELECT e.first_name || ' ' || e.last_name 직원이름,
       j.job_title                        담당업무
FROM   EMPLOYEES E FULL JOIN JOBS J
ON     E.JOB_ID = J.JOB_ID;

-- 부서명, 부서위치(CITY, STREET_ADDRESS)
1) INNER 27
SELECT d.department_name   부서명, 
       l.city || ' ' || l.street_address  부서위치
FROM   DEPARTMENTS D INNER JOIN LOCATIONS L
ON     D.LOCATION_ID = L.LOCATION_ID;

2) LEFT 27
SELECT d.department_name   부서명, 
       l.city || ' ' || l.street_address  부서위치
FROM   DEPARTMENTS D LEFT JOIN LOCATIONS L
ON     D.LOCATION_ID = L.LOCATION_ID;

3) RIGHT 43
SELECT d.department_name   부서명, 
       l.city || ' ' || l.street_address  부서위치
FROM   DEPARTMENTS D RIGHT JOIN LOCATIONS L
ON     D.LOCATION_ID = L.LOCATION_ID;

4) FULL 43
SELECT d.department_name   부서명, 
       l.city || ' ' || l.street_address  부서위치
FROM   DEPARTMENTS D FULL JOIN LOCATIONS L
ON     D.LOCATION_ID = L.LOCATION_ID;

-- 직원명, 부서명 부서위치(CITY, STREET_ADDRESS)
1)INNER : INNER JOIN -> (INNER) 생략하고 JOIN 만 써도 된다 -- 106
SELECT e.first_name || ' ' || e.last_name 직원이름,
       d.department_name                  부서명,
       l.city || ' ' || l.street_address  부서위치
FROM  EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY 직원이름 ASC;

2)LEFT -- 109
SELECT e.first_name || ' ' || e.last_name 직원이름,
       d.department_name                  부서명,
       l.city || ' ' || l.street_address  부서위치
FROM  EMPLOYEES E 
      LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
      LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY 직원이름 ASC;

3)RIGHT
SELECT e.first_name || ' ' || e.last_name 직원이름,
       d.department_name                  부서명,
       l.city || ' ' || l.street_address  부서위치
FROM  EMPLOYEES E
      RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
      RIGHT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY 직원이름 ASC;

4)FULL
SELECT e.first_name || ' ' || e.last_name 직원이름,
       d.department_name                  부서명,
       l.city || ' ' || l.street_address  부서위치
FROM  EMPLOYEES E 
      FULL JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
      FULL JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY 직원이름 ASC;

-- 직원명, 부서명, 국가, 부서위치(CITY, STREET_ADDRESS)
1) INNER -- 106
SELECT e.first_name || ' ' || e.last_name  직원명,
       d.department_name                   부서명,
       l.city                              국가,
       l.city || ' ' || l.street_address   부서위치
FROM   EMPLOYEES E 
       JOIN DEPARTMENTS D  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
       JOIN LOCATIONS   L  ON D.LOCATION_ID   = L.LOCATION_ID
       JOIN COUNTRIES   C  ON L.COUNTRY_ID     = C.COUNTRY_ID
ORDER BY 직원명;

2) LEFT -- 109 
SELECT e.first_name || ' ' || e.last_name  직원명,
       d.department_name                   부서명,
       l.city                              국가,
       l.city || ' ' || l.street_address   부서위치
FROM   EMPLOYEES E
       LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
       LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
       LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY 직원명;

3) RIGHT -- 149
SELECT e.first_name || ' ' || e.last_name  직원명,
       d.department_name                   부서명,
       l.city                              국가,
       l.city || ' ' || l.street_address   부서위치
FROM   EMPLOYEES E
       RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
       RIGHT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
       RIGHT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY 직원명;

4) FULL -- 152
SELECT e.first_name || ' ' || e.last_name  직원명,
       d.department_name                   부서명,
       l.city                              국가,
       l.city || ' ' || l.street_address   부서위치
FROM   EMPLOYEES E
       FULL JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
       FULL JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
       FULL JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY 직원명;

-- 부서명, 국가 : 모든부서 : 27줄 이상
SELECT  d.department_ID 부서명,
        c.country_name    국가
FROM    DEPARTMENTS D 
        JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
        JOIN COUNTRIES C ON L.COUNTRY_ID  = C.COUNTRY_ID
ORDER BY 부서명;

-- 직원명, 부서위치 단 IT 부서만
SELECT e.first_name || ' ' || e.last_name  직원이름,
       d.department_name                   부서이름,
       l.state_province || ',' || l.city || ',' || l.street_address   부서위치
FROM   EMPLOYEES E
       JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
       JOIN LOCATIONS   L ON D.LOCATION_ID   = L.LOCATION_ID
WHERE D.DEPARTMENT_NAME = 'IT'
ORDER BY 직원이름;

SELECT *
FROM   EMPLOYEES
WHERE  JOB_ID = 'IT_PROG'; 



-- 부서명별 월급 평균
월급평균이 NULL -> '직원없음'
SELECT D.DEPARTMENT_NAME      부서명,
       -- NVL(ROUND(AVG(e.salary),3), '0') 월급평균 -- 0으로 정상출력됨
       -- NVL(ROUND(AVG(e.salary),3), '직원없음') 월급평균 -- ORA-01722: 수치가 부적합합니다 NVL 은 비교대상 둘다 같은것으로 해야함 숫자,숫자 글자,글자
       DECODE(AVG(e.salary), NULL, '직원없음', ROUND(AVG(e.salary),2)) 월급평균
FROM   EMPLOYEES E RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        -- 부서명 별이니 기준이 DEPARTMENTS 에있는 DEPARTMENT_NAME이 기준이여야한다
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME;

-- 직원의 근무 연수
-- MONTHS_BETWEEN(날짜, 날짜2) : 날짜1 - 날짜2 : 월단위로
-- ADD_MONTH(날짜, n) : 날짜 +n개월 / 날짜 -n개월
SELECT  first_name || ' ' || last_name                   직원명,
        TO_CHAR(hire_date, 'YYYY-MM-DD')                 입사일,
        TO_CHAR(TRUNC(hire_date,'MONTH'),'YYYY-MM-DD')  "입사월의 첫번째날",
        TO_CHAR(LAST_DAY(hire_date), 'YYYY-MM-DD')       입사월의마지막날,
        TRUNC(SYSDATE - hire_date)                       근무일수,
        TRUNC( (SYSDATE - hire_date) / 365.2422 )        근무연수,--365.2422 중요!!! 1년인식
        TRUNC( MONTHS_BETWEEN(SYSDATE, hire_date) / 12 ) 근무연수
FROM    EMPLOYEES ;

-- 60번 부서 최소월급과 같은 월급자의 명단 출력
1) 60번 부서의 최소월급
SELECT MIN(salary) -- 4200
FROM   EMPLOYEES 
WHERE  DEPARTMENT_ID = 60;

2) 1) 월급을 받는사람의 이름
SELECT employee_id                     사번,
       department_id                   부서,
       first_name || ' ' || last_name  이름
FROM   EMPLOYEES
WHERE  SALARY = 4200;

3) 1+2
SELECT employee_id                     사번,
       department_id                   부서,
       first_name || ' ' || last_name  이름
FROM   EMPLOYEES
WHERE  SALARY = (
        SELECT MIN(salary) -- 4200
        FROM   EMPLOYEES 
        WHERE  DEPARTMENT_ID = 60
        );
    
    

-- 부서명, 부서장의 이름을 출력
1) INNER JOIN : 양쪽다 존재하는 데이터만 출력
SELECT d.department_name                  부서명,
       e.first_name || ' ' || e.last_name 이름 
FROM   DEPARTMENTS D
       JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;
       
2) LEFT JOIN 모든 부서에 대해서 출력 
SELECT d.department_name                  부서명,
       e.first_name || ' ' || e.last_name 이름 
FROM   DEPARTMENTS D
       LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;
-------------------------------------------------------------------------
결합연산자 - 줄 단위 결합
조건 -- 두 테이블의 칸 수와 타입이 동일해야한다
1) UNION     : 중복 제거
2) UNION ALL : 중복 포함
3) INTERSECT : 교집합 : 공통부분
4) MINUS     : 차집합 A - B

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;  -- 34줄
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;  -- 45줄

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 80   -- 34줄
UNION -- 입력시 두 표(80번 + 50번) 합쳐진다 34 + 45줄
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;  -- 45줄

-- 칼럼수와 칼럼들의 TYPE 이 같으면 합쳐진다 -> 주의할 것 : 의미없는 결합가능
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES
UNION
SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;

-- 직원정보, 담당업무

-- 직원명, 담당업무, 담당업무 히스토리

-- 사번, 업무시작일, 업무종료일, 담당업무, 부서번호
SELECT employee_id, 
FROM  EMPLOYEES;




