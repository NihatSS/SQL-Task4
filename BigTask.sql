create table Teachers(
	[Id] int primary key identity(1,1),
	[FullName] nvarchar(100),
	[Age] int,
	[Salary] int,
	[SubjectId] int,
	[CityId] int,
	foreign key (SubjectId) references Subjects(Id),
	foreign key (CityId) references Cities(Id)
)


insert into Teachers([FullName],[Age],[Salary],[SubjectId],[CityId])
values('Cavid Bashirov',30,3000,1,1),
	  ('Kubre Memmedova',24,2500,2,3),
	  ('Elza Seyidcahan',40,5000,3,1),
	  ('Namiq Qaracuxurlu',38,200,4,2)

create table Students(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[Surname] nvarchar(100),
	[Age] int,
	[Email] nvarchar(100),
	[Birthday] datetime,
	[TeacherId] int,
	[CityId] int,
	[ClassId] int,
	foreign key (ClassId) references Classes(Id),
	foreign key (CityId) references Cities(Id),
	foreign key (TeacherId) references Teachers(Id)
)

insert into Students([Name],[Surname],[Age],[Email],[Birthday],[TeacherId],[CityId],[ClassId])
values('Nihat','Soltanov',17,'nihat@gmail.com','2006.09.12',1,5,1),
	  ('Ferdi','Ismayilzade',18,'ferdi@gmail.com','2005.05.02',1,1,1),
	  ('Samir','Naci',16,'samir@gmail.com','2007.03.22',2,4,2),
	  ('Irade','Soltanova',16,'irade@gmail.com','2008.08.27',4,5,4),
	  ('Terxan','Zeynalabdiyev',25,'tarxan@gmail.com','1999.02.09',3,2,3)


create table Room(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[Capacity] int
)

insert into Room([Name],[Capacity])
values('12',25),
	  ('10',30),
	  ('9',17),
	  ('15',20),
	  ('11',35)

create table Classes(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
)

insert into Classes([Name])
values('PB102'),
	  ('11A'),
	  ('9C'),
	  ('10B')


create table TeacherClasses(
	[Id] int primary key identity(1,1),
	[TeacherId] int,
	[ClassId] int,
	foreign key (TeacherId) references Teachers(Id),
	foreign key (ClassId) references Classes(Id)
)

insert into TeacherClasses([TeacherId],[ClassID])
values(1,1),
	  (2,1),
	  (2,2),
	  (1,4),
	  (4,3)



create table RoomClasses(
	[Id] int primary key identity(1,1),
	[RoomId] int,
	[ClassId] int,
	foreign key (RoomId) references Room(Id),
	foreign key (ClassId) references Classes(Id)
)

insert into RoomClasses([RoomId],[ClassId])
values(1,1),
	  (2,4),
	  (3,3),
	  (5,3),
	  (4,2)



create table Subjects(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)
)

insert into Subjects([Name])
values('BackEnd development'),
	  ('Riyaziyyeat'),
	  ('Tarix'),
	  ('Ingilis dili'),
	  ('Edebiyyat')



create table SubjectClasses(
	[Id] int primary key identity(1,1),
	[SubjectId] int,
	[ClassId] int,
	foreign key (SubjectId) references Subjects(Id),
	foreign key (ClassId) references Classes(Id)
)

insert into SubjectClasses([SubjectId],[ClassId])
values(1,1),
	  (2,1),
	  (3,2),
	  (4,2),
	  (5,3)


create table StaffMembers(
	[Id] int primary key identity(1,1),
	[FullName] nvarchar(100),
	[Salary] int,
	[CityId] int,
	foreign key (CityId) references Cities(Id)
)

insert into StaffMembers([FullName],[Salary],[CityId])
values('Senan Soltanov',4000,5),
	  ('Yegane Memmedova',1500,1),
	  ('Valeh Meherremov',3000,1),
	  ('Hemid Aliyev',2000,2)



create table Roles(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)
)

insert into Roles([Name])
values('Principarl'),
	  ('Coach'),
	  ('Librarian'),
	  ('Nurse')

create table StaffMemberRoles(
	[Id] int primary key identity(1,1),
	[RoleId] int,
	[StaffMemberId] int,
	foreign key (RoleId) references Roles(id),
	foreign key (StaffMemberId) references StaffMembers(Id)
)

insert into StaffMemberRoles([RoleId],[StaffMemberId])
values(1,1),
	  (2,4),
	  (4,2),
	  (3,3)

create table Cities(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[CountryId] int,
	foreign key (CountryId) references Countries(Id)
)

insert into Cities([Name],[CountryId])
values('Baki',1),
	  ('Sumqayit',1),
	  ('Moskva',4),
	  ('New York',2),
	  ('Salyan',1)


create table Countries(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)
)

insert into Countries([Name])
values('Azerbaycan'),
	  ('Amerika'),
	  ('Ingiltere'),
	  ('Rusiya')



--1)
create function fn_TeachersStudentsAvgAgeMultiply()
returns int
begin
declare @studentsAvgAge int = (select AVG([Age]) from Students)
declare @teachersAvgAge int = (select AVG([Age]) from Teachers)
return @studentsAvgAge * @teachersAvgAge
end

