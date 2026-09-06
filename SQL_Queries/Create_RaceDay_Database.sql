/* =========================================================
   RACEDAY DATABASE
   Programming 2B - Part 1
   ========================================================= */

-- Create database
IF DB_ID('RaceDayDB') IS NULL
BEGIN
    CREATE DATABASE RaceDayDB;
END
GO

/* =========================================================
   1. RACEDAY USERS
   ========================================================= */

CREATE TABLE RaceDayUsers
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,

    FirstName VARCHAR(50) NOT NULL,

    LastName VARCHAR(50) NOT NULL,

    Email VARCHAR(100) NOT NULL UNIQUE,

    PasswordHash VARCHAR(255) NOT NULL,

    Role VARCHAR(20) NOT NULL
        DEFAULT 'Participant',

    PhoneNumber VARCHAR(20) NULL,

    CreatedAt DATETIME NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT CK_RaceDayUsers_Role
        CHECK (Role IN ('Organiser', 'Participant'))
);
GO



/* =========================================================
   2. EVENTS
   ========================================================= */

CREATE TABLE Events
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,

    OrganiserID INT NOT NULL,

    EventName VARCHAR(100) NOT NULL,

    Description VARCHAR(500) NULL,

    EventDate DATETIME NOT NULL,

    Location VARCHAR(150) NOT NULL,

    RegistrationDeadline DATETIME NOT NULL,

    Status VARCHAR(20) NOT NULL
        DEFAULT 'Open',

    CreatedAt DATETIME NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT FK_Events_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES RaceDayUsers(UserID),

    CONSTRAINT CK_Events_Status
        CHECK (Status IN ('Open', 'Upcoming', 'Closed', 'Cancelled'))
);
GO



/* =========================================================
   3. CATEGORIES
   ========================================================= */

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    CategoryName VARCHAR(100) NOT NULL,

    DistanceKM DECIMAL(5,2) NOT NULL,

    EntryFee DECIMAL(10,2) NOT NULL,

    AgeGroup VARCHAR(50) NULL,

    Description VARCHAR(300) NULL,

    CONSTRAINT FK_Categories_Event
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID)
        ON DELETE CASCADE
);
GO



/* =========================================================
   4. ENROLMENTS
   ========================================================= */

CREATE TABLE Enrolments
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    CategoryID INT NOT NULL,

    ParticipantID INT NOT NULL,

    EnrolmentDate DATETIME NOT NULL
        DEFAULT GETDATE(),

    RaceNumber VARCHAR(20) NOT NULL UNIQUE,

    PaymentStatus VARCHAR(20) NOT NULL
        DEFAULT 'Pending',

    CONSTRAINT FK_Enrolments_Event
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID),

    CONSTRAINT FK_Enrolments_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID),

    CONSTRAINT FK_Enrolments_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES RaceDayUsers(UserID),

    CONSTRAINT CK_Enrolments_PaymentStatus
        CHECK (PaymentStatus IN ('Pending', 'Paid', 'Cancelled'))
);
GO




/* =========================================================
   5. RESULTS
   ========================================================= */

CREATE TABLE Results
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,

    EnrolmentID INT NOT NULL UNIQUE,

    FinishTime TIME(7) NULL,

    ChipTime TIME(7) NULL,

    PositionOverall INT NULL,

    PositionCategory INT NULL,

    Pace DECIMAL(5,2) NULL,

    Status VARCHAR(20) NOT NULL
        DEFAULT 'Finished',

    CONSTRAINT FK_Results_Enrolment
        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolments(EnrolmentID),

    CONSTRAINT CK_Results_Status
        CHECK (Status IN ('Finished', 'Did Not Finish', 'Disqualified'))
);
GO


/* =========================================================
   6. ROUTES
   ========================================================= */

CREATE TABLE Routes
(
    RouteID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    RouteName VARCHAR(100) NOT NULL,

    DistanceKM DECIMAL(5,2) NOT NULL,

    Description VARCHAR(500) NULL,

    MapURL VARCHAR(500) NULL,

    CONSTRAINT FK_Routes_Event
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID)
        ON DELETE CASCADE
);
GO




/* =========================================================
   7. WEATHER
   ========================================================= */

CREATE TABLE Weather
(
    WeatherID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    RecordedAt DATETIME NOT NULL
        DEFAULT GETDATE(),

    Temperature DECIMAL(5,2) NULL,

    Humidity DECIMAL(5,2) NULL,

    WindSpeed DECIMAL(5,2) NULL,

    WeatherCondition VARCHAR(100) NULL,

    CONSTRAINT FK_Weather_Event
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID)
        ON DELETE CASCADE
);
GO



/* =========================================================
   SAMPLE DATA
   ========================================================= */


/* USERS */

INSERT INTO RaceDayUsers
    (FirstName, LastName, Email, PasswordHash, Role, PhoneNumber)
