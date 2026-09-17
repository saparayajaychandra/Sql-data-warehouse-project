/*
===============================================================================
Stored Procedure: Load Bronze Layer
===============================================================================
Purpose:
    Loads raw data from CRM and ERP CSV files into Bronze tables.

    - Truncates existing Bronze tables
    - Bulk inserts CSV data
    - Tracks individual table load duration
    - Tracks total batch load duration
    - Handles errors using TRY/CATCH
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN

    -- =========================================================
    -- Declare Variables
    -- =========================================================

    DECLARE 
        @batch_start_time DATETIME,
        @batch_end_time   DATETIME,
        @start_time       DATETIME,
        @end_time         DATETIME;

    BEGIN TRY

        -- =========================================================
        -- Start Batch Timer
        -- =========================================================

        SET @batch_start_time = GETDATE();


        PRINT '===========================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '===========================================================';


        -- =========================================================
        -- CRM TABLES
        -- =========================================================

        PRINT '-----------------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '-----------------------------------------------------------';


        -- =========================================================
        -- CRM Customer Information
        -- =========================================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_cust_info';

        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting Data Into: bronze.crm_cust_info';

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\Hp\OneDrive\Desktop\SQL Data WareHouse\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
              + ' seconds';

        PRINT '-------------------------------------------------------------------------------------------';


        -- =========================================================
        -- CRM Product Information
        -- =========================================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_prd_info';

        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting Data Into: bronze.crm_prd_info';

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Hp\OneDrive\Desktop\SQL Data WareHouse\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
              + ' seconds';

        PRINT '-------------------------------------------------------------------------------------------';


        -- =========================================================
        -- CRM Sales Details
        -- =========================================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_sales_details';

        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting Data Into: bronze.crm_sales_details';

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Hp\OneDrive\Desktop\SQL Data WareHouse\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
              + ' seconds';

        PRINT '-------------------------------------------------------------------------------------------';


        -- =========================================================
        -- ERP TABLES
        -- =========================================================

        PRINT '-----------------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '-----------------------------------------------------------';


        -- =========================================================
        -- ERP Customer
        -- =========================================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_cust_az12';

        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting Data Into: bronze.erp_cust_az12';

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\Hp\OneDrive\Desktop\SQL Data WareHouse\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
              + ' seconds';

        PRINT '-------------------------------------------------------------------------------------------';


        -- =========================================================
        -- ERP Location
        -- =========================================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_loc_a101';

        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting Data Into: bronze.erp_loc_a101';

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Hp\OneDrive\Desktop\SQL Data WareHouse\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
              + ' seconds';

        PRINT '-------------------------------------------------------------------------------------------';


        -- =========================================================
        -- ERP Product Category
        -- =========================================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Hp\OneDrive\Desktop\SQL Data WareHouse\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
              + ' seconds';

        PRINT '-------------------------------------------------------------------------------------------';


        -- =========================================================
        -- End Batch Timer
        -- =========================================================

        SET @batch_end_time = GETDATE();


        -- =========================================================
        -- Completion Message
        -- =========================================================

        PRINT '===========================================================';
        PRINT 'LOADING BRONZE LAYER IS COMPLETED';
        PRINT '===========================================================';

        PRINT '>> TOTAL LOAD DURATION: '
              + CAST(
                    DATEDIFF(
                        SECOND,
                        @batch_start_time,
                        @batch_end_time
                    ) AS NVARCHAR
                )
              + ' seconds';

        PRINT '===========================================================';


    END TRY


    -- =========================================================
    -- ERROR HANDLING
    -- =========================================================

    BEGIN CATCH

        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT '==========================================';

        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();

        PRINT 'ERROR NUMBER: '
              + CAST(ERROR_NUMBER() AS NVARCHAR);

        PRINT 'ERROR STATE: '
              + CAST(ERROR_STATE() AS NVARCHAR);

        PRINT 'ERROR LINE: '
              + CAST(ERROR_LINE() AS NVARCHAR);

        PRINT '==========================================';

    END CATCH

END;
GO


EXEC bronze.load_bronze;
GO
