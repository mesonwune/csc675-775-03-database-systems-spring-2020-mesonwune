use LibrarySystemFinal;


INSERT INTO User
(userID, firstName,lastName,DOB)
VALUES
(1,'Mary','Johnson','1989-11-15'), # adult librarian
(2,'Alfred','Kang','1976-04-29'), #registered adult 
(3,'Link','Kang','2013-01-31'), #registered child (alfred is parent)
(4,'Sharolyn','Fimbres','1970-12-02'),# librarian
(5,'Ulysses','Banks','1975-03-04'), #registered adult
(6,'Angelica','Kang','2010-09-07');# child alfred is parent

INSERT INTO Region
(regionID, region_Name)
VALUES
(1, 'North America'), (2, 'South America'), (3, 'Europe');

INSERT INTO Account
(fk_userID,fk_regionID)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1);

INSERT INTO Adult
(adultID,fk_accID)
VALUES
(1,(SELECT accountID FROM Account,User WHERE fk_userID = User.userID AND firstName = 'Alfred')),
(2,(SELECT accountID FROM Account,User WHERE fk_userID = User.userID AND firstName = 'Ulysses'));

INSERT INTO Child
(childID,fk_accID)
VALUES
(1,(SELECT accountID FROM Account,User WHERE fk_userID = User.userID AND firstName = 'Link')),
(2,(SELECT accountID FROM Account,User WHERE fk_userID = User.userID AND firstName = 'Angelica'));

INSERT INTO Librarian
(libID,fk_userID)
VALUES
(1,(SELECT userID FROM User WHERE firstName = 'Mary')),
(2,(SELECT userID FROM User WHERE firstName = 'Sharolyn'));

INSERT INTO Historical_Media
(historID, title)
VALUES
(1,'Leonardo da Vinci: A Life in Drawing'),
(2,'Frida Kahlo: Appearances Can Be Deceiving'),
(3,'Camp: Notes on Fashion');

INSERT INTO Librarian_has_Historical_Media
(Librarian_libID,Librarian_fk_userID,Historical_Media_historID)
VALUES
(1,1,1);

INSERT INTO Superviors
(supervisorID,fk_libID)
VALUES
(1,2);

INSERT INTO Registered
(regID,email,pswd,fees_due,fk_userID)
VALUES
(1,'akang@yaho.com','c00kiesMiruku',DEFAULT,2),
(2,'sanicg@yaho.com','luckymilk74',DEFAULT,3),
(3,'ulybankS@mail.com','cuteL!on11',2.50,5),
(4,'prncesspeech@yaho.com', 'poorpatch90', DEFAULT,6);

INSERT INTO Librarian_blocks_Registered
(Librarian_libID,Librarian_fk_userID,Registered_regID,Registered_userID)
VALUES
(1,1,3,5);


INSERT INTO Media
(mediaID, availability,Title)
VALUES
(1,TRUE, '1984'), #book
(2,TRUE, 'The Cat in the Hat'), #book
(3,True, 'Thriller'), #cd
(4,True, 'Lemonade'), #cd
(5,True, 'The New York Times'), #news
(6,True, 'The Wall Street Journal'), #news
(7,False, 'Romeo and Juliet'), #movie
(8,False, 'Little Women'); #movie

INSERT INTO Registered_has_Media
(Registered_regID,Registered_fk_userID,Media_mediaID)
VALUES
(3,5,8),
(1,2,7);

INSERT INTO Author
(firstName,lastName,Media_mediaID)
VALUES
('George','Orwell',1),
('Louisa May','Alcott',8),
('William','Shakespeare',7),
('Michael','Jackson',3);

INSERT INTO Author
(firstName,Media_mediaID)
VALUES
('Dr. Seuss',2),('Beyonce',4);

INSERT INTO Book
(bookID,Media_mediaID)
VALUES
(1,1),(2,2);
#Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`librarysystem`.`newspaper`, CONSTRAINT `fk_Newspaper_Media1` FOREIGN KEY (`Media_mediaID`) REFERENCES `media` (`mediaID`) ON DELETE CASCADE ON UPDATE CASCADE)

INSERT INTO Newspaper
(newsID,Media_mediaID)
VALUES
(1,5),(2,6);

INSERT INTO CD
(cd_ID,Media_mediaID)
VALUES
(1,3),(2,4);

INSERT INTO Movie
(movieID,Media_mediaID)
VALUES
(1,7),(2,8);

INSERT INTO Publisher
(pubID,pubName,street,city,country)
VALUES
(1,'The Penguin Publishing Group','123 Street Ave.','Berkeley','USA'),
(2,'HarperCollins','456 Basic Lane.','Dubai','UAE'),
(3,'Penguin Random House','1400 Niccolett Ave.','Minneapolis','USA');

INSERT INTO Media_Published
(Book_bookID,fk_pubID)
VALUES
(1,1),
(2,2);

Select * From Media_Published;

INSERT INTO Media_Published
(Newspaper_newsID,fk_pubID)
VALUES
(1,2),
(2,3);















