-- 오늘 날짜 출력
SELECT SYSDATE FROM DUAL;

-- 15/09/21로 입사한사람
SELECT EMPLOYEE_ID, HIRE_DATE
  FROM EMPLOYEES
 WHERE HIRE_DATE = '15/09/21';
 
 -- "YYYY-MM-DD HH24:MI:SS" -> 이런 형식으로 출력하게 만드는 명령
ALTER SESSION SET NLS_DATE_FORMAT = "YYYY-MM-DD HH24:MI:SS";
 
SELECT EMPLOYEE_ID, HIRE_DATE
  FROM EMPLOYEES
 WHERE HIRE_DATE = '2015-09-21';

---------------------------------------------------------------------------
-- 앞으로 날짜 표현은 다음과 같이 통일해 표현한다
-- TO_CHAR(DATE)

SELECT EMPLOYEE_ID, TO_CHAR(HIRE_DATE,'YYYY-MM-DD')
  FROM EMPLOYEES
 -- WHERE TO_CHAR(HIRE_DATE,'YYYY-MM-DD') = '2015-09-21';
WHERE TO_CHAR(HIRE_DATE,'YYYY-MM-DD') = '2026-04-07';


-- 입사후 일주일 이내인 직원명단
-- TRUNC() : 가지치기 함수
--          EX ) 원본 데이터: 2014-02-17 14:30:15
--               TRUNC(날짜): 2014-02-17 00:00:00 (시간을 모두 0으로 초기화)
SELECT    EMPLOYEE_ID,
          TO_DATE(HIRE_DATE,'YYYY-MM-DD'),
          TRUNC(SYSDATE - HIRE_DATE)
FROM      EMPLOYEES
WHERE     SYSDATE - HIRE_DATE <= 7
ORDER BY  EMPLOYEE_ID ASC;


-- 화요일 입사자를 출력
SELECT   EMPLOYEE_ID,
         FIRST_NAME || ' ' || LAST_NAME,
         TO_CHAR( HIRE_DATE, 'YYYY-MM-DD' ),
         TO_CHAR( HIRE_DATE, 'DAY' ) 
FROM     EMPLOYEES
WHERE    TO_CHAR(HIRE_DATE, 'DAY') = '화요일'
ORDER BY HIRE_DATE ASC;


-- 08월 입사자의 사번, 이름, 입사일을 입사일 순으로 
SELECT  EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        TO_CHAR(HIRE_DATE,'YYYY-MM-DD') 입사일
FROM    EMPLOYEES
WHERE   TO_CHAR( HIRE_DATE, 'MM') = '08';
 

-- 부서번호 80이 아닌 직원
SELECT   E.EMPLOYEE_ID                      사번,
         E.FIRST_NAME || ' ' || E.LAST_NAME 이름,
         E.DEPARTMENT_ID                    부서번호
FROM     EMPLOYEES E
WHERE    E.DEPARTMENT_ID <> 80; -- <>, != : 같지않다
-- =, <>, >, >=, <, <=, BETWEEN ~AND
-- ==, +, -, *, /, MOD(7, 2)


-- 2026년 04월 07일 10시 05분 04초 오전 수요일
-- 한자로 출력


-- 오전, 오후 : 午前, 午後 
-- 년월일시분초 : 年, 月, 日, 時, 分, 秒
-- 월화수목금토일 : 月, 火, 水, 木, 金, 土, 日
-- 요일 : 曜日


SELECT  TO_CHAR(SYSDATE, 'YYYY') || '年 '
     || TO_CHAR(SYSDATE, 'MM')   || '月 '
     || TO_CHAR(SYSDATE, 'DD')   || '日 '  
     || TO_CHAR(SYSDATE, 'HH12') || '時 ' 
     || TO_CHAR(SYSDATE, 'MI')   || '分 ' 
     || TO_CHAR(SYSDATE, 'SS')   || '秒 '
     || CASE TO_CHAR(SYSDATE,'DY')
        WHEN '일' THEN '日'
        WHEN '월' THEN '月'
        WHEN '화' THEN '火'
        WHEN '수' THEN '水'
        WHEN '목' THEN '木'
        WHEN '금' THEN '金'
        WHEN '토' THEN '土'
        END                      || '曜日 '
     || DECODE( TO_CHAR(SYSDATE, 'AM'),  '오전', '午後',
                                         '오후', '午後' 
        )
