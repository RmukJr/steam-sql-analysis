WITH publisher_review AS (
    SELECT
        publisher,
        COUNT(*) AS pocet_her,
        SUM(positive_ratings) AS positive,
        SUM(negative_ratings) AS negative,
        AVG(
            positive_ratings * 1.0
            / (positive_ratings + negative_ratings)
        ) AS prumerne_hodnoceni,
        SUM(positive_ratings + negative_ratings) AS total_reviews
    FROM steam
    WHERE positive_ratings + negative_ratings > 0
		AND publisher NOT LIKE '%;%'
    GROUP BY publisher
),
scored_publisher AS (
    SELECT
        *,
        positive * 1.0 / total_reviews AS vazene_hodnoceni
    FROM publisher_review
)
SELECT
    publisher,
    pocet_her,
    positive,
    negative,
    total_reviews,
    ROUND(prumerne_hodnoceni, 4) AS prumerne_hodnoceni,
    ROUND(vazene_hodnoceni, 4) AS vazene_hodnoceni,
    ROUND(
        vazene_hodnoceni - prumerne_hodnoceni,
        4
    ) AS rozdil_hodnoceni,
    ROW_NUMBER() OVER (
        ORDER BY vazene_hodnoceni DESC
    ) AS poradi
FROM scored_publisher
WHERE pocet_her >= 15
ORDER BY vazene_hodnoceni DESC
LIMIT 200;
