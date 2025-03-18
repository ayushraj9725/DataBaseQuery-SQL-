
USE  airbnb_vacation_rental_system ;

show tables ;
CREATE TABLE Booking (
   bookingId INT PRIMARY KEY NOT NULL auto_increment ,
   guestId INT NOT NULL ,
   listingId INT NOT NULL ,
   checkInDate DATE ,
   checkOutDate DATE ,
   guestCount INT,
   totalPrice DECIMAL(10,2) ,
   currency VARCHAR(3) ,
   status ENUM('pending', 'confirmed' , 'completed' ,' cancelled ') ,
   createdAt TIMESTAMP ,
   updatedAt TIMESTAMP ,
   FOREIGN KEY (guestId) REFERENCES Users(UserId) ,
   FOREIGN KEY (listingId) REFERENCES Listing(listingId) 
);

-- creating the table of Reviews and rating 

CREATE TABLE Reviews (
    reviewId INT PRIMARY KEY NOT NULL auto_increment ,
    listingId INT NOT NULL ,
    userId INT NOT NULL ,
    rating INT ,
    comment TEXT ,
    reviewDate DATE ,
    FOREIGN KEY (listingId) REFERENCES listing(listingId) ,
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

-- now creating the messages Tables 

CREATE TABLE Messages (
    messageId INT PRIMARY KEY NOT NULL auto_increment ,
    senderId INT NOT NULL ,
    receiverId INT NOT NULL ,
    content TEXT ,
    timestamp TIMESTAMP ,
    FOREIGN KEY (senderId) REFERENCES Users(userId) ,
    FOREIGN KEY (receiverID) REFERENCES Users(userId)
);

-- writing query for creating the table of Payments 

CREATE TABLE Payments (
    paymentId INT PRIMARY KEY NOT NULL auto_increment,
    bookingId INT NOT NULL ,
    amount DECIMAL(10,2) ,
    currency VARCHAR(3) ,
    paymentMethod VARCHAR(255) ,
    paymentStatus ENUM('processed' , 'pending' , 'failed') ,
    transactionDate TIMESTAMP ,
    FOREIGN KEY (bookingId) REFERENCES booking(bookingId)
);

ALTER TABLE users MODIFY userType ENUM('Host', 'Guest', 'Both') NOT NULL;

INSERT INTO Users (name, email, contactNumber, bio, userType, Language, passwordHash) 
VALUES 
('Alice Johnson', 'alice@example.com', '1234567890', 'Loves traveling and hosting guests.', 'Host', 'English', 'hashed_password_1'),
('Bob Smith', 'bob@example.com', '9876543210', 'Enjoys meeting new people.', 'Guest', 'French', 'hashed_password_2'),
('Charlie Brown', 'charlie@example.com', '1122334455', 'Frequent traveler and host.', 'Both', 'Spanish', 'hashed_password_3');

ALTER TABLE listing MODIFY AccommodationType ENUM('Room' , 'House', 'Unique Stay') NOT NULL;

-- Inserting the row Sample date into the Listing table to execute the query 

INSERT INTO listing (hostId, title, Description, location, city, geocoordinates, AccommodationType, Amenities, availability, basePricePerNight, currency, maxGuests, imageGallery) 
VALUES 
(1, 'Cozy Beach House', 'A beautiful beachfront house with amazing sunset views.', 'Miami Beach, FL', 'Miami', '25.7617° N, 80.1918° W', 'House', 
 '["WiFi", "Air Conditioning", "Parking", "Pool"]', 
 '{"availableDates": ["2024-06-10", "2024-06-15", "2024-06-20"]}', 120.00, 'USD', 4, 
 '["img1.jpg", "img2.jpg", "img3.jpg"]'),

(1, 'Luxury Apartment', 'A modern apartment in the heart of New York City.', 'Manhattan, NY', 'New York', '40.7128° N, 74.0060° W', 'Room', 
 '["WiFi", "Gym", "Balcony"]', 
 '{"availableDates": ["2024-06-05", "2024-06-12", "2024-06-18"]}', 250.00, 'USD', 2, 
 '["img4.jpg", "img5.jpg", "img6.jpg"]'),

(3, 'Rustic Cabin in the Woods', 'Escape the city and enjoy nature in this cozy cabin.', 'Lake Tahoe, CA', 'Tahoe', '39.0968° N, 120.0324° W', 'Unique Stay', 
 '["Fireplace", "Hiking Trails", "BBQ Grill"]', 
 '{"availableDates": ["2024-07-01", "2024-07-10", "2024-07-15"]}', 180.00, 'USD', 6, 
 '["img7.jpg", "img8.jpg", "img9.jpg"]');


-- Inserting the row Sample date into the Booking table to execute the query 

INSERT INTO booking (guestId, listingId, checkInDate, checkOutDate, guestCount, totalPrice, currency, status, createdAt, updatedAt) 
VALUES 
(2, 1, '2024-06-10', '2024-06-15', 2, 600.00, 'USD', 'confirmed', NOW(), NOW()),
(2, 2, '2024-06-18', '2024-06-20', 1, 500.00, 'USD', 'pending', NOW(), NOW()),
(3, 3, '2024-07-01', '2024-07-07', 4, 1080.00, 'USD', 'completed', NOW(), NOW());

-- Instering the sample data into Reviews table for testing purpose of the database based on CRUD operation , so that we can  writing and then execute the sql query

INSERT INTO Reviews (listingId, userId, rating, comment, reviewDate) 
VALUES 
(1, 2, 5, 'Amazing place, very clean and comfortable!', '2024-06-15'),
(2, 3, 4, 'Great location, but the room was a bit small.', '2024-06-18'),
(3, 2, 5, 'The cabin was beautiful, perfect for a weekend getaway!', '2024-07-02');

-- Inserting the row data into the messages table 

INSERT INTO Messages (senderId, receiverId, content, timestamp) 
VALUES 
(2, 1, 'Hello! Is your beach house available for next weekend?', NOW()),
(1, 2, 'Yes, it is available! Let me know if you want to book it.', NOW()),
(3, 1, 'Can I bring pets to the cabin?', NOW());

-- Inserting the row data into the payment 

INSERT INTO Payments (bookingId, amount, currency, paymentMethod, paymentStatus, transactionDate) 
VALUES 
(1, 600.00, 'USD', 'Credit Card', 'processed', NOW()),
(2, 500.00, 'USD', 'PayPal', 'pending', NOW()),
(3, 1080.00, 'USD', 'Bank Transfer', 'failed', NOW());


-- NOW WE ARE READY TO execute THE SQL QUERY !

-- EXTRACT THE DATA FROM THE ALL TABLE SHOW ONCE 

select * from users ;
select * from listing ;
select * from booking ;
select * from reviews ;
select * from messages ;
select * from payments ;

# Q : Write a SQL query to know the details of listing ownd by Alice Johnson .... ?

select * from listing join users on listing.hostId = Users.userId where users.name = 'Alice Johnson' ;

-- Alternative Query to know users info basic and his/her Listing 

SELECT listing.listingId, listing.title, listing.city, users.name, users.email , listing.location
FROM listing 
JOIN users ON listing.hostId = users.userId 
WHERE users.userId = 1;







