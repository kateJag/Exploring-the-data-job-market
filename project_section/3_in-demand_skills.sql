/*
Question: What are the most in-demand skills for data analyst?
*/


WITH remote_job_skills AS (
SELECT skill_id, COUNT(*) AS skill_count
FROM skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings
   ON skills_to_job.job_id=job_postings.job_id
WHERE job_work_from_home = TRUE AND job_title_short = 'Data Analyst'
GROUP BY skill_id
)

SELECT skills.skill_id, skills AS skill_name, skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills
    ON skills.skill_id=remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 10;

-- edited more compact version

SELECT skills,
       COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND  job_work_from_home = true
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10;