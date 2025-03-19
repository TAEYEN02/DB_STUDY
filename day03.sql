-- ORDER BY (정렬)
-- 질의 결과에 반환되는 행들을 특정을 기준으로 정렬하고자 할 때 사용
-- SELECT절의 가장 마지막에 기술
-- ASC : 오름차순(생략가능 ,DEFULT 값)
-- DESC : 내림차순(생략불가)

-- 사원테이블에서 급여를 많이 받는 순으로
-- 사번, 이름, 급여, 입사일 순으로 조회하세요
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE 
FROM EMPLOYEES 
ORDER BY SALARY DESC;

-- 급여가 같을때 입사일이 빠른순으로 조회
-- 다른 정렬 기준을 첫번째, 두번째... 기준으로 ','로 줄 수 있다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE 
FROM EMPLOYEES 
ORDER BY SALARY DESC , HIRE_DATE ASC;

-- 사원테이블에서 부서번호가 빠른순, 부서번호가 같다면 직종이 빠른순
-- 직종까지 같다면 급여를 많이 받는 순으로 사원의 사번, 이름 , 부서번호
-- 직종, 급여 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME,DEPARTMENT_ID,JOB_ID,SALARY
FROM EMPLOYEES 
ORDER BY DEPARTMENT_ID ASC,JOB_ID ASC,SALARY DESC ;

--급여가 15000이상인 사원들의 사번, 이름, 급여 ,입사일 을
-- 입사일이 빠른 순으로 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE 
FROM EMPLOYEES 
WHERE SALARY >=15000 ORDER BY HIRE_DATE;

---------------------------------------------------------------------
-- [문자 함수]
-- ASCII('값')
-- 지정된 문자의 아스키코드 값을 반환
SELECT ASCII('A') FROM DUAL;

-- CHAR(숫자)
-- 지정된 숫자와 일치하는 ASCII코드를 반환한다.
SELECT CHR(65) FROM DUAL;


-- RPAD(데이터, 고정길이, 문자)
-- 고정길이 안에 데이터를 출력하고 나머지 공간은 문자로 채운다
SELECT RPAD(DEPARTMENT_NAME,10,'*') FROM DEPARTMENTS;

-- LPAD(데이터,고정길이,문자)

-- TRIM()
-- 앞 뒤 문자열 공백을 제거
SELECT TRIM('   HELLO   ')FROM DUAL;

-- 컬럼이나 대상 문자열에서 특정 문자가 첫번째나
-- 마지막 위치에 있으면, 해당 특정 문자를 잘라낸 후
-- 남은 문자열만 반환된다.
SELECT TRIM('z' FROM 'zzzHELLOWzzz') FROM DUAL;

-- RTRIM()
-- 오른쪽 공백문자 제거
SELECT RTRIM('HELLO   ') FROM DUAL;

-- LTRIM()
-- 왼쪽 공백문자 제거ALTER 
SELECT RTRIM('   HELLO') FROM DUAL;

-- INSTR('문자열','문자')
-- 특정 문자의 위치를 반환
SELECT INSTR('HELLOW','O') FROM DUAL;

-- 문자열에서 1번째 자리부터 검색하여 
-- 두번째로 나오게 되는 글자가 위치하는 자리를 반환한다.
SELECT INSTR('HELLOW','L',-1,2) FROM DUAL;

-- 찾는 문자열이 없으면 0을 반환한다.
SELECT INSTR('HELLOW','Z') FROM DUAL;ALTER 

-- INITCAP(데이터)
-- 첫 문자를 대문자로 변환하는 함수
-- 공백, /를 구분자로 인식
SELECT INITCAP('good morning') FROM dual;
SELECT INITCAP('good/morning')FROM dual;

-- length(문자열)
-- 문자열의 길이를 반환한다
SELECT LENGTH('john')FROM dual;

-- CONCAT(문자열,문자열)
-- 두 문자열을 연결
SELECT CONCAT('Republic of',' Korea')FROM dual;

-- SUBSTR (데이터, 길이)
-- 문자열의 시작 위치부터 길이만큼 자른 후 변환
SELECT SUBSTR('Hello Oracle',2) AS CASE1,
		SUBSTR('Hello Oracle', 7,5) AS CASE2
FROM dual;

-- LOWER()
-- 문자열을 모두 소문자로 변환
SELECT LOWER('HELLO ORACLE')FROM DUAL;
-- UPPER()
-- 문자열을 모두 대문자로 변환
SELECT UPPER('hello oracle')FROM DUAL;

-- REPLACE()
-- 문자열 중에서 특정 문자를 다른 문자로 치환
SELECT REPLACE('HELLO WORLD','WORLD','SQL')FROM DUAL;

-- 부서번호가 50번인 사원들의 이름을 출력하되
-- 이름중 'el'을 모두 '**'로 대체하여 조회하세요
SELECT REPLACE(FIRST_NAME,'el','**')AS NAME FROM EMPLOYEES
WHERE DEPARTMENT_ID=50;

-- 문자열 '   oracle SQL Programming   '에서
-- 양쪽 공백을 제거한 후, 모든 문자를 대문자로 변환하고
-- 최종 문자열의 길이를 반환하시오
SELECT LENGTH(UPPER(TRIM('   oracle SQL Programming   ')))FROM DUAL;

-- ' Hello, Oracle SQL !'문자열에서 양쪽 공백 제거 후
-- 앞의 5글자와 마지막 5글자를 추출하여 
-- 각각 대문자로 변환한고 두 결과를 콜론으로 연결하여 반환
SELECT CONCAT(UPPER(SUBSTR(TRIM(' Hello Oracle SQL! '),1,5)),
CONCAT(':',UPPER(SUBSTR(TRIM(' Hello Oracle SQL! '),-5))))
FROM dual;

SELECT REPLACE(CONCAT(UPPER(SUBSTR(TRIM(' Hello Oracle SQL! '),1,5))
,UPPER(SUBSTR(TRIM(' Hello Oracle SQL! '),-5))),' ',':')
FROM dual;

-- 'Data' 왼쪽에 '-'문자를 채워 총 10자리 문자열로 만들고
-- 'Base'를 오른쪽에 '*'문자를 채워 총 10자리의 문자열로 
-- 만든 후, 이 두 결과를 연결히여 반환하는 sql
SELECT CONCAT(LPAD('Data',10,'-'),RPAD('Base',10,'*'))AS "add" FROM dual;

-- 이름이 6글자 이상인 사원의 사번과 이름, 급여 조회하기
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY FROM EMPLOYEES WHERE LENGTH(FIRST_NAME)>=6;

-- 사원테이블에서 사원번호화 사원번호 홀수면 1, 짝수면 0을 출력하세요
SELECT EMPLOYEE_ID, MOD(EMPLOYEE_ID,2) FROM EMPLOYEES;

-- 사원번호가 짝수인 사람들의 사원번호 와 이름 출력하기
SELECT EMPLOYEE_ID,FIRST_NAME FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2)=0;

-- 사원테이블에서 이름, 급여, 급여의 1000당 *개수로 
-- 채워서 조회하기
SELECT FIRST_NAME,SALARY FROM EMPLOYEES;

SELECT FIRST_NAME,SALARY,RPAD('口',ROUND(SALARY/1000),'口') FROM EMPLOYEES

