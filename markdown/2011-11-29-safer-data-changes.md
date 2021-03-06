<!--# set var="title" value="Safe(r) data changes" -->
<!--# set var="date" value="2011-11-29" -->

<!--# include file="include/top.html" -->

It's a great goal to avoid making manual changes to your database. It never works 100%, though; there are always software bugs, unexpected interactions and other events that muck up your data, and you have to do one-off corrections. These are inherently hazardous: hard to test for unexpected data corruption, hard to apply consistently and hard to model the application behavior that results from them. Here are some strategies for the first issue, avoiding unexpected data corruption.

1. Don't run one-off executables against your database. Instead, have the executable print out SQL that it would have run to update the database. If something goes wrong, you don't have to model the behavior of the program; you can just look at the SQL.
1. Check the SQL files into source control somewhere. Manual changes tend to breed more manual changes to fix the fixes, so you never know when you'll want a record of what you twiddled in the past.
1. Include all fields from the primary key in the WHERE clause. This ensures that each statement only modifies one row. Even if this results in a huge list of changes, at least you know exactly what changed.
1. Include as many additional gating clauses as possible, linked with AND. For example, if you have a table of products and you want to set the price to 0.99 for everything that is currently set to 1.00, do:

        UPDATE Products SET Price=0.99 WHERE ProductId=2762 AND Price=1.00;

   This ensures that if something else changes Price just before you run your change, you don't destroy that update.
1. Record the number of rows affected by each statement, in case something unexpected happens.
1. Use transactions sensibly. Overly huge grouping of statements can block replication, but consider whether your changes will be toxic if partially applied.
1. Stop running changes on errors or warnings and let a human examine the output. Warnings like string truncation can be a sign of a broken change.

\#4 can be a challenge if your verification statements are complex. Consider, for example, if you want to update rows in table A for which there is exactly one row for a particular CustomerId. It's relatively easy to do a SELECT statement to verify this by hand:

    SELECT
        CustomerId,
        COUNT(CustomerId)
      FROM A
      WHERE
        CustomerId IN (15, 16)
      GROUP BY CustomerId;

To verify this at UPDATE time, however, you either need a subselect or an intermediate table. We'll use the latter:

    CREATE TABLE ScratchTable AS
      SELECT
          CustomerId,
          COUNT(CustomerId) AS Customers
        FROM A
        WHERE
          CustomerId IN (15, 16)
        GROUP BY CustomerId;

    UPDATE A
      JOIN ScratchTable USING (CustomerId)
      SET Updated=1
      WHERE
        A.Id=3
        AND Customers=1;

The same trick works if your data change inserts new rows:

    INSERT INTO A (CustomerId)
      SELECT CustomerId
        FROM ScratchTable
        WHERE
          CustomerId=15
          AND Customers=1;

<!--# include file="include/bottom.html" -->
