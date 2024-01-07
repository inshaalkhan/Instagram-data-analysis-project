-- SOLUTIONS

-- A) Marketing: The marketing team wants to launch some campaigns, and they need your help with the following

-- 1.Rewarding Most Loyal Users: People who have been using the platform for the longest time.
-- Task: Find the 5 oldest users of the Instagram from the database provided

select username, created_at
from users
order by created_at
limit 5;

-- 2.Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.
-- Task: Find the users who have never posted a single photo on Instagram

select u.id, u.username
from users u
left join photos p on u.id = p.user_id
where p.id is null;

-- 3.Declaring Contest Winner: 
-- The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
-- Task: Find the winner of the contest.

select
    p.user_id as winner_user_id,
    u.username as winner_username,
    p.id as winning_photo_id,
    count(l.user_id) as like_count
from photos p
join likes l ON p.id = l.photo_id
join users u ON p.user_id = u.id
group by p.id
ORDER BY like_count DESC
LIMIT 1;

-- 4.Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
-- Task: Identify and suggest the top 5 most commonly used hashtags on the platform.

select t.id AS tag_id, t.tag_name, count(pt.photo_id) as tag_count
from tags t
join photo_tags pt ON t.id = pt.tag_id
group by t.id, t.tag_name
order by tag_count desc
limit 5;

-- 5.What day of the week most user have registered on? 
-- Task: Provide insights on when to schedule an ad campaign.
  
select date_format((created_at), '%W') as dayy, count(username)
from users
group by 1
order by 2 desc;

-- 6.Provide how many times does average user posts on Instagram. 
-- Also, provide the total number of photos on Instagram/total number of users 

select * from photos,users;
with base as(
select u.id as userid, count(p.id) as photoid from users u left join photos p on p.user_id=u.id group by u.id)
select sum(photoid) as totalphotos, count(userid) as total_users, sum(photoid)/count(userid) as photoperuser
from base;

