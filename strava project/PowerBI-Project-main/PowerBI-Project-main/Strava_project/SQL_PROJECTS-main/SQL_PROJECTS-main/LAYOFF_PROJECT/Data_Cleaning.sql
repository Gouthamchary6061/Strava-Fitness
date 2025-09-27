-- Data Cleaning 

select *
from layoffs;

-- 1. Remove Duplicates
-- 2. Standarize the data
-- 3. Null or blank values
-- 4. Remove any column

CREATE TABLE layoffs_curr
like layoffs;

select *
from layoffs_curr;

insert into layoffs_curr
select *
from layoffs;




--    Handling the duplicates
with duplicated as (
select *,
	row_number() over (partition by company, location, industry, total_laid_off, 
		percentage_laid_off, `date`,stage, country, funds_raised_millions) as rn
from layoffs_curr
)
select *
from duplicated
where rn>1;

-- we can't simple delete these duplicates; to do this we need to create a new table with a extra column and proceed from there

CREATE TABLE `layoffs_curr2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rn` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_curr2;

insert into layoffs_curr2
select *,
	row_number() over (partition by company, location, industry, total_laid_off, 
		percentage_laid_off, `date`,stage, country, funds_raised_millions) as rn
from layoffs_curr;

select *
from layoffs_curr2
where rn>1;


delete
from layoffs_curr2
where rn>1;

select *
from layoffs_curr2;






--     Standardizing the data

select company, trim(company)
from layoffs_curr2
order by 1;

update layoffs_curr2
set company = trim(company);

select distinct(industry)
from layoffs_curr2
order by 1;

select *
from layoffs_curr2
where industry like 'crypto%';

update layoffs_curr2
set industry = 'Crypto'
where industry like 'crypto%';


select distinct country
from layoffs_curr2
order by 1;

select *
from layoffs_curr2
where country like 'United States%';

select distinct country, trim(trailing '.' from country)
from layoffs_curr2
order by 1;

update layoffs_curr2
set country = trim(trailing '.' from country)
where country like 'United States%';

select *
from layoffs_curr2;

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_curr2;

update layoffs_curr2
set date= str_to_date(`date`,'%m/%d/%Y');

select `date`
from layoffs_curr2;

alter table layoffs_curr2
modify column `date` date;





--     			Handling the nulls
select *
from layoffs_curr2
where total_laid_off is null and
percentage_laid_off is null;


select *
from layoffs_curr2
where industry is null
or industry ='';

select *
from layoffs_curr2
where company='Airbnb' or company ='Carvana';


select a.company, a.location, a.industry, b.company, b.industry
from layoffs_curr2 a
join layoffs_curr2 b
on a.company = b.company and 
	a.location = b.location
where (a.industry is null or a.industry = '')
  and (b.industry is not null and b.industry != '') ;

update layoffs_curr2 a
join layoffs_curr2 b
on a.company = b.company and 
	a.location = b.location
set a.industry = b.industry
where (a.industry is null or a.industry = '')
  and (b.industry is not null and b.industry != '') ;
  
  
  
  
  
  -- 			Removing the columns
  
  
select *
from layoffs_curr2
where total_laid_off is null and
percentage_laid_off is null;

delete
from layoffs_curr2
where total_laid_off is null and
percentage_laid_off is null;

select *
from layoffs_curr2;

  
  
  alter table layoffs_curr2
  drop column rn ;
  
  
  
  
  
  
  
  



