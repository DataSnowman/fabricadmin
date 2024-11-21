CREATE PROCEDURE [dev].[usp_CreateAndPopulateDimTables]
AS
BEGIN
    -- Step 1: Create Tables
    -- Create cms_provider_dim_drug table
    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='cms_provider_dim_drug' AND xtype='U')
    BEGIN
        CREATE TABLE [dev].[cms_provider_dim_drug]
        (
            [Brnd_Name] [varchar](8000)  NULL,
	        [Gnrc_Name] [varchar](8000)  NULL,
	        [Max_Year] [int]  NULL,
	        [Min_Year] [int]  NULL,
	        [drug_key] [bigint]  NULL
        )
    END

    -- Create cms_provider_dim_year table
    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='cms_provider_dim_year' AND xtype='U')
    BEGIN
        CREATE TABLE [dev].[cms_provider_dim_year]
        (
            [Year] [int]  NULL,
            [Year_Date_Key] [date]  NULL
        )
    END

    -- Step 2: Populate Tables
    -- Populate cms_provider_dim_drug
    INSERT INTO [dev].[cms_provider_dim_drug] (Brnd_Name, Gnrc_Name, Max_Year, Min_Year, drug_key)
    SELECT [Brnd_Name]
          ,[Gnrc_Name]
          ,MAX([fourdigityear]) AS [Max_Year]
          ,MIN([fourdigityear]) AS [Min_Year]
          ,ROW_NUMBER() OVER (ORDER BY [Brnd_Name],[Gnrc_Name] ASC) AS [drug_key]
    FROM [medicarepartd].[dbo].[medicarepartd]
    GROUP BY [Brnd_Name],[Gnrc_Name]

    -- Populate cms_provider_dim_year
    INSERT INTO [dev].[cms_provider_dim_year] (Year, Year_Date_Key)
    SELECT DISTINCT [fourdigityear]
          ,CAST(CONCAT('1-1-',CAST([fourdigityear] AS varchar)) AS date) AS [Year_Date_Key]
    FROM [medicarepartd].[dbo].[medicarepartd]

END