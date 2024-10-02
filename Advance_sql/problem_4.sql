/* 
Count problems
*/
 -- Count total job_posting which offers health insurance

SELECT COUNT(*)
FROM job_postings_fact
WHERE job_health_insurance = TRUE;

-- Job posting total for each country

SELECT job_country,COUNT(job_id)
FROM job_postings_fact
GROUP BY job_country;