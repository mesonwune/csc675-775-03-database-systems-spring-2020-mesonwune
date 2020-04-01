use LibrarySystem;

INSERT INTO `LibrarySystem`.`User`
(`userID`,
`firstName`,
`lastName`,
`DOB`)
VALUES
(1,'Mary','Johnson','1989-11-15'),
(2,'Alfred','Kang','1976-04-29'),
(3,'Link','Lupo','2013-01-31'),
(4,'Sharolyn','Fimbres','1970-12-02'),
(5,'Ulysses','Banks','1975-03-04'),
(6,'Mohammed','Square','2010-09-07'),
(7,'Emmie','Lupo','1987-02-25'),
(8,'Vikki','Zylstra','2011-04-21'),
(9,'Angelica','Millhouse','1996-02-27'),
(10, 'Vikki', 'Garcia', '1987-09-21');

INSERT INTO `LibrarySystem`.`Region`
(`regionID`, `region_Name`)
VALUES
(1, 'North America'), (2, 'South America'), (3, 'Europe');

INSERT INTO `LibrarySystem`.`Account`
(`accountID`,
`fk_userID`,
`fk_regionID`)
VALUES
(1, 1, 2),(2, 3, 2),(3, 2, 3),
(4, 6, 1),(5, 9, 3),(6, 8, 2),
(7, 5, 3),(8, 4, 1),(9, 7, 1);

INSERT INTO `LibrarySystem`.`Adult`
(`adultID`,
`fk_accID`)
VALUES
(1,1),
(2,3),
(3,8),
(4,9),
(5,5),
(6,7);

INSERT INTO `LibrarySystem`.`Child`
(`childID`,
`fk_accID`)
VALUES
(1,2),
(2,4),
(3,6);

INSERT INTO `LibrarySystem`.`Librarian`
(`libID`,
`fk_userID`)
VALUES
(1,1), (2,5), (3,4);

INSERT INTO `LibrarySystem`.`Historical_Media`
(`title`)
VALUES
('Leonardo da Vinci: A Life in Drawing'),
('Frida Kahlo: Appearances Can Be Deceiving'),
('Camp: Notes on Fashion');

INSERT INTO `LibrarySystem`.`Librarian_has_Historical_Media`
(`Librarian_libID`,
`Librarian_fk_userID`,
`Historical_Media_historID`)
VALUES
(1,1,1),
(2,5,2),
(3,4,2);

INSERT INTO `LibrarySystem`.`Superviors`
(`supervisorID`,
`fk_libID`)
VALUES
(1,1),
(2, 2),
(3,3);

INSERT INTO `LibrarySystem`.`Librarian_blocks_Registered`
(`Librarian_libID`,
`Librarian_fk_userID`,
`Registered_regID`,
`Registered_userID`)
VALUES
(1,1,2,7);

INSERT INTO `LibrarySystem`.`Registered`
(`regID`,
`email`,
`fees_due`,
`fk_userID`)
VALUES
(1,'lbanks@yaho.com',DEFAULT,3),
(2,'elupo33@mail.com',2.50,7),
(3,'vzylstra@ao.com',DEFAULT,8);

INSERT INTO `LibrarySystem`.`Unregistered`
(`unregID`,
`fk_userID`)
VALUES
(1,2),
(2,6),
(3,9);

INSERT INTO `LibrarySystem`.`Media`
(`availability`,
`Title`)
VALUES
(TRUE, '1984'),
(TRUE, 'The Little Prince'),
(TRUE, 'The Help'),
(TRUE, 'The Cat in the Hat'),
(TRUE, 'Life of Pi'),
(True, 'Thriller'),
(True, 'Smyle'),
(True, 'Lemonade'),
(True, 'USA Today'),
(True, 'The New York Times'),
(True, 'The Wall Street Journal'),
(FALSE,'To Kill a Mockingbird'),
(False, 'Romeo and Juliet'),
(False, 'Little Women');

INSERT INTO `LibrarySystem`.`Author`
(`firstName`,
`lastName`,
`Media_mediaID`)
VALUES
('George','Orwell',15),
('Louisa May','Alcott',31),
('William','Shakespeare',30),
('Michael','Jackson',20);

INSERT INTO `LibrarySystem`.`Author`
(`firstName`,
`Media_mediaID`)
VALUES
('Dr. Seuss',18),
('Beyonce',22),
('Kyle',21);

INSERT INTO `LibrarySystem`.`Book`
(`Media_mediaID`)
VALUES
(15),
(18),
(31),
(30);

INSERT INTO `LibrarySystem`.`Newspaper`
(
`Media_mediaID`)
VALUES
(24),
(23),
(25);

INSERT INTO `LibrarySystem`.`CD`
(`Media_mediaID`)
VALUES
(20),
(22),
(21);

INSERT INTO `LibrarySystem`.`Movie`
(`Media_mediaID`)
VALUES
(16),
(17),
(19),
(29);

INSERT INTO `LibrarySystem`.`Publisher`
(
`street`,
`city`,
`country`)
VALUES
('123 Street Ave.','Berkeley','USA'),
('456 Basic Lane.','Dubai','UAE'),
('1400 Niccolett Ave.','Minneapolis','USA');

INSERT INTO `LibrarySystem`.`Media_Published`
(`Book_bookID`,
`fk_pubID`)
VALUES
(1,1),
(4,3),
(3,2),
(2,2);

INSERT INTO `LibrarySystem`.`Media_Published`
(`Newspaper_newsID`,
`fk_pubID`)
VALUES
(3,1),
(2,3),
(1,2);















