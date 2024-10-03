/*
Answer: What are the top skills based on salary?
- Look at the avarage salary associated with each skill for Data Engineer positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Engineer and
    helps identifay the most financially rewarding skills to acquire or improve
*/


SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact jf
INNER JOIN skills_job_dim sd ON jf.job_id = sd.job_id
INNER JOIN skills_dim ON sd.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 10;




/*
- Full-Stack Data Engineering: Demand is increasing for Data Engineers who can handle both 
    backend (Node.js, databases) and frontend (Vue.js) development, creating data-driven 
    applications and visualizations.
- Blockchain Integration: The rise of "solidity" highlights the growing need for Data Engineers 
    with expertise in blockchain technology and decentralized data management.
- Advanced Programming and Cloud: Skills like "clojure", "rust", and "codecommit" emphasize the importance of 
    specialized programming languages, cloud platforms, and DevOps practices in modern data engineering.

[
  {
    "skills": "node",
    "avg_salary": "181862"
  },
  {
    "skills": "mongo",
    "avg_salary": "179403"
  },
  {
    "skills": "ggplot2",
    "avg_salary": "176250"
  },
  {
    "skills": "solidity",
    "avg_salary": "166250"
  },
  {
    "skills": "vue",
    "avg_salary": "159375"
  },
  {
    "skills": "codecommit",
    "avg_salary": "155000"
  },
  {
    "skills": "ubuntu",
    "avg_salary": "154455"
  },
  {
    "skills": "clojure",
    "avg_salary": "153663"
  },
  {
    "skills": "cassandra",
    "avg_salary": "150255"
  },
  {
    "skills": "rust",
    "avg_salary": "147771"
  }
]
*/