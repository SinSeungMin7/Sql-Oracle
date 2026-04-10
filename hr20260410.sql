-- 함수
- 숫자 함수
① ABS(n)
    ABS 함수는 매개변수로 숫자를 받아 그 절대값을 반환하는 함수다.
    SELECT ABS(10), ABS(-10), ABS(-10.123)  FROM DUAL;
   -- 결과값 10        10          10.123
   
② CEIL(n)과 FLOOR(n) -> 결과 정수형
  • CEIL     : 무조건 올림
   - CEIL 함수는 매개변수 n과 같거나 가장 큰 정수를 변환한다
  • FLOOR(n) : 버림
   - floor 함수는 ceil 함수와는 반대로 매개변수 n 보다 작거나 가장 큰 정수를 변환한다
   SELECT CEIL(10.123), CEIL(10.541), CEIL(11.001) FROM DUAL;
   -- 결과값     11            11            12 
   
   SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.001) FROM DUAL;
   -- 결과값      10             10            11 

   SELECT FLOOR(-10.123), FLOOR(-10.541), FLOOR(-11.001) FROM DUAL;
   -- 결과값      -11             -11             -12 
   
   SELECT TRUNC(-10.123), TRUNC(-10.541), TRUNC(-11.001) FROM DUAL;
   -- 결과값      -10             -10             -11 
   
③ ROUND(n, i)와 TRUNC(n1, n2)
    - ROUND 함수는 매개변수 n을 소수점 기준 (i + 1)번 째에서 반올림한 결과를 반환한다.
      i는 생략할 수 있고 디폴트 값은 0, 즉 소수점 첫 번째 자리에서 반올림이 일어나 정수 부분의 일의 자리에 결과가 반영된다
     
    - TRUNC 함수는 반올림을 하지 않고 n1을 소수점 기준 n2 자리에서 무조건 잘라낸 결과를 반환한다.
            '양수'일때는 소수점 기준 오른쪽, '음수'일떄는 소수점 기준 왼쪽 자리에서 잘라낸다
            
    ROUND(n, i) n의 i 번째 자리수 까지 표현 단 i번째 자리수는 i 뒷자리를 반올림 하여 표현한다
    ex) ROUND(10.154, 1) : 10.2  -> 10.15의 0.05를 반올림하여 10.2가 나옴
    ex) ROUND(10.154, 2) : 10.15 -> 10.154의 0.004를 반올림하여 10.15가 나옴

   SELECT ROUND(10.154, 1), ROUND(10.154, 2), ROUND(10.154, 3) FROM DUAL;
   -- 결과값      10.2              10.15            10.154     
   
   SELECT TRUNC(10.154, 1), TRUNC(10.154, 2), TRUNC(10.154, 3) FROM DUAL;
   -- 결과값      10.1              10.15            10.154     
   
   SELECT ROUND(0, 3), ROUND(115.155, -1), ROUND(115.155, -2) FROM DUAL;
   -- 결과값     0               120                 100      
   
   SELECT TRUNC(0, 3), TRUNC(115.155, -1), TRUNC(115.155, -2) FROM DUAL;
   -- 결과값     0               110                 100      

④ POWER(n2, n1)와 SQRT(n)
    - SQRT(n) : 제곱근 : SQUARE ROOT
    - POWER 함수는 n2를 n1 제곱한 결과를 반환한다.
            n1은 정수, 실수 모두 올수있는데, n2가 음수일때 n1은 정수만 올 수 있다.
   
   SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001), POWER(4, 0.5) FROM DUAL;
   -- 결과값   9              27       27.00...             1.99..
   
   SELECT SQRT(2), SQRT(4) FROM DUAL;
   -- 결과값 1.14142... 2      
   
   SELECT SQRT(2), SQRT(-4) FROM DUAL;
   -- 루트안에 (-)음수를 넣으면 에러가 난다
   
⑤ MOD(n2, n1)와 REMAINDER(n2, n1)
   - MOD 함수는 n2를 n1으로 나눈 나머지 값을 반환한다.
   - REMAINDER 함수 역시 n2를 n1으로 나눈 나머지 값을 반환하는데,
               나머지를 구하는 내부적 연산 방법이 MOD함수와는 다르다
  • MOD → n2 - n1 * FLOOR (n2/n1)
  • REMAINDER → n2 - n1 * ROUND (n2/n1)
  
   SELECT MOD(19,4), MOD(19.123, 4.2) FROM DUAL;
   -- 결과값   3            2.323
   
   SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2) FROM DUAL;
   -- 결과값         -1                 -1.877

