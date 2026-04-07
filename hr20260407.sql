 SELECT * FROM tab; -- 테이블 목록 조회
 /*
 SELECT     칼럼명1   별칭1, 칼럼명2  별칭2, 칼럼명3  별칭3, ...
  FROM      테이블명
  WHERE     조건
   ORDER BY 정렬할칼럼1 ASC, 정렬할칼럼2 DESC,
*/

-- 직원의 이름을 성과 이름을 붙여서 출력
SELECT      FIRST_NAME, LAST_NAME, FIRST_NAME || ' ' || LAST_NAME  EMPNAME
 FROM       EMPLOYEES
 -- ORDER BY    FIRST_NAME || ' ' || LAST_NAME;
 -- ORDER BY    EMPNAME;
  ORDER BY   3;   -- 3번째 칼럼을 기준으로 출력이된다 SELECT의 3번째
  
  
  -- 부서번호가 60인 직원번호(번호 이름 이메일 부서번호) 
  -- 조건 : =, !=(<>,^=)
  --        >, <, >=, <=
  --        NOT, AND, OR
SELECT   EMPLOYEE_ID                       번호,
         FIRST_NAME || ' ' || LAST_NAME    이름,
         EMAIL                             이메일, 
         DEPARTMENT_ID                     부서번호
FROM     EMPLOYEES
WHERE    DEPARTMENT_ID = 60
ORDER BY 이름  ASC; -- 정렬단계 현재는 이름으로 오름차순

  -- 부서번호가 90인 직원번호
SELECT   EMPLOYEE_ID                       번호,
         FIRST_NAME || ' ' || LAST_NAME    이름,
         EMAIL                             이메일, 
         DEPARTMENT_ID                     부서번호
FROM     EMPLOYEES
WHERE    DEPARTMENT_ID = 90
ORDER BY 번호  DESC; -- 정렬단계 현재는 번호로 내림차순
 
 
 -- 부서번호가 60, 90 부서의 직원정보(번호 이름 이메일 부서번호)
 -- ALT + ' = 소문자를 대문자로 바꾸는 단축키
SELECT   E.EMPLOYEE_ID                       번호, 
         E.FIRST_NAME || ' ' || E.LAST_NAME  이름, 
         E.EMAIL                             이메일, 
         DEPARTMENT_ID                       부서번호
FROM     EMPLOYEES  E
WHERE    E.DEPARTMENT_ID = 60 OR E.Department_Id = 90 -- OR : 이거나 : + 논리합
ORDER BY 번호 ASC;
 
 
-- IN 명령어 사용
SELECT   E.EMPLOYEE_ID                       번호, 
         E.FIRST_NAME || ' ' || E.LAST_NAME  이름, 
         E.EMAIL                             이메일, 
         DEPARTMENT_ID                       부서번호
