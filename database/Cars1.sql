use [Car1DB]
go

drop table Cars
go

create table Cars
(
Id int  identity(1,1) primary key not null,
CarName nvarchar(50) not null,
CarModel nvarchar(50) not null,
Company nvarchar(50) not null,
Price int
);
go


Create procedure [dbo].[AddNewCarDetails]
(
@Id int,
@CarName nvarchar (50),
@CarModel nvarchar (50),
@Company nvarchar (50),
@Price int
)
as
begin
Insert into Cars values(@Id,@CarName,@CarModel,@Company,@Price)
select SCOPE_IDENTITY() InsertedId
end
go



CREATE Procedure [dbo].[GetCars]  
@Id int = null,
	@Search nvarchar(50) = null,
	@OrderBy varchar(100) = 'name',
	@IsDescending bit = 0
as begin
	select 
		Id,
		CarName,
		CarModel,
		Company,
		Price
		
	from 
		Cars
	where
		Id = coalesce(@Id, Id)
		and
		(
			(@Search is null or @Search = '')
			or
			(
				@Search is not null
				and
				(
					CarName like '%' + @Search + '%'
					or
					CarModel like '%' + @Search + '%'
					or
					Company like '%' + @Search + '%'
					or
					Price like '%' + @Search + '%'
				)
			)
		)
	order by
		case when @OrderBy = 'carname' and @IsDescending = 0 then CarName end asc
		, case when @OrderBy = 'carname' and @IsDescending = 1 then CarName end desc
		, case when @OrderBy = 'carmodel' and @IsDescending = 0 then CarModel end asc
		, case when @OrderBy = 'carmodel' and @IsDescending = 1 then CarModel end desc
		, case when @OrderBy = 'company' and @IsDescending = 0 then Company end asc
		, case when @OrderBy = 'company' and @IsDescending = 1 then Company end desc
		, case when @OrderBy = 'price' and @IsDescending = 0 then Price end asc
		, case when @OrderBy = 'price' and @IsDescending = 1 then Price end desc
end
go

SET IDENTITY_INSERT [dbo].[Cars] ON 
GO
INSERT [dbo].[Cars] ([Id], [CarName], [CarModel], [Company], [Price]) VALUES (1, N'Lamborghini', N'Diablo', N'Volkswagen AG', 30000000)
GO
INSERT [dbo].[Cars] ([Id], [CarName], [CarModel], [Company], [Price]) VALUES (2, N'Ford', N'Raptor', N'Ford', 52000000)
GO
INSERT [dbo].[Cars] ([Id], [CarName], [CarModel], [Company], [Price]) VALUES (3, N'Ferrari', N' Testarossa',  N'Ferrari', 400000000)
GO
SET IDENTITY_INSERT [dbo].[Cars] OFF
GO



create proc [dbo].[Cars_Get]
	@Id int
as begin
	select 
		Id,
		CarName,
		CarModel,
		Company,
		Price
	from 
		Cars
	where 
		Id = @Id
end
go



Create procedure [dbo].[UpdateCarDetails]
(
@Id int,
@CarName nvarchar (50),
@CarModel nvarchar (50),
@Company nvarchar (50),
@Price int
)
as
begin
Update Cars
set 
CarName=@CarName,
CarModel=@CarModel,
Company=@Company,
Price=@Price
where Id=@Id
End 
go

drop proc [dbo].[DeleteCarById]
go

Create procedure [dbo].[DeleteCarById]
(
@Id int
)
as
begin
Delete from Cars where Id=@Id
End
go