⑥ EXP(n), LN(n) 그리고 LOG(n2, n1)
  - EXP는 지수 함수이다 n의 제곱 값을 반환
  - LN 함수는 자연 로그 함수로 밑수가 e인 로그 함수이다.
  - LOG는 n2를 밑수로 하는 n1의 로그 값을 반환한다
  
    SELECT EXP(2), LN(2.713), LOG(10, 100) FROM DUAL; -- 결과값 7.3890560989306502272304274605750078132,  0.9980550336767946922014710783755035594696, 2  
  
7) SIN(), COS(), TAN() : DEGREE(각도) -> RADIAN (원주율/180 * 각도) -> 0.01745
    SIN 30 도 -> 0.5
    
    SELECT SIN(30), SIN(30 * 0.01745) FROM DUAL;
--------------------------------------------------------------------------------

 문자함수  
 - 연산 대상이 문자이며 반환 값은 함수에 따라 문자나 숫자를 반환한다
 
① INITCAP(char), LOWER(char), UPPER(char)
    INITCAP 함수는 매개변수로 들어오는 char의 첫 문자는 대문자로, 나머지는 소문자
    SELECT INITCAP('never say goodbye'), INITCAP('never6say*good가bye') FROM DUAL;
   -- 결과값       Never Say Goodbye              Never6say*Good가Bye
   
② CONCAT(char1, char2), SUBSTR(char, pos, len), SUBSTRB(char, pos, len)
   - CONCAT 함수는 '||' 연산자 처럼 매개변수로 들어오는 두 문자를 붙여 반환한다.
   
   - SUBSTR 함수는 문자 함수 중 가장 많이 사용되는 함수,
            잘라올 대사 문자열 char의 pos번째 문자부터 len 길이만큼 잘라낸 결과 반환
            pos 값으로 음수가 오면 char 문자열 맨 끝에서 시작한 상대적 위치를 의미
            len 값이 생략되면 pos번째 문자부터 나머지 모든 문자를 반환한다
      
   - SUBSTRB 함수는 문자 개수가 아닌 무자열의 바이트(byte) 수만큼 잘라낸 결과를 반환한다
-- 알아보기                                
    SELECT CONCAT('I Have', ' A Dream'), 'I Have' || ' A Dream'  FROM DUAL;
   -- 결과값        I Have A Dream           I Have A Dream
   
    SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -3, 4) FROM DUAL;
   -- 결과값           ABCD                     EFG
   -- SUBSTR('ABCDEFG', -1, 4) : -1 뒤로부터 첫번째 에서 4개 앞으로 진행 'G'
   
    SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('가나다라마바사', 1, 4) FROM DUAL;
   -- 결과값           ABCD                      가
   
③ LTRIM(char, set), RTRIM(char, set)
  --왼쪽글 날리기 / 오른쪽글날리기
    SELECT LTRIM('ABCDEFGABC', 'ABC'),  -- DEFGABC
           LTRIM('가나다라', '가'),     -- 나다라
           RTRIM('ABCDEFGABC', 'ABC'),  -- ABCDEFG
           RTRIM('가나다라', '라'),     -- 가나다       
           TRIM('   ABCDEF      '), -- ABCDEF
           LENGTH( TRIM('   ABCDEF      ') ), -- 6
           TRIM( LEADING ' ' FROM '   ABCDEF      ' ), -- ABCDEF      
           LENGTH( TRIM ( LEADING ' ' FROM '   ABCDEF      ' ) ) --12
    FROM DUAL;
 --------------------------------------------------------------------   
④ LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)
/* LPAD 함수는 매개변수로 들어온 expr2 문자열(생략할 때 디폴트는 공백 한 문자)을
   n자리만큼 왼쪽부터 채워 expr1을 반환하는 함수다.
   매개변수 n은 expr2와 expr1이 합쳐져 반환되는 총 자릿수를 의미한다.*/
    CREATE TABLE ex4_1 ( phone_num VARCHAR2(30) );
    
    INSERT INTO ex4_1 VALUES ('111-1111');

    INSERT INTO ex4_1 VALUES ('111-2222');

    INSERT INTO ex4_1 VALUES ('111-3333');

    SELECT * FROM ex4_1;
      
    SELECT LPAD(phone_num, 12, '(02)') FROM ex4_1;
    -- 왼쪽에 (02) 입력해줌 (실제 데이터가 바뀌는것은 아니다)
    
    SELECT RPAD(phone_num, 12, '(02)') FROM ex4_1;
    -- 오른쪽에 (02) 입력해줌 (실제 데이터가 바뀌는것은 아니다)

⑤ REPLACE(char, search_str, replace_str), TRANSLATE(expr, FROM_str, to_str)
   /* REPLACE 함수는 char 문자열에서 search_str 문자열을 찾아
      이를 replace_str 문자열로 대체한 결과를 반환하는 함수다.*/
     SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나', '너')  FROM DUAL;
   
     SELECT LTRIM(' ABC DEF '),
            RTRIM(' ABC DEF '),
            REPLACE(' ABC DEF ', ' ', '')
     FROM DUAL;
   
   
⑥ INSTR(str, substr, pos, occur),--indexOf()
    LENGTH(chr)  -- 글자수
    LENGTHB(chr) -- 바이트
/*  INSTR 함수는 str 문자열에서 substr과 일치하는 위치를 반환하는데, 
    pos는 시작 위치로 디폴트 값은 1, occur은 몇 번째 일치하는지를 명시하며 디폴트 값은 1이다.*/

    SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약') AS INSTR1,      -- 4   ('만약'을 찾아라)
           INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5) AS INSTR2,   -- 18  (5이후에 나오는 '만약')
           INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5, 2) AS INSTR3 -- 32  (5이후에 2번째나오는 '만약')
    FROM DUAL;
   
    SELECT LENGTH('대한민국'),  -- 4 글자
           LENGTHB('대한민국')  -- 12 BYTE
    FROM DUAL;
    
7) TRANSLATE()
  - 암호화와 복호화를 처리할때 사용한다
 --------------------------------------------------------------------------------------
 -- 날짜 함수
① SYSDATE, SYSTIMESTAMP

② ADD_MONTHS (date, integer)
 -- ADD_MONTHS 함수는 매개변수로 들어온 날짜에 interger 만큼의 월을 더한 날짜를 반환한다.

③ MONTHS_BETWEEN(date1, date2) 
 -- MONTHS_BETWEEN 함수는 두 날짜 사이의 개월 수를 반환하는데, date2가 date1보다 빠른 날짜가 온다.

④ LAST_DAY(date)
 -- LAST_DAY는 date 날짜를 기준으로 해당 월의 마지막 일자를 반환한다.

⑤ ROUND(date, format), TRUNC(date, format)
 -- ROUND와 TRUNC는 숫자 함수이면서 날짜 함수로도 쓰이는데, ROUND는 format에 따라 반올림한 날짜를, TRUNC는 잘라낸 날짜를 반환한다.

⑥ NEXT_DAY (date, char)
 -- NEXT_DAY는 date를 char에 명시한 날짜로 다음 주 주중 일자를 반환한다.

------------------------------------------------------------------------------------------------
https://thebook.io/006696/0113/
-- 변환 함수
① TO_CHAR (숫자 혹은 날짜, format)
  -- 숫자나 날짜를 문자로 변환해 주는 함수가 바로 TO_CHAR로, 매개변수로는 숫자나 날짜가 올 수 있고 반환 결과를 특정 형식에 맞게 출력할 수 있다.
    SELECT TO_CHAR(123456789, '999,999,999'),  -- 123,456,789
           TO_CHAR(1234567,    '99,999,999'),  -- 1,234,567
           TO_CHAR(1234567,    '00,000,000'),  -- 01,234,567
           TO_CHAR(123.45678,  '99,990.000'),  -- 123.457
           -- 소수이하 자동반올림 3자리로
           TO_CHAR(123456789, '$999,999,999'), -- $123,456,789
           TO_CHAR(123456789, 'L999,999,999')  -- ￦123,456,789
    FROM DUAL;
    
    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL; -- 2026-04-10
    
