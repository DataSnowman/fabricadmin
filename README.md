# fabricadmin
Repo with Samples for Microsoft Fabric Administration

Use this repo for learning and skilling related to Microsoft Fabric Fundamentals

Welcome to the workhop.  The purpose of the workshop is to bring you up to speed on some of the Fabric Admin, Lakehouse, Data Engineering, and Data Integration experiences in Microsoft Fabric.  You will be using resources in a Microsoft Fabric tenant and in a Fabric Workspace for this workshop.

## Fabric Admin Tools:

* Microsoft Fabric [Fabric Admin](https://learn.microsoft.com/en-us/fabric/admin/microsoft-fabric-admin) and [Fabric Documentation for Admins](https://learn.microsoft.com/en-us/fabric/admin/) and [All Fabric Documentation](https://learn.microsoft.com/en-us/fabric/)
* [Microsoft OneLake file explorer for Windows](https://www.microsoft.com/en-us/download/details.aspx?id=105222)
* GitHub [This Repo](https://github.com/DataSnowman/fabricadmin) and [Fabric Docs](https://github.com/MicrosoftDocs/fabric-docs/tree/main/docs)
* VSCode [Install](https://code.visualstudio.com/download) and [Extension](https://marketplace.visualstudio.com/items?itemName=ms-mssql.sql-database-projects-vscode)
* Azure Data Studio [Install](https://learn.microsoft.com/en-us/azure-data-studio/download-azure-data-studio?tabs=win-install%2Cwin-user-install%2Credhat-install%2Cwindows-uninstall%2Credhat-uninstall) and [Documentation](https://learn.microsoft.com/en-us/azure-data-studio/)
* SQL Server Management Studio (SSMS) [Install](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) and [Documentation](https://learn.microsoft.com/en-us/fabric/data-warehouse/connectivity)

## Get Sample Datasource

Download to your computer, one or more years of Medicare Part D data like 2013
[Medicare Part D Prescribers - by Provider and Drug](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider-and-drug/data/2013)

![downloadcsv](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/downloadcsv.png)

## Part 1: Lakehouse and Data Engineering

Log into Microsoft Fabric at https://fabric.microsoft.com with your Azure Active Directory userid (work email) and password.  Same one you use to access M365.

![fabrichome](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/fabrichome.png)

Since we want to create a lakehouse and do data engineering tasks click on the Microsoft Fabric icon in the bottom left corner and select Data Engineering

![fabricicon](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/fabricicon.png)

`Note: If you have not been assigned a Fabric Workspace you may need to create one.  If you are taking a training with and an instructor please check with your instructor.`

### Use your assigned Workspace or Create a Workspace (If you don't currently have one assigned)

Click on Workspaces on the left nav bar and select your assigned Workspace.  If you have an assigned Workspace jump forward to the `Create a Lakehouse` section below.

If you don't have a workspace click on +New workspace

![newworkspace](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/newworkspace.png)

Give the workspace a name like fabriclakehouse (or if you have multiple users taking the workshop prehaps add you intials fabriclakehouse-des).  If using a trial make sure to chose the Trial License mode under the Advanced area.  Or chose a Fabric Capacity if you have access.  Click Apply.

![createws](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/createws.png)

### Create a Lakehouse

You now should be in your new workspace.  Click on New and choose Lakehouse.  

![createlh](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/createlh.png)

This will pop up a New Lakehouse dialog.  Enter a name like `medicarepartd` and click Create

![lhname](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/lhname.png)

This will create an open up your new Lakehouse.

```Note that the Lakehouse and the concept around OneLake and Delta/Parquet files is the foundation of Data Engineering and Data Science use cases using Fabric```

![explorelh](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/explorelh.png)

You are now ready to start doing some data engineering.  You are going to first want to create some new subfolders under Files

### Upload some files into the Lakehouse

![newsub](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/newsub.png)

Enter a name for your new subfolder and click Create

![medicaresf](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/medicaresf.png)

Add additional subfolders so it looks like this

![subs](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/subs.png)

You can also use the OneLake Windows Explorer to create subfolders and copy files

![olwe](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/olwe.png)

If you have not already done so, download the Medicare PartD files [here](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider-and-drug/data/2013) for as many years as you like.  At the time of writing this there were 9 years from 2013 to 2021 available.  You can toggle to the year you want to Export and the top and click export to download the year csv as a zip file.

![exportmpd](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/exportmpd.png)

Upload all the zip files into the zip subfolder using the OneLake Windows Explorer or the Fabric lakehouse browser

![upload](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/upload.png)

All the files should look like this

![zip](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/zip.png)

Or if you just uploaded one file more like this

![onezip](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/onezip.png)

### Create a Data Factory Pipeline to unzip and copy the files to the raw folder

Go back into the Workspace and create a new Data pipeline.  Click on Data Pipeline 

![newpl](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/newpl.png)

Name the pipeline something like `UnzipLoad` and click Create

![createpl](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/createpl.png)

This will open up the Data Factory pipeline.  Click on Add pipeline activity and select Copy data

![copydata](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/copydata.png)

Give the Copy activity a name like `Unzip and Copy to raw`

![UnzipCopyRaw](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/UnzipCopyRaw.png)

On the Source tab choose the Workspace, Lakehouse, Files, and File Path and browse to the zip folder and click Ok

![sourcebrowse](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/sourcebrowse.png)

Your source choice should look like this:

File path: `medicare/zip`

Recursively: checked

File Format: Binary

Click on Settings and select Compression Type: `ZipDeflate (.zip)`

Preserve zip file name as folder: unchecked

![sourceunzip](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/sourceunzip.png)

On the Destination tab choose the Workspace, Lakehouse, Files, and File Path and browse to the raw folder and click Ok

File path: `medicare/raw`

File Format: Binary

![destinationraw](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/destinationraw.png)

Save and Run the pipeline

![inprogress](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/inprogress.png)

The pipeline will take the zipfiles in `medicare/zip`

![zipfiles](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/zipfiles.png)

And when succeeded

![succeeded](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/succeeded.png)

And uzip them to `medicare/raw`

![unzippedfiles.png](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/zipfiles.png)

### Load all the files into a Delta Table using a Data Engineering Notebook

To get a copy of the `LoadMedicarePartDfiles.ipynb` notebook either click [here](https://github.com/DataSnowman/fabricadmin/tree/main/medicarepartd/code/notebook) and download the notebook.  Or you can clone the GitHub Repo to your computer

```
git clone https://github.com/DataSnowman/fabricadmin.git
```

Import the notebook into the workspace by navigating to the workspace and clicking on Import notebook 

![importnb](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/importnb.png)

Click Upload and select the notebook and click Open

![uploadnb](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/uploadnb.png)

Click on Go to workspace

![gotows](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/gotows.png)

Click on the `LoadMedicarePartDfiles` notebook

![loadmpdfiles](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/loadmpdfiles.png)

Remove the existing Lakehouse (the one I created it in originally) by clicking on the `>` to the right of Lakehouse

![removelh1](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/removelh1.png)

Click on double arrow and click on `Remove all Lakehouses`

![removelh2](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/removelh2.png)

Click on Continue

![removecontinue](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/removecontinue.png)

Click `Add` button below Add lakehouse

![addlh](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/addlh.png)

Choose Existing lakehouse Add button

![existinglh](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/existinglh.png)

Choose the data you want to connect to `medicarepartD` lakehouse and click Add

![choosedata](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/choosedata.png)

Now your notebook should look like this:

![nbtorun](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/nbtorun.png)

The first two cells of the notebook include schemas for the csvs and for the Delta/Parquet table

![2cells](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/2cells.png)

The third cell has the logic for loading the 9 csv files

![3rdcell](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/3rdcell.png)

You can chose to run one cell at a time or click on Run all.  It will take about 20-25 minutes for the tables to load

When it is running you may get some messages like this since the files have a number of null columns.  This is fine.

![nbrunning](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/nbrunning.png)

The notebook creates the medicarepartd Delta table in the Lakehouse

![medicarepartdtable](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/medicarepartdtable.png)


### Open and query the Delta Table using the Lakehouse SQL analytics endpoint

In the top right corner of the Lakehouse interface you can switch to the SQL analytics endpoint

![switchtosqlep](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/switchtosqlep.png)

The Delta table automatically creates a SQL Table that can be queried with SQL

![sqlep](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/sqlep.png)

Click on `New SQL query`

![newquery](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/newquery.png)

Copy the existing query to count the rows loaded by fourdigityear which represents the number of rows in each yearly csv file

```
SELECT fourdigityear, count(Prscrbr_NPI) as numrows FROM medicarepartd GROUP BY fourdigityear
``````

Click Run

![rowsbyyear](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/rowsbyyear.png)

If you highlight the SQL statement you can click `Save as view` to create a view like `yearrowtotalsvw`

![saveasaview](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/saveasaview.png)

Click OK 

Find the view and look at the data prreview

![viewdatapreview](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/viewdatapreview.png)

In a similar way you can download the data in the query to Excel.  If you highlight the SQL statement you can click Open in Excel to create an Excel file.

![excel](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/excel.png)

Click Continue and save and open the Excel file, Authenticate, etc

Two give users Read access to the table and views created in the Lakehouse just provide the user with Viewer access to the workspace.  Click on Manage access

![manageaccess](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/manageaccess.png)

Select the user or security group and select `Viewer` and click `Add`

![viewaccess](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/viewaccess.png)

The user or the users in the security group now have read access to the tables and views

![readaccess](https://raw.githubusercontent.com/datasnowman/fabricadmin/main/images/readaccess.png)




