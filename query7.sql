-- Question 7 (20 pts): How many artists published at least 10 MPEG tracks?

SELECT COUNT(*) AS NumberOfArtists
FROM (
    SELECT ar.ArtistId
    FROM artists ar
    INNER JOIN albums al ON ar.ArtistId = al.ArtistId
    INNER JOIN tracks t ON al.AlbumId = t.AlbumId
    INNER JOIN media_types mt ON t.MediaTypeId = mt.MediaTypeId
    WHERE mt.Name LIKE '%MPEG%'
    GROUP BY ar.ArtistId
    HAVING COUNT(t.TrackId) >= 10
);
