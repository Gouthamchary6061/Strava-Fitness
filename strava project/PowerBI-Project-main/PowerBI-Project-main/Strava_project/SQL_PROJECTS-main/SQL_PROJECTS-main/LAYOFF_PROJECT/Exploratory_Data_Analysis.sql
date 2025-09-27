SELECT *
FROM layoffs_curr2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_curr2;

SELECT *
FROM layoffs_curr2
where percentage_laid_off=1
order by total_laid_off desc;


SELECT *
FROM layoffs_curr2
where percentage_laid_off=1
order by funds_raised_millions desc;

SELECT company, sum(total_laid_off)
FROM layoffs_curr2
group by company 
order by 2 desc;

select min(`date`) , max(`date`)
from layoffs_curr2;

SELECT industry, sum(total_laid_off)
FROM layoffs_curr2
group by industry 
order by 2 desc;

SELECT country, sum(total_laid_off)
FROM layoffs_curr2
group by country
order by 2 desc;

SELECT location, sum(total_laid_off)
FROM layoffs_curr2
group by location
order by 2 desc;

SELECT year(`date`), sum(total_laid_off)
FROM layoffs_curr2
group by year(`date`)
order by 1 desc;

SELECT stage, sum(total_laid_off)
FROM layoffs_curr2
group by stage
order by 2 desc;


select *
from layoffs_curr2;

select substring(`date`, 1,7) as `month` , sum(total_laid_off)
from layoffs_curr2
where substring(`date`, 1,7) is not null
group by `month`
order by 1 ;

with rolling_total as 
(
select substring(`date`, 1,7) as `month` , sum(total_laid_off) as total_off
from layoffs_curr2
where substring(`date`, 1,7) is not null
group by `month`
order by 1 
)

select `month` ,total_off,  sum(total_off) over (order by `month`) as rolling_total
from rolling_total;




SELECT country, sum(total_laid_off)
FROM layoffs_curr2
group by country
order by 2 desc;

SELECT company, year(`date`) , sum(total_laid_off)
FROM layoffs_curr2
group by company, year(`date`)
order by 3 desc;

with company_year(company, years, total_laid_off) as 
(
SELECT company, year(`date`) , sum(total_laid_off)
FROM layoffs_curr2
group by company, year(`date`)
order by 3 desc
),
company_year_rank as
(
select *, dense_rank() over (partition by years order by total_laid_off desc ) as rankings
from company_year
where years is not null
)

select *
from company_year_rank
where rankings<=5








