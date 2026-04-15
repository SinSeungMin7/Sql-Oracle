
성적처리 TABLE
 업무
 학생 : 학번, 이름, 전화, 입학일
 성적 : 학번, 국어, 영어, 수학, 총점, 평균, 석차 결과
 과목은 변경될 수 있다.
 
 TABLE 생성
 학생     : 학번(PK), 이름,   전화,   입학일
 STUDENT    STID      STNAME  PHONE   INDATE  
 
 성적     : 일련번호(PK), 교과목,   점수,   학번(FK)
 SCORES     SCID          SUBJECT   SCORE   STID
 
 -- 제약조건(CONSTRAINTS) - 무결성  
  TABLE 에 저장될 데이터에 조건을 부여하여 잘못된 DATA 입려되는 방지
  1. 주식별자 설정 : 기본키
     PRIMARY KEY     : NOT NULL + UNIQUE 기본 적용
      CREATE TABLE 명령안에 한번만 사용가능
  2. NOT NULL / NULL : 필수입력, 컬럼단위 제약조건
  3. UNIQUE          : 중복방지
  4. CHECK           : 값의 범위지정 , DOMAIN 제약 조건 
  5. FOREIGN KEY     : 외래키 제약조건
  
  -- 관계가 설정된 테이블 삭제 방법 1
  -- 테이블 삭제 순서 자식테이블 -> 부모테이블
  drop table scores;    -- 자식 테이블을 먼저 삭제 해야한다
  drop table student;   -- 부모 테이블을 나중에 삭제
  
  -- 관계가 설정된 테이블 삭제 방법 2
  DROP TABLE STUDENT CASCADE CONSTRAINTS PURGE; -- 순서에 무관하게 삭제 할때 쓰는 명령어
  DROP TABLE SCORES;
  
  
 학생     : 학번(PK), 이름,   전화,   입학일
 STUDENT    STID      STNAME  PHONE   INDATE  
 
 CREATE     TABLE     STUDENT
 (
    STID    NUMBER(6)     PRIMARY KEY,        -- 학번 숫자(6) 기본키
    STNAME  VARCHAR2(30)  NOT NULL,           -- 이름 문자(30) 필수 입력
    PHONE   VARCHAR2(20), UNIQUE              -- 전화 문자(20) 중복방지
    INDATE  DATE          DEFAULT   SYSDATE   -- 입학일 날짜 기본값 오늘
 );
 
 성적     : 일련번호(PK), 교과목,   점수,   학번(FK)
 SCORES     성적처리 TABLE
 업무
 학생 : 학번, 이름, 전화, 입학일
 성적 : 학번, 이름, 국어, 영어, 수학, 총점, 평균, 석차 결과
 과목은 변경될 수 있다.
 
 TABLE 생성
 학생     : 학번(PK), 이름,   전화,   입학일
 STUDENT    STID      STNAME  PHONE   INDATE  
 
 성적     : 일련번호(PK), 교과목,   점수,   학번(FK)
 SCORES     SCID          SUBJECT   SCORE   STID
 
 -- 제약조건(CONSTRAINTS) - 무결성  
  TABLE 에 저장될 데이터에 조건을 부여하여 잘못된 DATA 입려되는 방지
  1. 주식별자 설정 : 기본키
     PRIMARY KEY     : NOT NULL + UNIQUE 기본 적용
      CREATE TABLE 명령안에 한번만 사용가능
  2. NOT NULL / NULL : 필수입력, 컬럼단위 제약조건
  3. UNIQUE          : 중복방지
  4. CHECK           : 값의 범위지정 , DOMAIN 제약 조건 
  5. FOREIGN KEY     : 외래키 제약조건
  
  
  
 학생     : 학번(PK), 이름,   전화,   입학일
 STUDENT    STID      STNAME  PHONE   INDATE  
 CREATE     TABLE     STUDENT
 (
    STID    NUMBER(6)     PRIMARY KEY,        -- 학번 숫자(6) 기본키
    STNAME  VARCHAR2(30)  NOT NULL,           -- 이름 문자(30) 필수 입력
    PHONE   VARCHAR2(20)  UNIQUE,             -- 전화 문자(20) 중복방지
    INDATE  DATE          DEFAULT   SYSDATE   -- 입학일 날짜 기본값 오늘
 );
 
 -- 학생정보 입력
 INSERT INTO STUDENT (STID, STNAME, PHONE, INDATE)
  VALUES             (1,    '가나', '010', SYSDATE);
  
 INSERT INTO STUDENT 
  VALUES             (2,    '나나', '011', SYSDATE);
  
 INSERT INTO STUDENT (STID, STNAME, PHONE)
  VALUES             (3,    '다나', '012');

 INSERT INTO STUDENT (STID, STNAME, PHONE)
  VALUES             (4,    '라나', '013');
 
 INSERT INTO STUDENT (STID, STNAME, PHONE)
  VALUES             (5,    '라나', '014');
  
 INSERT INTO STUDENT (STID, STNAME, PHONE)
  VALUES             (NULL,    '라나', '015'); -- 입력안됨