FROM DUAL;

-- 1) TO_CHAR 활용
SELECT  SYSDATE,
        TO_CHAR( SYSDATE,'YYYY-MM-DD HH24:MI:SS') 날짜1,
        TO_CHAR( SYSDATE,'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초" DAY AM') 날짜2,
        TO_CHAR( SYSDATE,'YYYY"年" MM"月" DD"日" HH24"時" MI"分" SS"秒" DAY AM') 날짜3,
        TO_CHAR( SYSDATE,'AM')
FROM    DUAL ;

-- 2) IF를 구현 
-- 2-1)  NVL(), NVL2() : NULL VALUE 의미
--       NVL(expr1, expr2), NVL2((expr1, expr2, expr3)
--       NVL 함수는 expr1이 NULL일 때 expr2를 반환한다.
--       NVL2는 NVL을 확장한 함수로 expr1이 NULL이 아니면 expr2를, NULL이면 expr3를 반환하는 함수다.
---- 사번, 이름, 월급, COMMISSION_PCT(단 NULL 이면 0 으로 출력)
SELECT EMPLOYEE_ID                                                    사번,
       FIRST_NAME || ' ' || LAST_NAME                                 이름,
       SALARY                                                         월급,
       NVL(COMMISSION_PCT, 0)                                         COMMISSION_PCT,
       NVL2( COMMISSION_PCT, SALARY+(SALARY*COMMISSION_PCT), SALARY ) 보너스
       -- COMMISSION 이 NULL 이 아니면 SALARY+(SALARY*COMMISSION_PCT) 실행, NULL이면 SALARY 실행
 FROM  EMPLOYEES;




-- 2-2) NULLIF (expr1, expr2)
--      NULLIF 함수는 expr1과 expr2을 비교해 같으면 NULL을, 같지 않으면 expr1을 반환한다.

-- 2-3)DECODE (expr, search1, result1, 
--                   search2, result2,
--                   …,
--                   default)
--     DECODE는 expr과 search1을 비교해 두 값이 같으면 result1을,
--     같지 않으면 다시 search2와 비교해 값이 같으면 result2를 반환하고,
--     이런 식으로 계속 비교한 뒤 최종적으로 같은 값이 없으면 default 값을 반환한다.

-- 사번, 부서번호(단 부서번호가 NULL 이면 '부서없음')
SELECT  employee_id                       사번,
        -- VNL(department_id , '부서없음')   부서번호 -- ORA-00904: "VNL": 부적합한 식별자 두 TYPE이 동일해야한다 
        DECODE(department_id, NULL, '부서없음',
                                     department_id ) 부서번호
        -- department_id 이것이 NULL 이면  '부서없음' 출력, 아니면 department_id 출력
FROM    EMPLOYEES;

SELECT TO_CHAR(SYSDATE, 'AM'),
       DECODE( TO_CHAR(SYSDATE, 'AM'), '오전', '午前',
                                       '오후', '午後'   )
    -- TO_CHAR(SYSDATE, 'AM') 결과값이 오전이면 午前 출력 , 오후이면, 午後 출력
FROM  DUAL;
-----------------------------------------------------------------------------------
/*
10	Administration
20	Marketing
30	Purchasing
40	Human Resources
50	Shipping
60	IT
70	Public Relations
80	Sales
90	Executive
100	Finance
110	Accounting
*/
-- DECODE 로
-- 사번, 이름, 부서명
SELECT department_id                   사번,
       first_name || ' ' ||  last_name 이름,
       DECODE(DEPARTMENT_ID, 
                            10,	 'Administration',
                            20,	 'Marketing',
                            30,	 'Purchasing',
                            40,	 'Human Resources',
                            50,	 'Shipping',
                            60,	 'IT',
                            70,	 'Public Relations',
                            80,	 'Sales',
                            90,	 'Executive',
                            100, 'Finance',
                            110, 'Accounting'
                               , '그 외'
       )                                부서명
FROM   EMPLOYEES;

