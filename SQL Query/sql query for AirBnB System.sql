
USE  airbnb_vacation_rental_system ;

show tables ;
CREATE TABLE users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    contactNumber VARCHAR(20) NOT NULL,
    bio TEXT NOT NULL,
    userType ENUM('Host', 'Guest', 'Both') NOT NULL,
    Language VARCHAR(255) NOT NULL,
    passwordHash VARCHAR(255) NOT NULL
);

CREATE TABLE listing (
    listingId INT AUTO_INCREMENT PRIMARY KEY,
    hostId INT NOT NULL,
    title VARCHAR(255),
    description TEXT,
    location VARCHAR(255),
    city VARCHAR(255),
    geocoordinates VARCHAR(255),
    AccommodationType ENUM('Room', 'House', 'Unique Stay'),
    Amenities TEXT,
    availability JSON,
    basePricePerNight DECIMAL(10,2),
    currency VARCHAR(3),
    maxGuests INT NOT NULL,
    imageGallery TEXT,
    FOREIGN KEY (hostId) REFERENCES users(userId) ON DELETE CASCADE
);

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

-- Inserting more sample data and value .**************************************************************************************************************

-- Inserting Sample Data into `users` Table
INSERT INTO users (name, email, contactNumber, bio, userType, Language, passwordHash)
VALUES
('Rajesh Kumar', 'rajesh.kumar@example.com', '9876543210', 'Tech enthusiast and host', 'Host', 'Hindi', 'hashed_pass_1'),
('Priya Sharma', 'priya.sharma@example.com', '9876101112', 'Traveler who loves exploring', 'Guest', 'English', 'hashed_pass_2'),
('Amit Verma', 'amit.verma@example.com', '9786543210', 'Works in IT and hosts on weekends', 'Both', 'Hindi, English', 'hashed_pass_3'),
('Neha Gupta', 'neha.gupta@example.com', '9654321890', 'Loves meeting new people', 'Host', 'English', 'hashed_pass_4'),
('Aniket Joshi', 'aniket.joshi@example.com', '9345678901', 'Passionate about travel', 'Guest', 'Marathi', 'hashed_pass_5');

-- Inserting Sample Data into `listing` Table
INSERT INTO listing (hostId, title, Description, location, city, geocoordinates, AccommodationType, Amenities, availability, basePricePerNight, currency, maxGuests, imageGallery)
VALUES
(2, 'Beachfront Villa', 'Beautiful villa facing the beach', 'Juhu Beach, Mumbai', 'Mumbai', '19.0760° N, 72.8777° E', 'House',
 '["WiFi", "Air Conditioning", "Swimming Pool"]',
 '{"availableDates": ["2024-07-10", "2024-07-15"]}', 4500.00, 'INR', 6,
 '["beach_villa1.jpg", "beach_villa2.jpg"]'),

(2, 'Luxury Apartment', 'Fully furnished apartment in central Bangalore', 'MG Road, Bangalore', 'Bangalore', '12.9716° N, 77.5946° E', 'Room',
 '["WiFi", "Kitchen", "Balcony"]',
 '{"availableDates": ["2024-08-01", "2024-08-10"]}', 3500.00, 'INR', 4,
 '["luxury_apt1.jpg", "luxury_apt2.jpg"]'),

(6, 'Hilltop Cottage', 'A peaceful cottage in the hills of Manali', 'Old Manali', 'Manali', '32.2396° N, 77.1887° E', 'Unique Stay',
 '["Fireplace", "Mountain View", "Garden"]',
 '{"availableDates": ["2024-06-20", "2024-06-30"]}', 2500.00, 'INR', 5,
 '["hilltop_cottage1.jpg", "hilltop_cottage2.jpg"]');

-- Inserting Sample Data into `booking` Table
INSERT INTO booking (guestId, listingId, checkInDate, checkOutDate, guestCount, totalPrice, currency, status, createdAt, updatedAt)
VALUES
(2, 3, '2024-07-10', '2024-07-15', 2, 22500.00, 'INR', 'confirmed', NOW(), NOW()),
(3, 2, '2024-08-02', '2024-08-08', 3, 21000.00, 'INR', 'pending', NOW(), NOW()),
(4, 6, '2024-06-21', '2024-06-26', 4, 12500.00, 'INR', 'completed', NOW(), NOW());

