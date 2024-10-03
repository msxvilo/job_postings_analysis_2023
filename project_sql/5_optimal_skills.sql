/*
What are the most optimal skills to learn?
- Identify skills in high demand and associated with average salaries for Data Engineer roles
- Concentrates on remote positions with specified salaries
*/

WITH top_paying_skills AS (
    SELECT
        sd.skill_id, 
        s.skills,  
        ROUND(AVG(jf.salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact jf
    INNER JOIN skills_job_dim sd ON jf.job_id = sd.job_id
    INNER JOIN skills_dim s ON sd.skill_id = s.skill_id  
    WHERE
        jf.job_title_short = 'Data Engineer' AND
        jf.salary_year_avg IS NOT NULL AND
        jf.job_work_from_home = TRUE
    GROUP BY
        sd.skill_id,
        s.skills  
), demand_skills AS (
    SELECT 
        sd.skill_id,
        s.skills,  
        COUNT(sd.job_id) AS demand_count
    FROM job_postings_fact jf
    INNER JOIN skills_job_dim sd ON jf.job_id = sd.job_id
    INNER JOIN skills_dim s ON sd.skill_id = s.skill_id  
    WHERE
        jf.job_title_short = 'Data Engineer' AND
        jf.salary_year_avg IS NOT NULL AND
        jf.job_work_from_home = TRUE
    GROUP BY
        sd.skill_id,
        s.skills   
)

SELECT
    ds.skill_id,
    ds.skills,  
    ds.demand_count,
    tps.avg_salary
FROM
    demand_skills ds  
INNER JOIN top_paying_skills tps ON ds.skill_id = tps.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;