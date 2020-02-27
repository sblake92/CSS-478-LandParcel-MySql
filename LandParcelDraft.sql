create table LandParcel(
landParcelId int PRIMARY KEY,
governmentAcencyId int NOT NULL, /*this is a foreign key*/
parcelNumber int,
parcelSize int
);
create index governmentAgencyID on LandParcel(govenrnmentAcencyID);

create table LandParcelZoning(
landParcelZoningID int PRIMARY KEY,
landParcelID int NOT NULL, /*this is a foreign key*/
landParcelZoningTypeCode int NOT NULL, /*this is a foreign key*/
startDate datetime NOT NULL,
endDate datetime
);
create index landParcelZoningTypeCode on LandParcelZoning(landParcelZoningTypeCode);
create index landParcelID on LandParcelZoning(landParcelID);
create index startDate on LandParcelZoning(startDate);

create table LandParcelZoningType(
landParcelZoningTypeCode int PRIMARY KEY
);

create table LandParcelValuation(
landParcelValuationID int PRIMARY KEY,
landParcelID int NOT NULL, /*this is a foreign key*/
landParcelValue float NOT NULL,
startDate datetime NOT NULL,
endDate datetime
);
create index landParcelID on LandParcelValuation(landParcelID);
create index landParcelValue on LandParcelValuation(landParcelValue);
create index startDate on LandParcelValuation(startDate);

create table LandParcelTaxes(
landParcelTaxID int PRIMARY KEY,
landParcelID int NOT NULL, /*this is a foreign key*/
startDate datetime NOT NULL,
endDate datetime,
taxExempt bool NOT NULL, /*I'm not sure about this one*/
taxPercent dec NOT NULL
);
create index landParcelID on LandParcelTaxes(landParcelID);
create index startDate on LandParcelTaxes(startDate);
create index taxExempt on LandParcelTaxes(taxExempt);
create index taxPercent on LandParcelTaxes(taxPercent);

create table LandParcelTransaction(
landParcelTransactionlD int PRIMARY KEY,
landParcelID int NOT NULL, /*this is a foreign key*/
landParcelTransactionTypeCode int NOT NULL, /*this is FK*/
closingDate datetime,
purchasePrice float,
cashAtClosing float,
earnestMoney float,
possessionDate datetime
);
create index landParcelID on LandParcelTransaction(landParcelID);
create index landParcelTransactionTypeCode on LandParcelTransaction(landParcelTransactionTypeCode);

create table landParcelTransactionTypeCode(
landParcelTransactionTypeCode int PRIMARY KEY
);

create table Structure(
structureID int PRIMARY KEY,
landParcelID int NOT NULL, /*this is a foreign key*/
structureTypeCode int NOT NULL, /*FK*/
addressInfoID int NOT NULL, /*FK*/
yearBuilt datetime NOT NULL,
yearDestroyed dateTime
);
create index landParcelID on Structure(landParcelID);
create index structureTypeCode on Structure(structureTypeCode);
create index addressInfoID on Structure(addressINfoID);
create index yearBuilt on Structure(yearBuilt);

create table StructureTypeCode(
structureTypeCode int PRIMARY KEY
);

create table AddressInfo(
addressInfoID int PRIMARY KEY,
landParcelID int NOT NULL, /*this is a foreign key*/
stateCode varchar(3) NOT NULL, /*FK*/
streetAddress varchar(100) NOT NULL,
zipCode int NOT NULL,
city varChar(255) NOT NULL,
poBoxNo int,
aptUnitSuiteNo int,
county varchar(255) NOT NULL
);
create index landParcelID on AddressInfo(landParcelID);
create index stateCode on AddressInfo(stateCode);
create Index streetAddress on AddressInfo(streetAddress);
create index zipCode on AddressInfo(zipCode);
create index city on AddressInfo(city);
create index county on AddressInfo(county);

create table State(
stateCode varchar(3) PRIMARY KEY
);

