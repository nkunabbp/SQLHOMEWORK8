USE Library


-- 1
-- EXISTS
SELECT DISTINCT P.Name
FROM Press AS P
WHERE EXISTS (
				SELECT B.Id_Press
				FROM Books AS B
				WHERE P.Id = B.Id_Press
)

-- ANY
SELECT DISTINCT P.Name
FROM Press AS P
WHERE Id = ANY(SELECT Id_Press FROM Books)

-- JOIN
SELECT DISTINCT P.Name
FROM Press AS P
JOIN Books AS B
ON P.Id = B.Id_Press


-- 2
-- ALL
SELECT B.Name , B.Pages
FROM Books AS B
WHERE B.Pages = ALL (
						SELECT MAX(B.Pages)
						FROM Books AS B
)

-- aggregate function
SELECT TOP(1) B.Name , MAX(B.Pages) AS MP
FROM Books AS B
GROUP BY B.Name
ORDER BY MP DESC


-- 3
-- WXISTS
SELECT DISTINCT T.Id, T.FirstName , T.LastName
FROM Teachers AS T
WHERE EXISTS (
				SELECT *
				FROM T_Cards AS TC
				WHERE T.Id NOT IN (SELECT DISTINCT Id_Teacher FROM T_Cards)

)

-- JOIN 
SELECT DISTINCT T.Id, T.FirstName , T.LastName
FROM Teachers AS T
JOIN T_Cards AS TC
ON T.Id NOT IN (SELECT DISTINCT Id_Teacher FROM T_Cards)


-- 4
-- 1. EXISTS
SELECT DISTINCT B.Id, B.Name, B.Pages
FROM Books AS B
WHERE EXISTS (
				SELECT *
				FROM T_Cards AS TC
				WHERE EXISTS( 
								SELECT Id_Book
								FROM S_Cards AS SC
								WHERE B.Id = SC.Id_Book AND B.Id = TC.Id_Book

				)

)
ORDER BY B.Pages DESC

-- 2. EXISTS
SELECT DISTINCT B.Id, B.Name, B.Pages
FROM Books AS B
WHERE EXISTS (
				SELECT *
				FROM T_Cards AS TC
				JOIN  S_Cards AS SC 
				ON SC.Id_Book = B.Id
				WHERE B.Id = SC.Id_Book AND B.Id = TC.Id_Book


)
ORDER BY B.Pages DESC

-- JOIN 
SELECT DISTINCT B.Id, B.Name, B.Pages
FROM T_Cards AS TC
JOIN Books AS B
ON TC.Id_Book = B.Id
JOIN  S_Cards AS SC 
ON SC.Id_Book = B.Id
WHERE B.Id = TC.Id_Book AND B.Id = SC.Id_Book
ORDER BY B.Pages DESC