-- 사번, 이름, 부서명 : 모든 부서명 , NULL 부서없음
SELECT EMPLOYEE_ID                    사번,
       FIRST_NAME || ' ' || LAST_NAME 이름,
       DECODE(department_id,
                            10,	 'Administration',
                            20,	 'Marketing',
                            30,	 'Purchasing',
                            40,	 'Human Resources',
                            50,	 'Shipping',
                            60,	 'IT',
                            70,	 'Public Relations',
                            80,	 'Sales',
                            90,	 'Executive',
                            100, 'Finance',
                            110, 'Accounting'
                               , 'NULL 부서없음'
       )                              부서명
FROM   EMPLOYEES;

-- 직원명단 직원의 월급, 보너스 출력 연봉출력
-- NULL 이 계산에 포함되면 결과는 NULL
SELECT EMPLOYEE_ID                            번호,
       FIRST_NAME || ' ' || LAST_NAME         이름,
       SALARY                                 월급,
       NVL( SALARY*COMMISSION_PCT, 0 )        보너스,
       -- NVL  commission_pct 이 NULL 이면 0출력
       SALARY + NVL(SALARY * COMMISSION_PCT, 0) 연봉_월기준,
       NVL2(COMMISSION_PCT, SALARY + (SALARY * COMMISSION_PCT), SALARY) 실수령액,
       (SALARY * 12) + NVL(SALARY * COMMISSION_PCT, 0) 총연봉
       -- NVL2 commission_pct 이 NULL 이 아니면 commission_pct + (SALARY*commission_pct) 출력 / NULL 이면 SALARY 출력
FROM   EMPLOYEES;

---------------------------------------------------------------------------------
-- 3) CASE WHENMN THEN END
-- WHEN SCORE BETWEEN 90 AND 100     THEN 'A'
-- WHEN 90 <= SCORE AND SCORE <= 100 THEN 'A'


-- 사번, 이름, 부서명
SELECT employee_id,
      first_name || ' ' || last_name,
      CASE DEPARTMENT_ID 
          WHEN 60  THEN 'IT'
          WHEN 80  THEN 'SALSE'
          WHEN 90  THEN 'EXECUTIVE'
          ELSE          '그외'
          END           부서명
FROM EMPLOYEES;

SELECT employee_id,
      first_name || ' ' || last_name,
      CASE
          WHEN DEPARTMENT_ID = 60  THEN 'IT'
          WHEN DEPARTMENT_ID = 80  THEN 'SALSE'
          WHEN DEPARTMENT_ID = 90  THEN 'EXECUTIVE'
          ELSE                          '그외'
          END                           부서명
FROM EMPLOYEES;

--------------------------------------------------------------------------------
-- 집계함수 : AGGREGATE 함수
-- 모든 집계함수는 NULL 값은 포함하지 않는다
-- SUM(), AVG(), MIN(), MAX(), COUNT(), SEDDEV(), VARIANCE()
-- 합계   평균   최소   최대    줄수    표준편차    분산
-- 그루핑 : GROUP BY
-- ~별 인원수 

SELECT *                      FROM EMPLOYEES;
SELECT COUNT(*)               FROM EMPLOYEES;  -- 109 : ROW 줄 수
SELECT COUNT(EMPLOYEE_ID)     FROM EMPLOYEES;  -- 109
SELECT COUNT(DEPARTMENT_ID)   FROM EMPLOYEES;  -- 106

SELECT EMPLOYEE_ID            FROM EMPLOYEES
WHERE  DEPARTMENT_ID          IS NULL;

SELECT COUNT(EMPLOYEE_ID)     FROM EMPLOYEES
WHERE  DEPARTMENT_ID          IS NULL;

-- 전체 직원의 월급합 : 세로합 ( NULL 제외 )
SELECT COUNT(SALARY)          FROM EMPLOYEES;  -- 107
SELECT SUM(SALARY)            FROM EMPLOYEES;  -- 691416
SELECT AVG(SALARY)            FROM EMPLOYEES;  -- 6461.831775700934579439252336448598130841
SELECT MAX(SALARY)            FROM EMPLOYEES;  -- 24000
SELECT MIN(SALARY)            FROM EMPLOYEES;  -- 2100