FROM     EMPLOYEES  E
WHERE    E.DEPARTMENT_ID IN ( 60, 90, 80 ) 
ORDER BY 부서번호 ASC, 이름 ASC;
-- 부서번호순, 부서번호가 같으면 이름 순으로 정렬


 --1. 월급이 12000 이상인 직원의(번호, 이름, 이메일, 월급)을 월급순으로 출력
 SELECT E.EMPLOYEE_ID                      번호,
        E.FIRST_NAME || ' ' || E.LAST_NAME 이름, 
        E.EMAIL                            이메일, 
        E.SALARY                           월급
 FROM   EMPLOYEES E
 WHERE  SALARY >= 12000
 ORDER BY 월급 DESC;
 
 
 --2. 월급이 10000~15000 인 직원의(사번, 이름, 월급, 부서번호)
 --1)
 SELECT E.EMPLOYEE_ID                      사번,
        E.FIRST_NAME || ' ' || E.LAST_NAME 이름,
        E.SALARY                           월급,
        E.DEPARTMENT_ID                    부서번호
 FROM   EMPLOYEES E
 WHERE  E.SALARY >= 10000 AND E.SALARY <= 15000
 ORDER BY 월급 DESC;


 --2. 월급이 10000~15000 인 직원의(사번, 이름, 월급, 부서번호)
 --2)
 SELECT E.EMPLOYEE_ID                      사번,
        E.FIRST_NAME || ' ' || E.LAST_NAME 이름,
        E.SALARY                           월급,
        E.DEPARTMENT_ID                    부서번호
 FROM   EMPLOYEES E
 WHERE  E.SALARY BETWEEN 10000 AND 15000
 ORDER BY 월급 DESC; 
 
 
 -- 3. 직업 ID 가 IT_PROG 인 직원 명단(사번, 이름, 월급, 부서번호)
 -- 1)
 SELECT E.EMPLOYEE_ID                      번호,
        E.FIRST_NAME || ' ' || E.LAST_NAME 이름, 
        E.JOB_ID                           직업ID,
        E.DEPARTMENT_ID                    부서번호
 FROM   EMPLOYEES E
 WHERE  E.JOB_ID = 'IT_PROG' or E.Job_Id = 'it_prog';
 
 
 -- 2) UPPER(), LOWER(), INITCAP() 함수
 SELECT E.EMPLOYEE_ID                      번호,
        E.FIRST_NAME || ' ' || E.LAST_NAME 이름, 
        E.JOB_ID                           직업ID,
        E.DEPARTMENT_ID                    부서번호
 FROM   EMPLOYEES E
 WHERE  LOWER( E.JOB_ID ) = 'it_prog';
 
 -- 4. 직원이름이 GRANT 인 직원을 찾으세요 
 SELECT E.EMPLOYEE_ID                      번호,
        E.FIRST_NAME || ' ' || E.LAST_NAME 이름,
        E.email                            이메일
 FROM   EMPLOYEES E
 WHERE  UPPER(E.FIRST_NAME || ' ' || E.LAST_NAME) LIKE '%GRANT%'
 ORDER BY E.FIRST_NAME || ' ' || E.LAST_NAME ASC;
 
 
 -- 5. 사번, 월급, 10% 인상한 월급
 SELECT E.EMPLOYEE_ID                      EMPID,
        E.FIRST_NAME || ' ' || E.LAST_NAME ENAME,
        E.SALARY                           SAL,
        E.SALARY * 1.1                     SAL2
 --       E.SALARY + (E.salary * 0.1)        SAL2
 FROM   EMPLOYEES E
 ORDER BY SALARY * 1.1 DESC;
 
 
 -- 6. 50번 부서의 직원명단, 월급, 부서번호
 SELECT E.employee_id                      사번,
        E.FIRST_NAME || ' '|| E.LAST_NAME  직원명단, 
        E.SALARY                           월급, 
        E.DEPARTMENT_ID                    부서번호
 FROM   EMPLOYEES E
 WHERE  E.DEPARTMENT_ID = 50
 ORDER BY 월급 DESC;
 
 
 -- 7. 20, 80, 60, 90 번 부서의 직원명단, 월급, 부서번호
 SELECT E.FIRST_NAME || ' '|| E.LAST_NAME  직원명단, 
        E.SALARY                           월급, 
        E.DEPARTMENT_ID                    부서번호
 FROM   EMPLOYEES E
 WHERE  E.DEPARTMENT_ID = 20
  OR    E.DEPARTMENT_ID = 80
  OR    E.DEPARTMENT_ID = 60
  OR    E.DEPARTMENT_ID = 90
  --    E.DEPARTMENT_ID IN(20, 80, 60, 90)   
 ORDER BY 부서번호 DESC, 월급 DESC;
 
 -- 중요데이터를 2개 입력
 ---- 전체 자료수 출력 COUNT(*)
 SELECT COUNT(*)
 FROM   EMPLOYEES; -- 107 ROW의 COUNT
 
 SELECT SYSDATE
 FROM   DUAL; -- 오늘의 날짜 : 연,월,일,시,분,초
 
 -- 신입사원 입사 ( 박보검, 장원영 )
 INSERT     INTO    EMPLOYEES
 VALUES ( 207,     '보검', '박', 'BOKUM', '1.242.555.8888', SYSDATE,
         'IT_PROG', NULL,  NULL,  NULL,    NULL );
         
 INSERT     INTO    EMPLOYEES
 VALUES ( 208,     '리나', '카', 'LINAKA', '1.242.555.9999', SYSDATE,
         'IT_PROG', NULL,  NULL,  NULL,    NULL );
         
 SELECT *        FROM EMPLOYEES; -- 박보검 카리나 행에 추가됨
 SELECT COUNT(*) FROM EMPLOYEES; -- 109
 
UPDATE  EMPLOYEES
SET     EMAIL        = 'KRINA',
        PHONE_NUMBER = '010-1234-5678'
