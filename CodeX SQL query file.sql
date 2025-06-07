create database codex;
use codex;

create table fact_survey_responses;
select * from fact_survey_responses;
select * from dim_cities;
select * from dim_repondents;

alter table fact_survey_responses modify column Respondent_ID int;

# Query 1 Who prefers energy drink more? (male/female/non-binary?)
select Gender, count(Respondent_ID) as No_of_Respondents
from dim_repondents
group by Gender
order by No_of_Respondents desc;

# Query 2 Which age group prefers energy drinks more?
select Age, count(Respondent_ID) as No_of_Respondents, round(count(Respondent_ID)/10000 *100, 1 ) as Response_percent
from dim_repondents
group by Age;

# Query 3 What are the preferred ingredients of energy drinks among respondents?
select Ingredients_expected as Ingredients, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_percent
from fact_survey_responses
group by Ingredients_expected
order by No_of_Respondents desc;

# Query 4 What packaging preferences do respondents have for energy drinks?
select Packaging_preference , count(Respondent_ID) as No_of_Respondents, round(count(Respondent_ID)/10000 *100 ) as Response_percent
from fact_survey_responses
group by Packaging_preference
order by No_of_Respondents desc;

# Query 5 Who are the current market leaders?
select Current_brands as Brands, count(Respondent_ID) as No_of_Respondents
from fact_survey_responses
group by Brands
order by No_of_Respondents desc;

#Query 6 What are the primary reasons consumers prefer those brands over ours?
select Reasons_for_choosing_brands as Preferred_Reasons, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_Percent
from fact_survey_responses
group by Preferred_Reasons
order by No_of_Respondents desc;

#Query 7 Which marketing channel can be used to reach more customers?
select Marketing_channels Preferred_Channel, count(Respondent_ID) as Reach_Count
from fact_survey_responses
group by Preferred_Channel
order by Reach_Count desc;

#Query 8 What do people think about our brand? (overall rating)
select Brand_perception as Customer_Sentiment, count(Respondent_ID) as No_of_Respondents
from fact_survey_responses
group by Customer_Sentiment
order by No_of_Respondents desc;

select Taste_experience, count(Respondent_ID) as No_of_Respondents
from fact_survey_responses
group by Taste_experience
order by No_of_Respondents desc;

#Query 9 Which cities do we need to focus more on?
select c.City as City, c.Tier, count(r.Respondent_ID) as Total_Respondents, round(count(r.Respondent_ID)/10000 *100, 1 ) as Response_Percent
from dim_repondents r
join dim_cities c  on r.City_ID = c.City_ID
group by City, c.Tier
order by Response_Percent asc;

#Query 11 Which type of marketing reaches the most Youth (15-30)?
select f.Marketing_channels, count(r.Respondent_ID) as Reach_Count_Youth
from fact_survey_responses f
join dim_repondents	r on f.Respondent_ID = r.Respondent_ID
WHERE Age IN ('15-18', '19-30')
group by f.Marketing_channels
order by Reach_Count_Youth desc;

#Query 12 Where do respondents prefer to purchase energy drinks?
select Purchase_location , count(Respondent_ID) as No_of_Respondents
from fact_survey_responses
group by Purchase_location
order by No_of_Respondents desc;

#Query 13 What are the typical consumption situations for energy drinks among respondents?
select Typical_consumption_situations, count(Respondent_ID) as No_of_Respondents
from fact_survey_responses
group by Typical_consumption_situations
order by No_of_Respondents desc;

#Query 14 What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
select Price_range, count(Respondent_ID) as No_of_Respondents
from fact_survey_responses
group by Price_range
order by No_of_Respondents desc;

select Limited_edition_packaging, count(Respondent_ID) as No_of_Respondents
from fact_survey_responses
group by Limited_edition_packaging
order by No_of_Respondents desc;

#Query 15 Which area of business should we focus more on our product development? (Branding/taste/availability)
Select Reasons_for_choosing_brands as Decision_Drivers, count(Respondent_ID) as No_of_Respondents
from fact_survey_responses
where Current_brands = 'CodeX'
group by Decision_Drivers
order by No_of_Respondents desc;

#product formulation
select Interest_in_natural_or_organic, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_Percent
from fact_survey_responses
group by Interest_in_natural_or_organic
order by No_of_Respondents desc;

# Health_concerns
select Health_concerns, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_Percent
from fact_survey_responses
group by Health_concerns
order by No_of_Respondents desc;

# Ingredients_expected
select Ingredients_expected, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_Percent
from fact_survey_responses
group by Ingredients_expected
order by No_of_Respondents desc;

# Improvements_desired
select Improvements_desired, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_Percent
from fact_survey_responses
group by Improvements_desired
order by No_of_Respondents desc;

# Reasons_preventing_trying
select Reasons_preventing_trying, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_Percent
from fact_survey_responses
group by Reasons_preventing_trying
order by No_of_Respondents desc;

# Consume_reason
select Consume_reason, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_Percent
from fact_survey_responses
group by Consume_reason
order by No_of_Respondents desc;

# product's ideal Price_range
select Price_range, count(Respondent_ID) as No_of_Respondents,
		round(count(Respondent_ID)/10000 *100, 1 ) as Response_Percent
from fact_survey_responses
group by Price_range
order by No_of_Respondents desc;

# Heard_before about product
select f.Heard_before, count(r.Respondent_ID) as No_of_Respondents,
		round(count(r.Respondent_ID)/10000 *100, 2 ) as Response_Percent
from fact_survey_responses f
join dim_repondents r on f.Respondent_ID = r.Respondent_ID
where f.Current_brands = "CodeX"
group by f.Heard_before
order by No_of_Respondents desc;

# Tried_before about product
select f.Tried_before, count(r.Respondent_ID) as No_of_Respondents,
		round(count(r.Respondent_ID)/10000 *100, 2 ) as Response_Percent
from fact_survey_responses f
join dim_repondents r on f.Respondent_ID = r.Respondent_ID
where f.Current_brands = "CodeX"
group by f.Tried_before
order by No_of_Respondents desc;


##Address complaints for positive customer experiences.
##Marketing & Visibility- digital ads, Collaborate with fitness influencers, Strengthen brand messaging around effectiveness and safety.
#Offer exclusive deals for students and young professionals, since many use energy drinks for work/study.
##Product Quality & Perception -reflect health-conscious choices. meet customer expectations.
## By focusing on authentic communication like actively to customer feedback on social media, Share success stories and positive customer experiences. 
# Also on Customer trust, brand perception can shift positively within weeks to months
## Target - Young Professionals & Students (15-30 years old) as Many consume energy drinks to stay awake during work/study.
# Some respondents avoid energy drinks due to health concerns.Introducing low-sugar, organic, or vitamin-infused variants can win them over.
# Marketing through music festival and entertainment partnerships can attract Social & Party-Goers segment.









