-- Question 2 (5 pts): What are the names of each album and the artist who created it?

SELECT a.Title AS AlbumTitle, ar.Name AS ArtistName
FROM albums a
INNER JOIN artists ar ON a.ArtistId = ar.ArtistId
WHERE a.Title IS NOT NULL
  AND ar.Name IS NOT NULL
ORDER BY ar.Name, a.Title;
