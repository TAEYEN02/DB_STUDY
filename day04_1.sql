-- 표준 조인
-- ANSI 조인 : 표준 JOIN 방법

-- INNER JOIN
-- 두 테이블 간에 조인 조건에 일치하는 데이터만 가져온다

-- SELECT 컬럼명1, 컬럼명
-- FROM TABLE A (INNER) JOIN TABLE B
-- ON TABLEA.조건명 = TABLEB.조건명

-- 사원테이블에 부서명이 없음
-- 부서테이블과 DEPARTMENT_ID로 연결

SELECT E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 부서 테이블과 지역(Locations)로부터 부서명 city 조회
SELECT department_name, city
FROM LOCATIONS l JOIN  DEPARTMENTS d
ON L.LOCATION_ID =D.LOCATION_ID;

-- 지역(Locations) , 나라(countries)를 조회
-- 도시명과 국가명 조회
SELECT l.CITY ,c.COUNTRY_NAME
FROM LOCATIONS l JOIN COUNTRIES c 
ON l.COUNTRY_ID  = c.COUNTRY_ID;

SELECT * FROM LOCATIONS l;
SELECT * FROM COUNTRIES c ;

-- 사원테이블과, jobs 테이블을 이용하여
-- 이름, 성, 직종번호, 직종이름을 조회하세요

SELECT * FROM JOBS;

SELECT e.FIRST_NAME,e.LAST_NAMe ,e.JOB_ID ,j.JOB_TITLE 
FROM EMPLOYEES e JOIN JOBS j 
ON e.JOB_ID = e.JOB_ID ;

-- 사원, 부서 지역테이블로부터 
-- 이름,이메일, 부서번호, 부서명, 지역번호, 도시명
-- 을 조회하되, 도시가 'Seattle' 인 경우만 조회하기
SELECT 
	e.FIRST_name,
	e.email,
	e.department_id,
	d.department_name,
	l.location_id,
	l.city
FROM employees e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
JOIN LOCATIONS l ON d.LOCATION_ID =l.LOCATION_ID
AND L.CITY = 'Seattle';

-- 1-1 self inner join
-- 하나의 테이블 내에서 다른 컬럼을 참조하기 위해 사용하는
-- '자기 자신과의 조인'방법이다
-- 이를 통해서 데이터베이스에서 한 테이블 내의 값을 다른 값과 연결할 수 있다.

/*
 * select a.컬럼1, b.컬럼1
 * from 테이블A a
 * join 테이블A b
 * on a.열 = b.열
 * */

SELECT e1.first_name,e2.employee_id
FROM employees e1 
JOIN employees e2
ON e1.EMPLOYEE_ID = e2.MANAGER_ID;













