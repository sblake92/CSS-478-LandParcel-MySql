create table LandParcel(
landParcelID int PRIMARY KEY auto_increment,
businessEntityID int NOT NULL, /*this is a foreign key*/
parcelNumber int,
parcelSize int
)ENGINE=InnoDB;
create index businessEntityID on LandParcel(businessEntityID);

create table LandParcelZoning(
landParcelZoningID int PRIMARY KEY auto_increment,
landParcelID int NOT NULL, /*this is a foreign key*/
landParcelZoningTypeCode int NOT NULL, /*this is a foreign key*/
startDate datetime NOT NULL,
endDate datetime
)ENGINE=InnoDB;
create index landParcelZoningTypeCode on LandParcelZoning(landParcelZoningTypeCode);
create index landParcelID on LandParcelZoning(landParcelID);
create index startDate on LandParcelZoning(startDate);


create table LandParcelZoningType(
landParcelZoningTypeCode int PRIMARY KEY auto_increment
)ENGINE=InnoDB;

create table LandParcelValuation(
landParcelValuationID int PRIMARY KEY auto_increment,
landParcelID int NOT NULL, /*this is a foreign key*/
landParcelValue float NOT NULL,
startDate datetime NOT NULL,
endDate datetime
)ENGINE=InnoDB;
create index landParcelID on LandParcelValuation(landParcelID);
create index landParcelValue on LandParcelValuation(landParcelValue);
create index startDate on LandParcelValuation(startDate);

create table LandParcelTaxes(
landParcelTaxID int PRIMARY KEY auto_increment,
landParcelID int NOT NULL, /*this is a foreign key*/
startDate datetime NOT NULL,
endDate datetime,
taxExempt bool NOT NULL, /*I'm not sure about this one*/
taxPercent dec NOT NULL
)ENGINE=InnoDB;
create index landParcelID on LandParcelTaxes(landParcelID);
create index startDate on LandParcelTaxes(startDate);
create index taxExempt on LandParcelTaxes(taxExempt);
create index taxPercent on LandParcelTaxes(taxPercent);


create table LandParcelTransaction(
landParcelTransactionID int PRIMARY KEY auto_increment,
landParcelID int NOT NULL, /*this is a foreign key*/
landParcelTransactionTypeCode int NOT NULL, /*this is FK*/
closingDate datetime,
purchasePrice float,
cashAtClosing float,
earnestMoney float,
possessionDate datetime
)ENGINE=InnoDB;
create index landParcelID on LandParcelTransaction(landParcelID);
create index landParcelTransactionTypeCode on LandParcelTransaction(landParcelTransactionTypeCode);


create table LandParcelTransactionTypeCode(
landParcelTransactionTypeCode int PRIMARY KEY auto_increment
)ENGINE=InnoDB;

create table Structure(
structureID int PRIMARY KEY auto_increment,
landParcelID int NOT NULL, /*this is a foreign key*/
structureTypeCode int NOT NULL, /*FK*/
addressInfoID int NOT NULL, /*FK*/
yearBuilt datetime NOT NULL,
yearDestroyed dateTime
)ENGINE=InnoDB;
create index landParcelID on Structure(landParcelID);
create index structureTypeCode on Structure(structureTypeCode);
create index addressInfoID on Structure(addressINfoID);
create index yearBuilt on Structure(yearBuilt);


create table StructureTypeCode(
structureTypeCode int PRIMARY KEY auto_increment
)ENGINE=InnoDB;

create table AddressInfo(
addressInfoID int PRIMARY KEY auto_increment,
landParcelID int NOT NULL, /*this is a foreign key*/
stateCode varchar(3) NOT NULL, /*FK*/
streetAddress varchar(100) NOT NULL,
zipCode int NOT NULL,
city varChar(255) NOT NULL,
poBoxNo int,
aptUnitSuiteNo int,
county varchar(255) NOT NULL
)ENGINE=InnoDB;
create index landParcelID on AddressInfo(landParcelID);
create index stateCode on AddressInfo(stateCode);
create Index streetAddress on AddressInfo(streetAddress);
create index zipCode on AddressInfo(zipCode);
create index city on AddressInfo(city);
create index county on AddressInfo(county);

create table State(
stateCode varchar(3) PRIMARY KEY
)ENGINE=InnoDB;

create table TransactionRole(
transactionRoleID int PRIMARY KEY auto_increment,
transactionRoleTypeCode varchar(100) NOT NULL, /*FK*/
landParcelTransactionID int NOT NULL, /*FK*/
businessEntityID int NOT NULL /*FK*/
)ENGINE=InnoDB;
create index transactionRoleTypeCode on TransactionRole(transactionRoleTypeCode);
create index landParcelTransactionID on TransactionRole(landParcelTransactionID);
create index businessEntityID on TransactionRole(businessEntityID);

create table TransactionRoleType(
transactionRoleTypeCode varchar(100) PRIMARY KEY auto_increment
)ENGINE=InnoDB;