② TO_NUMBER(expr, format)
  -- 문자나 다른 유형의 숫자를 NUMBER 형으로 변환하는 함수다.
  
③ TO_DATE(char, format), TO_TIMESTAMP(char, format)
  /* 문자를 날짜형으로 변환하는 함수다. 형식 매개변수로는 [표 4-1]에 있는 항목이 올 수 있으며,
     TO_DATE는 DATE 형으로 TO_TIMESTAMP는 TIMESTAMP 형으로 변환해 값을 반환한다. */
     
-----------------------------------------------------------------------------------
NULL 관련 함수
① NVL(expr1, expr2), NVL2((expr1, expr2, expr3)
 -- NVL 함수는 expr1이 NULL일 때 expr2를 반환한다.
② COALESCE (expr1, expr2, …)
 -- COALESCE 함수는 매개변수로 들어오는 표현식에서 NULL이 아닌 첫 번째 표현식을 반환하는 함수다.
③ LNNVL(조건식)
 -- LNNVL은 매개변수로 들어오는 조건식의 결과가 FALSE
④ NULLIF (expr1, expr2)
 -- NULLIF 함수는 expr1과 expr2을 비교해 같으면 NULL을, 같지 않으면 expr1을 반환한다.
------------------------------------------------------------------------------------
06 기타 함수
① GREATEST(expr1, expr2, …), LEAST(expr1, expr2, …)
 -- GREATEST는 매개변수로 들어오는 표현식에서 가장 큰 값을, LEAST는 가장 작은 값을 반환하는 함수다.(숫자뿐만아니라 문자도 비교 가능)
    SELECT GREATEST(1, 2, 3, 2), -- 3, 리스트중 제일 큰수 
           LEAST(1, 2, 3, 2)     -- 1, 리스트중 제일 작은수
      FROM DUAL;
---------------------------------------------------------------------------------------   
   
-- 직원이름, 담당업무
SELECT first_name || ' ' || last_name 직원이름,
       job_id                         담당업무
FROM   EMPLOYEES;

-- 직원명, 담당업무, 담당업무 히스토리
1)
SELECT EMPLOYEE_ID, JOB_ID
FROM   EMPLOYEES
UNION -- 2개가 1개의 테이블로 표시됨
SELECT EMPLOYEE_ID, JOB_ID
FROM   JOB_HISTORY;

2) INLINE VIEW -> FROM 뒤에있는것을 INLINE VIEW 라고 한다
SELECT  *
FROM    (
            SELECT EMPLOYEE_ID, JOB_ID
            FROM   EMPLOYEES
            UNION -- 2개가 1개의 테이블로 표시됨
            SELECT EMPLOYEE_ID, JOB_ID
            FROM   JOB_HISTORY
        ) -- INLINE VIEW : ORDER BY 사용할수 있어요 : FROM 뒤에 사용한다
ORDER BY EMPLOYEE_ID ASC;

-- 사번, 업무시작일, 업무종료일, 담당업무, 부서번호
SELECT *
FROM (
SELECT employee_id                      사번,
       TO_CHAR(hire_date, 'YYYY-MM-DD') 업무시작일,
       '재직중'                         업무종료일,
       JOB_ID                           담당업무,
       department_id                    부서번호
FROM   EMPLOYEES
UNION
SELECT employee_id                       사번,
       TO_CHAR(start_date, 'YYYY-MM-DD') 업무시작일,
       TO_CHAR(end_date, 'YYYY-MM-DD')   업무종료일,
       JOB_ID                            담당업무,
       department_id                     부서번호
FROM   JOB_HISTORY
)
ORDER BY 사번 ASC, 업무시작일 ASC;

-- 사번, 직원명, 업무시작일, 업무종료일, 담당업무명, 부서이름 
SELECT E.employee_id                      사번,
       e.first_name || ' ' || e.last_name 직원명,
       TO_CHAR(E.hire_date, 'YYYY-MM-DD') 업무시작일,
       '재직중'                           업무종료일,
       E.job_id                           담당업무명,
       d.department_name                  부서이름
