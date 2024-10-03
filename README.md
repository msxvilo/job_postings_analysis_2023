# Introduction
This project analyzes 2023 job posting data to identify key trends and insights in the field of data engineering.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
This project undertakes an in-depth analysis of data engineering job postings from the previous year, aiming to identify the most sought-after skills in the field. By examining trends in skill demand, the project seeks to provide valuable insights for aspiring data engineers, enabling them to make informed decisions about their career development and optimize their job search strategies.

### The analysis focused on answering the following questions:

1. What are the top-paying jobs for Data Engineer?
2. What are the skills required fore these top-paying roles?
3. What are the most in-demand skills for Data Engineer?
4. What are the top skills based on salary for Data Engineer
5. What are the most optimal skills to learn?         Optimal: High Demand AND High Paying
# Tools I Used
The following tools were used in this analysis:

- **SQL:** SQL is the industry-standard language for managing and manipulating relational databases. SQL allowing me to query the database and unearth critical insights.

- **PostgreSQL:** PostgreSQL is a powerful, open-source database system. this database is ideal for handling given data

- **Visual Studio Code (VS Code):** VS code is a free, lightweight, and highly customizable code editor. It supports a wide range of programming languages and Git integration.   

- **Gemini:** Gemini is a one of the great AI tools which help me solve some task such as iteration and etc

- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and
project tracking.

**Additional Thoughts**

- The combination of tools you used represents a modern and effective approach to data analysis. SQL and PostgreSQL provide the foundation for data management and querying, while VS Code or Gemini offer a productive coding environment. Git and GitHub enable efficient version control and collaboration.
# The Analysis
Each query for this project aimed at investigating specific aspects of the Data Engineer job market.
Here's ho I approached each question:

### 1. Top Paying Data Engineer Jobs
The job_postings_fact table was queried to identify "Data Engineer" roles with the highest salary_year_avg, focusing on remote positions.
```SQL
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
```
Here's the breakdown of the top data analyst jobs also few insight what I find when I analysing this data

- **The top-paying** jobs for Data Engineers are concentrated in companies like Engtal and Durlston Partners, with average salaries reaching up to $325,000 per year.

- **Job Title Variet:** There's a high diversity in job titles, from Data Engineer to Director of Data Engineers.

- **Remote Work Premium:** The focus on remote positions indicates that companies are willing to pay a premium for top talent, regardless of location.

- **Salary Variance:** Even within the top 10, there is some salary variance, indicating that factors beyond the company and job title are also at play.


### 2. What are the skills required fore these top-paying roles?
The skills_job_dim table was joined with the results from the previous query to identify the skills associated with the highest-paying jobs.
```sql
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
```

Here's the brakdown of the most demanded skills for the top 10 highest paying Data Engineer jobs in 2023.

- **Python** is leading with a bold count of 7.
- **Spark** follows clously with bold count of 5
- **Hadoop** big data technology
- **Kubernetes** cloud platform

![Top Paying Skills](assets\Skills_Required_for_Top_Paying_Jobs.png)
*Bar graph visualizing the top paying 10 skills for Data Engineer: Gemini generated this graph from my SQL query results*

### 3. Most In-Demand Skills
The skills_job_dim and skills_dim tables were joined with the job_postings_fact table. The skills were counted across all Data Engineer job postings to identify those with the highest demand.
```sql
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
```
Here's the brakdown of the most demanded skills for Data Engineer in 2023:

- The most in-demand skills for Data Engineers are SQL, Python, AWS, and Azure, reflecting the importance of data management, analysis, and cloud computing in this field.

| Skills  | Demand Count |
|---------| -------------|
| sql     | 113375       |
| python  | 108265       |
| aws     | 62174        |
| azure   | 60823        |
| spark   | 53789        |

*Table of the demand for the top 5 skills in Data Engineer job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
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
```
Here's the brakdown of the top paying skills for Data Engineer:
- **Niche Expertise:** Specialization in niche technologies like Node.js and MongoDB can significantly enhance earning potential.

- **Full-Stack Data Engineering:** The presence of Node.js and Vue.js suggests a growing demand for full-stack data engineers who can handle both backend and frontend development.

- **Blockchain Integration:** The emergence of Solidity highlights the increasing need for data engineers with expertise in blockchain technology.

- **Advanced Programming:** Skills like Clojure and Rust emphasize the importance of specialized programming languages in modern data engineering.

| Skills  | Demand Count |
|---------| -------------|
| node    | 181862       |
| mongo   | 179403       |
| ggplot2 | 176250       |
| solidity| 166250       |
| vue     | 159375       |
| codecommit | 155000    |
|ubuntu   | 154455       |
| clojure | 153663       |
| cassandra| 150255      |
| rust    | 147771       |

*Table of the average salary for the top 10 paying skills for data analysts*


### 5. Optimal Skills to Learn
Combined the results from the high-demand skills and high-paying skills analyses to identify skills that are both in high demand and associated with high average salaries. 
```sql
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
```
|   Skill ID | Skills        |   Demand Count |   Average Salary($) |
|------------|---------------|----------------|--------------|
|        213 | kubernetes    |             56 |       158190 |
|         94 | numpy         |             14 |       157592 |
|         63 | cassandra     |             19 |       151282 |
|         98 | kafka         |            134 |       150549 |
|         27 | golang        |             11 |       147818 |
|        212 | terraform     |             44 |       146057 |
|         93 | pandas        |             38 |       144656 |
|         59 | elasticsearch |             21 |       144102 |
|        144 | ruby          |             14 |       144000 |
|         30 | ruby          |             14 |       144000 |
|         83 | aurora        |             14 |       142887 |
|        101 | pytorch       |             11 |       142254 |
|          3 | scala         |            113 |       141777 |
|         92 | spark         |            237 |       139838 |
|         95 | pyspark       |             64 |       139428 |
|         64 | dynamodb      |             27 |       138883 |
|         18 | mongodb       |             32 |       138569 |
|         62 | mongodb       |             32 |       138569 |
|         96 | airflow       |            151 |       138518 |
|          4 | java          |            139 |       138087 |
|         97 | hadoop        |             98 |       137707 |
|         17 | typescript    |             19 |       137207 |
|          2 | nosql         |             93 |       136430 |
|          6 | shell         |             34 |       135499 |
|        185 | looker        |             30 |       134614 |

*Table of the most optimal skills for Data Engineer sorted by salary*


Here's breakdown of the most optimal skills for Data Analysts in 2023:
- **Strategic Skill Development:** Aspiring data engineers should strategically focus on skills that optimize their job prospects and earning potential.

- **Kubernetes Value:** Kubernetes' high demand and high average salary underscore its importance in container orchestration and cloud-native deployments.

- **Niche Demand:** Skills like NumPy and Cassandra, while more specialized, still offer a good balance of demand and earning potential.


# What I Learned
- **Complex Query Crafring:** Mastered the art of advanced SQL, merging tables and wielding WITH clauses.
- **Data Aggregation:** Got comfortable with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **Analytical Wizardry:** Leveled up my real-world puzzle solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions
From the analysis, several general insights emerged:

1. **Top-Paying Data Engineer Jobs:** The highest-paying jobs for data engineer that allow remote work offer a wide range of salaries, the highest at $350,000!
2. **Skills for Top-Paying Jobs:** High-paying data engineer jobs require advanced proficiency in Python, spark and few other. suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL, Python, AWS, and Azure are also the most demanded skills in the data engineer job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as node and mongo, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** kubernetes leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data engineers to learn to maximize their market value.