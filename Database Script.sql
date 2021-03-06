USE [master]
GO
/****** Object:  Database [CATS]    Script Date: 2/2/2022 4:22:50 PM ******/
CREATE DATABASE [CATS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CATS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CATS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CATS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CATS_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CATS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CATS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CATS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CATS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CATS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CATS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CATS] SET ARITHABORT OFF 
GO
ALTER DATABASE [CATS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CATS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CATS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CATS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CATS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CATS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CATS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CATS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CATS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CATS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CATS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CATS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CATS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CATS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CATS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CATS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CATS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CATS] SET RECOVERY FULL 
GO
ALTER DATABASE [CATS] SET  MULTI_USER 
GO
ALTER DATABASE [CATS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CATS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CATS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CATS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CATS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CATS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CATS', N'ON'
GO
ALTER DATABASE [CATS] SET QUERY_STORE = OFF
GO
USE [CATS]
GO
/****** Object:  UserDefinedFunction [dbo].[FormatPhone]    Script Date: 2/2/2022 4:22:50 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE FUNCTION [dbo].[FormatPhone] (@PhoneNumber varchar(13))
RETURNS varchar(13) AS  
BEGIN 
Declare @FomattedPhone varchar(13)
Declare @pLen int 
Declare @phonepart char(3) 
Set @PhonePart = '   '
Set @PhoneNumber = Ltrim(Rtrim(@PhoneNumber))
Set @PhoneNumber =  Replace(Replace(Replace(@Phonenumber,'(',''),')',''),'-','')
Set @pLen = Len(@PhoneNumber)


If @pLen = 7 
   Set @FomattedPhone = '(   )' + Left(@PhoneNumber,3) + '-' + Right(@Phonenumber,4)
If  @pLen < 7 
begin 
   if @pLen > 4 
   begin
   Set @phonePart =  Right('   ' + subString(@PhoneNumber,1,@Plen-4) ,3)
   end 
   Set @FomattedPhone = '(   )' + @PhonePart + '-' + Right('    ' + Right(@Phonenumber,4),4)
end 
if @pLen > 7 
   Set @FomattedPhone = '(' + Replicate(' ',3-(@Plen-7)) + SubString(@Phonenumber,1,@Plen-7) +   ')' + 
		SubString(@PhoneNumber,@Plen-7+1,3) + '-' + Right(@Phonenumber,4)

Return @FomattedPhone


END

GO
/****** Object:  UserDefinedFunction [dbo].[uGetFullName]    Script Date: 2/2/2022 4:22:50 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[uGetFullName] (@LastName varchar(40), @FirstName varchar(40), @MI varchar(10), @Type varchar(10), @Prefix varchar(10) = '')  

RETURNS varchar(90) AS  
BEGIN 
Declare @rName varchar(90)
Declare @tMI varchar(10)
Declare @tPrefix Varchar(10)
Set @tPrefix = ''


If IsNull(@Prefix,'') <> ''
  Set @tPrefix = Ltrim(rtrim(@Prefix)) + ' '

Set @rName = ''
If Ltrim(@MI) = '' 
  Set @tMI = ' '
else
  set @tmi = ' ' + Rtrim(Ltrim(@MI)) + ' ' 
  
  If @Type = 'LASTFIRST' 
   Set @rName =  Rtrim(LtriM(@LastName)) + ', ' + Rtrim(Ltrim(@FirstName)) + ' ' + Rtrim(Ltrim(@MI))
  
  If @Type = 'FIRSTLAST' 
   Set @rName =   @tPrefix + Rtrim(Ltrim(@FirstName)) + @tMI +Rtrim(LtriM(@LastName) )

Return @rName
END

GO
/****** Object:  Table [dbo].[lkLookups]    Script Date: 2/2/2022 4:22:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lkLookups](
	[LookupTableName] [varchar](50) NOT NULL,
	[IDLookup] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](25) NULL,
	[Description] [varchar](255) NULL,
	[SortOrder] [smallint] NOT NULL,
	[Tag] [varchar](35) NULL,
	[URSCode] [char](10) NULL,
	[Active] [bit] NOT NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
	[NumRange1] [decimal](9, 2) NOT NULL,
	[NumRange2] [decimal](9, 2) NOT NULL,
 CONSTRAINT [PK_lkLookups] PRIMARY KEY CLUSTERED 
(
	[LookupTableName] ASC,
	[IDLookup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lkOrganizationSubTypes]    Script Date: 2/2/2022 4:22:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lkOrganizationSubTypes](
	[IDOrganizationSubType] [int] IDENTITY(1,1) NOT NULL,
	[IDOrganizationSubTypeCode] [int] NOT NULL,
	[OrganizationTypeID] [int] NOT NULL,
	[Description] [varchar](50) NULL,
	[URSCode] [char](10) NULL,
	[SortOrder] [smallint] NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_lkOrganizationSubTypes] PRIMARY KEY CLUSTERED 
(
	[IDOrganizationSubType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrgEntities]    Script Date: 2/2/2022 4:22:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrgEntities](
	[IDOrgEntities] [int] IDENTITY(1,1) NOT NULL,
	[LegacyTableName] [varchar](50) NULL,
	[LegacyID] [int] NOT NULL,
	[LegacyTypeID] [int] NULL,
	[OrgEntityTypeID] [int] NOT NULL,
	[OrgEntitySubTypeID] [int] NULL,
	[OrgEntitySubTypeCodeID] [int] NOT NULL,
	[OrgName] [varchar](75) NULL,
	[Address1] [varchar](40) NULL,
	[Address2] [varchar](40) NULL,
	[City] [varchar](30) NULL,
	[State] [char](2) NULL,
	[Zip] [varchar](10) NULL,
	[RawPhone] [varchar](20) NULL,
	[Phone] [varchar](13) NULL,
	[Ext] [varchar](10) NULL,
	[Fax] [varchar](13) NULL,
	[Beeper] [varchar](13) NULL,
	[ContactLastName] [varchar](30) NULL,
	[ContactFirstName] [varchar](20) NULL,
	[ContactTitle] [varchar](50) NULL,
	[ContactPrefix] [varchar](10) NULL,
	[ContactPhone] [varchar](13) NULL,
	[ContactExt] [varchar](10) NULL,
	[EmailAddress] [varchar](75) NULL,
	[URSCode] [char](10) NULL,
	[Active] [bit] NOT NULL,
	[Notes] [text] NULL,
	[InstitutionID] [int] NOT NULL,
	[Contact]  AS ([dbo].[uGetFullName]([ContactLastName],[ContactFirstName],'','FIRSTLAST',[ContactPrefix])),
	[ContactPhone_Format]  AS ([dbo].[FormatPhone](isnull([ContactPhone],[Phone]))),
	[UseID]  AS (case when [LegacyID]=(0) then [IDOrgEntities] else [LegacyID] end),
	[LicNumber] [varchar](20) NULL,
	[SortOrder] [smallint] NULL,
	[AssocContractID] [int] NOT NULL,
	[TIN] [char](9) NULL,
	[NPI] [char](10) NULL,
	[MergedOrgId] [int] NULL,
	[MergeDateTime] [datetime] NULL,
 CONSTRAINT [PK_tblOrgEntities] PRIMARY KEY CLUSTERED 
(
	[IDOrgEntities] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[lkLookups] ON 

INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283132, N'', N'Hospital or University-based clinic', 0, N'N', N'Y         ', 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283133, N'', N'Health Department', 0, N'N', NULL, 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283134, N'', N'Community Partners', 0, N'Y', NULL, 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283135, N'', N'VA Facility', 0, N'N', NULL, 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283136, N'', N'Solo/group private medical practice', 0, N'N', N'Y         ', 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283137, N'', N'Other CBO', 0, N'N', NULL, 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283138, N'', N'PLWHA coalition', 0, N'N', NULL, 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283139, N'', N'Distributor', 0, N'N', NULL, 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 283140, N'', N'Agency', 0, N'N', NULL, 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
INSERT [dbo].[lkLookups] ([LookupTableName], [IDLookup], [Code], [Description], [SortOrder], [Tag], [URSCode], [Active], [AddedBy], [AddedOn], [LastUpdatedBy], [LastUpdatedOn], [NumRange1], [NumRange2]) VALUES (N'LUP_ORGANIZATIONTYPES', 315764, N'', N'Community Partner Pilots', 0, N'Y', NULL, 1, 0, NULL, 0, NULL, CAST(0.00 AS Decimal(9, 2)), CAST(0.00 AS Decimal(9, 2)))
SET IDENTITY_INSERT [dbo].[lkLookups] OFF
GO
SET IDENTITY_INSERT [dbo].[lkOrganizationSubTypes] ON 

INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (1, 1, 283136, N'Physician', N'          ', 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (3, 1, 283140, N'Hospital', N'          ', 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (4, 2, 283136, N'Physicians Assistant', N'          ', 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (6, 2, 283140, N'Clinic', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (7, 3, 283136, N'Registered Nurse', N'          ', 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (10, 4, 283136, N'Certified Nurse Practioner', N'          ', 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (14, 6, 283140, N'Medical Facility', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (15, 7, 283140, N'Social Service Agency', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (30, 22, 283140, N'Public Clinic', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (31, 23, 283140, N'Home Care', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (32, 24, 283140, N'Public Health Center', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (33, 25, 283140, N'Public Health Facility', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (34, 26, 283140, N'Health Clinic', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (35, 27, 283140, N'Health Facility (private)', NULL, 0, 1)
INSERT [dbo].[lkOrganizationSubTypes] ([IDOrganizationSubType], [IDOrganizationSubTypeCode], [OrganizationTypeID], [Description], [URSCode], [SortOrder], [Active]) VALUES (36, 28, 283140, N'Home Health Care', NULL, 0, 1)
SET IDENTITY_INSERT [dbo].[lkOrganizationSubTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[tblOrgEntities] ON 

INSERT [dbo].[tblOrgEntities] ([IDOrgEntities], [LegacyTableName], [LegacyID], [LegacyTypeID], [OrgEntityTypeID], [OrgEntitySubTypeID], [OrgEntitySubTypeCodeID], [OrgName], [Address1], [Address2], [City], [State], [Zip], [RawPhone], [Phone], [Ext], [Fax], [Beeper], [ContactLastName], [ContactFirstName], [ContactTitle], [ContactPrefix], [ContactPhone], [ContactExt], [EmailAddress], [URSCode], [Active], [Notes], [InstitutionID], [LicNumber], [SortOrder], [AssocContractID], [TIN], [NPI], [MergedOrgId], [MergeDateTime]) VALUES (1, NULL, 0, 0, 283140, 36, 28, N'Test org Name 1', N'12345 Some street', N'Suite 100', N'West Palm Bech', N'Fl', N'33401', N'5611112222', N'561-596-1132', N'1001', NULL, NULL, N'Jones', N'Fred', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, -1, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblOrgEntities] ([IDOrgEntities], [LegacyTableName], [LegacyID], [LegacyTypeID], [OrgEntityTypeID], [OrgEntitySubTypeID], [OrgEntitySubTypeCodeID], [OrgName], [Address1], [Address2], [City], [State], [Zip], [RawPhone], [Phone], [Ext], [Fax], [Beeper], [ContactLastName], [ContactFirstName], [ContactTitle], [ContactPrefix], [ContactPhone], [ContactExt], [EmailAddress], [URSCode], [Active], [Notes], [InstitutionID], [LicNumber], [SortOrder], [AssocContractID], [TIN], [NPI], [MergedOrgId], [MergeDateTime]) VALUES (2, NULL, 0, 0, 283140, 3, 1, N'Our Favority Hospital', N'222 West Main', N' ', N'North Palm Beach', N'FL', N'33402', N'9542223333', N'954-222-3333', NULL, N'954-333-2222', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ourhospital@gmail.com', NULL, 0, NULL, 0, NULL, 0, -1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblOrgEntities] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_lkLookups]    Script Date: 2/2/2022 4:22:50 PM ******/
ALTER TABLE [dbo].[lkLookups] ADD  CONSTRAINT [IX_lkLookups] UNIQUE NONCLUSTERED 
(
	[LookupTableName] ASC,
	[Description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lkOrganizationSubTypes]    Script Date: 2/2/2022 4:22:50 PM ******/
ALTER TABLE [dbo].[lkOrganizationSubTypes] ADD  CONSTRAINT [IX_lkOrganizationSubTypes] UNIQUE NONCLUSTERED 
(
	[IDOrganizationSubTypeCode] ASC,
	[OrganizationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lkLookups] ADD  CONSTRAINT [DF_lkLookups_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[lkLookups] ADD  CONSTRAINT [DF_lklookups_inactive]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[lkLookups] ADD  CONSTRAINT [DF_lklookups_AddedOn]  DEFAULT (getdate()) FOR [AddedOn]
GO
ALTER TABLE [dbo].[lkLookups] ADD  CONSTRAINT [DF_lklookups_LastUpdatedOn]  DEFAULT (getdate()) FOR [LastUpdatedOn]
GO
ALTER TABLE [dbo].[lkLookups] ADD  CONSTRAINT [DF_lkLookups_NumRange1]  DEFAULT ((0)) FOR [NumRange1]
GO
ALTER TABLE [dbo].[lkLookups] ADD  CONSTRAINT [DF_lkLookups_NumRange2]  DEFAULT ((0)) FOR [NumRange2]
GO
ALTER TABLE [dbo].[lkOrganizationSubTypes] ADD  CONSTRAINT [DF_lkOrganizationSubTypes_OrganizationTypeID]  DEFAULT ((0)) FOR [OrganizationTypeID]
GO
ALTER TABLE [dbo].[lkOrganizationSubTypes] ADD  CONSTRAINT [DF_lkOrganizationSubTypes_URSCode]  DEFAULT ((0)) FOR [URSCode]
GO
ALTER TABLE [dbo].[lkOrganizationSubTypes] ADD  CONSTRAINT [DF_lkOrganizationSubTypes_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  CONSTRAINT [DF_tblOrgEntities_LegacyID]  DEFAULT ((0)) FOR [LegacyID]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  CONSTRAINT [DF_tblOrgEntities_LegacyTypeID]  DEFAULT ((0)) FOR [LegacyTypeID]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  CONSTRAINT [DF_tblOrgEntities_OrgEntityTypeID]  DEFAULT ((0)) FOR [OrgEntityTypeID]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  CONSTRAINT [DF_tblOrgEntities_OrgEntitySubTypeID]  DEFAULT ((0)) FOR [OrgEntitySubTypeID]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  CONSTRAINT [DF_tblOrgEntities_OrgEntitySubTypeCodeID]  DEFAULT ((0)) FOR [OrgEntitySubTypeCodeID]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  CONSTRAINT [DF_tblOrgEntities_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  CONSTRAINT [DF_tblOrgEntities_InstitutionID]  DEFAULT ((0)) FOR [InstitutionID]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  CONSTRAINT [DF__tblOrgEnt__SortO__2D37690B]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[tblOrgEntities] ADD  DEFAULT ((-1)) FOR [AssocContractID]
GO
USE [master]
GO
ALTER DATABASE [CATS] SET  READ_WRITE 
GO