-- Inserting Sample Data into `reviews` Table
INSERT INTO Reviews (listingId, userId, rating, comment, reviewDate)
VALUES
(2, 2, 5, 'Amazing experience! The beach villa was stunning.', '2024-07-16'),
(6, 3, 4, 'Very clean and centrally located, but noisy at night.', '2024-08-09'),
(3, 4, 5, 'Loved the mountain view, will visit again!', '2024-06-28');

-- Inserting Sample Data into `messages` Table
INSERT INTO Messages (senderId, receiverId, content, timestamp)
VALUES
(3, 4, 'Hi, is the beachfront villa available for next weekend?', NOW()),
(5, 2, 'Yes, it is available. Would you like to proceed with booking?', NOW()),
(6, 1, 'Is early check-in possible for the luxury apartment?', NOW());

-- Inserting Sample Data into `payments` Table
INSERT INTO Payments (bookingId, amount, currency, paymentMethod, paymentStatus, transactionDate)
VALUES
(4, 22500.00, 'INR', 'Credit Card', 'processed', NOW()),
(5, 21000.00, 'INR', 'UPI', 'pending', NOW()),
(3, 12500.00, 'INR', 'Net Banking', 'failed', NOW());

-- /*********************************************************** MORE RANDOM SAMPLE DATA *******************************************************************/
INSERT INTO listing (hostId, title, Description, location, city, geocoordinates, AccommodationType, Amenities, availability, basePricePerNight, currency, maxGuests, imageGallery)
VALUES
(4, 'Budget Apartment', 'Affordable stay with all basic amenities.', 'Connaught Place, Delhi', 'Delhi', '28.6340° N, 77.2197° E', 'Room',
 '["WiFi", "Air Conditioning"]',
 '{"availableDates": ["2024-07-01", "2024-07-10"]}', 1500.00, 'INR', 2,
 '["budget_apartment1.jpg", "budget_apartment2.jpg"]'),

(5, 'Luxury Suite', 'Premium suite with top-class amenities.', 'South Extension, Delhi', 'Delhi', '28.5584° N, 77.2303° E', 'House',
 '["WiFi", "Swimming Pool", "Gym", "Air Conditioning"]',
 '{"availableDates": ["2024-08-01", "2024-08-15"]}', 4500.00, 'INR', 4,
 '["luxury_suite1.jpg", "luxury_suite2.jpg"]'),

(6, 'Premium Bungalow', 'Spacious bungalow for families and groups.', 'Hauz Khas, Delhi', 'Delhi', '28.5509° N, 77.1944° E', 'Unique Stay',
 '["WiFi", "Garden", "Fireplace", "Private Parking"]',
 '{"availableDates": ["2024-06-15", "2024-06-30"]}', 7000.00, 'INR', 6,
 '["premium_bungalow1.jpg", "premium_bungalow2.jpg"]');

-- NOW WE ARE READY TO execute THE SQL QUERY !

-- EXTRACT THE DATA FROM THE ALL TABLE SHOW ONCE 

select * from users ;
select * from listing ;
select * from booking ;
select * from reviews ;
select * from messages ;
select * from payments ;

# WRTING THE SQL QUERY FOR SOLUTION OF PROBLEM 

# 🛠 User Queries 
  -- 1. Retrieve all users who are hosts.
  
  SELECT u.userId , u.name , u.contactNumber FROM users AS u
  JOIN listing AS l ON u.userId = l.hostId ;
  
  -- 2. Find the total number of users from Mumbai.
  
  SELECT count(*) AS no_of_user FROM users AS u
  JOIN listing l ON u.userId = l.hostId WHERE city = 'Mumbai' ;
  
  -- 3. Fetch the user details of the most recent booking.
  
  SELECT * FROM Users u
  JOIN booking b ON b.guestId = u.userId 
  ORDER BY b.createdAt DESC LIMIT 1 ;
  