FROM   EMPLOYEES E, DEPARTMENTS D 
WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID
UNION  --> 위 아래의 칼럼 갯수가 같아야한다 이름 테이블 부여전 위 6 아래 5개라 오류
SELECT J.employee_id                       사번,
       e.first_name || ' ' || e.last_name  직원명,
       TO_CHAR(J.start_date, 'YYYY-MM-DD') 업무시작일,
       TO_CHAR(J.end_date, 'YYYY-MM-DD')   업무종료일,
       J.JOB_ID                            담당업무,
       d.department_name                   부서이름
FROM   JOB_HISTORY J, DEPARTMENTS D, EMPLOYEES E 
WHERE  J.DEPARTMENT_ID = D.DEPARTMENT_ID
AND    J.JOB_ID = E.JOB_ID;
-------------------------------------------------------------------
VIEW : 뷰 -- SQL 문을 저장해 놓고 TABLE 처럼 호출해서 사용하는 객체
1) INLINE VIEW   -> SELECT 할때만 VIEW 로 작동 - 임시 존재
   -
   
   SELECT * 
   FROM (
        SELECT   EMPLOYEE_ID                    사번,
                 FIRST_NAME || ' ' || LAST_NAME 이름,
                 EMAIL      || '@GREEN.COM'     이메일,
                 PHONE_NUMBER
        FROM     EMPLOYEES
        ORDER BY 이름
   ) T
   WHERE T.사번 IN(100, 101, 102);
   
   SELECT *
   FROM (
        SELECT   DEPARTMENT_ID  DEPT_ID,
                 COUNT(SALARY)  CNT_SAL,
                 SUM(SALARY)    SUM_SAL,
                 AVG(SALARY)    AVG_SAL
        FROM     EMPLOYEES 
        GROUP BY DEPARTMENT_ID
        ORDER BY DEPT_ID
   ) t
   WHERE t.AVG_SAL >= 4000;
   
   
2) 일반적인 VIEW -> 영구저장된 객체
   
    VIEW 생성 - 영구적으로 보관
    CREATE OR REPLACE VIEW "HR"."VIEW_EMP"("사번", "이름", "이메일", "전화") -- ."" HR안에 VIEW_EMP 입력후 뒤에 칼럼 이름입력
    AS
        SELECT   EMPLOYEE_ID                    사번,
                 FIRST_NAME || ' ' || LAST_NAME 이름,
                 EMAIL      || '@GREEN.COM'     이메일,
                 PHONE_NUMBER                   전화
        FROM     EMPLOYEES
        ORDER BY 이름;

  SELECT *
  FROM   VIEW_EMP
  WHERE  이름 LIKE '%King%';

-----------------------------------------------------------------------------
2) WITH  -- 가상의 테이블 생성
    WITH A ("사번", "이름", "이메일", "전화")
     AS (
        SELECT   EMPLOYEE_ID                    사번,
                 FIRST_NAME || ' ' || LAST_NAME 이름,
                 EMAIL      || '@GREEN.COM'     이메일,
                 PHONE_NUMBER                   전화
        FROM     EMPLOYEES
        ORDER BY 이름
     )
     SELECT * FROM A
     ORDER BY 사번;
-------------------------------------------------------------------------------
SELF JOIN -> 계층형 쿼리가 만들어질때 사용  아무 테이블에서나 걸수없다
 -- 직원번호, 직속상사번호
 SELECT EMPLOYEE_ID 직원번호,
        MANAGER_ID  직속상사번호
 FROM   EMPLOYEES ;
 
 -- 직원이름, 직속상사이름 
 -- 상사정보 : E1, 부하정보 E2 - 테이블 복사
SELECT E1.first_name || ' ' || E1.last_name 직원이름,
       E2.first_name || ' ' || E2.last_name 직속상사이름        
FROM   EMPLOYEES E1, EMPLOYEES E2
WHERE  E1.EMPLOYEE_ID = E2.MANAGER_ID
ORDER BY 직원이름;


-- INNER JOIN 으로 변경 
SELECT E2.first_name || ' ' || E2.last_name 직원이름,
       E1.first_name || ' ' || E1.last_name 직속상사이름        
FROM   EMPLOYEES E1 JOIN EMPLOYEES E2 ON E1.EMPLOYEE_ID = E2.MANAGER_ID
ORDER BY E1.EMPLOYEE_ID ASC
; -- 사장이 출력되지 않는다

