SELECT
    YEAR(release_date) AS rok,
    COUNT(*) AS pocet_her,

    SUM(
        CASE
            WHEN price = 0 THEN 1
            ELSE 0
        END
    ) AS free_hry,

    SUM(
        CASE
            WHEN price > 0 THEN 1
            ELSE 0
        END
    ) AS placene_hry,

    ROUND(
        AVG(price),
        2
    ) AS prumerna_cena_vsech_her,

    ROUND(
        AVG(
            CASE
                WHEN price > 0 THEN price
            END
        ),
        2
    ) AS prumerna_cena_placenych,

    ROUND(
        SUM(
            CASE
                WHEN price = 0 THEN 1
                ELSE 0
            END
        ) * 1.0 / COUNT(*),
        4
    ) AS podil_free_her,

    ROUND(
        SUM(
            CASE
                WHEN positive_ratings + negative_ratings > 0
                THEN positive_ratings
                ELSE 0
            END
        ) * 1.0
        /
        NULLIF(
            SUM(
                CASE
                    WHEN positive_ratings + negative_ratings > 0
                    THEN positive_ratings + negative_ratings
                    ELSE 0
                END
            ),
            0
        ),
        4
    ) AS vazene_hodnoceni

FROM steam
GROUP BY YEAR(release_date)
ORDER BY rok;
