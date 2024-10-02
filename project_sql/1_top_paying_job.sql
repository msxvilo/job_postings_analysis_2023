/*
1. What are the top-paying jobs for Data Engineer?
        - Identify the top 10 highest-paying Data Enginner roles that are avalable remotly.
        - Focuses on job postings with specified salaries (remove nulls)
        - Why? Highlight the top-paying opportunities for Data Engineers
*/

SELECT
    job_id,
    cd.name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact jf
LEFT JOIN company_dim cd ON jf.company_id = cd.company_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;