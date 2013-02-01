#This document shows how I went from SQLite database of the metadata from the million song dataset to the subsample used for my SWC lecture. The original 700MB database is availible here: http://labrosa.ee.columbia.edu/millionsong/. All these operations are performed on this dataset.

# To create the copy table:

CREATE TABLE songz (
	track_id text PRIMARY KEY, 
	title text, song_id text, 
	release text, 
	artist_id text, 
	artist_mbid text, 
	artist_name text, 
	duration real, 
	artist_familiarity real, 
	artist_hotttnesss real, 
	year int, 
	track_7digitalid int, 
	shs_perf int, 
	shs_work int);

# Now let's create some new tables we can join across.


CREATE TABLE lineup (
	release text,
	musician text);

# Add some random data
INSERT INTO songz SELECT * FROM songs LIMIT 500;

# Add some data we'll need
INSERT INTO songz SELECT * FROM songs WHERE artist_name LIKE "% BECK %";
INSERT INTO songz SELECT * FROM songs WHERE artist_name  = "BECK";
INSERT INTO songz SELECT * FROM songs WHERE artist_name  = "The Yardbirds";
INSERT INTO songz SELECT * FROM songs WHERE release LIKE "Enter The Wu-Tang%";
INSERT INTO songz SELECT * FROM songs WHERE artist_name = "Stanley Clarke" AND release = "Journey To Love";
INSERT INTO songz SELECT * FROM songs WHERE artist_name = "Stanley Clarke" AND release = "School Days";
INSERT INTO songz SELECT * FROM songs WHERE artist_name = "Stanley Clarke" AND release = "The Clarke/Duke Project Vol. 3";
INSERT INTO songz SELECT * FROM songs WHERE release = 'Tical';


# Now let's add some data we can join across
INSERT INTO lineup SELECT DISTINCT(release),"Jeff Beck" FROM songz WHERE artist_name LIKE "%Jeff Beck%";
INSERT INTO lineup SELECT DISTINCT(release),"Method Man" FROM songz WHERE release LIKE "Enter%";
INSERT INTO lineup SELECT DISTINCT(release),"RZA" FROM songz WHERE release LIKE "Enter%";
INSERT INTO lineup SELECT DISTINCT(release),"GZA" FROM songz WHERE release LIKE "Enter%";
INSERT INTO lineup SELECT DISTINCT(release),"Raekwon" FROM songz WHERE release LIKE "Enter%";
INSERT INTO lineup SELECT DISTINCT(release),"Ghostface Killah" FROM songz WHERE release LIKE "Enter%";
INSERT INTO lineup SELECT DISTINCT(release),"Inspectah Deck" FROM songz WHERE release LIKE "Enter%";
INSERT INTO lineup SELECT DISTINCT(release),"U-God" FROM songz WHERE release LIKE "Enter%";
INSERT INTO lineup SELECT DISTINCT(release),"ODB" FROM songz WHERE release LIKE "Enter%";
INSERT INTO lineup SELECT DISTINCT(release),"Masta Killa" FROM songz WHERE release LIKE "Enter%"
INSERT INTO lineup SELECT DISTINCT(release),"Stanley Clarke" FROM songz WHERE artist_name = "Stanley Clarke";
INSERT INTO lineup SELECT DISTINCT(release),"George Duke" FROM songz WHERE release LIKE "%DUKE%";
INSERT INTO lineup SELECT DISTINCT(release),"Jeff Beck" FROM songz WHERE release = "Journey To Love"
INSERT INTO lineup SELECT DISTINCT(release),"Method Man" FROM songz WHERE release = "Tical";