create table TransactionRole(
transactionRoleID int PRIMARY KEY,
transactionRoleTypeCode varchar(100) NOT NULL, /*FK*/
landParcelTransactionlD int NOT NULL, /*FK*/
businessEntityID int NOT NULL /*FK*/
);
create index transactionRoleTypeCode on TransactionRole(transactionRoleTypeCode);
create index landParcelTransactionlD on TransactionRole(landParcelTransactionlD);
create index businessEntityID on TransactionRole(businessEntityID);

create table TransactionRoleType(
transactionRoleTypeCode varchar(100) PRIMARY KEY
);

create table LandParcelOwner(
landParcelOwnerID int PRIMARY KEY,
landParcelID int NOT NULL, /*this is a foreign key*/
businessEntityID int NOT NULL, /*FK*/
startDate datetime NOT NULL,
endDate datetime
);
create index landParcelID on LandParcelOwner(landParcelID);
create index businessEntityID on LandParcelOwner(businessEntityID);
create index startDate on LandParcelOwner(startDate);

create table BusinessEntity(
businessEntityID int PRIMARY KEY,
addressInfoID int NOT NULL, /*FK*/
landParcelRequestID int NOT NULL /*FK*/
);
create index addressInfoID on BusinessEntity(addressInfoID);
create index landParcelRequestID on BusinessEntity(landParcelRequestID);

create table Applicant(
applicantID int PRIMARY KEY,
businessEntityID int NOT NULL, /*FK*/
authorization varchar(100) NOT NULL /*not sure about this one maybe it should be bool?*/
);
create index businessEntityID on Applicant(businessEntityID);
create index authorization on Applicant(authorization);

create table LandParcelRequest(
landParcelRequestID int PRIMARY KEY,
landParcelRequestTypeCode varchar(255) NOT NULL, /*FK*/
landParcelID int NOT NULL, /*this is a foreign key*/
applicantID int NOT NULL, /*FK*/
governmentEmployeeID int NOT NULL, /*FK*/
applicantNo int
);
create index landParcelID on LandParcelRequest(landParcelID);
create index landParcelRequestTypeCode on LandParcelRequest(landParcelRequestTypeCode);
create index applicantID on LandParcelRequest(applicantID);
create index governmentEmployeeID on LandParcelRequest(governmentEmployeeID);

create table LandParcelRequestType(
landParcelRequestType int PRIMARY KEY
);

create  table Company(
businessEntityID int PRIMARY KEY, /*doesnt inherited take PK of parent?*/
companyTypeCode varchar(100) NOT NULL, /*FK*/
companyName varchar(255) NOT NULL, 
businessLicenseNo int,
yearFounded datetime
);
create index companyTypeCode on Company(companyTypeCode);
create index companyName on Company(companyName);

create table CompanyType(
companyTypeCode varchar(100) PRIMARY KEY
);

create table CompanyEmployee(
companyEmployeeID int PRIMARY KEY,
businessEntityID int NOT NULL, /*FK*/
jobTitle varchar(100) NOT NULL,
licenseNo int
);
create index businessEntityID on CompanyEmployee(businessEntityID);
create index jobTitle on CompanyEmployee(jobTitle);

create table Person(
businessEntityID int PRIMARY KEY,
firstName varchar(255),
lastName varchar(255),
emailAddress varchar(255),
phoneNo int,
faxNo int)
);
create index fullName on Person(lastName, firstName);

create table GovernmentAgency(
businessEntityID int PRIMARY KEY,
governmentAgencyTypeCode int NOT NULL, /*FK*/
agencyName varchar (255) NOT NULL
);
create index governmentAgencyTypeCode on GovernmentAgency(governmentAgencyTypeCode);
create index agencyName on GovernmentAgency(agencyName);

create table GovernmentAgencyTypeCode(
governmentAgencyTypeCode int PRIMARY KEY
);

create table GovernmentEmployee(
governmentEmployeeID int PRIMARY KEY,
businessEntityID int NOT NULL, /*FK*/
jobTitle varchar(255) NOT NULL
):
create index businessEntityID on GovernmentEmployee(businessEntity);
create index jobTitle on GovernmentEmployee(jobTitle);




