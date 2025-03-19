-- [숫자 함수]

-- abs()
-- 절대값을 반환
SELECT -10,abs(-10)FROM dual;

-- ROUND()
-- 특정 자리수에서 반올림하여 반환
SELECT 
	ROUND(1234.567,1),
	ROUND(1234.567,-1),
	ROUND(1234.567)
FROM DUAL;

-- FLOOR()
-- 주어진 숫자보다 작거나 같은 수 중 최대값을 반환
SELECT FLOOR(2),FLOOR(2.1) FROM DUAL;

-- TRUNC()
-- 특정 자리수를 버리고 반환
SELECT 
	TRUNC(1234.567,1),
	TRUNC(1234.567,-1),
	TRUNC(1234.567)
FROM DUAL;

-- SIGN()
-- 주어진 값의 양수, 음수, 0인지 여부를 판단
-- 음수는 -1, 양수는 1 0은 0을 반환
-- NULL은 NULL을 반환
SELECT 
	SIGN(-2),
	SIGN(10),
	SIGN(0),
	SIGN(NULL)
FROM DUAL;

-- CEIL()
-- 주어진 숫자보다 크거나 같은 정수 중 최솟값을 반환한다
SELECT 
	CEIL(2),
	CEIL(2.1)
FROM DUAL;

-- MOD()
-- 나누기 후 나머지를 반환한다
SELECT 
	MOD(1,3),
	MOD(2,3),
	MOD(3,3),
	MOD(4,3),
	MOD(5,3)
FROM DUAL;

-- POWER()
-- 주어진 숫자의 지정된 수 만큼 제곱값을 반환
SELECT 
	POWER(2,1),
	POWER(2,2),
	POWER(2,3),
	POWER(2,0)
FROM DUAL;

-- [날짜함수]

-- ADD_MONTHS()
-- 특정 날짜에 개월수를 더한다.
-- 현재 날짜에서 2개월 뒤의 날짜 구하기
select SYSDATE, add_months(SYSDATE, 2)from dual;

-- MONTHS_BETWEEN()
-- 두 날짜 사이 간격 개월을 반환한다

-- 모든 사원들이 입사일로부터 오늘가지 몇개월이 경과했는지 출력
-- SYSDATE,HIRE_DATE 개월수로 조회
SELECT SYSDATE, hire_date, MONTHS_BETWEEN(SYSDATE,hire_date) 
FROM EMPLOYEES;

-- NEXT_DAY()
-- 주어진 일자가 다음에 나타나는 지정요일의 날짜를 반환한다.
-- (1:일요일 ~ 7:토요일)
SELECT 
	sysdate "오늘",
	NEXT_DAY(sysdate-7,'일요일') "저번주 일요일",
	NEXT_DAY(sysdate,'일요일') "이번주 일요일"
FROM DUAL;

-- [형변환 함수]

-- TO_CHAR(날짜, 포맷)
-- 날짜를 형식에 맞춰 문자열로 변환
SELECT TO_CHAR(sysdate,'yyyy-mm-dd'), 
 TO_CHAR(sysdate,'yyyy-mm-dd day'), 
 TO_CHAR(sysdate,'yyyy-mm-dd HH:MI:SS')
FROM dual;

-- 날짜 FORMATTING 형식
-- SCC, CC : 세기
-- YYYY, YY : 연도
-- MM : 월
-- DAY : 요일
-- MON : 월명(JAN, FAB, MAR)
-- MONTH : 월명(JANUARY)
-- HH, HH24 : 시간
-- MI : 분
-- SS : 초

-- TO_NUMBER는 잘 안씀
-- 숫자모양으로 되어있는 문자열은 오라클이 묵시적으로
-- 숫자 취급을 해버린다.

/*
0 : 숫자, 공백시 0으로 채움
9 : 숫자
, : 쉼표 표기
L : local currency symbol
*/
SELECT TO_CHAR(1234567, '9,999,999'),
	TO_CHAR(1234567, 'L9,999,999.99'),
	TO_CHAR(12,'0999')
