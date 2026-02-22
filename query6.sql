-- Question 6 (15 pts): What are the names of all artists who performed MPEG (video or audio) tracks
-- in either the "Brazilian Music" or the "Grunge" playlists?

SELECT DISTINCT ar.Name AS ArtistName
FROM artists ar
INNER JOIN albums al ON ar.ArtistId = al.ArtistId
INNER JOIN tracks t ON al.AlbumId = t.AlbumId
INNER JOIN media_types mt ON t.MediaTypeId = mt.MediaTypeId
INNER JOIN playlist_track pt ON t.TrackId = pt.TrackId
INNER JOIN playlists p ON pt.PlaylistId = p.PlaylistId
WHERE mt.Name LIKE '%MPEG%'
  AND p.Name IN ('Brazilian Music', 'Grunge')
  AND ar.Name IS NOT NULL
ORDER BY ar.Name;
