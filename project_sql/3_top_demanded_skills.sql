/*
Question: What are the most in-demand skills for Data Engineer?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a Data Engineer.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valueble skills for job seekers.
*/

SELECT 
    skills,
    COUNT(sd.job_id) AS demand_count
FROM job_postings_fact jf
INNER JOIN skills_job_dim sd ON jf.job_id = sd.job_id
INNER JOIN skills_dim ON sd.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;




/*
This is the second version of this querry but above one is more shorter and I like it to use for
soloution of this problem.


WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id
    WHERE 
        job_postings.job_work_from_home = TRUE AND
        job_postings.job_title_short = 'Data Engineer'
    GROUP BY 
        skill_id)

SELECT 
    skills_dim.skill_id,
    skills,
    skill_count
FROM 
    skills_dim
INNER JOIN remote_job_skills 
    ON skills_dim.skill_id = remote_job_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5;
*/