SELECT e2.employee_id                       사번,
       E2.first_name || ' ' || E2.last_name 직원이름,
       E1.first_name || ' ' || E1.last_name 직속상사이름        
FROM   EMPLOYEES E1 RIGHT JOIN EMPLOYEES E2 ON E1.EMPLOYEE_ID = E2.MANAGER_ID
ORDER BY E2.EMPLOYEE_ID ASC;
 -- 모든 직원정보 : STEVEN KING, 보검, 카리나
 
-------------------------------------------------------------------------------
계층형 쿼리, CASCADING
계층형쿼리 : HIRERACHY

LEVEL : 예약어, 계층형 쿼리의 레벨을 구하는 예약어다.(START WITH) LEVEL 과 같이쓴다 
직원번호, 직원명, 레벨, 부서명

SELECT E.EMPLOYEE_ID                                                 직원번호,
       LPAD(' ', 3 *(LEVEL-1)) || E.FIRST_NAME || ' ' || E.LAST_NAME 직원명,
       -- LEVEL: 현재 데이터가 몇 번째 계급인지 나타내는 가상 번호입니다 (사장님=1, 부장님=2...)
       -- LPAD(' ', 3 * (LEVEL-1)): 레벨이 깊어질수록 왼쪽(Left)에 공백을 3칸씩 더 채워 넣습니다
       LEVEL,
       D.DEPARTMENT_NAME                  부서명 
FROM   EMPLOYEES   E
JOIN   DEPARTMENTS D
ON     E.DEPARTMENT_ID = D.DEPARTMENT_ID
START WITH E.MANAGER_ID IS NULL
CONNECT BY PRIOR E.EMPLOYEE_ID = E.MANAGER_ID;
-------------------------------------------------------------------------------
EQUI JOIN, 등가조인 : 조인 조건인 = 인 것들

NON-EQUI JOIN : 비등가 조인 : 조인조건이 '=' 아닌 것

     직원등급
월급          등급
20000    초과 : S
15001 ~ 20000 : A
10001 ~ 15000 : B
 5001 ~ 10000 : C
 3001 ~  5000 : D
    0 ~  3000 : E
 
직원번호 직원명 월급 등급
SELECT employee_id                    직원번호,
       first_name || ' ' || last_name 직원명,
       salary                         월급,
       CASE
         WHEN SALARY > 20000                  THEN 'S'
         WHEN SALARY BETWEEN 150001 AND 20000 THEN 'A'
         WHEN SALARY BETWEEN 100001 AND 15000 THEN 'B'
         WHEN SALARY BETWEEN  50001 AND 10000 THEN 'C'
         WHEN SALARY BETWEEN   3001 AND  5000 THEN 'D'
         WHEN SALARY BETWEEN      0 AND  3000 THEN 'E'
         ELSE                                      '등급없음'
       END                            등급
FROM   EMPLOYEES
ORDER BY 직원번호;

-- 등급 테이블 생성
DROP   TABLE SALGRADE; -- 테이블 삭제 명령어
CREATE TABLE SALGRADE
(
     GRADE      VARCHAR2(1) PRIMARY KEY
    ,LOSAL      NUMBER(11)
    ,HISAL      NUMBER(11)
);

INSERT INTO SALGRADE VALUES ( 'S', 20001, 99999999999 );
INSERT INTO SALGRADE VALUES ( 'A', 15001, 20000 );
INSERT INTO SALGRADE VALUES ( 'B', 10001, 15000 );
INSERT INTO SALGRADE VALUES ( 'C',  5001, 10000 );
INSERT INTO SALGRADE VALUES ( 'D',  3001,  5000 );
INSERT INTO SALGRADE VALUES ( 'E',     0,  3000 );
COMMIT;

직원번호 직원명 월급 등급
SELECT E.EMPLOYEE_ID                      직원번호,
       E.first_name || ' ' || E.last_name 직원명,
       E.SALARY                           월급,
       NVL(SG.GRADE, '등급없음')          등급
FROM EMPLOYEES E LEFT JOIN SALGRADE SG
  ON   E.SALARY BETWEEN SG.LOSAL AND SG.HISAL
ORDER BY 직원번호;
------------------------------------------------------