SELECT SUM(SALARY) / COUNT(SALARY) FROM EMPLOYEES;  -- 6461.831775700934579439252336448598130841
                    -- 107 / 맞는 계산식 2명의 SALARY 가 없기 때문
SELECT SUM(SALARY) / COUNT(*) FROM EMPLOYEES;       -- 6343.266055045871559633027522935779816514
                    -- 109
                    
-- 60번 부서의 평균월급
SELECT AVG(salary)
FROM   EMPLOYEES
WHERE  department_id = 60; -- 5760

-- EMPLOYEE TABLE의 부서수 의 갯수
SELECT COUNT(department_id)
FROM   EMPLOYEES; -- 106줄 : (NULL)은 제외한값 

SELECT department_id
FROM   EMPLOYEES; -- 109줄 : 직원수를 구한것과 가깝다

-- 중복을 제거(DISTINCT) 한 부서의 수를 출력
-- 중복을 제거한 부서번호 리스트 : NULL 이 출력됨
SELECT DISTINCT  department_id
FROM   EMPLOYEES; -- 12줄



-- 중복 / NULL 을 제외한 줄 수
SELECT COUNT(DISTINCT  department_id)
FROM   EMPLOYEES; -- 11줄

-- 직원이 근무하는 부서의 수 : 부서장이 있는 부서수 : DEPARTMENTS 부서에서
SELECT COUNT(DISTINCT DEPARTMENT_ID) "직원이 있는 부서 수" FROM   DEPARTMENTS ; -- 27
SELECT COUNT(DISTINCT MANAGER_ID)    "부서장이 있는 부서수"FROM   DEPARTMENTS ; -- 11

-- 직원이 근무하는 부서의 수
SELECT COUNT( DEPARTMENT_ID)
FROM DEPARTMENTS
WHERE MANAGER_ID IS NOT NULL;


-- 
SELECT 7/2,
       ROUND(156.456, 2), ROUND(156.456, -2), 
      -- 소수점 반올림123.46 / 소수점 앞 2자리 반올림 100
       TRUNC(156.456, 2), TRUNC(156.456, -2)
FROM DUAL;

-- 직원수, 월급합, 월급평균, 최대월급, 최소월급
SELECT COUNT(employee_id)  직원수   FROM  EMPLOYEES; -- 109
SELECT SUM(SALARY)         월급합   FROM  EMPLOYEES; -- 691416
SELECT AVG(SALARY)         월급평균 FROM  EMPLOYEES; -- 6461.831775700934579439252336448598130841
SELECT MAX(SALARY)         최대월급 FROM  EMPLOYEES; -- 24000
SELECT MIN(SALARY)         최소월급 FROM  EMPLOYEES; -- 2100

SELECT COUNT(EMPLOYEE_ID)    직원수,
       SUM(SALARY)           월급합,
       ROUND(AVG(SALARY), 3) 월급평균,
       MAX(SALARY)           최대월급,
       MIN(SALARY)           최소월급
FROM  EMPLOYEES;       
       
       
-- 부서 60번 부서 인원수, 월급합, 월급평균
SELECT COUNT(employee_id) 인원수,  -- 5
       SUM(SALARY)        월급합,  -- 28800
       AVG(SALARY)        월급평균 -- 5760
FROM   EMPLOYEES
WHERE  department_id = 60;

--------------------------------------
SQL 문의 실행 순서
1. FROM
2. WHERE
3. SELECT
4. ORDER BY
--------------------------------------

-- 부서 50, 60, 80번 부서가 아닌 인원수, 월급합, 월급평균
SELECT COUNT(DEPARTMENT_id)   인원수,  -- 22 = ( 109 - ( 45 + 05 + 34 ) )-3(NULL 3명)
       SUM(SALARY)            월급합,  -- 194716
       ROUND(AVG(SALARY), 3)  월급평균 -- 8850.727
FROM   EMPLOYEES
WHERE  department_id <> 50 -- 45명
AND    department_id != 60 -- 05명
AND    department_id != 80;-- 34명
-- SELECT COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;


