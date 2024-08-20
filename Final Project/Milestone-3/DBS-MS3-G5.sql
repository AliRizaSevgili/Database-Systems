/********************************************
DBS211 NHH
MILESTONE 3 - GROUP 5
-----------------------
PET WELLNESS CLINIC
------------------------
Ali Riza Sevgili
Asem Al-Hakami
Ryan Gillespie
-----------------------
2023-12-2
********************************************/




-- CREATE PATIENTS 
CREATE TABLE PATIENTS (
  PatientID INT PRIMARY KEY,
  Name VARCHAR2(50) NOT NULL,
  Species VARCHAR2(50) NOT NULL,
  Breed VARCHAR2(50) NOT NULL,
  OwnerID INT NOT NULL,
  Dob DATE NOT NULL,
  MicroChipID CHAR(20),
  Sex CHAR(2) NOT NULL
);

-- CREATE PEOPLE 
CREATE TABLE PEOPLE (
  PersonID INT PRIMARY KEY,
  FirstName VARCHAR2(50) NOT NULL,
  LastName VARCHAR2(50) NOT NULL,
  DOB DATE NOT NULL,
  Email VARCHAR2(100),
  PhoneNumber VARCHAR2(10),
  Address VARCHAR2(100) NOT NULL,
  City VARCHAR2(25) DEFAULT 'Toronto' NOT NULL,
  PostalCode CHAR(6) NOT NULL
);

-- CREATE PHONE 
CREATE TABLE PHONE (
  PhoneID INT PRIMARY KEY,
  PersonID INT NOT NULL,
  PhoneType VARCHAR2(10) NOT NULL,
  FOREIGN KEY (PersonID) REFERENCES PEOPLE(PersonID)
);

-- CREATE EMPLOYEE 
CREATE TABLE EMPLOYEE (
  EmployeeID INT PRIMARY KEY,
  PersonID INT NOT NULL,
  Position VARCHAR2(50) NOT NULL,
  HireDate DATE NOT NULL,
  HourlyRate DECIMAL(5,2) NOT NULL,
  userName VARCHAR2(10),
  password VARCHAR2(10),
  FOREIGN KEY (PersonID) REFERENCES PEOPLE(PersonID)
);

-- CREATE  VETERINARIANS
CREATE TABLE VETERINARIANS (
  VeterinarianID INT PRIMARY KEY,
  EmployeeID INT NOT NULL,
  Specialty VARCHAR2(50),
  VetLicense CHAR(10) NOT NULL,
  FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);

CREATE TABLE APPOINTMENTS (
  AppointmentID INT PRIMARY KEY,
  VeterinarianID INT NOT NULL,
  PatientID INT NOT NULL,
  AppointmentDate DATE NOT NULL,
  StartTime TIMESTAMP NOT NULL,
  EndTime TIMESTAMP NOT NULL,
  Notes VARCHAR2(255),
  FOREIGN KEY (VeterinarianID) REFERENCES VETERINARIANS(VeterinarianID),
  FOREIGN KEY (PatientID) REFERENCES PATIENTS(PatientID)
);

-- CREATE APPOINTMENTS-DETAILS 
CREATE TABLE APPOINTMENTS_DETAILS (
  DetailID INT PRIMARY KEY,
  AppointmentID INT NOT NULL,
  ProcedureID INT NOT NULL,
  Quantity INT NOT NULL,
  FOREIGN KEY (AppointmentID) REFERENCES APPOINTMENTS(AppointmentID),
  FOREIGN KEY (ProcedureID) REFERENCES PROCEDURES(ProcedureID)
);

-- CREATE PROCEDURES 
CREATE TABLE PROCEDURES (
  ProcedureID INT PRIMARY KEY,
  ProcedureName VARCHAR2(100) NOT NULL,
  Description VARCHAR2(255),
  Cost DECIMAL NOT NULL
);

-- CREATE PRESCRIPTIONS
CREATE TABLE PRESCRIPTIONS (
  PrescriptionID INT PRIMARY KEY,
  VeterinarianID INT NOT NULL,
  PatientID INT NOT NULL,
  PrescriptionDate DATE NOT NULL,
  FOREIGN KEY (VeterinarianID) REFERENCES VETERINARIANS(VeterinarianID),
  FOREIGN KEY (PatientID) REFERENCES PATIENTS(PatientID)
);

-- CREATE  MEDICATIONS
CREATE TABLE MEDICATIONS (
  MedicationID INT PRIMARY KEY,
  MedicationName VARCHAR2(100) NOT NULL,
  Manufacturer VARCHAR2(100),
  UnitPrice DECIMAL(9,2) NOT NULL
);

