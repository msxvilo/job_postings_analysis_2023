/*
Qustion: What skills are required for the top-paying Data Engineer jobs?
- Use the top 10 highest-paying Data Engineer jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detaled look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develope that align with top salaries
*/


WITH top_10 AS (
    SELECT
        job_id,
        cd.name AS company_name,
        job_title,
        salary_year_avg
    FROM 
        job_postings_fact jf
    LEFT JOIN company_dim cd ON jf.company_id = cd.company_id
    WHERE
        job_title_short = 'Data Engineer' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10)


SELECT 
    top_10.*,
    skills
FROM 
    top_10
INNER JOIN skills_job_dim sd ON top_10.job_id = sd.job_id
INNER JOIN skills_dim ON sd.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