select dbo.fn_TeachersStudentsAvgAgeMultiply()

--2)

select * from Students where [CityId] != 1

select * from Students


--3)

declare @studentsAgeSum int = (select SUM([Age]) from Students)
declare @teachersAgeSum int = (select SUM([Age]) from Teachers)

print @studentsAgeSum + @teachersAgeSum

--4)

create view vw_GetStudents
as
select std.[Name],std.[Surname],std.Age,std.Email,ct.[Name] as 'City',co.[Name] as 'Country',cl.[Name] as 'Class'  from Students std
inner join Cities ct
on std.CityId=ct.Id
join Classes cl
on std.ClassId=cl.Id
inner join Countries co
on ct.CountryId=co.Id

select * from vw_GetStudents


--5)

create view vw_GetClassesWithSubjects
as
select cl.[Name] as 'Class name', sb.[Name] as 'Subject' from Classes cl
join SubjectClasses sc
on cl.Id = sc.ClassId
join Subjects sb
on sb.Id = sc.SubjectId


select * from vw_GetClassesWithSubjects


--6)

create function fn_SerchStudent(@stdName nvarchar(100))
returns table
as
return
	select * from Students where [Name] = @stdName

select * from fn_SerchStudent('Nihat')
--7)

select sm.[FullName], rl.[Name]  from StaffMembers sm
join StaffMemberRoles smr
on sm.Id = smr.[StaffMemberId]
join Roles rl
on rl.Id = smr.[RoleId]


--8)

create function fn_GetStudentsByAge(@age int)
returns int
begin
	return (select COUNT(*) from Students where [Age] > @age)
end


select * from Students
select dbo.fn_GetStudentsByAge(20)



--9)
create procedure usp_AddStudent 
@name nvarchar(100), 
@surname nvarchar(100),
@age nvarchar(100),
@email nvarchar(100),
@birthday datetime,
@teacherId int,
@cityId int,
@classId int
as
insert into Students([Name],[Surname],[Age],[Email],[Birthday],[TeacherId],[CityId],[ClassId])
values(@name,@surname,@age,@email,@birthday,@teacherId,@cityId,@classId)


exec usp_AddStudent 'Aqil','Ismayilov',28,'aqil@gmail.com','1996.03.30',1,1,1
select * from Students


--10)
alter table Teachers
add SoftDeleted bit not null default 0

create procedure usp_SoftDeleteTeacherById
@id int
as
update Teachers
set SoftDeleted = 1
where [Id] = @id

exec usp_SoftDeleteTeacherById 3

select * from Teachers


--11)
create function fn_GetAllStudentsByTeacherId(@teacherId int)
returns table
as
return
	select std.* from Teachers tc
	inner join TeacherClasses tcl
	on tc.Id=tcl.TeacherId
	join Classes cl
	on cl.Id=tcl.ClassId
	join Students std
	on std.ClassId=cl.Id
	where tc.Id=@teacherId


select * from fn_GetAllStudentsByTeacherId(1)


--12)
create function fn_GetStudentsByBithday(@from datetime, @to datetime)
returns table
as
return
	select * from Students where [Birthday] between @from and @to




select * from Students
select * from dbo.fn_GetStudentsByBithday('2004-01-01','2010-01-01')



--13)
create function fn_GetStaffMembersBySalary(@from int, @to int)
returns table
as
return
	select * from StaffMembers where [Salary] >= @from and [Salary] <= @to

select * from StaffMembers


select * from fn_GetStaffMembersBySalary(2000,4000)


--14)

create procedure usp_UpdateTeachersSalaryById 
@id int,
@newSalary int
as
	update Teachers
	set [Salary] = @newSalary
	where [Id] = @id

select * from Teachers

exec usp_UpdateTeachersSalaryById 1,4000

--15)

create function fn_GetAllPersonsByAge(@from int, @to int)
returns int
begin
	declare @studentAge int = (select COUNT(*) from Students where [Age] between @from and @to)
	declare @teacherAge int = (select COUNT(*) from Teachers where [Age] between @from and @to)
	return
end



--16)

--Muellim teachers de email olmadigina gore students e gore yazdim.

create function fn_GetStudentsByEmail(@email nvarchar(100))
returns table
as
return
	select * from Students where [Email] like (@email + '%');

select * from fn_GetStudentsByEmail('f') 

--17)

create view vw_GetStaffMembers
as
select sm.*, ct.[Name] as 'City', co.[Name] as 'County' from StaffMembers sm
inner join Cities ct
on sm.[CityId] = ct.[Id]
join Countries co
on ct.[CountryId] = co.[Id]


select * from vw_GetStaffMembers
select [Birthday] from Students

--18)

create function fn_MultiplyMaxStdAgeAndMinTeacherAge()
returns int
begin
	declare @maxStdAge int = (select MAX([age]) from Students)
	declare @minTeacherAge int = (select MIN([age]) from Students)
	return @maxStdAge * @minTeacherAge
end

select dbo.fn_MultiplyMaxStdAgeAndMinTeacherAge()
