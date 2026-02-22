<img width="1440" height="712" alt="image" src="https://github.com/user-attachments/assets/b14dfeb8-9768-40f9-a644-0e5c507320e0" />

# MediaDB SQL Queries

SQL queries for the MediaDB (Chinook-style) database, covering customer purchases, album/artist relationships, playlist analysis, and more.

## Database Schema

The database contains the following tables: `albums`, `artists`, `customers`, `employees`, `genres`, `invoices`, `invoice_items`, `media_types`, `playlists`, `playlist_track`, and `tracks`.

## Queries

| File | Points | Description |
|------|--------|-------------|
| `query1.sql` | 5 pts | Last names and emails of all customers who made purchases |
| `query2.sql` | 5 pts | Names of each album and the artist who created it |
| `query3.sql` | 10 pts | Total number of unique customers per state, ordered alphabetically |
| `query4.sql` | 10 pts | States with more than 10 unique customers |
| `query5.sql` | 10 pts | Artists with album titles containing the substring "symphony" |
| `query6.sql` | 15 pts | Artists who performed MPEG tracks in "Brazilian Music" or "Grunge" playlists |
| `query7.sql` | 20 pts | Count of artists who published at least 10 MPEG tracks |
| `query8.sql` | 25 pts | Playlists longer than 2 hours with total length in hours |
| `query9.sql` | 25 pts | Creative query: Builds a quarterly sales rep leaderboard using two CTEs and three window functions |

## Usage

```bash
sqlite3 MediaDB.db < query1.sql
```