-- CREATE PRESCRIPTION-DETAILS
CREATE TABLE PRESCRIPTION_DETAILS (
  DetailID INT PRIMARY KEY,
  PrescriptionID INT NOT NULL,
  MedicationID INT NOT NULL,
  Dosage VARCHAR2(30) NOT NULL,
  FOREIGN KEY (PrescriptionID) REFERENCES PRESCRIPTIONS(PrescriptionID),
  FOREIGN KEY (MedicationID) REFERENCES MEDICATIONS(MedicationID)
);



-- CREATE INVOICE 
CREATE TABLE INVOICE (
  InvoiceID INT PRIMARY KEY,
  VeterinarianID INT NOT NULL,
  PatientID INT NOT NULL,
  InvoiceDate DATE NOT NULL,
  TotalAmount DECIMAL(5,1) NOT NULL,
  FOREIGN KEY (VeterinarianID) REFERENCES VETERINARIANS(VeterinarianID),
  FOREIGN KEY (PatientID) REFERENCES PATIENTS(PatientID)
);

-- CREATE INVOICE-DETAILS 
CREATE TABLE INVOICE_DETAILS (
  DetailID INT PRIMARY KEY,
  InvoiceID INT NOT NULL,
  ProcedureID INT NOT NULL,
  Quantity INT NOT NULL,
  FOREIGN KEY (InvoiceID) REFERENCES INVOICE(InvoiceID),
  FOREIGN KEY (ProcedureID) REFERENCES PROCEDURES(ProcedureID)
);


-- ALTER TABLE
ALTER TABLE PATIENTS MODIFY (SEX VARCHAR2(10));

-- Insert Related Data

-- PATIENTS TABLE
INSERT INTO PATIENTS (PatientID, Name, Species, Breed, OwnerID, Dob, MicroChipID, Sex)
VALUES (2, 'Whiskers', 'Cat', 'Siamese', 102, TO_DATE('2019-09-10', 'YYYY-MM-DD'), 'CHIP456', 'Female');


INSERT INTO PATIENTS (PatientID, Name, Species, Breed, OwnerID, Dob, MicroChipID, Sex)
VALUES (215, 'Tyson', 'Dog', 'American Bully', 3190, TO_DATE('2022-12-15', 'YYYY-MM-DD'), '632104598756432', 'Male');

COMMIT;

-- PEOPLE TABLE
INSERT INTO PEOPLE (PersonID, FirstName, LastName, DOB, Email, PhoneNumber, Address, City, PostalCode)
VALUES (3130, 'Sean', 'John', TO_DATE('1991-12-18', 'YYYY-MM-DD'), 'seanjohn@email.com', '2891239078', '120 Kingston Rd', 'Toronto', 'M1M1P5');

COMMIT;

INSERT INTO PEOPLE (PersonID, FirstName, LastName, DOB, Email, PhoneNumber, Address, City, PostalCode)
VALUES (3131, 'Emma', 'Smith', TO_DATE('1990-08-25', 'YYYY-MM-DD'), 'emma@email.com', '4167894321', '45 Elm Street', 'Montreal', 'H3H2K3');

COMMIT;


-- PHONE TABLE
INSERT INTO PHONE (PhoneID, PersonID, PhoneType)
VALUES (5489673190, 3130, 'Cell');

INSERT INTO PHONE (PhoneID, PersonID, PhoneType)
VALUES (5489673191, 3131, 'Home');

COMMIT;


-- EMPLOYEE TABLE

INSERT INTO EMPLOYEE (EmployeeID, PersonID, Position, HireDate, HourlyRate, userName, password)
VALUES (4321, 3130, 'Veterinarian', TO_DATE('2023-12-18', 'YYYY-MM-DD'), 30.25, 'seanjohn', 'lovepets');

COMMIT;

INSERT INTO EMPLOYEE (EmployeeID, PersonID, Position, HireDate, HourlyRate, userName, password)
VALUES (5432, 3131, 'Assistant Veterinarian', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 25.50, 'emmasmith', 'petscare');

COMMIT;

-- VETERINARIANS TABLE
INSERT INTO VETERINARIANS (VeterinarianID, EmployeeID, Specialty, VetLicense)
VALUES (3130, 4321, 'Dermatology', 'XX-000-XX');


-- APPOINTMENTS TABLE
INSERT INTO APPOINTMENTS (AppointmentID, VeterinarianID, PatientID, AppointmentDate, StartTime, EndTime, Notes)
VALUES (5678, 3130, 215, TO_DATE('2023-11-25', 'YYYY-MM-DD'), TO_TIMESTAMP('14:15:00', 'HH24:MI:SS'), TO_TIMESTAMP('15:15:00', 'HH24:MI:SS'), 'Follow-up');

