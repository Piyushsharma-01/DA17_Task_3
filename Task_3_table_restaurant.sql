CREATE TABLE Restaurants (
	id serial primary key,
    Name TEXT NOT NULL,
    Address TEXT NOT NULL,
    Contact BIGINT NOT NULL CHECK (LENGTH(Contact::TEXT) = 10),
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Cuisine TEXT[] NOT NULL,
    opTime TIME NOT NULL,
    closingTime TIME NOT NULL
);

select  * from restaurants

INSERT INTO Restaurants (Name, Address, Contact, Rating, Cuisine, opTime, closingTime) 
VALUES ('Spice Hub', '123 Flavor Street, Nagpur', 9876543210, 2, ARRAY['Indian', 'Chinese'], '10:00', '22:00');

INSERT INTO Restaurants (Name, Address, Contact, Rating, Cuisine, opTime, closingTime) 
VALUES ('Pasta Paradise', '456 Olive Lane, Nagpur', 9123456780, 5, ARRAY['Italian'], '11:00', '23:00'),
('Burger Bliss', '789 Burger Blvd, Nagpur', 9988776655, 3, ARRAY['American'], '09:00', '21:00'),
('Taco Tales', '101 Taco Avenue, Nagpur', 9876501234, 4, ARRAY['Mexican'], '12:00', '20:00'),
('Sushi Haven', '202 Sushi Street, Nagpur', 9876512345, 5, ARRAY['Japanese'], '13:00', '23:00'),
('The Curry Bowl', '303 Curry Lane, Nagpur', 8765432190, 4, ARRAY['Indian', 'Thai'], '10:30', '22:30'),
('Grill Master', '404 BBQ Road, Nagpur', 9988665544, 5, ARRAY['Barbecue'], '12:00', '23:00'),
('Veggie Delight', '505 Greenway, Nagpur', 9876523456, 3, ARRAY['Vegan', 'Vegetarian'], '08:00', '20:00'),
('Seafood Shack', '606 Ocean Drive, Nagpur', 9765432101, 4, ARRAY['Seafood'], '11:30', '22:30'),
('Sweet Tooth', '707 Dessert Lane, Nagpur', 9234567890, 5, ARRAY['Desserts'], '10:00', '20:00');

select  * from restaurants

CREATE TABLE Staff (
    Id SERIAL PRIMARY KEY,
    Name TEXT NOT NULL,
    staffType TEXT NOT NULL CHECK (staffType IN ('cheff', 'waiter', 'captain', 'maneger')),
    Contact BIGINT NOT NULL CHECK (LENGTH(Contact::TEXT) = 10),
    Address TEXT NOT NULL,
    BloodGrp TEXT NOT NULL,
    Salary NUMERIC NOT NULL,
    RestaurantId INT NOT NULL REFERENCES Restaurants(Id) ON DELETE CASCADE
);

CREATE TABLE Customer (
    Id SERIAL PRIMARY KEY,
    Name TEXT NOT NULL,
    Contact BIGINT NOT NULL CHECK (LENGTH(Contact::TEXT) = 10),
    Address TEXT NOT NULL,
    Email TEXT UNIQUE NOT NULL,
    RestaurantId INT NOT NULL REFERENCES Restaurants(Id) ON DELETE CASCADE
);

CREATE TABLE Orders (
    Id SERIAL PRIMARY KEY,
    Cust_id INT NOT NULL REFERENCES Customer(Id) ON DELETE CASCADE,
    Chief INT NOT NULL REFERENCES Staff(Id) ON DELETE SET NULL,
    Waiter INT NOT NULL REFERENCES Staff(Id) ON DELETE SET NULL,
    tableNo INT NOT NULL,
    Cusine TEXT NOT NULL,
    Dish TEXT NOT NULL,
    Qty INT NOT NULL,
    RestaurantId INT NOT NULL REFERENCES Restaurants(Id) ON DELETE CASCADE
);