VALUES
    ('Sipho', 'Mokoena', 'sipho@raceday.co.za',
     'hashed_password_001', 'Organiser', '0821112233'),

    ('Lerato', 'Naidoo', 'lerato@raceday.co.za',
     'hashed_password_002', 'Organiser', '0832223344'),

    ('Thabo', 'Mthembu', 'thabo@gmail.com',
     'hashed_password_003', 'Participant', '0843334455'),

    ('Amahle', 'Dlamini', 'amahle@gmail.com',
     'hashed_password_004', 'Participant', '0854445566'),

    ('Jason', 'Williams', 'jason@gmail.com',
     'hashed_password_005', 'Participant', '0865556677');
GO



/* EVENTS */

INSERT INTO Events
    (OrganiserID, EventName, Description, EventDate,
     Location, RegistrationDeadline, Status)
VALUES
    (
        1,
        'Johannesburg City Run',
        'Annual road running event in Johannesburg.',
        '2026-10-10',
        'Johannesburg, Gauteng',
        '2026-10-01',
        'Open'
    ),

    (
        2,
        'Durban Coastal Cycle',
        'Coastal cycling event along the Durban route.',
        '2026-11-07',
        'Durban, KwaZulu-Natal',
        '2026-10-28',
        'Open'
    ),

    (
        1,
        'Cape Town Community Run',
        'Community running event for local participants.',
        '2026-12-05',
        'Cape Town, Western Cape',
        '2026-11-25',
        'Upcoming'
    );
GO



/* CATEGORIES */

INSERT INTO Categories
    (EventID, CategoryName, DistanceKM, EntryFee, AgeGroup, Description)
VALUES
    (1, '5KM Fun Run', 5.00, 80.00, '16+', 'Short community fun run.'),

    (1, '10KM Run', 10.00, 120.00, '18+', 'Competitive 10 kilometre race.'),

    (2, '40KM Cycle', 40.00, 250.00, '18+', 'Coastal cycling category.'),

    (2, '80KM Cycle', 80.00, 400.00, '18+', 'Long-distance cycling category.'),

    (3, '5KM Community Run', 5.00, 70.00, '16+', 'Community 5 kilometre run.'),

    (3, '10KM Community Run', 10.00, 110.00, '18+', 'Community 10 kilometre run.');
GO



/* ENROLMENTS */

INSERT INTO Enrolments
    (EventID, CategoryID, ParticipantID,
     EnrolmentDate, RaceNumber, PaymentStatus)
VALUES
    (1, 1, 3, '2026-08-01', 'JR001', 'Paid'),

    (1, 2, 4, '2026-08-03', 'JR002', 'Paid'),

    (2, 3, 5, '2026-08-05', 'DC001', 'Paid'),

    (3, 5, 3, '2026-08-10', 'CR001', 'Pending');
GO


/* RESULTS */

INSERT INTO Results
    (EnrolmentID, FinishTime, ChipTime,
     PositionOverall, PositionCategory, Pace, Status)
VALUES
    (1, '00:31:25', '00:31:10', 25, 8, 6.28, 'Finished'),

    (2, '00:52:40', '00:52:15', 12, 5, 5.23, 'Finished'),

    (3, '01:45:20', '01:44:50', 18, 7, 2.62, 'Finished');
GO


/* ROUTES */

INSERT INTO Routes
    (EventID, RouteName, DistanceKM, Description, MapURL)
VALUES
    (
        1,
        'Johannesburg City 5KM Route',
        5.00,
        'Urban route through central Johannesburg.',
        'https://example.com/routes/jhb-5km'
    ),

    (
        1,
        'Johannesburg City 10KM Route',
        10.00,
        'Extended urban running route.',
        'https://example.com/routes/jhb-10km'
    ),

    (
        2,
        'Durban Coastal 40KM Route',
        40.00,
        'Coastal cycling route around Durban.',
        'https://example.com/routes/durban-40km'
    ),

    (
        3,
        'Cape Town Community 5KM Route',
        5.00,
        'Community route through Cape Town.',
        'https://example.com/routes/cape-town-5km'
    );
GO


/* WEATHER */

INSERT INTO Weather
    (EventID, RecordedAt, Temperature,
     Humidity, WindSpeed, WeatherCondition)
VALUES
    (1, '2026-10-10 07:00:00', 18.50, 62.00, 12.00, 'Clear'),

    (2, '2026-11-07 07:00:00', 21.00, 70.00, 15.00, 'Partly Cloudy'),

    (3, '2026-12-05 07:00:00', 20.50, 65.00, 10.00, 'Sunny');
GO




/* =========================================================
   TEST QUERIES
   ========================================================= */

SELECT * FROM RaceDayUsers;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM Enrolments;
SELECT * FROM Results;
SELECT * FROM Routes;
SELECT * FROM Weather;
GO



/* =========================================================
   JOIN QUERY
   ========================================================= */

SELECT
    e.EventName,
    c.CategoryName,
    u.FirstName + ' ' + u.LastName AS ParticipantName,
    en.RaceNumber,
    en.PaymentStatus
FROM Enrolments en
INNER JOIN Events e
    ON en.EventID = e.EventID
INNER JOIN Categories c
    ON en.CategoryID = c.CategoryID
INNER JOIN RaceDayUsers u
    ON en.ParticipantID = u.UserID;
GO