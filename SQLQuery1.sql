--Display which channels have the highest number of trending videos

select channel_title, COUNT(channel_title) as trend_count 
from youtube_india..INvideos group by channel_title
order by trend_count desc

--Creating a table to map category ids to their particular category names

CREATE TABLE category(category_id nvarchar(MAX), category_name varchar(MAX))
INSERT INTO category(category_id, category_name) 
VALUES('1','Film & Animation'), ('2','Autos & Vehicles'),('10','Music'),('15','Pets & Animals'),('17','Sports'),('18','Short Movies'),('19','Travel & Events'),('20','Gaming'),('21','Videoblogging'),('22','People & Blogs'),('23','Comedy'),('24','Entertainment'),('25','News & Politics'),('26','Howto & Style'),('27','Education'),('28','Science & Technology'),('30','Movies'),('31','Anime/Animation'),('32','Action/Adventure'),('33','Classics'),('34','Comedy'),('35','Documentary'),('36','Drama'),('37','Family'),('38','Foreign'),('39','Horror'),('40','Sci-Fi/Fantasy'),('41','Thriller'),('42','Shorts'),('43','Shows'),('44','Trailers')

--Display which categories have the highest number of trending videos 

select category_name, COUNT(category_name) as trend_count 
from youtube_india..INvideos left join category on INvideos.category_id = category.category_id group by category_name
order by trend_count desc

--Creating a view to export data to PowerBI for visualization
go
create view [youtube_view] as select channel_title, category_name, round(cast(likes AS float)*100/cast([views] as float),2) as engagement_percentage, round(cast(comment_count AS float)*100/cast([views] as float),2) as comment_percentage, len(title) as title_length,isnull(len(description),0) as desc_length
from youtube_india..INvideos left join category on INvideos.category_id = category.category_id