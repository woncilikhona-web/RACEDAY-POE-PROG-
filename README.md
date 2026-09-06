# RaceDay – Event Management System

## Project Overview

RaceDay is an event management system designed for the South African running, walking and cycling community. The system allows organisers to create and manage sporting events, categories, routes, participants and race results.

Participants can browse available events, view categories, enrol in events and access their race results. The system also provides route and weather information to assist participants when preparing for events.

This project forms part of the **PROG6212 Programming 2B Portfolio of Evidence (PoE) – Part 1**.

---

## System Features

The main features of RaceDay include:

* User registration and authentication
* Organiser and participant roles
* Event creation and management
* Event category management
* Participant enrolments
* Race result management
* Event route information
* Weather information
* Relational database management
* API-based system communication

---

## Database

RaceDay uses **Microsoft SQL Server** as its database management system.

The database consists of seven main entities:

* `RaceDayUsers`
* `Events`
* `Categories`
* `Enrolments`
* `Results`
* `Routes`
* `Weather`

Primary keys and foreign keys are used to maintain relationships between the entities. The `Enrolments` table acts as an associative entity between participants and events.

The SQL script is located in:

```text
SQL_Queries/01_Create_RaceDay_Database.sql
```

---

## API

The RaceDay API provides endpoints for:

* Authentication
* User profiles
* Events
* Categories
* Enrolments
* Results
* Routes
* Weather

The API uses standard HTTP methods such as `GET`, `POST`, `PUT` and `DELETE`.

The API Endpoint Plan is located in:

```text
API/API_Endpoint_Plan.md
```

---

## ERD

The Entity Relationship Diagram represents the database structure and shows the relationships between the RaceDay entities.

The main relationships include:

```text
RaceDayUsers → Events
RaceDayUsers → Enrolments
Events → Categories
Events → Enrolments
Categories → Enrolments
Enrolments → Results
Events → Routes
Events → Weather
```

The ERD is located in:

```text
ERD/RaceDay_ERD.png
```

---

## User Roles

### Organiser

Organisers can create and manage events, categories, routes, weather information and race results.

### Participant

Participants can browse events, enrol in categories, manage their profiles and view their race results.

---

## Technologies Used

* C#
* ASP.NET Core
* Microsoft SQL Server
* Entity Framework Core
* Visual Studio
* Git
* GitHub
* GitHub Actions

---

## Project Structure

```text
RaceDay_PoE_Part1
│
├── ERD
│   └── RaceDay_ERD.png
│
├── API
│   └── API_Endpoint_Plan.md
│
├── SQL_Queries
│   └── 01_Create_RaceDay_Database.sql
│
├── Screenshots
│   └── Database screenshots
│
└── README.md
```

---

## Testing

The SQL database was tested by creating the required tables, inserting sample data and executing SELECT and JOIN queries.

Testing verifies that the database tables and relationships are functioning correctly.

---



---

## Conclusion

RaceDay Part 1 establishes the foundation for the development of the event management system. The ERD defines the database structure, the API Endpoint Plan describes the planned system functionality, and the SQL implementation provides the required database tables, relationships and sample data.