-- SQL 오류: ORA-01400: NULL을 ("SKY"."STUDENT"."STID") 안에 삽입할 수 없습니다 
-- PRIMARY KEY 칸은 기본적으로 NULL을 입력할 수 없다

 INSERT INTO STUDENT (STID, STNAME, PHONE)
  VALUES             (5,    '라나', '014'); -- 입력안됨, 기본키는 중복 X
--  ORA-00001: 무결성 제약 조건(SKY.SYS_C008384)에 위배됩니다

 INSERT INTO STUDENT (STID, STNAME, PHONE)
  VALUES             (6,    '하나', '014'); -- 입력안됨, PHONE 넘버 중복 -> 확인 방법 테이블의 제약조건에 들어가서 오류코드를 대조한다
-- ORA-00001: 무결성 제약 조건(SKY.SYS_C008385)에 위배됩니다

 INSERT INTO STUDENT (STID, STNAME, PHONE)
  VALUES             (7,    NULL, '018'); -- 입력안됨 STNAME NOT NULL 제약조건 위반
-- SQL 오류: ORA-01400: NULL을 ("SKY"."STUDENT"."STNAME") 안에 삽입할 수 없습니다

COMMIT; -- 저장

INSERT INTO STUDENT (STID, STNAME, PHONE)
  VALUES             (6,    '하나', '019');
 
 select * from student;
COMMIT; 
select * from student;

 성적     : 일련번호(PK), 교과목,   점수,   학번(FK)
 SCORES     SCID          SUBJECT   SCORE   STID  

 CREATE   TABLE  SCORES
 (
    SCID     NUMBER(7)    NOT NULL,                         -- 일련번호 숫자(7)  기본키, 번호자동증가
    SUBJECT  VARCHAR2(60) NOT NULL,                         -- 교과목   문자(60) 필수입력 
    SCORE    NUMBER(3)    CHECK (SCORE BETWEEN 0 AND 100),  -- 점수     숫자(3)  범위 0 ~ 100
    STID     NUMBER(6),                                     -- 학번     숫자(6)  외래키
    CONSTRAINT   SCID_PK -- 제약조건 이름 SCID_PK 부여
     PRIMARY KEY  (SCID, SUBJECT), -- 복합키
    CONSTRAINT   STID_FK
     FOREIGN KEY  (STID) -- 칼럼 STID
     REFERENCES  STUDENT(STID) -- 외래키 설정방법
 ); 
 
 INSERT INTO SCORES(SCID, SUBJECT, SCORE, STID) 
  VALUES           (1,    '국어',    100,   1);
 INSERT INTO SCORES VALUES (2,    '영어',   100,   1);  
 INSERT INTO SCORES VALUES (3,    '수학',   100,   1);  
 INSERT INTO SCORES VALUES (4,    '국어',   100,   2);  
 INSERT INTO SCORES VALUES (5,    '수학',    80,   2);
 INSERT INTO SCORES VALUES (6,    '국어',    70,   4);
 INSERT INTO SCORES VALUES (7,    '영어',    80,   4);
 INSERT INTO SCORES VALUES (8,    '수학',    85,   4);
 INSERT INTO SCORES VALUES (9,    '국어',   805,   5); -- ORA-02290: 체크 제약조건(SKY.SYS_C008388)이 위배되었습니다
 INSERT INTO SCORES VALUES (10,   '영어',   100,   8); -- ORA-02291: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 부모 키가 없습니다
 COMMIT;
 
 
DML 추가, 수정, 삭제 -- COMMIT 필수
1. INSERT(추가) - 줄(DATA) 추가
  1) INSERT INTO SCORES ( SCID, SUBJECT, SCORE, STID )
      VALUES            (1,    '국어',    100,   1);
      
  2) 여러줄 추가 
     INSERT INTO EMP4 
       SELECT * FROM HR.EMPLOYEES;
       
  3) INSERT 문을 여러개를 한번에 실행 - 여러줄 추가 : 신규문법
     CREATE TABLE EX_SKY
     (
        ID     NUMBER(7)     PRIMARY KEY,
        NAME   VARCHAR2(30)  NOT NULL
     );
     
     INSERT ALL 
        INTO EX_SKY VALUES (103, '이순신')
        INTO EX_SKY VALUES (104, '김유신')
        INTO EX_SKY VALUES (105, '강감찬')
     SELECT * FROM DUAL;
     COMMIT;
 