# 🏠 Listing Queries
  -- 4. Retrieve all listings available in Bangalore.
  
  SELECT * FROM listing WHERE city = 'Bangalore' ;
  
  -- PROBLME WRITE SOLUTION FOR TELL ME ALL THE LISTING IN BANGALORE WITH LISTING ID 
  SELECT listingId , COUNT(*) AS no_of_listing FROM listing WHERE city = 'Bangalore' GROUP BY listingId ;
  
  -- 5. Find the total number of listings per city.
  
  SELECT  city , COUNT(*)  AS total_no_of_listing FROM listing GROUP BY city ;
  
  -- 6. Get the cheapest listing in Delhi.
  
  SELECT * FROM listing WHERE city = 'Delhi' ORDER BY basePricePerNight ASC limit 1 ;
  
  -- 7. Find all listings with a swimming pool.
  
  SELECT * FROM listing WHERE Amenities LIKE '%Swimming Pool%';
  
# 📆 Booking Queries
  -- 8. Retrieve all confirmed bookings.
  
  
  -- 9. Find total revenue generated from bookings.
  
  
  -- 10. Get all bookings made in the last 30 days.
  
  
  -- 11. Find the most booked listing.
  
#⭐ Review Queries
  -- 12. Retrieve all reviews for the Beachfront Villa.
  
  
  -- 13. Find the average rating of each listing.
  
  
  -- 14. Fetch users who have not left any reviews.
  
  
  -- 15. Get listings with at least 5 reviews.
  
#📩 Messages Queries
  -- 16. Retrieve all messages between user 1 and user 2.
  
  
  -- 17. Find the last message sent by each user.
  
  
  -- 18. Get the total number of messages exchanged per user.
  
  
  -- 19. Find users who have sent messages but never booked.
  
#💳 Payment Queries
  -- 20. Retrieve all successful payments.
  
  
  -- 21. Find the total amount pending in payments.
  
  
  -- 22. Get all payments made via UPI.
  
  
  -- 23. Find the largest transaction made so far.
  
#🛠 Advanced Joins & Aggregation 
  -- 24. Retrieve all bookings with guest details and listing details.
  
  
  -- 25. Find the total revenue generated per host.
  
  
  -- 26. Fetch the top 3 most reviewed listings.
  
  
  -- 27. Retrieve users who have both hosted and booked.
  
   
  -- 28. Find the most frequent guest (who has made the most bookings).
  
  
  -- 29. Retrieve all listings that have never been booked.
  
  
  -- 30. Find the total messages exchanged per city.
  
  

# MEDIUM OR HARD QUERY BY MERGING ALL THE THINGS ( JOINS , AGGERATION FUNCTION AND SUB QUERY )

# Q1 : Write a SQL query to know the details of listing ownd by Alice Johnson .... ?

select * from listing join users on listing.hostId = Users.userId where users.name = 'Alice Johnson' ;

-- Alternative Query to know users info basic and his/her Listing 

SELECT listing.listingId, listing.title, listing.city, users.name, users.email , listing.location
FROM listing 
JOIN users ON listing.hostId = users.userId 
WHERE users.userId = 1;

# Q.2. : write solution to finf the avg rating of all the listing city .

SELECT l.city , AVG(r.rating) AS averageRating
FROM listing l
JOIN reviews r ON l.listingId = r.listingId 
GROUP BY l.city 
ORDER BY averageRating ASC ;

# Q.3 : Identify the guest with the highest total spent money  or
# Determine which guest have spent the most money on booking , including their stays .
# show the guest name , contact number , total spent amount , ordered by total spent in descending order 

SELECT u.name , u.contactNumber, SUM(b.totalPrice) AS spentAmount 
FROM users u 
JOIN booking b ON u.userId = b.bookingId 
GROUP BY u.userId 
ORDER BY spentAmount  DESC;

# Q.4 : Retrieve all listings that have never been booked.

# Q.5 : Average Length of stay by guest in different countries , (length in aspect of time so calculate by your self ( b.checkOutDate - b.checkInDate )

# Q.6 : Occupancy rate for each listing each last month (HARD) 

# Q.7 : new Calender table 

# 
 





