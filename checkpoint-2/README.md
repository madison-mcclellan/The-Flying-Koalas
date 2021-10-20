# Checkpoint 2: Data Exploration 

In this checkpoint, we sought to answer the following questions through data visualization in Tableau:
* Is there an overlap between officers with a high number of tactical response reports (TRRs) and officers with a high number of complaint reports (CRs) filed against them?
* Is there a correlation between an officer's use of a firearm and the lighting conditions of the incident?

### Navigating the Tableau Workbooks
Each figure in the findings.pdf document has its own Tableau workbook which can be found in the src directory. The figures and their corresponding workbooks are as follows:
* Figure 1.1 - CR_TRR.twb
* Figure 1.2 - CR_TRR_Verbal.twb
* Figure 2.1 - Firearm_Total.twb
* Figure 2.2 - Firearm_District4.twb
* Figure 2.3 - Firearm_District20.twb

Because we used data from CSV files in these workbooks, each workbook also has a corresponding CSV file in the data directory. The name of the CSV file matches the name of the .twb file. 

To run the workbook in Tableau, clone the repository to your local file system and open the desired workbook. When Tableau opens, an error message will occur saying that it cannot locate the data source. This is because it is searching for a local file path, which will vary laptop-to-laptop. Thus, you must right click the data source on the lefthand side of the screen and select "Edit Data Source," then navigate to the data directory and select the CSV file with the same name as the current workbook. This will load the correct data source and you will be able to view the visualizaiton. 