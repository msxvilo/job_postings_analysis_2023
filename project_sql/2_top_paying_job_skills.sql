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



/*
This is Data Engineer jobs most demand skills in 2023 base on job postings:
Based on the analysis of the skills column in the dataset, the top 5 most frequent skills required
for data engineering roles are Python, Spark, Hadoop, Kafka, and Scala. 
Python is the most in-demand skill, appearing 7 times, followed by Spark with 5 appearances,
and Hadoop, Kafka, and Scala each appearing 3 times. This suggests that proficiency
in these skills is crucial for aspiring data engineers.

[
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "python"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "spark"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "pandas"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "numpy"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "pyspark"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "hadoop"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "kafka"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "python"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "spark"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "pandas"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "numpy"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "pyspark"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "hadoop"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "kafka"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 270455,
    "company_name": "Durlston Partners",
    "job_title": "Data Engineer",
    "salary_year_avg": "300000.0",
    "skills": "sql"
  },
  {
    "job_id": 270455,
    "company_name": "Durlston Partners",
    "job_title": "Data Engineer",
    "salary_year_avg": "300000.0",
    "skills": "python"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "spark"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "hadoop"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "kafka"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "tensorflow"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "keras"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "pytorch"
  },
  {
    "job_id": 561728,
    "company_name": "AI Startup",
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "python"
  },
  {
    "job_id": 561728,
    "company_name": "AI Startup",
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "scala"
  },
  {
    "job_id": 561728,
    "company_name": "AI Startup",
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "r"
  },
  {
    "job_id": 561728,
    "company_name": "AI Startup",
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "azure"
  },
  {
    "job_id": 595768,
    "company_name": "Signify Technology",
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "python"
  },
  {
    "job_id": 595768,
    "company_name": "Signify Technology",
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "scala"
  },
  {
    "job_id": 595768,
    "company_name": "Signify Technology",
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "databricks"
  },
  {
    "job_id": 595768,
    "company_name": "Signify Technology",
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "spark"
  },
  {
    "job_id": 543728,
    "company_name": "Signify Technology",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "python"
  },
  {
    "job_id": 543728,
    "company_name": "Signify Technology",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "scala"
  },
  {
    "job_id": 543728,
    "company_name": "Signify Technology",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "databricks"
  },
  {
    "job_id": 543728,
    "company_name": "Signify Technology",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "spark"
  },
  {
    "job_id": 151972,
    "company_name": "Movable Ink",
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "skills": "nosql"
  },
  {
    "job_id": 151972,
    "company_name": "Movable Ink",
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "skills": "aws"
  },
  {
    "job_id": 151972,
    "company_name": "Movable Ink",
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "skills": "gcp"
  },
  {
    "job_id": 204320,
    "company_name": "Handshake",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "245000.0",
    "skills": "go"
  },
  {
    "job_id": 2446,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "sql"
  },
  {
    "job_id": 2446,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "python"
  },
  {
    "job_id": 2446,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "java"
  },
  {
    "job_id": 2446,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "perl"
  }
]
*/