WHERE   EMPLOYEE_ID  = 208;
 
 COMMIT;
 ROLLBACK;
 
 
 -- 8. 보너스없는 직원명단 (COMMISSION_PCT 가 없다)
 -- 1)
SELECT   EMPLOYEE_ID                     번호, 
         FIRST_NAME || ' ' || LAST_NAME  이름,
         COMMISSION_PCT                  보너스
FROM     EMPLOYEES 
WHERE    COMMISSION_PCT IS NULL
ORDER BY EMPLOYEE_ID ASC;


 -- 8. 보너스있는 직원명단 (COMMISSION_PCT 가 없다)
 -- 2)
SELECT   EMPLOYEE_ID                     번호, 
         FIRST_NAME || ' ' || LAST_NAME  이름,
         COMMISSION_PCT                  보너스
FROM     EMPLOYEES 
WHERE    COMMISSION_PCT IS NOT NULL
ORDER BY EMPLOYEE_ID ASC;


 -- 9. 전화번호가 010으로 시작하는
 -- PATTERN MACTCHING
 -- % : 0 자 이상의 모든 숫자 글자
 -- _ : 1자의 모든 숫자 글자
SELECT  E.employee_id                       번호,
        E.first_name || ' ' || E.last_name  이름,
        E.phone_number                      전화번호
