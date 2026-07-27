SELECT 
    CASE 
        WHEN price = 0 THEN 'Free'
        WHEN price > 0 THEN 'Paid'
    END AS kategorie,

    COUNT(*) AS pocet_her,

    ROUND(
        AVG(
            positive_ratings * 1.0 
            / (positive_ratings + negative_ratings)
        ),
        4
    ) AS prumerne_hodnoceni,

    ROUND(
        SUM(positive_ratings) * 1.0
        / SUM(positive_ratings + negative_ratings),
        4
    ) AS vazene_hodnoceni

FROM steam

WHERE positive_ratings + negative_ratings > 0

GROUP BY 
    CASE 
        WHEN price = 0 THEN 'Free'
        WHEN price > 0 THEN 'Paid'
    END;