-- 분석함수와 WINDOW 함수
1. ROW_NUMBER() : 줄번호 (1,2,3,4,5,....)
2. RANK()       : 석차   (1,2,2,4,5,5,7....)
3. DENSE_RANK() : 석차   (1,2,2,3,4,5,5,6....)
4. NTILE()      : 그룹으로 분류해줌
5. LIST_AGG()

1. ROW_NUMBER()
전체
SELECT employee_id, first_name, last_name, salary
FROM   EMPLOYEES
ORDER BY SALARY DESC NULLS LAST;

자료를 10개만 출력 - 페이징 기술
1) OLD 문법 : ROWNUM -- 의사(psuedo)칼럼 : 비추
SELECT ROWNUM employee_id, first_name, last_name, salary
FROM   EMPLOYEES
-- WHERE ROWNUM BETWEEN 1 AND 10
ORDER BY SALARY DESC NULLS LAST;

SELECT ROWNUM, employee_id, first_name, last_name, salary
FROM (
        SELECT employee_id, first_name, last_name, salary
        FROM   EMPLOYEES
        ORDER BY SALARY DESC NULLS LAST
) ;

2) ANSI 문법 : ROW_NUMBER -- 11G
   SELECT * 
   FROM
   (
    SELECT ROW_NUMBER () OVER (ORDER BY SALARY NULLS LAST) RN,
           employee_id,
           first_name,
           last_name,
           salary
    FROM   EMPLOYEES
    ) T
    WHERE T.RN BETWEEN 11 AND 20;

3)  ORACLE 12C 부터는 OFFSET 
    SELECT * 
    FROM EMPLOYEES
    ORDER BY SALARY DESC NULLS LAST
    OFFSET 11 ROWS FETCH NEXT 10 ROWS ONLY;
    -- 11 부터 10개 : ROW_NUMBER 보다 속도가 빠르다
    
--------------------------------------------------------------------------------
2. RANK()       : 석차   (1,2,2,4,5,5,7....)
3. DENSE_RANK() : 석차   (1,2,2,3,4,5,5,6....)
월급순으로 석차를 출력
SELECT employee_id 사번, 
       first_name || ' ' || last_name                이름, 
       salary                                        월급,
       RANK() OVER (ORDER BY SALARY DESC NULLS LAST) 석차
FROM   EMPLOYEES;

SELECT employee_id 사번, 
       first_name || ' ' || last_name                이름, 
       salary                                        월급,
       DENSE_RANK() OVER (ORDER BY SALARY DESC NULLS LAST) 석차
FROM   EMPLOYEES;

월급순으로 석차를 출력(1~10등까지)
SELECT * 
FROM
(
    SELECT employee_id 사번, 
           first_name || ' ' || last_name                이름, 
           salary                                        월급,
           RANK() OVER (ORDER BY SALARY DESC NULLS LAST) 석차
    FROM   EMPLOYEES
) T
WHERE  T.석차 BETWEEN 1 AND 10;

SELECT * 
FROM
(
    SELECT employee_id 사번, 
           first_name || ' ' || last_name                이름, 
           salary                                        월급,
           DENSE_RANK() OVER (ORDER BY SALARY DESC NULLS LAST) 석차
    FROM   EMPLOYEES
) T
WHERE  T.석차 BETWEEN 1 AND 10;

---------------------------------------------------------------------------
LISTAGG() 여러줄을 한줄짜리 문자열로 변경

SELECT department_id          FROM   EMPLOYEES ;

SELECT DISTINCT department_id FROM   EMPLOYEES ;


SELECT LISTAGG( DISTINCT department_id ) FROM   EMPLOYEES ;

SELECT LISTAGG( DISTINCT department_id, ',' ) FROM   EMPLOYEES ; -- 랜덤정렬

SELECT LISTAGG( DISTINCT department_id, ',' ) WITHIN GROUP(ORDER BY DEPARTMENT_ID DESC)
FROM   EMPLOYEES ; --정렬됨




-- NULLS LAST/FIRST (NULL이 나중에나오게 / 먼저 나오게) 하는 명령어
DESC NULLS LAST   -- NULL이 맨밑으로 나오게
DESC NULLS FIRST  -- NULL이 맨위로 나오게 : 기본값