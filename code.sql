--Number of Distinct campaigns
SELECT COUNT(DISTINCT utm_campaign) AS 'Campaigns'
FROM page_visits;

--Number of Distinct sources
SELECT COUNT(DISTINCT utm_source) AS 'Sources'
FROM page_visits;

--Number of Campaigns and sources
SELECT DISTINCT utm_campaign AS 'Campaigns',
	utm_source AS 'Sources'
FROM page_visits;

--Pages on CoolTShirt
SELECT DISTINCT page_name AS 'Page'
FROM page_visits;

--First Touch
--First Touch temporary table
WITH first_touch AS (
    SELECT user_id,
    	MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
--Finding number of first touch by each campaign
SELECT pv.utm_campaign AS 'Campaign',
	COUNT(ft.first_touch_at) AS 'First Touch'
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;

--Last Touch
--Last Touch temporary table
WITH last_touch AS (
    SELECT user_id,
    	MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
--Finding number of last touch by each campaign
SELECT pv.utm_campaign AS 'Campaign',
	COUNT(lt.last_touch_at) AS 'Last Touch'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;


--Last Touch Purchase
--Last Touch temporary table
WITH last_touch AS (
    SELECT user_id,
    	MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
--Finding number of last touch by each campaign
SELECT pv.utm_campaign AS 'Campaign',
	COUNT(lt.last_touch_at) AS 'Last Touch purchase'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE page_name = '4 - purchase'
GROUP BY 1
ORDER BY 2 DESC;