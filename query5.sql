-- Question 5 (10 pts): What are the names of the artists who made an album containing the substring "symphony" in the album title?

SELECT DISTINCT ar.Name AS ArtistName
FROM artists ar
INNER JOIN albums a ON ar.ArtistId = a.ArtistId
WHERE a.Title LIKE '%symphony%'
  AND ar.Name IS NOT NULL
ORDER BY ar.Name;