create table LandParcelOwner(
landParcelOwnerID int PRIMARY KEY auto_increment,
landParcelID int NOT NULL, /*this is a foreign key*/
businessEntityID int NOT NULL, /*FK*/
startDate datetime NOT NULL,
endDate datetime
)ENGINE=InnoDB;
create index landParcelID on LandParcelOwner(landParcelID);
create index businessEntityID on LandParcelOwner(businessEntityID);
create index startDate on LandParcelOwner(startDate);

create table BusinessEntity(
businessEntityID int PRIMARY KEY auto_increment,
businessEntityCode char(2) NOT NULL, /*FK*/
addressInfoID int NOT NULL, /*FK*/
landParcelRequestID int NOT NULL, /*FK*/
/*Additions after talking with the professor */
/*from company */
companyTypeCode varchar(100) NOT NULL, /*FK*/
companyName varchar(255) NOT NULL, 
businessLicenseNo int,
yearFounded datetime,
/*from person*/
firstName varchar(255),
lastName varchar(255),
emailAddress varchar(255),
phoneNo int,
faxNo int,
/* from GovAgency */
governmentAgencyTypeCode int NOT NULL, /*FK*/
agencyName varchar (255) NOT NULL
)ENGINE=InnoDB;
create index addressInfoID on BusinessEntity(addressInfoID);
create index landParcelRequestID on BusinessEntity(landParcelRequestID);
/* from gov agency*/
create index governmentAgencyTypeCode on BusinessEntity(governmentAgencyTypeCode);
create index agencyName on BusinessEntity(agencyName);
/*from person*/ 
create index fullName on BusinessEntity(lastName, firstName);
/*from company*/
create index companyTypeCode on BusinessEntity(companyTypeCode);
create index companyName on BusinessEntity(companyName);

create table BusinessEntityCode(
businessEntityCode char(3) PRIMARY KEY auto_increment,
businessEntityID int NOT NULL, /*fk*/
 /*
 we need to figure out this selection piece*
 I'm thinking they should be "com"per"gov"
 just not sure how to make that mandatory or whatever
 */
company varchar(3) NOT NULL,
person varchar(3) NOT NULL,
governmentAgency varchar(3) NOT NULL
)ENGINE=InnoDB;
create index businessEntityID on BusinessEntityCode(businessEntityID);

create table Applicant(
applicantID int PRIMARY KEY auto_increment,
businessEntityID int NOT NULL, /*FK*/
authorization varchar(100) NOT NULL /*not sure about this one maybe it should be bool?*/
)ENGINE=InnoDB;
create index businessEntityID on Applicant(businessEntityID);
create index authorization on Applicant(authorization);

create table LandParcelRequest(
landParcelRequestID int PRIMARY KEY auto_increment,
landParcelRequestTypeCode varchar(255) NOT NULL, /*FK*/
landParcelID int NOT NULL, /*this is a foreign key*/
applicantID int NOT NULL, /*FK*/
governmentEmployeeID int NOT NULL, /*FK*/
applicantNo int
)ENGINE=InnoDB;
create index landParcelID on LandParcelRequest(landParcelID);
create index landParcelRequestTypeCode on LandParcelRequest(landParcelRequestTypeCode);
create index applicantID on LandParcelRequest(applicantID);
create index governmentEmployeeID on LandParcelRequest(governmentEmployeeID);


create table LandParcelRequestType(
landParcelRequestType int PRIMARY KEY auto_increment
)ENGINE=InnoDB;

create table CompanyType(
companyTypeCode varchar(100) PRIMARY KEY auto_increment
)ENGINE=InnoDB;

create table CompanyEmployee(
companyEmployeeID int PRIMARY KEY auto_increment,
businessEntityID int NOT NULL, /*FK*/
jobTitle varchar(100) NOT NULL,
licenseNo int
)ENGINE=InnoDB;
create index businessEntityID on CompanyEmployee(businessEntityID);
create index jobTitle on CompanyEmployee(jobTitle);


create table GovernmentAgencyTypeCode(
governmentAgencyTypeCode int PRIMARY KEY auto_increment
)ENGINE=InnoDB;

create table GovernmentEmployee(
governmentEmployeeID int PRIMARY KEY auto_increment,
businessEntityID int NOT NULL, /*FK*/
jobTitle varchar(255) NOT NULL
)ENGINE=InnoDB;
create index businessEntityID on GovernmentEmployee(businessEntityID);
create index jobTitle on GovernmentEmployee(jobTitle);

/*ADDING FORIEGN KEYS TO EACH TABLE*/

alter table LandParcel
ADD  CONSTRAINT landParcel_busEntID_FK1
FOREIGN KEY (businessEntityID) REFERENCES BusinessEntity(businessEntityID);

alter table LandParcelZoning
add constraint lpZoning_landParcel_FK1
foreign key(landParcelID) references LandParcel(landParcelID);
alter table LandParcelZoning
add constraint lpZoning_zoningType_FK1
foreign key(landParcelZoningTypeCode) references LandParcelZoningTypeCode(landParcelZoningTypeCode);

