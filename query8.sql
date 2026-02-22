-- Question 8 (25 pts): What is the total length of each playlist in hours?
-- List the playlist id and name of only those playlists that are longer than 2 hours,
-- along with the length in hours rounded to two decimals.

SELECT p.PlaylistId,
       p.Name,
       ROUND(SUM(t.Milliseconds) / 3600000.0, 2) AS LengthInHours
FROM playlists p
INNER JOIN playlist_track pt ON p.PlaylistId = pt.PlaylistId
INNER JOIN tracks t ON pt.TrackId = t.TrackId
WHERE t.Milliseconds IS NOT NULL
GROUP BY p.PlaylistId, p.Name
HAVING SUM(t.Milliseconds) / 3600000.0 > 2
ORDER BY LengthInHours DESC;
