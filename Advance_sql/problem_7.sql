/*
Find job postings from the first quarter that have a salary greater than $70k
- Combine job posting table from the first quarter of 2023 (jan-mar)
- Gets job postings with an average yearly salary > $70000
- Get only Data Analyst job
*/

WITH qt1 AS (
    SELECT *
    FROM 
        january_jobs jj

    UNION ALL

    SELECT *
    FROM
        february_jobs fj

    UNION ALL

    SELECT *
    FROM
        march_jobs mj
)

SELECT 
    qt1.job_title_short,
    qt1.job_location,
    qt1.job_via,
    qt1.job_posted_date::DATE,
    qt1.salary_year_avg
FROM 
    qt1
WHERE 
    qt1.salary_year_avg > 70000 AND
    qt1.job_title_short = 'Data Analyst'
ORDER BY
    qt1.salary_year_avg DESC