2. DELETE -- 줄(DATA) 를 삭제하는데, 사용하는 명령어 기본적으로 여러줄이 대상
          -- WHERE 이 없으면 전체를 대상으로 작업한다
   DELETE
    FORM 테이블명
    WHERE 조건;
 
3. UPDATE -- 줄에 변화는 없고 칸에 있는 정보만 수정을 한다
          -- WHERE 이 없으면 전체를 대상으로 작업한다
 
   UPDATE 테이블
   SET 칼럼1 = 고칠값
       칼럼2 = 고철값2,
       칼럼3 = 고철값3
   WHERE 조건;
   
   SELECT * FROM SCORES;
   
   UPDATE SCORES
   SET SCORE = 70
   WHERE SCID = 6;

  ROLLBACK;
 -------------------------------------------------------
 DATA 제거
 1. DROP TABLE SCORES;       -- 구조(테이블), DATA 모두 삭제, 복구 불가능
 
 2. TRUNKCATE TABLES SCORES; -- 구조 남기고 DATA만 삭제 속도 빠름
 
 3. DELETE FROM SCORES       -- 구조 남기고 DATA 만 삭제 소도 느림
 
 -- SET TIMING ON
 
 SELECT * FROM SCORES;
 DELETE FROM SCORES;
 SELECT * FROM SCORES;
 ROLLBACK;
 
 SELECT * FROM STUDENT;
 DELETE FROM STUDENT; -- ORA-02292: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
 SELECT * FROM STUDENT;
 
 INSERT INTO STUDENT VALUES (11, '히나', '0111', SYSDATE);
 COMMIT;
 
 DELETE FROM STUDENT
  WHERE STID = 1; -- ORA-02292: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

  DELETE FROM STUDENT
  WHERE STID = 11;
 
  외래키 관계에서 자식테이블의 DATA 를 지우고 부모 테이블의 DATA 를  삭제하면 된다
  
  DELETE FROM SCORES 
  WHERE STID = 1;
  
  DELETE FROM STUDENT
  WHERE STID = 1;
  
  -- 지워졋는지 확인
  SELECT * FROM SCORES;
  SELECT * FROM STUDENT;
  
  DROP TABLE SCORES;  -- SCORES 테이블 삭제
  DROP TABLE STUDENT; -- STUDENT 테이블 삭제
 -------------------------------------------------------
 
 성적처리 TABLE
 업무
 학생 : 학번, 이름, 전화, 입학일
 성적 : 학번, 이름, 국어, 영어, 수학, 총점, 평균, 석차 결과
 과목은 변경될 수 있다.
 
 -----------------------------------------------------------------------------
 공부확인용 예제 문제들 
 학생/스코어 
 SELECT * FROM student;
 SELECT * FROM scores;
 
 -- 조회
 1. 학번, 이름, 점수
    SELECT st.stid    학번,
           st.stname  이름,
           sc.score   
    FROM   STUDENT ST LEFT JOIN SCORES SC
    ON ST.STID = SC.STID
    ORDER BY ST.STID ASC;
    
    
 1.1-2) 
    SELECT   st.stid    학번,
             st.stname  이름,
             sc.score   점수
    FROM     STUDENT ST, SCORES SC
    WHERE    ST.STID = SC.STID(+)
    ORDER BY ST.STID ASC;
    
 2. 학번, 이름, 총점, 평균
   2-1)
    SELECT st.stid                       학번,
           st.stname                     이름,
           SUM(sc.score)                 총점,
           ROUND( (SUM(sc.score)/3),3)   평균
    FROM   STUDENT ST LEFT JOIN SCORES SC
    ON ST.STID = SC.STID
    GROUP BY ST.STID, ST.STNAME
    ORDER BY 학번 ;
    
    2-2)
    SELECT   ST.STID                       학번,
             ST.STNAME                     이름,
             SUM(SC.SCORE)                 총점,
             ROUND(AVG(SC.SCORE),2)        평균
    FROM     STUDENT ST, SCORES SC
    WHERE    ST.STID = SC.STID(+)
    GROUP BY ST.STID, ST.STNAME
    ORDER BY ST.STID ASC, ST.STNAME ASC;
    
 3. 모든 학생의 학번, 이름, 총점, 평균
    점수가 NULL인 학생은'미응시'
    3-1)
    SELECT st.stid                                                학번,
           st.stname                                              이름,
           NVL( TO_CHAR ( SUM (sc.score) ), '미응시')             총점,
           NVL( TO_CHAR (ROUND( (SUM(sc.score)/3),3)), '미응시')  평균
    FROM   STUDENT ST LEFT JOIN SCORES SC
    ON ST.STID = SC.STID
    GROUP BY ST.STID, ST.STNAME
    ORDER BY 학번;
    
    3-2)
    SELECT   ST.STID                                           학번,
             ST.STNAME                                         이름,
             DECODE(SUM(SC.SCORE),NULL,'미응시',SUM(SC.SCORE)) 총점,  -- NULL 이라면 '미응시' 아니라면 SUM(SC.SCORE) 출력
             CASE         
               WHEN ROUND(AVG(SC.SCORE),2) IS NULL THEN   '미응시'
               ELSE              TO_CHAR( AVG(SC.SCORE),'999.00' )      
             END                                               평균
    FROM     STUDENT ST, SCORES SC
    WHERE    ST.STID = SC.STID(+)
    GROUP BY ST.STID, ST.STNAME
    ORDER BY ST.STID ASC, ST.STNAME ASC;
    
    3-3)
    SELECT 학번,
           이름,
           DECODE (총점, NULL, '미응시', TO_CHAR(총점, '990')),
           DECODE (총점, NULL, '미응시', TO_CHAR(평균, '990.00'))
    FROM (
            SELECT st.stid                                                학번,
                   st.stname                                              이름,
                   NVL( TO_CHAR ( SUM (sc.score) ), '미응시')             총점,
                   NVL( TO_CHAR (ROUND( (SUM(sc.score)/3),3)), '미응시')  평균
            FROM   STUDENT ST LEFT JOIN SCORES SC
            ON ST.STID = SC.STID
            GROUP BY ST.STID, ST.STNAME
            ORDER BY 학번;
    )
    
 4. 모든 학생의 학번, 이름 ,총점, 평균, 등급, 석차
    SELECT st.stid                                                  학번,
           st.stname                                                이름,
           NVL( TO_CHAR ( SUM (sc.score) ), '미응시')               총점,
           NVL( TO_CHAR (ROUND( (SUM(sc.score)/3),3)), '미응시')    평균,
           CASE                                                   
                WHEN (SUM(sc.score)/3) >= 90  THEN 'A'
                WHEN (SUM(sc.score)/3) >= 80  THEN 'B'
                WHEN (SUM(sc.score)/3) >= 70  THEN 'C'
                WHEN (SUM(sc.score)/3) >= 60  THEN 'D'
                WHEN (SUM(sc.score)/3) IS NULL THEN '미응시'
                ELSE 'F'
           END                                                       등급,
           RANK() OVER (ORDER BY (SUM(sc.score)/3) DESC NULLS LAST ) 석차
    FROM   STUDENT ST LEFT JOIN SCORES SC ON ST.STID = SC.STID
    GROUP BY ST.STID, ST.STNAME
    ORDER BY 학번;
    
 5. 학번, 이름, 국어, 영어, 수학, 총점, 평균 등급, 석차
    SELECT st.stid                                                  학번,
           st.stname                                                이름,
           sc.subject = '국어'                                      국어,
           sc.subject = '영어'                                      영어,
           sc.subject = '수학'                                      수학,
           NVL( TO_CHAR ( SUM (sc.score) ), '미응시')               총점,
           NVL( TO_CHAR (ROUND( (SUM(sc.score)/3),3)), '미응시')    평균,
           CASE                                                   
                WHEN (SUM(sc.score)/3) >= 90  THEN 'A'
                WHEN (SUM(sc.score)/3) >= 80  THEN 'B'
                WHEN (SUM(sc.score)/3) >= 70  THEN 'C'
                WHEN (SUM(sc.score)/3) >= 60  THEN 'D'
                WHEN (SUM(sc.score)/3) IS NULL THEN '미응시'
                ELSE 'F'
           END                                                       등급,
           RANK() OVER (ORDER BY (SUM(sc.score)/3) DESC NULLS LAST ) 석차
    FROM   STUDENT ST LEFT JOIN SCORES SC ON ST.STID = SC.STID
    GROUP BY ST.STID, ST.STNAME
    ORDER BY 학번;
 
 
 
 
 
 
 
 
 
 