SELECT COUNT(DEPARTMENT_id)   인원수,  -- 22 = ( 109 - ( 45 + 05 + 34 ) )-3(NULL 3명)
       SUM(SALARY)            월급합,  -- 194716
       ROUND(AVG(SALARY), 3)  월급평균 -- 8850.727
FROM   EMPLOYEES
WHERE  DEPARTMENT_ID NOT IN(50, 60, 80);

----------------------------------------------------------------------------------
 부서별 사원수
 SELECT DEPARTMENT_ID        부서번호,
        COUNT( EMPLOYEE_ID ) 사원수
 FROM   EMPLOYEES; -- ORA-00937: 단일 그룹의 그룹 함수가 아닙니다 
 -- GROUP BY 절이 필요하다
 -- 일반칼럼과 집계함수를 동시에 사용하면 ~ 별 통계라고 해석이 된다.
 
 SELECT   DEPARTMENT_ID        부서번호,
          COUNT( EMPLOYEE_ID ) 사원수
 FROM     EMPLOYEES
 -- WHERE  : GROUP 을 만들기 '전' 조건
 -- GROUP BY DEPARTMENT_ID
 GROUP BY ROLLUP( DEPARTMENT_ID )
 -- HAVING : GROUP을 만든 '후' 조건
 ORDER BY DEPARTMENT_ID;
 
 -- 부서별 월급합, 월급 평균을 구하시오
SELECT   DEPARTMENT_ID          부서번호,
         SUM(SALARY)            월급합,
         ROUND(AVG(SALARY), 2)  월급평균
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 부서별 사원수 통계
SELECT    DEPARTMENT_ID      번호,
          COUNT(employee_id) 사원수  -- 집계함수 사용
FROM      EMPLOYEES
GROUP BY  DEPARTMENT_ID              
ORDER BY  DEPARTMENT_ID;

-- 부서별 인원수 월급합
SELECT   department_id      번호,
         COUNT(employee_id) 사원수,
         SUM(SALARY)        월급합
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 부서별 인원수가 5명 이상인 부서번호
SELECT    DEPARTMENT_ID      번호,
          COUNT(employee_id) 사원수
FROM      EMPLOYEES
GROUP BY  DEPARTMENT_ID
HAVING    COUNT(employee_id) >= 5
ORDER BY  DEPARTMENT_ID;

-- 부서별 월급총계가 20000이상인 부서번호
SELECT   department_id      번호,
         COUNT(employee_id) 사원수,
         SUM(SALARY)        월급합
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING   SUM(SALARY) >= 20000
ORDER BY DEPARTMENT_ID;

-- JOB_ID 별 인원수
SELECT    JOB_ID     ,
          COUNT(EMPLOYEE_ID) 인원수
FROM      EMPLOYEES
GROUP BY  JOB_ID
ORDER BY  JOB_ID;

-- JOB_TITLE 별 인원수
SELECT
FROM

-- 입사일 기준 월별 인원수, 2017년 기준
SELECT   TO_CHAR(HIRE_DATE, 'MM')  입사일, 
         COUNT(EMPLOYEE_ID)        인원수
FROM     EMPLOYEES
WHERE    TO_CHAR(HIRE_DATE, 'YYYY') = '2017'
GROUP BY TO_CHAR(HIRE_DATE, 'MM')
ORDER BY TO_CHAR(HIRE_DATE, 'MM');

-- 부서별 최대월급이 14000 이상인 부서의 부서번호와 최대 월급
SELECT   DEPARTMENT_ID  부서번호,
         MAX(SALARY)    최대월급
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING   MAX(SALARY) >= 14000
ORDER BY DEPARTMENT_ID;

-- 부서별 모우고 같은부서는 직업별 인원수, 월급평균
SELECT   department_id  부서번호, 
         JOB_ID         직업별, -- JOB_TITLE
         COUNT(JOB_ID)  인원수,
         ROUND( AVG(salary), 3 ) 월급평균
FROM     EMPLOYEES
--GROUP BY DEPARTMENT_ID, JOB_ID
--GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID, JOB_ID;


-- ROLLUP : GROUP BY 절과 함께 쓰이며
--          계층적인 요약 통계(소계 및 총계)를 자동으로 생성해주는 함수입니다.





