FROM DUAL;

-- TO_DATE
-- 문자열을 날짜 형식으로 표현
SELECT 
	TO_DATE('2025.03.14'),
	TO_DATE('03,14,2025','MM-DD-YYYY'),
	TO_DATE('2025.04', 'YYYY.MM'), -- 일을 입력하지 않으면 1일로 나온다
	TO_DATE('14','DD') -- 년, 월 입력 안하면 해당 년도, 해당월로 변환
FROM DUAL;

-- [NULL 처리함수]
-- NULL값을 다른 값으로 변경

-- NVL (컬럼, 치환할 값)
SELECT FIRST_NAME, NVL(COMMISSION_PCT,0)
FROM EMPLOYEES ORDER BY COMMISSION_PCT;

-- NVL2(컬럼, NULL이 아닐때 치환할 값, NULL일때 치환할 값)
SELECT FIRST_NAME, NVL2(COMMISSION_PCT,1,0)
FROM EMPLOYEES ORDER BY COMMISSION_PCT;

-- [순위 함수]
-- RANK() OVER(ORDER BY 컬럼)
-- 그룹 내 순위를 계산하여 NUMBER타입으로 순위를 반환

FIRST_NAME, SALARY FROM EMPLOYEES;

--DENSE_RANK() OVER :중복순위 계산 X
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "RANK", 
FIRST_NAME, SALARY FROM EMPLOYEES;

-- 집계함수
-- 여러 행들에 대한 연산의 결과를 하나의 행으로 반환한다
-- NULL값에 대해 계산하지 않는다.

-- COUNT() 
-- 행의 개수를 센다
SELECT COUNT(EMPLOYEES.COMMISSION_PCT) FROM EMPLOYEES;

-- 부서의 개수를 출력해보자
-- DISTINCT : 중복되는 값을 제거
SELECT COUNT(DISTINCT(EMPLOYEES.DEPARTMENT_ID))FROM EMPLOYEES;

-- MIN()
-- 최소값
SELECT MIN(EMPLOYEES.SALARY) FROM EMPLOYEES;

--MAX()
-- 최대값
SELECT MAX(EMPLOYEES.SALARY) FROM EMPLOYEES;

-- SUM()
-- 총합
SELECT SUM(SALARY) FROM EMPLOYEES;

--AVG()
-- 평균
SELECT ROUND(AVG(SALARY),1) FROM EMPLOYEES;

-- 집계함수는 일반 컬럼과 같이 사용하는 것은
-- 일반적인 방법으로는 불가능하다.
SELECT FIRST_NAME, MAX(SALARY) FROM EMPLOYEES;

-- 그룹화(GROUP BY)
-- 특정 테이블에서 소그룹을 만들어 결과를 분산시켜 얻고자 할때

-- 각 부서별 급여의 평균과 총합을 출력
SELECT e.DEPARTMENT_ID ,ROUND(AVG(SALARY)), SUM(SALARY) 
FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID;

-- 부서별, 직종별로 그룹을 나눠서 인원수를 출력하되 
-- 부서번호가 낮은 순서로 정렬
SELECT DEPARTMENT_ID, JOB_ID , COUNT(*) FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID ;

-- 사원테이블에서 80번 부서에 속하는 사원들의
-- 급여의 평균을 소수점 두자리까지 반올림하여 출력하세요
SELECT ROUND(AVG(SALARY),2)FROM EMPLOYEES
WHERE DEPARTMENT_ID=80  ; 

-- 각 직종별 인원수
SELECT JOB_ID ,COUNT(*) FROM EMPLOYEES
GROUP BY JOB_ID;
-- 각 직종별 급여의 합
SELECT JOB_ID ,SUM(SALARY) FROM EMPLOYEES
GROUP BY JOB_ID;
-- 부서별로 가장 높은 급여 조회
SELECT RANK() OVER(ORDER BY SALARY DESC),JOB_ID,SALARY FROM EMPLOYEES
GROUP BY SALARY,JOB_ID;