INSERT INTO APPOINTMENTS (AppointmentID, VeterinarianID, PatientID, AppointmentDate, StartTime, EndTime, Notes)
VALUES (5679, 3130, 2, TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_TIMESTAMP('09:30:00', 'HH24:MI:SS'), TO_TIMESTAMP('10:15:00', 'HH24:MI:SS'), 'Checkup');


-- PROCEDURES TABLE
INSERT INTO PROCEDURES (ProcedureID, ProcedureName, Description, Cost)
VALUES (112, 'Vaccination', 'Annual shots', 100.00);

INSERT INTO PROCEDURES (ProcedureID, ProcedureName, Description, Cost)
VALUES (113, 'Dental Cleaning', 'Routine dental cleaning', 120.00);


-- PRESCRIPTIONS TABLE
INSERT INTO PRESCRIPTIONS (PrescriptionID, VeterinarianID, PatientID, PrescriptionDate)
VALUES (111, 3130, 215, TO_DATE('2023-11-25', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTIONS (PrescriptionID, VeterinarianID, PatientID, PrescriptionDate)
VALUES (112, 3130, 2, TO_DATE('2023-12-01', 'YYYY-MM-DD'))



-- MEDICATION TABLE
INSERT INTO MEDICATIONS (MedicationID, MedicationName, Manufacturer, UnitPrice)
VALUES (112, 'Stool Meds', 'Totvet', 50.00);

INSERT INTO MEDICATIONS (MedicationID, MedicationName, Manufacturer, UnitPrice)
VALUES (113, 'Pain Reliever', 'PharmaCo', 35.00);

INSERT INTO MEDICATIONS (MedicationID, MedicationName, Manufacturer, UnitPrice)
VALUES (114, 'Antibiotic', 'MediLab', 40.00);


--  PRESCRIPTION_DETAILS TABLE
INSERT INTO PRESCRIPTION_DETAILS (DetailID, PrescriptionID, MedicationID, Dosage)
VALUES (111, 111, 112, 'Three times a day 20mg');

INSERT INTO PRESCRIPTION_DETAILS (DetailID, PrescriptionID, MedicationID, Dosage)
VALUES (112, 112, 113, 'Twice a day 10mg');

--  INVOICE TABLE
INSERT INTO INVOICE (InvoiceID, VeterinarianID, PatientID, InvoiceDate, TotalAmount)
VALUES (1234, 3130, 215, TO_DATE('2023-11-25', 'YYYY-MM-DD'), 150.0);

INSERT INTO INVOICE (InvoiceID, VeterinarianID, PatientID, InvoiceDate, TotalAmount)
VALUES (1235, 3130, 2, TO_DATE('2023-11-26', 'YYYY-MM-DD'), 175.0);

--  INVOICE_DETAILS TABLE
INSERT INTO INVOICE_DETAILS (DetailID, InvoiceID, ProcedureID, Quantity)
VALUES (111, 1234, 112, 2);

INSERT INTO INVOICE_DETAILS (DetailID, InvoiceID, ProcedureID, Quantity)
VALUES (112, 1235, 113, 3);


-- VIEW 1: Show Appointments
CREATE VIEW Appointments_View AS
SELECT A.AppointmentID, A.AppointmentDate, A.StartTime, A.EndTime, A.Notes,
       V.VeterinarianID, V.EmployeeID, V.Specialty, V.VetLicense
FROM APPOINTMENTS A
JOIN VETERINARIANS V ON A.VeterinarianID = V.VeterinarianID;


-- VIEW 1 results: 
SELECT * FROM Appointments_View;



-- VIEW 2: Show InvoiceDetails
CREATE VIEW InvoiceDetails_View AS
SELECT ID.DetailID, ID.InvoiceID, P.ProcedureName, ID.Quantity, (ID.Quantity * P.Cost) AS TotalCost
FROM INVOICE_DETAILS ID
JOIN PROCEDURES P ON ID.ProcedureID = P.ProcedureID;

-- VIEW 2 results: 
SELECT * FROM InvoiceDetails_View;


-- VIEW 3: Veterinarian Medications
CREATE VIEW VeterinarianMedications_View AS
SELECT PM.PrescriptionID, M.MedicationName, PD.Dosage, V.SPECIALTY AS VeterinarianSpecialty, P.NAME AS PatientName
FROM PRESCRIPTIONS PM
JOIN PRESCRIPTION_DETAILS PD ON PM.PrescriptionID = PD.PrescriptionID
JOIN MEDICATIONS M ON PD.MedicationID = M.MedicationID
JOIN VETERINARIANS V ON PM.VeterinarianID = V.VETERINARIANID
JOIN PATIENTS P ON PM.PatientID = P.PATIENTID;

-- VIEW 3 results: 
SELECT * FROM VeterinarianMedications_View;
