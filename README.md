# RaceDay – System Planning and Database

## Section A: Entity Relationship Diagram

The Entity Relationship Diagram (ERD) provides a visual representation of the database structure proposed for the RaceDay Event Management System. The ERD identifies the main entities within the system, their attributes, primary keys, foreign keys and relationships. The database consists of seven main entities, namely **RaceDayUsers, Events, Categories, Enrolments, Results, Routes and Weather**.

The **RaceDayUsers** entity stores information relating to users of the system, including organisers and participants. The **Events** entity stores information about races and other sporting events created by organisers. Each event can contain multiple **Categories**, such as different distances or age groups. Participants register for events through the **Enrolments** entity, which also resolves the many-to-many relationship between participants and events.

The **Results** entity records participant performance information associated with an enrolment, including finish time, chip time, overall position, category position and pace. The **Routes** entity stores information about the routes associated with events, while the **Weather** entity records weather conditions relevant to an event.

Primary keys are used to uniquely identify records within each entity, while foreign keys establish relationships between related entities. For example, `OrganiserID` in the Events entity references `UserID` in RaceDayUsers, while `ParticipantID` in Enrolments also references `UserID`. Similarly, `EventID` connects Events with Categories, Enrolments, Routes and Weather. These relationships ensure referential integrity and allow related information to be retrieved efficiently.

The database therefore supports one-to-many relationships, such as one organiser managing multiple events and one event containing multiple categories. The relationship between participants and events is many-to-many because a participant can enter multiple events and an event can have multiple participants. This relationship is resolved through the Enrolments associative entity. The ERD consequently provides the foundation for the database implementation and ensures that the proposed database structure corresponds with the functional requirements of the RaceDay system.

## Section B: API Endpoint Plan

The API Endpoint Plan defines how the RaceDay system will allow the client application to communicate with the database and application services. The proposed API follows a RESTful approach, where HTTP methods such as GET, POST, PUT and DELETE are used to retrieve, create, update and remove resources.

Authentication and user management endpoints are included to support secure access to the system. Users can register and authenticate using the authentication endpoints, while authenticated users can view and update their profile information. Role-based access is incorporated into the endpoint design to distinguish between the permissions of organisers and participants.

The event management endpoints allow users to retrieve available events, while authorised organisers can create, update and delete events. Category endpoints provide similar functionality for managing the different race categories associated with events. This allows an organiser to define information such as the category name, distance, entry fee and applicable age group.

The enrolment endpoints support participant registration for event categories. Participants can create and view their enrolments, while authorised users can update or cancel enrolments where permitted. The results endpoints allow organisers to record and manage participant results, while authenticated users can access relevant results. Additional endpoints are provided for routes and weather information so that event-related route details and weather conditions can be stored and retrieved.

Each endpoint in the API plan specifies the HTTP method, route, purpose, required user role, request body and expected response. This provides a clear technical plan for the development of the API and ensures that the API structure corresponds with the database entities and system requirements. The use of role-based access also contributes to system security by restricting administrative operations to authorised organisers.

## Section C: Database Implementation

The RaceDay database is implemented using Microsoft SQL Server. The database structure follows the ERD and contains the seven identified entities: **RaceDayUsers, Events, Categories, Enrolments, Results, Routes and Weather**. Each table has a primary key to uniquely identify its records, while foreign keys are used to establish relationships between related tables.

Appropriate data types and constraints are applied to maintain data integrity. For example, user email addresses are required to be unique, while role and status fields use restrictions to ensure that only valid values can be stored. Default values are also applied where appropriate, such as automatically assigning creation dates and default payment or event statuses. The Results table uses a unique foreign key for the enrolment relationship, ensuring that an enrolment cannot have multiple result records.

Sample data was inserted into the database to demonstrate that the implemented structure is functional. The sample dataset includes organiser and participant accounts, multiple events, event categories, participant enrolments, results, routes and weather records. This data represents realistic information that could be managed by the RaceDay Event Management System.

SQL queries were executed in SQL Server Management Studio to verify that the database and its tables were successfully created and populated. SELECT queries were used to display the stored records, while JOIN operations were used to demonstrate that information from related entities could be retrieved together. These tests provide evidence that the primary keys, foreign keys and relationships defined within the database are functioning as intended.

The implemented database therefore provides the required foundation for the RaceDay system. It supports event management, participant enrolment, category management, result recording, route information and weather information while maintaining relationships and data integrity between the different components of the system.

## Conclusion

The planning and database design for the RaceDay Event Management System establish a structured foundation for the development of the complete application. The ERD identifies the required entities and relationships, while the API Endpoint Plan defines how the application will interact with these resources. The SQL Server implementation translates the planned database structure into functional tables containing appropriate constraints and sample data.

The integration between the ERD, API plan and database ensures consistency across the system design. The proposed structure can subsequently be used as the foundation for developing the application functionality, including user authentication, event management, participant enrolment, results management, route information and weather-related features.


