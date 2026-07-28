SELECT
    name,
    release_date,
    positive_ratings,
    negative_ratings,
    positive_ratings + negative_ratings AS total_reviews,
    ROUND(
        positive_ratings * 1.0
        / (positive_ratings + negative_ratings),
        4
    ) AS podil_pozitivnich_hodnoceni
FROM steam
WHERE positive_ratings + negative_ratings >= 1000
ORDER BY total_reviews DESC;