INSERT INTO Customer (Name, Contact, Address, Email, RestaurantId) 
VALUES 
('John Doe', 9876543210, '123 Elm Street, Nagpur', 'john.doe@example.com', 1),
('Jane Smith', 9123456780, '456 Oak Road, Nagpur', 'jane.smith@example.com', 1),
('Michael Johnson', 9988776655, '789 Maple Ave, Nagpur', 'michael.j@example.com', 2),
('Emily Davis', 9876501234, '101 Pine Lane, Nagpur', 'emily.d@example.com', 2),
('Robert Brown', 9876512345, '202 Cedar Street, Nagpur', 'robert.b@example.com', 3),
('Sophia Taylor', 8765432190, '303 Willow Blvd, Nagpur', 'sophia.t@example.com', 3),
('William Moore', 9988665544, '404 Birch Way, Nagpur', 'william.m@example.com', 4),
('Olivia Wilson', 9876523456, '505 Chestnut Drive, Nagpur', 'olivia.w@example.com', 4),
('James Thomas', 9765432101, '606 Aspen Road, Nagpur', 'james.t@example.com', 5),
('Isabella Garcia', 9234567890, '707 Spruce Avenue, Nagpur', 'isabella.g@example.com', 5);

INSERT INTO Staff (Name, staffType, Contact, Address, BloodGrp, Salary, RestaurantId) 
VALUES 
('Chef Alex', 'cheff', 9876543211, 'Kitchen Street, Nagpur', 'O+', 45000, 1),
('Waiter Max', 'waiter', 9123456781, 'Service Lane, Nagpur', 'A+', 25000, 1),
('Captain Lily', 'captain', 9988776656, 'Leadership Blvd, Nagpur', 'B+', 30000, 1),
('Manager Chris', 'maneger', 9876501235, 'Management Avenue, Nagpur', 'AB+', 60000, 1),
('Chef Sarah', 'cheff', 9876512346, 'Cooking Road, Nagpur', 'O-', 46000, 1),

('Chef David', 'cheff', 9876543222, 'Kitchen Street 2, Nagpur', 'O+', 47000, 2),
('Waiter John', 'waiter', 9123456782, 'Service Lane 2, Nagpur', 'A+', 26000, 2),
('Captain Emma', 'captain', 9988776666, 'Leadership Blvd 2, Nagpur', 'B+', 32000, 2),
('Manager Clara', 'maneger', 9876501236, 'Management Avenue 2, Nagpur', 'AB+', 62000, 2),
('Chef Zoe', 'cheff', 9876512347, 'Cooking Road 2, Nagpur', 'O-', 48000, 2),

('Chef Sam', 'cheff', 9876543233, 'Kitchen Street 3, Nagpur', 'O+', 48000, 3),
('Waiter Peter', 'waiter', 9123456783, 'Service Lane 3, Nagpur', 'A+', 27000, 3),
('Captain Mia', 'captain', 9988776677, 'Leadership Blvd 3, Nagpur', 'B+', 34000, 3),
('Manager Edward', 'maneger', 9876501237, 'Management Avenue 3, Nagpur', 'AB+', 64000, 3),
('Chef Lily', 'cheff', 9876512348, 'Cooking Road 3, Nagpur', 'O-', 49000, 3);


INSERT INTO Orders (Cust_id, Chief, Waiter, tableNo, Cusine, Dish, Qty, RestaurantId) 
VALUES 
(1, 1, 2, 10, 'Indian', 'Butter Chicken', 2, 1),
(1, 1, 2, 11, 'Indian', 'Paneer Tikka', 1, 1),
(1, 2, 3, 12, 'Chinese', 'Fried Rice', 3, 1),
(1, 2, 3, 13, 'Chinese', 'Spring Rolls', 2, 1),
(1, 3, 4, 14, 'Italian', 'Pasta', 1, 1),
(1, 3, 4, 15, 'Mexican', 'Tacos', 4, 1),
(1, 4, 5, 16, 'Thai', 'Green Curry', 2, 1),
(1, 4, 5, 17, 'Seafood', 'Grilled Salmon', 3, 1),
(1, 5, 2, 18, 'Dessert', 'Chocolate Cake', 2, 1),
(1, 5, 3, 19, 'Barbecue', 'BBQ Ribs', 1, 1),

(2, 6, 7, 10, 'Italian', 'Pizza', 1, 2),
(2, 6, 7, 11, 'Indian', 'Dal Makhani', 2, 2),
(2, 7, 8, 12, 'Chinese', 'Manchurian', 3, 2),
(2, 7, 8, 13, 'Mexican', 'Nachos', 4, 2),
(2, 8, 9, 14, 'Indian', 'Biryani', 2, 2),
(2, 8, 9, 15, 'Italian', 'Lasagna', 1, 2),
(2, 9, 10, 16, 'Seafood', 'Lobster', 3, 2),
(2, 9, 10, 17, 'Barbecue', 'Grilled Chicken', 2, 2),
(2, 10, 6, 18, 'Dessert', 'Ice Cream', 3, 2),
(2, 10, 7, 19, 'Indian', 'Kofta Curry', 1, 2);


	