-- HAVING 절
-- GROUP BY로 집계된 값 중 조건을 추가하는 것

-- WHERE절과 HAVING절의 차이
-- HAVING절을 GROUP BY와 함께 사용해야 하며
-- 집계함수를 사용하여 조건절을 작성하거나
-- GROUP BY 컬럼만 조건절에 사용할 수 있다.

-- 각 부서의 급여의 최대값, 최소값, 인원수를 조회하되,
-- 급여의 최대값이 8000이상인 결과만 조회할 것
SELECT EMPLOYEE_ID , MAX(SALARY), MIN(SALARY),COUNT(EMPLOYEE_ID)
FROM EMPLOYEES
GROUP BY EMPLOYEE_ID 
HAVING MAX(SALARY)>=8000
ORDER BY MAX(SALARY) DESC ;

-- 각 부서별 인원수가 20명 이상인 부서의 정보를 
-- 부서번호, 급여의 합, 급여의 평균, 인원수 순으로 출력하되
-- 급여의 평균은 소수점 둘째자리 까지 반올림으로 조회
SELECT DEPARTMENT_ID ,SUM(SALARY),ROUND(AVG(SALARY),2),COUNT(DEPARTMENT_ID)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID 
HAVING COUNT(DEPARTMENT_ID )>=20;

-- 부서별, 직종별로 그룹화하여 부서번호, 직종, 인원수
-- 순으로 조회하되, 직종이 'MAN'으로 끝나는 경우만 조회
SELECT DEPARTMENT_ID ,JOB_ID ,COUNT(*)
FROM EMPLOYEES 
WHERE JOB_ID LIKE '%MAN'
GROUP BY DEPARTMENT_ID ,JOB_ID;

-- 각 부서별 평균급여를 소수점 한자리까지 버리고,
-- 평균 급여가 10000미만인 그룹만 조회해야하며,
-- 부서번호가 50 이하인 부서만 조회

SELECT JOB_ID , DEPARTMENT_ID,ROUND(AVG(SALARY),1)
FROM EMPLOYEES 
WHERE DEPARTMENT_ID >=50
GROUP BY DEPARTMENT_ID,JOB_ID
HAVING AVG(SALARY)<10000;

-- 그룹함수
CREATE TABLE 월별매출 (
    상품ID VARCHAR2(5),
    월 VARCHAR2(10),
    회사 VARCHAR2(10),
    매출액 INTEGER );
    
INSERT INTO  월별매출 VALUES ('P001', '2019.10', '삼성', 15000);
INSERT INTO  월별매출 VALUES ('P001', '2019.11', '삼성', 25000);
INSERT INTO  월별매출 VALUES ('P002', '2019.10', 'LG', 10000);
INSERT INTO  월별매출 VALUES ('P002', '2019.11', 'LG', 20000);
INSERT INTO  월별매출 VALUES ('P003', '2019.10', '애플', 15000);
INSERT INTO  월별매출 VALUES ('P003', '2019.11', '애플', 10000);

SELECT * FROM 월별매출;

-- ROLLUP
-- 계층적 그룹핑을 통해 점진적으로 소계와 총계를 계산
SELECT 상품ID,월,SUM(매출액) "매출액"
FROM 월별매출
GROUP BY ROLLUP(상품ID,월);

-- CUBE(A,B) : A,B그룹핑 / A그룹핑/ B그룹핑 -> A소계,B소계/합계
-- 모든 가능한 조합의 그룹핑 집합을 생성하여 모든 소계와 총계를 포함
SELECT 상품ID, 월, SUM(매출액) "매출액"
FROM 월별매출
GROUP BY CUBE(상품ID,월);

-- GROUPING SETS()
-- 사용자 정의 그룹핑 집합을 통해 원하는 조합만
-- 선택적으로 집계할 수 있다.
SELECT 상품ID, 월, SUM(매출액) "매출액"
FROM 월별매출
GROUP BY GROUPING SETS(상품ID,월);