alter table LandParcelValuation
add constraint lpValuation_landParcel_FK1
foreign key(landParcelID) references LandParcel(landParcelID);

alter table LandParcelTaxes
add constraint lpTaxes_landParcel_FK1
foreign key(landParcelID) references LandParcel(landParcelID);

alter table LandParcelTransaction
add constraint lpTransaction_landParcel_FK1
foreign key (landParcelID) references LandParcel(landParcelID);
alter table LandParcelTransaction
add constraint lpTransaction_lpTransTypeCode_FK1
foreign key (landParcelTransactionTypeCode) references LandParcelTransactionTypeCode(landParcelTransactionTypeCode);

alter table Structure
add constraint structure_landParcel_FK1
foreign key( landParcelID) references LandParcelID(landParcelID);
alter table Structure
add constraint structure_sTypeCode_FK1
foreign key (structureTypeCode) references StructureTypeCode(StructureTypeCode);
alter table Structure
add constraint structure_addressInfo_FK1
foreign key (addressInfoID) references AddressInfo(addressInfoID);

alter table AddressInfo
add constraint addressInfo_landParcel_FK1
foreign key (landParcelID) references LandParcel(landParcelID);
alter table AddressInfo
add constraint addressInfo_stateCode_FK1
foreign key (stateCode) references State(stateCode);

alter table TransactionRole
add constraint transRole_transRoleType_FK1
foreign key(transactionRoleTypeCode) references TransactionRoleType(transactionRoleTypeCode);
alter table TransactionRole
add constraint transRole_lpTransID_FK1
foreign key(landParcelTransactionID) references LandParcelTransaction(landParcelTransactionID);
alter table TransactionRole
add constraint transRole_busEnt_FK1
foreign key(businessEntityID) references BusinessEntity(businessEntityID);

alter table LandParcelOwner
add constraint lpOwner_landParcel_FK1
foreign key(landParcelID) references LandParcel(landParcelID);
alter table LandParcelOwner
add constraint lpOwner_busEnt_FK1
foreign key(businessEntityID) references BusinessEntity(businessEntityID);

alter table BusinessEntity
add constraint busEnt_busEntCode_FK1
foreign key (businessEntityCode) references BusinessEntityCode(businessEntityCode);
alter table BusinessEntity
add constraint busEnt_addressInfo_FK1
foreign key (addressInfoID) references AddressInfo(addressInfoID);
alter table BusinessEntity
add constraint busEnt_lpRequest_FK1
foreign key (landParcelRequestID) references LandParcelRequest(landParcelRequestID);
alter table BusinessEntity
add constraint busEnt_compType_FK1
foreign key (conmpanyTypeCode) references CompanyType(companyTypeCode);
alter table BusinessEntity
add constraint busEnt_govAgencyType_FK1
foreign key (governmentAgencyTypeCode) references GovernmentAgencyType(governmentAgencyTypeCode);

alter table BusinessEntityCode
add constraint busEntCode_businessEntity_FK1
foreign key(businessEntityID) references BusinessEntity(businessEntityID);

alter table Applicant
add constraint applicant_busEnt_FK1
foreign key(businessEntityID) references BusinessEntity(businessEntityID);

alter table LandParcelRequest
add constraint lpRequest_lpRequestType_FK1
foreign key(landParcelRequestTypeCode) references LandParcelRequestType(landParcelRequestTypeCode);
alter table LandParcelRequest
add constraint lpRequest_landParcel_FK1
foreign key(landParcelID) references LandParcel(landParcelID);
alter table LandParcelRequest
add constraint lpRequest_Applicant_FK1
foreign key(applicantID) references Applicant(applicantID);
alter table LandParcelRequest
add constraint lpRequest_govEmployee_FK1
foreign key(governmentEmployeeID) references GovernmentEmployee(governmentEmployeeID);

alter table CompanyEmployee
add constraint compEmp_busEnt_FK1
foreign key(businessEntityID) references BusinessEntity(businessEntityID);

alter table GovernmentEmployee
add constraint govEmp_busEnt_FK1
foreign key(businessEntityID) references BusinessEntity(businessEntityID);

/* OLD STUFF WE'RE NOT YET SURE TO WHAT TO DO WITH */
/*
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
governmentAgencyTypeCode int NOT NULL,
agencyName varchar (255) NOT NULL
);
create index governmentAgencyTypeCode on GovernmentAgency(governmentAgencyTypeCode);
create index agencyName on GovernmentAgency(agencyName);

create  table Company(
businessEntityID int PRIMARY KEY, 
companyTypeCode varchar(100) NOT NULL,
companyName varchar(255) NOT NULL, 
businessLicenseNo int,
yearFounded datetime
);
create index companyTypeCode on Company(companyTypeCode);
create index companyName on Company(companyName);*/

