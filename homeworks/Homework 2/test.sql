# DELETE, SELECT, UPDATE #
-- Business Rule 1: A user can only create one account per region. --
SELECT 
    firstName,
    lastName,
    DOB
FROM User
WHERE firstName = 'Vikki';






-- Business Rule 2: A user can be unregistered, registered, or a librarian. --

SELECT
	U.firstName AS 'First Name',
    U.lastName AS 'Last Name',
    R.email AS 'Email'
FROM User U, Registered R 
WHERE U.userID = R.fk_userID;

UPDATE User
SET
lastName = 'James'
WHERE firstName = 'Link';

Delete from User
where firstName = 'Vikki' AND lastName = 'Garcia';

-- Business Rule 3: Unregistered users can search for media.  --





-- Business Rule 4: Users should be able to rent multiple medias at once before checking out.  --

-- Business Rule 5: Media can be a book, CD, movie, or newspapers.  --

SELECT
	B.bookID,
	M.title
From Media M, Book B
Where M.mediaID = B.Media_mediaID;

/*
DELETE FROM Media
WHERE title = '1984';
*/






-- Business Rule 6: Registered users can only check out media.  --

-- Business Rule 7: Registered users can be a child or adult account.  --




-- Business Rule 8: Media is copyrighted by only one author.  --

SELECT
	M.title,
	A.firstName,
    A.lastName
FROM Author A, Media M
Where A.Media_mediaID = M.mediaID AND A.lastName IS NOT NULL;



-- Business Rule 9: Registered users can search for media.  --

-- Business Rule 10: Books and newspapers are published by a publisher.  --

-- Business Rule 11: A librarian can supervise other librarians.  --

-- Business Rule 12: Librarians can block registered users.  --

-- Business Rule 13: A librarian manages the system.  --

-- Business Rule 14: Librarians curate a list of historical media.  --