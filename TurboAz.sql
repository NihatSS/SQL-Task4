create table Seats(
	[Id] int primary key identity(1,1),
	[Count] int
)

create table Colors(
	[Id] int primary key identity(1,1),
	[Color] nvarchar(100)
)


create table Brands(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)
)

create table Volumes(
	[Id] int primary key identity(1,1),
	[MinVolume] int,
	[MaxVolume] int
)


create table Powers(
	[Id] int primary key identity(1,1),
	[Power] int
)


create table Gears(
	[Id] int primary key identity(1,1),
	[Type] nvarchar(100)
)


create table Models(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[BrandId] int,
	[VolumeId] int,
	[PowerId] int,
	[GearId] int,
	foreign key (BrandId) references Brands(Id),
	foreign key (VolumeId) references Volumes(Id),
	foreign key (PowerId) references Powers(Id),
	foreign key (GearId) references Gears(Id)
)


create table Currency(
	[Id] int primary key identity(1,1),
	[Type] nvarchar(100)
)


create table Prices(
	[Id] int primary key identity(1,1),
	[Value] int,
	[CurrencyId] int,
	foreign key (CurrencyId) references Currency(Id)
)


create table Cities(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)
)

create table Owners(
	[Id] int primary key identity(1,1),
	[Number] nvarchar(100),
	[CityId] int,
	foreign key (CityId) references Cities(Id)
)


create table Situation(
	[Id] int primary key identity(1,1),
	[Stroked] bit not null default 0,
	[Colored] bit not null default 0,
	[AcciendOrSpareParts] bit not null default 0,
)


create table Statuses(
	[Id] int primary key identity(1,1),
	[OnSale] bit not null default 0,
	[IsNew] bit not null default 0
)



create table GearBoxs(
	[Id] int primary key identity(1,1),
	[Type] nvarchar(100)
)


create table Categories(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)
)


create table Vehicles(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[ModelId] int,
	[PriceId] int,
	[SituationId] int,
	[StatusId] int,
	[GearBoxId] int,
	[CategoryId] int,
	foreign key (ModelId) references Models(Id), 
	foreign key (PriceId) references Prices(Id), 
	foreign key (SituationId) references Situation(Id), 
	foreign key (GearBoxId) references GearBoxs(Id), 
	foreign key (CategoryId) references Categories(Id), 
)


Create table VehicleColors(
	[Id] int primary key identity(1,1),
	[ColorId] int,
	[VehicleId] int,
	foreign key (ColorId) references Colors(Id),
	foreign key (VehicleId) references Vehicles(Id)
)


Create table ModelSeats(
	[Id] int primary key identity(1,1),
	[ModelId] int,
	[SeatId] int,
	foreign key (ModelId) references Models(Id),
	foreign key (SeatId) references Seats(Id)
)


Create table VehicleOwners(
	[Id] int primary key identity(1,1),
	[OwnerId] int,
	[VehicleId] int,
	foreign key (OwnerId) references Owners(Id),
	foreign key (VehicleId) references Vehicles(Id)
)