FROM    EMPLOYEES  E
WHERE   E.phone_number LIKE '010%' -- 010으로 시작하는
--  WHERE   E.phone_number LIKE '%010'  -- STARTS WITH : --으로 시작하는
--  WHERE   E.phone_number LIKE '%555%' -- CONTAINS    : --를 포함되는
--  WHERE   E.phone_number LIKE '555%'  -- ENDS WITH   : --로 끝나는
ORDER BY 번호 ASC;


 -- 10. LAST_NAME 세번째, 네번째 글자가 LL 인것을 찾아라
 SELECT  E.employee_id,                     
         E.first_name,
         E.last_name
 FROM    EMPLOYEES E
 WHERE  UPPER( E.last_name ) LIKE '__LL%'
 -- WHERE  E.last_name LIKE '__ll%'
 ORDER BY E.employee_id ASC;
 -------------------------------------------------------
 SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
 FROM   EMPLOYEES;
 
 -- 날짜 26/04/07 : 표현법이 틀림 년/월/일 사용하지 않음 
 -- 2026-04-07    : ANSI 표준이다
 -- 04/13/26      : 월/일/년  -> 미국식
 -- 13/04/26      : 일/월/년  -> 영국식
 
 ALTER      SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
 
 SELECT     SYSDATE         FROM    DUAL; -- 26/04/07
 SELECT     7/2             FROM    DUAL; -- 3.5
 SELECT     0/2             FROM    DUAL; -- 0
 SELECT     2/0             FROM    DUAL; -- 오류 ORA-01476: 제수가 0 입니다
 SELECT     2/0.0           FROM    DUAL; -- 오류 ORA-01476: 제수가 0 입니다
 SELECT     SYSTIMESTAMP    FROM    DUAL; -- 26/04/07 15:36:12.477000000 +09:00
 
 SELECT     SYSDATE - 7, -- 오늘 날짜 - 7일(일주일전)
            SYSDATE,     -- 오늘 날짜
            SYSDATE + 7  -- 오늘 날짜 + 7일(일주일후)
 FROM       DUAL;
 -- 날짜 + n, 날짜 - n : 몇 일 전,후
 -- 날짜1 - 날짜2 : 두날짜 사이의 차이를 일 수로 계산
 -- 날짜1 + 날짜2 : 오류 잘못된 표현 - 의미없음
 -- TO_DATE(), TO_CHAR(), TO_NUMBER()
 -- 크리스마스에서 오늘 날짜의 일수 차이
 SELECT TO_DATE('26/12/25') - SYSDATE 
 FROM DUAL; -- 261.339965277777777777777777777777777778
 
 -- 소수이하 3자리로 반올림 : ROUND(VAL, 3)
 -- 소수이하 3자리로 절삭   : TRUNC(VAL, 3)
 -- 15일 기준으로 반올림 날짜 : ROUND(SYSDATE,'MONTH')
 -- 해당달의 첫번째 날짜      : TRUNC(SYSDATE,'MONTH')
 SELECT SYSDATE, ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH')
 FROM DUAL;
 
 SELECT NEXT_DAY( SYSDATE, '월요일' ) FROM DUAL; -- 26/04/13 : 다음 월요일이 몇일인지
 SELECT TRUNC( SYSDATE, 'MONTH' ) FROM DUAL;     -- 26/04/01 : 날짜에 해당월의 첫번째 일일
 SELECT LAST_DAY( SYSDATE ) FROM DUAL;           -- 26/04/30 : 날짜에 해당월의 마지막날
 
 
 
 -- 11. 입사년월이 17년 2월인 사원출력
 ALTER      SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
 SELECT  E.employee_id                      번호,
         E.first_name || ' ' || E.last_name 이름,
         E.HIRE_DATE                        입사년월
 FROM    EMPLOYEES E
 WHERE   TO_CHAR( HIRE_DATE, 'YYYY-MM') = '2017-02';
 -- WHERE   TO_CHAR(E.hire_date, 'YY/MM') = '17/02'
 --WHERE   HIRE_DATE
 --   BETWEEN '2017-02-01'
 --   AND     LAST_DAY('2017-02-01')
 
 
 -- 12.'17/02/07'에 입사한 사람 출력, 
 --1)
 SELECT  department_id                  번호,
         first_name || ' ' || last_name 이름,
         hire_date                      입사년월
 FROM    EMPLOYEES
 WHERE   hire_date = '2017-02-07'  
 ORDER BY 번호 ASC;
 
 
 -- 12.'12/06/07'에 입사한 사람 출력,  
 --2)
  ALTER      SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
 SELECT  department_id                  번호,
         first_name || ' ' || last_name 이름,
         hire_date                      입사년월
 FROM    EMPLOYEES
 WHERE   hire_date = '2012-06-07' 
 ORDER BY 번호 ASC;
 
 
 -- 13. 오늘 '26/04/07' 입사한 사람
 ALTER      SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
 SELECT  E.employee_id                      번호,
         E.first_name || ' ' || E.last_name 이름,
         E.HIRE_DATE                        입사년월
 FROM    EMPLOYEES E
 -- WHERE   '2026-04-07 00:00:00' <= HIRE_DATE
 -- AND     HIRE_DATE <= '2026-04-07 23:59:59'
 -- WHERE   E.HIRE_DATE BETWEEN '2026-04-07 00:00:00' AND '2026-04-07 23:59:59'
 WHERE TRUNC(HIRE_DATE) = '2026-04-07 00:00:00';
 
 -- TYPE 변환
 -- TO_DATE(문자)          -> 날짜
 -- TO_NUMBER(문자)        -> 숫자
 -- TO_CHAR( 숫자,'포맷' ) -> 글자
 -- TO_CHAR( 날짜,'포맷' ) -> 날짜 형태의 문자
 -- 포맷 : YYYY-MM-DD HH24:MI:SS DAY AM
    -- YYYY  : 연도
    -- MM    : 월
    -- DD    : 일 
    -- HH24  : 시 24시간 기준 / HH12 : 12시간 기준
    -- MI    : 분 
    -- SS    : 초
    -- DAY   : 요일   , 일요일
    -- DY    : 요일   , 일
    -- AM/PM : 오전/오후 (한글로만 나옴)
 
-- 입사후 일주일 이내인 직원명단
SELECT    EMPLOYEE_ID,
          FIRST_NAME, LAST_NAME,
          HIRE_DATE,
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
SELECT  employee_id                     사번,
        first_name || ' ' || last_name  이름,
        hire_date                       입사일
FROM    EMPLOYEES
WHERE TO_CHAR( HIRE_DATE, 'MM') = '08';


-- 부서번호 80이 아닌 직원
SELECT   E.employee_id                      사번,
         E.first_name || ' ' || E.last_name 이름,
         E.department_id                    부서번호
FROM     EMPLOYEES E
WHERE    E.department_id != 80
ORDER BY 부서번호 ASC;

-- 직원사번, 입사일
-- 2026년 04월 07일 10시 05분 04초 오전 수요일
-- 한자로 출력
SELECT  employee_id                     사번,
        first_name || ' ' || last_name  이름,
       TO_CHAR( hire_date,'YYYY"年"-MM"月"-DD"日"HH:MI:SS AM DAY')입사일
FROM    EMPLOYEES; 














 
 
 