-- Таблица ROSSTAT_SALARY_RU, содержит сведения о средней заработной плате в РФ по регионам 
-- на 1 января 2019 года по данным Росстата. Представим ситуацию, что из-за невнимательности 
-- операциониста, регионы: Магаданская обл., г. Санкт-Петербург, Тульская область оказались 
-- не представлены в итоговой сводке. Роль невнимательного операциониста придется исполнить Вам 
-- (т.е. нужно удалить соответствующие строки), а далее работать уже с новой выборкой.

-- Постройте вариационный ряд (сортировка по неубыванию, нумерация элементов начинается с 1).

-- Введите X(1):

SELECT SALARY
FROM
(
    SELECT REGION_NAME
        , SALARY
        , ROW_NUMBER() OVER(ORDER BY SALARY) AS ROW_N
    FROM ROSSTAT_SALARY_RU
    WHERE REGION_NAME NOT IN ('Магаданская обл.', 'г. Санкт-Петербург', 'Тульская область')
)
WHERE ROW_N = 1

-- Введите X(41):

SELECT SALARY
FROM
(
    SELECT REGION_NAME
        , SALARY
        , ROW_NUMBER() OVER(ORDER BY SALARY) AS ROW_N
    FROM ROSSTAT_SALARY_RU
    WHERE REGION_NAME NOT IN ('Магаданская обл.', 'г. Санкт-Петербург', 'Тульская область')
)
WHERE ROW_N = 41

-- Введите X(72):

SELECT SALARY
FROM
(
    SELECT REGION_NAME
        , SALARY
        , ROW_NUMBER() OVER(ORDER BY SALARY) AS ROW_N
    FROM ROSSTAT_SALARY_RU
    WHERE REGION_NAME NOT IN ('Магаданская обл.', 'г. Санкт-Петербург', 'Тульская область')
)
WHERE ROW_N = 72

-- Найдите выборочное среднее (ответ округлите до сотых):

SELECT ROUND(AVG(SALARY), 2) AS SAMPLE_MEAN
FROM
(
    SELECT REGION_NAME
        , SALARY
        , ROW_NUMBER() OVER(ORDER BY SALARY) AS ROW_N
    FROM ROSSTAT_SALARY_RU
    WHERE REGION_NAME NOT IN ('Магаданская обл.', 'г. Санкт-Петербург', 'Тульская область')
)

-- Определите выборочную медиану:

SELECT MEDIAN(SALARY) AS MEDIAN
FROM
(
    SELECT REGION_NAME
        , SALARY
        , ROW_NUMBER() OVER(ORDER BY SALARY) AS ROW_N
    FROM ROSSTAT_SALARY_RU
    WHERE REGION_NAME NOT IN ('Магаданская обл.', 'г. Санкт-Петербург', 'Тульская область')
)