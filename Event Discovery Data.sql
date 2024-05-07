-- Table to store user accounts
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Role ENUM('admin', 'user') DEFAULT 'user',
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    PhoneNumber VARCHAR(20),
    ProfilePicture VARCHAR(255),
    LastLoginTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to store user profile information
CREATE TABLE UserProfile (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Location VARCHAR(50),
    Bio TEXT,
    YearOfCollege ENUM('freshman', 'sophomore', 'junior', 'senior'),
    Interests TEXT,
    MajorOrFieldOfStudy VARCHAR(100),
    SocialMediaLinks TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Table to store notifications for users
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Message TEXT NOT NULL,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Table to store events
CREATE TABLE Events (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    StartTime DATETIME,
    EndTime DATETIME,
    Location VARCHAR(255),
    Organizer VARCHAR(100),
    Capacity INT,
    Tags TEXT,
    RegistrationDeadline DATETIME,
    EventType VARCHAR(50)
);

-- Table to store user-event relationships (for signed-up events)
CREATE TABLE UserEvents (
    UserID INT,
    EventID INT,
    PRIMARY KEY (UserID, EventID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE
);

-- Table to store user activities
CREATE TABLE UserActivityLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ActivityType VARCHAR(100),
    ActivityTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Table to store event registrations
CREATE TABLE EventRegistrations (
    RegistrationID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    EventID INT,
    RegistrationTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE
);

-- Table to store feedback
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    EventID INT,
    FeedbackText TEXT,
    FeedbackTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE
);

-- Table to store errors
CREATE TABLE ErrorLog (
    ErrorID INT PRIMARY KEY AUTO_INCREMENT,
    ErrorMessage TEXT,
    ErrorTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to track event attendance
CREATE TABLE EventAttendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    EventID INT,
    AttendanceTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE
);
