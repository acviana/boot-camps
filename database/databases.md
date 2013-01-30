Introduction
============

Welcome to the Software Carpentry screencast on Databases. This screencast is an introduction to databases. In this screencast we'll try to give you a sense of what databases are and what you can do with them.

A database is a way to store and manipulate information that is arranged as tables. Each table has columns (also known as fields) which describe the data, and rows (also known as records) which contain the data.

This table you see here is a log of all of the work done on experiments in a research lab, broken down by project and scientist. Each record in the table describes an Experiment. There is a field for loginID of the scientist running the experiment, the project, experiment name, hours spent on the experiment, and date the experiment was run.

In a spreadsheet, you insert formulas or new sheets to analyse your data. In a database, you give commands, also known as Queries, the database does the analysis your query specifies, and returns the results in a tabular form.

Queries you give are written in a simple, english-like, language called SQL, which stands for "Structured Query Language". SQL is a vast language that provides all sorts of ways of mixing and remixing your data. In this lecture we'll assume you already have a database, and so we'll only be discussing queries that extract and analyze data.

Broadly speaking though, there are only six basic types of operations you can do with a database. Each operation extracts or transforms data from a previous operation, to form a pipeline or flow of data that ends with the results you get back. We're going to give you a preview of the basic database operations now in order to give you a flavour of what databases can do. In the other database screencasts we'll show you this all in much more detail, along with showing you how to accomplish common analysis tasks.

So, let's begin with the data we saw in the first slide. The `SELECT` operation simply extracts various fields from a table or from the results of other another query. This is obviously a fundamental operation: if you want to get data out of the database you'll need to use the `SELECT` operator to tell the database where to find the data you're interested in.

The `APPEND` operation adds new, calculated fields to the results, like rounding the values in another column. The `SORT` operation orders the results by the values in a field. The `FILTER` operation chooses records to include based on `TRUE` or `FALSE` conditions. So, here is an illustration of a query that filters for records that have Hours values of 5 or greater.

The `AGGREGATE` operation summarizes groups of records into new records. This is useful for calculating the `SUM`, `MAX`, `MIN`, `Average` or a `count` of records that share a unique set of fields. Here we see the Hours being totaled for each project.

Suppose we had a Person table that shows more details on each of the scientists. The `JOIN` operation joins two (or more) tables together by combining records based on `TRUE` or `FALSE` conditions.

We could use this operation to return results from the `Experiment` table with the full names of the corresponding scientists from the Person table:

A database is the right tool for managing complex and structured data, that is spread over many different tables. Databases are also designed to work quickly on very large data sets—much larger than can comfortably be managed with a spreadsheet. Queries allow for great flexibility in how you are able to analyse your data. This makes databases a good choice for if you need to explore or mix and remixing it in many different ways. Unlike spreadsheets, databases do not typically have built in charting and visualising tools. But, it's always possible to export the results of a query to be used in other tools.

So, summing up: A database is a set of tables of data on which you can explore and manipulate using queries. We've seen six basic kinds of operations that you can do on the data in a database: `SELECT`, `APPEND`, `FILTER`, `AGGREGATE`, `JOIN`, `SORT`.

In this screencast we've tried to give you a flavour of the sorts of remixing you can do by showing you the basic operations. Databases are the right tool for managing large amounts of data, or data that is complex. They are useful when you need to remix and explore your data in different ways.

Selecting Data
==============

Welcome to the Software Carpentry screencast on Databases. This screencast is on retreiving data from tables in a database. Databases come in many flavours. In these screencasts we will be using the SQLite Manager plugin for Firefox to interact with our database.

As we've seen, a database is a way to store information that is arranged as tables. We will be using a database that has a single table named Experiment. This table is a log of all of the work done on experiments in a research lab, broken down by project and scientist. The table has a column for the login id of the scientist, the name of their project, a numeric id for their experiment, how many hours they spent on it, and when it took place. Each row, or record, in this table describes one scientist's work on a certain experiment on a given date. To start, lets write an SQL query that retrieves the loginID and the Project name from the Experiment table.

We do that by using the SQL command, `SELECT`. We then list the columns we want to read from the database table. We want the `LoginID`, and `Project` name, so we write those column names, and then we write `FROM`, and the name of the table we want the data from, `Experiment`:

```
SELECT LoginID, Project FROM Experiment;
```

We put a semi-colon at the end to tell the database this is the end of the command. I've capitalised the words `SELECT`, and `FROM` because they are SQL keywords. Capitalisation isn't necessary, but we'll continue this throughout the screencast so that it is clear what is a keyword and what is a table name or field name.

When we run the command, it shows us all of the data from the `Experiment` table for the two columns that we asked for: the `LoginID`, and the name of the `Project`. If wanted the `Hours` column, we'd just add that to the list of columns in the `SELECT` clause:

```
SELECT LoginID, Project, Hours FROM Experiment;
```

So, After the `SELECT` command you listed the fields you want returned. You can place them in any order. We could write:

```
SELECT Project, LoginID, ...
```

And you can repeat field names if you'd like:

```
SELECT Project, LoginID, LoginID, Project ...
```

If you want to pull up all of the columns in a table, you can use the asterisk, or star, after `SELECT`. The asterisk means "all of the column names" — it is just a shortcut. So, if we run this query:

```
SELECT * FROM Experiment;
```

we see all of the columns from the `Experiment` table. If the there are duplicate rows returned by your query, it is possible to remove the duplicates. For example, we can fetch only the `Project` column from the `Experiment` table:

```
SELECT Project FROM Experiment;
```

and if we just wanted to know which different `Projects` the scientists were working on , we put `DISTINCT` keyword right after the `SELECT` keyword,

```
SELECT DISTINCT Project FROM Experiment;
```

This lists all of the projects, but only once. If select more than one column name:

```
SELECT DISTINCT Project, LoginID FROM Experiment;
```

then only the distinct pairs of projects and login IDs are returned. Suppose that 10% of the time spent on each experiment was prep. work which needs to be accounted for separately. In our `SELECT` statement we can add expressions that do computations on each row. So, to calculate 10% of the time spent on each experiment, we can add an expression to the list of columns in the `SELECT` field (in this case we'll leave the `*` there to select all of the columns), but we'll add the expression `Hours * .1`.

```
SELECT *, Hours * .1 FROM Experiment;
```

When we run the query, the expression `Hours * .1` is evaluated for each row and appended to the output. When appending expressions in the `SELECT` clause, you can use any of the fields, all of the arthimetic operators can be used here, as well as a certain built-in functions. For instance, we could round these values to the first decimal place by using the ROUND function:

```
SELECT *, ROUND(Hours * .1, 1) FROM Experiment;
```

In this screencast we've introduced the very basics of interacting with and retrieving data from database. We've seen that you can select columns from a table to retreive, use the `DISTINCT` keyword to only return unique rows, as well as append calculated columns to output.

Filtering
=========

Welcome to the Software Carpentry screencast on Databases. This screencast is on filtering results from a databse.

As we've seen in a previous screencast, we can use the `SELECT` statement to pull out columns from a table, and add computed values to results. One of the most powerful features of a database is the ability to filter through your data to find the records that match certain criteria. Let's say we wanted to see all of the Experiments before the year 1990. To do this we'd write a `SELECT` query with all of the columns from the `Experiments` table, and we use the `WHERE command to specify our filter conditions.

```
SELECT * FROM Experiment WHERE ExperimentDate < '1900-01-01';
```

We put the expression, `ExperimentDate < '1990-01-01'`, this specifies that we want only experiment info with an experiment date before January 1st, 1990.

You can think about how this query works as the database inspecting each row from the `Experiments` table, and checking it against the condition in the `WHERE` clause. If the condition holds true, then that row is included in the results, otherwise it is filtered out.

We can use other comparison operators in our filtering conditions. For example, we could ask for all of the Experiments in table that took 3 or more hours. To do this we change the `WHERE` condition to be `Hours >= 3`

```
SELECT * FROM Experiment WHERE Hours >= 3;
```

We can use most of the familiar comparision operators: equal to, not equal to, greater than, less than, and so on. We can make our `WHERE` conditions even more sophisticated by using logical operators like `AND` and `OR` to combine conditions. For instance, if we want to find all of the experiments run by `mlom` that took more than three hours, we can modify our query. It already filters for experiments that take more than 3 hours. We can add `AND` and then the other condition that needs to be met, that the `loginID` is `mlom`:

```
... WHERE Hours >= 3 AND LoginID = 'mlom';
```

When using an AND operator, each record returned now must satisfy two conditions: in this case, the `Hours` spent has to be greater than 3, and the `loginID` must be `mlom`. If we wanted experiments either by `mlom` or by `best`, we would write

```
... WHERE Hours >= 3 AND (LoginID = 'mlom' OR LoginID = 'best');
```

The parentheses ensure that the OR-clause is evaluated first, so it is true whether the `loginID` is `mlom` or `best`, and the entire `WHERE` condition is true if the OR-clause is true AND the hours spent are greater than 3. Another way to write this OR-clause is to use the `IN` operator. With this operator, we can write a condition that is true if a field—the `loginID` in this case—contains anything from a list of values:

```
WHERE Hours >= 3 AND LoginID IN ('mlom', 'best');
```

This is exactly the same as writing out the `OR` clause, but it's shorter to write, and easier to read. In this screencast we've shown that you can select data from a table and then filter those rows based on `TRUE` and `FALSE` conditions using a `WHERE` clause.

Sorting
=======

Welcome to the Software Carpentry screencast on Databases. This screencast is on sorting results from a database.

As we've seen in a previous screencast, we can use the `SELECT` statement to pull out columns from a table.

```
 SELECT * FROM Experiments;
 ```

... but the results of our queries are returned in an arbitrary order—they are not sorted by default. If we wanted to sort them by the Project, we add an `ORDER BY` clause to our query,

'''
SELECT * FROM Experiments ORDER BY;
'''

and list the column we want the sorting to be done on, in this case, `Project`, and then we put `ASC`, an abbreviation of ascending, to specify that we want the results to be sorted in ascending order.

```
SELECT * FROM Experiment ORDER BY Project ASC;
```

When we run the query you see that the results are now sorted in ascending order by the `Project` field. If we wanted the sorting to be done in descending order, we put the keyword `DESC`, short for descending, after the sort field,

```
SELECT * FROM Experiment ORDER BY Project DESC;
```

If we want to sort the results by the `Project`, and then by the `Hours`, we list both field names after the `ORDER BY` clause, separated by commas. So,

```
SELECT * FROM Experiment ORDER BY Project DESC, Hours ASC;
```

In the database system we are using, SQLite, ascending order is the default. That is, if we don't specify the sort order we get the results in ascending order,

```
SELECT * FROM Experiment ORDER BY Project, Hours;
```

We do not have to have selected the column in order for us to sort by it. For instance, if we `SELECT` the `LoginID`, `Project`, and `Hours` spent

```
SELECT LoginID, Project, Hours FROM Experiment
```

we are able to order the results by the `ExperimentDate`, even though we haven't selected it.

```
... ORDER BY ExperimentDate
```

We are able to do this because `ExperimentDate` /is/ in the table we are reading from, we just chose not to return it's value in the results.  We can even sort the results by the value of an expression. In SQLite, the `RANDOM()` function returns a psuedo-random integer, as we see here:

```
SELECT *, RANDOM() FROM Experiment
```

(tip: run the query twice) The values change each time we run the query. So to randomize the order of our query results, we can simply sort them by the value of this function which, because it returns random values, will cause the ordering of the results to be random:

```
SELECT * FROM Experiment ORDER BY RANDOM()
```

In previous screencasts we've seen how you can select columns, append new calculated columns, and filter the results. All of these operations can be combined into one query.

```
SELECT *, ROUND(Hours * .1, 1) FROM Experiment WHERE Hours >= 3 ORDER BY ExperimentDate DESC;
```

The `SELECT` clause lists the columns we want to retrieve. We'll use the asterisk as a shortcut for all of the columns in the table, and an expression that calculates 10% of each hour. The `FROM` clause tells the database which table to fetch the records from. The `WHERE` clause specifies the conditions the records have to meet in order to be included in the results. And, finally, the `ORDER BY` clause is used to specify how the results should be sorted.

The order that you see the clauses in here is required by SQL. The `SELECT` must come before the `FROM`, the `WHERE` clause must come after the `FROM`, and `ORDER BY` clause comes last.

In this screencast we've seen that you can select data from a table, and sort the results by fields in your tables, or with expressions, and we've seen that the selecting, filtering, and sorting operations can all be combined into a single query.

Aggregation
===========

Welcome to the Software Carpentry screencast on Databases. In this screencast, we will show you how to combine values from multiple rows. This is called "aggregation". Suppose we wanted to know how many hours were spent on all experiments so far. First, we need to fetch all the hours in the table, which can write like this:

To add up all the hours, all we need to do is apply the `SUM` function to the `Hours` column. So we write,

```
SELECT SUM(Hours) FROM Experiment;
```

`SUM` is one of the aggregation functions in SQL. In their simplest form, aggregation functions are applied to all rows fetched by a query and they reduce the result to a single row. `MAX`, `MIN` and `AVG` are also aggregation functions.

```
SELECT SUM(Hours), MAX(Hours), MIN(Hours), AVG(Hours) FROM Experiment;
```

You can use them like `SUM` and they'll do what you expect: compute the maximum, minimum, and average of your query results. Another handy aggregation function is `COUNT`. If you would like to know how many records are returned by a query,

```
SELECT COUNT(*) FROM Experiment;
```

The use of the asterisk, or `*`, here is an idiom that is used because we are interested in counting the number of records, not of counting anything in a particular column. What if we want the total number of hours each scientist has worked so far? One way is to use a `WHERE` clause to single out specific scientists. We would write,

```
SELECT SUM(Hours) FROM Experiment WHERE LoginID = 'mlom';
```

The problem with this approach is that we have to write one query for each scientist. We only have a few scientists in our table, but imagine if we had hundreds. What we want to be able to is have the database return a row for each scientist, and include a sum of the hours they have worked, like so:

```
SELECT LoginID, SUM(Hours) FROM Experiment;
```

But this query returns a single row, not one for each scientist. And why does it return that particular `LoginID`? Let's take a look at the same query without the `SUM` aggregate function:

```
SELECT LoginID, Hours FROM Experiment;
```

When we used `SUM`, the database was collapsing these rows by summing the `Hours` column, but since we haven't specified a aggregation function for `LoginID`, the database just picks an arbitrary `LoginID` and returns it. If your query selects fields directly from a table and aggregates at the same time, the values for unaggregated fields can be any value in the records being aggregated. So, if we want the total number of hours each scientist has worked so far we need to tell the database to aggregate the hours for each scientist separately. We do this by using the `GROUP BY` clause.

```
SELECT LoginID, Hours FROM Experiment
GROUP BY;
```

We want our aggregation done for each scientist, so we group by the `LoginID`,

```
SELECT LoginID, Hours FROM Experiment
GROUP BY LoginID;
```

and for each group we display the loginID and the SUM of the hours of that group:

```
SELECT LoginID, SUM(hours) FROM Experiment
GROUP BY LoginID;
```

So, this query tells the database to group all of the rows that have the same `LoginID` together, and then do the aggregation for each of those groups separately. Since we're grouping by `LoginID`, we know that the rows in each group have the same `LoginID`, so it's safe to select the `LoginID` column here without getting unexpected results. If we want, we can group by multiple criteria at once. So, for example, if we wanted the number of hours each scientist had spent on each project, we would group by both `loginID` and `Project`:


```
... GROUP BY LoginID, Project;
```

And then add the `ProjectID` to the `SELECT` clause so that we know which project the hours belong to:

```
SELECT LoginID, Project, SUM(Hours) FROM Experiment
```

The `GROUP BY` clause here specifies that all of the rows that have the same `LoginID` and `Project` name are grouped together, and then the sum is done for each of those groups.

The other aggregation functions work in the same way. So, for instance, to calculate how many experiments each scientist has done for each project, we add `COUNT` to our `SELECT` clause,

```
SELECT LoginID, Project, SUM(Hours), COUNT(*) FROM Experiment
GROUP BY LoginID, Project;
```

Sorting and filtering can also be done on queries that aggregate data. For example, If we want the total time spent on each project sorted by project name, we would write:

```
SELECT Project, SUM(Hours) FROM Experiment
```

to select the project name and total number of hours worked, and we want this for each project,

```
GROUP BY Project
```

and we want to sort the results by the project name

```
ORDER BY Project ASC;
```

The `ORDER BY` clause always goes after the `GROUP BY` clause, because we are ordering /the results/ of aggregation — it wouldn't make any difference to order the data before it was aggregated. What if we wanted to sort the results by the number of hours spent? Instead of using a plain field to sort on, like `Project`, we can use an aggregate function as our sorting criterion.

```
ORDER BY SUM(Hours) ASC;
```

So, here we are sorting the results, not by a field from the `Experiments` table — the raw data — but by the results of an aggregation function computed on the data from the `Experiments` table. What if you want to remove the negative hours, and only add up the positive values? You can do this by adding a `WHERE` clause to our query to filter out values you don't want before they are grouped and aggregated. In this case, the query is:

```
SELECT Project, SUM(Hours) FROM Experiment
WHERE Hours >= 0
GROUP BY LoginID, Project
ORDER BY SUM(Hours) ASC;
```

Notice that we can read the query as a series steps in the same order they are written. First, the data is selected from the table, those results are filtered by the `WHERE` clause, then what is left over is aggregated, and finally the aggregated results are sorted. This query nicely summaries everything we've covered in this lecture.

In this screencast we've demonstrated how aggregation functions, like `SUM`and `COUNT`, can be used to perform calculations on multiple rows; how to group your data and aggregate over those groups using the `GROUP BY` clause; and how filtering and sorting can also be used in conjunction with aggregation.

Joining Tables
==============

Welcome to the Software Carpentry lectures on Databases. In this screencast we'll show you how to combine data from multiple tables. The database we'll use in this screencast has two tables. The `Experiment` table you are familiar with from previous lectures and the `Person` table you see here. This table describes each scientist. It contains their `Firstname`, `Lastname`, and `LoginID`. Suppose we wanted to get the Experiment data and the scientists' first and last name on each row, not just their login names. We do this by using the `JOIN` command:

```
SELECT *
FROM Person
JOIN Experiment;
```

This says, "Join records in the Person table together with records in the Experiment table, and return all of the columns". The results many not be quite what we you expected. When doing a join, by default, the database simply returns a row for every possible combination of rows from the joined tables. (This is called the Cross Product of the rows.) That is, the database does not attempt to figure out out how to join the tables by the column names or by the data it contains — it leaves that part to you to explain. What we want to do is only return the combinations of rows from the `Person` table and the `Experiment` table when the `LoginID` fields are the same. To express this in SQL we need to use an `ON` clause that specifies this fact.

```
SELECT *
FROM Person
JOIN Experiment
ON Person.LoginID = Experiment.LoginID;
```

The `ON` clause tells the database which rows to return from the default cross-product of rows we saw before. In this case, it only returns rows from that cross product where the `LoginID` is the same from both the `Person` table and the `Experiment` table. The `ON` clause is like a `WHERE` clause that is applied when joining the tables. We could have written the query like this:

```
SELECT * FROM Person
JOIN Experiment
WHERE Person.LoginID = Experiment.LoginID;
```

but using the `ON` clause makes it clear what relationship you intend there to be in the join. Notice in our query that we put the `Person` table name before the `LoginID` in the `ON` clause. This is necessary because the `LoginID` field appears in both the `Person` and the `Experiment` table, so we need to be clear which table's field we are referring to. We can use this same 'dot' syntax to refer to columns we want to return. For example, if we wrote this:

``
SELECT Person.FirstName, Experiment.*
FROM Person
JOIN Experiment
ON Person.LoginID = Experiment.LoginID;
```

This query returns only the `FirstName` column from the `Person` table, and returns every column (that's the star) from the `Experiment` table. To simplify the query, we can provide an alias for the tables we are joining. We do this by putting the alias right after the table name in the `FROM` clause:

```
SELECT Person.FirstName, Experiment.*
FROM Person p
JOIN Experiment e
ON Person.LoginID = Experiment.LoginID;
```

This means that in this query, the Person table must be refered to as "p", and the Experiment table as "e". So we need to fix up the query with the new names:

```
SELECT p.FirstName, e.*
FROM Person p
JOIN Experiment e
ON p.LoginID = e.LoginID;
```

This is exactly the same query as before, except it's a lot shorter which comes in handy when we write more complex queries. You can join more than two tables simply by adding another `JOIN ON` clause to the query. Let's add another table into our database. This table is called `ExperimentDetails`. For each `Project` and Experiment ID this table lists the name of the experiment, and the location. So say you wanted the full name, and date, location and name of the experiment:

```
SELECT ExperimentDate, FirstName, LastName, ExperimentName, Location
```

We'll put these fields down now, and come back later to add in the table aliases once we've written our query. These fields are coming from three tables: Person, Experiment, and ExperimentDetail, so we'll need to join all of these tables together in our query.

```
FROM Person p
JOIN Experiment e
```

The Person table is joined to the Experiment table as before, by the LoginID

ON p.LoginID = e.LoginID
We then join to the ExperimentDetail table by specifying the condition that both the project and experiment must be the same between rows of the Experiment table and of the ExperimentDetail table

```
JOIN ExperimentDetail ed
ON (e.Project = ed.Project AND e.Experiment = ed.Experiment);
```

Now we can go back and update our selected field names with their table aliases:

```
SELECT
  e.ExperimentDate,
  p.FirstName,
  p.LastName,
  ed.ExperimentName,
  ed.Location
FROM Person p
JOIN Experiment e
ON p.LoginID = e.LoginID
JOIN ExperimentDetail ed
ON (e.Project = ed.Project AND e.Experiment = ed.Experiment);
```

In this screencast we've shown you how to mix data from different tables using a JOIN..ON clause. We've seen that we can join two or more tables using the JOIN clause. The ON clause acts like a filter that specifies the conditions for how to join rows from each table.

Missing Data
============

Welcome to the Software Carpentry lectures on Databases. Today's topic is `NULL` values. Here is a table from a previous lecture. It tracks the work done on experiments broken down by the project and scientist. Notice that we've modified the data slightly for this lecture, so that for some data is missing — that's what the red coloured cells are. In the real world data is not always complete — there are always holes. A database uses a special value for these holes: `NULL`. `NULL` is not zero, `False`, or the empty String, it is simply just a different kind of value.So, for these rows where the hours have a `NULL` value, does this mean that the hours for these experiments is missing? Or does it mean that the value is not known? Or maybe it means something else? These are questions that we cannot answer just by looking at the data, but instead we have to understand how the data is supposed to be interpreted. We tackle this question in our lecture on data modeling. In this lecture we will discuss how to work with NULL values in our queries. Suppose you wanted to know which experiments are missing Hours data. You might try to filter the values like so:

```
SELECT * FROM Experiement
WHERE Hours = NULL ;
```

We get no results, why? For many database systems, NULL is a special value that isn't comparable to anything else using the usual equality operators (e.g. =, !=, , …). Comparing NULL to any other value using these operators always return False. So, In our query the condition Hours = NULL is always false, so no records returned. To write a condition that returns true on rows that contain NULL values you must use the IS operator:

SELECT * FROM Experiment
WHERE Hours IS NULL;

IS is used to compare fields to NULL. It behaves like the = operator, except that it returns True when comparing two NULL values. Here you can see that the entries in the experiments table with missing Hours fields are returned. To find all of the rows that do not have a NULL Value, you can use the IS NOT operator for nulls in place of the != operator

SELECT * FROM Experiment
WHERE Hours IS NOT NULL;

Because NULL is a different type of value all together, if your data may have NULL values in it, your queries must take this into account. For example, suppose you wanted to find the all of the Experiments which did not take 7 hours. You might write:

SELECT * FROM Experiment
WHERE Hours != 7;

Notice that the results are missing the records with NULL values in the Hours field. Those records were filtered out because, as we've said, only the IS and IS NOT operator will return True when comparing a NULL to another value. If we mean for these rows to be included, we need to add to the WHERE clause to explicitly check for NULL values:

SELECT * FROM Experiment
WHERE Hours != 7 OR Hours IS NULL;

Now when we run our query we get back those records with NULL Hours values along with the other records where the Hours field doesn't equal 7. NULL values are also handled differently by aggregation functions. Most aggregation functions ignore NULL values in their calculations. So, for instance, let's look at the SUM function. To calculate the total number of hours spent on experiments we'd start with a query like this,

SELECT Hours FROM Experiment;
add SUM to total the values…

SELECT Sum(Hours) FROM Experiment;

… but this total is actually just the sum of all of the numeric values. The NULL values are skipped. This more important for functions like AVG, which depend on the total number of records in the aggregation.

SELECT AVG(Hours) FROM Experiment;

NULL values are skipped, and so they don't count towards the average. The NULL values are not treated as zero, the average function just skips over them as if they weren't in the dataset.
This is also true for Max, Min, and `COUNT` in SQLite. In this lecture we've seen that databases use a special value for empty or missing information, NULL. This value has to be taken into account, and handled in a unique way, when you are writing queries. We will see ways of working with NULL values pop up in many future lectures.

Nested Queries
==============

Welcome to the Software Carpentry screencast on Databases. This screencast is on nesting queries. How do we find scientists that haven't been experimenting with time travel? Our first instinct might be to write a query like this:

SELECT DISTINCT LoginID,
FROM Experiment
WHERE Project != 'Time Travel';

Unfortunately, this query doesn't give us what we want, since 'ivan' and 'skol' (Sofia) have each worked both on Time Travel but also on other projects as well.There are scientists who have worked on Time Travel Projects….. and their are scientists who have worked on other projects…… and, of course, there are scientists who have worked on both Time Travel projects AND other projects as well. Our query is returning all of the scientists who have worked on projects other than Time Travel… but that includes scientists that have worked on time travel and other projects. Our original question was to find all of the scientists that had never worked on Time Travel. To see why, let's look at the experiment table, but we'll sort the records by scientist and project:

SELECT * FROM Experiment ORDER BY LoginID, Project;

Our original query reject rows where the project was 'Time Travel'. But for scientists like Ivan, who have worked on other projects, their other projects don't get filtered out, and so their names appear in the final results. The strategy for answering this question is to start with all of the scientists. subtract those scientists which have worked on Time Travel projects  to get just the scientists that haven't been experimenting with Time Travel. To do this we'll make use of nested queries. Finding all of the scientists who have worked on Time Travel projects is easy:

SELECT DISTINCT LoginID FROM Experiment
WHERE Project = 'Time Travel';

Finding all of the scientists is also easy:

SELECT DISTINCT LoginID FROM Experiment;

What we want to do is somehow:

SELECT DISTINCT LoginID FROM Experiment
WHERE

subtract, or filter, from these results the results of our earlier query:

WHERE LoginID NOT IN ('ivan', 'skol');

In SQL we're able to nest one query inside of another to use its results in filter conditions. So, we create a filter condition that only includes scientists

SELECT DISTINCT LoginID FROM Experiment
WHERE LoginID NOT IN
  (SELECT DISTINCT LoginID FROM Experiment
  WHERE Project = 'Time Travel');

where their LoginID is not in… and then we put the results of the first query in parentheses. So, we can read this query as saying, "Fetch all of the scientists who have run experiments, but exclude them if they appear in the list of scientists who have worked on Time Travel". And this is what we wanted! The pattern demonstrated by this query, of selecting and then filtering based on the results of nested query, is very useful one. I should note, that the nested query here is completely separate from the larger query. It just fetches a list of LoginIDs once, and those loginIDs are used by the larger query's filter condition as it inspects each record. But nested queries can also refer to the larger query they are embedded in. For instance, in our screencast on JOIN we asked the question: which scientists have worked on more than one project? We answered the question by joining the Experiment table to itself and then filtering results so that we only had scientists that had been paired with themselves, but working on different projects. Using nested queries we can answer this same question in a different way. Let's first remind ourselves of who has worked on which projects:

SELECT LoginID, Project FROM Experiment ORDER BY LoginID, Project;

Best has worked on one project, so has Dian Fossey, dimitri, Banting, Herschel. But, Ivan Pavlov has worked on two projects, and so has Lomonosov, and so has Kovaleskaya. So, we can write a query that selects the scientists from the experiments table.

SELECT DISTINCT LoginID FROM Experiment e1
WHERE
where… 

and here we want to filter out the scientist if they haven't worked on any other project. That is, in order to be included they must /have/ worked on another project:

WHERE LoginID IN (

Well, we need a query that will fetch the OTHER projects the scientist has been involved in. So, we start with fetching the LoginIDs

SELECT DISTINCT LoginID FROM Experiment e2
...

but put a filter condition in so that the loginIDs we fetch are those of the same scientist, but have a different project.

...
WHERE e2.LoginID = e1.LoginID AND e1.Project != e2.Project);

When we run this query we get Pavlov, Lomonosov, Kovaleskaya as expected. This is a different kind of nested query than we wrote before, because the results of this nested query depend on which record is being processed by the outer query.

SELECT DISTINCT LoginID FROM Experiment e1
WHERE LoginID IN (
  SELECT DISTINCT LoginID FROM Experiment e2
  WHERE e2.LoginID = e1.LoginID AND e1.Project != e2.Project);

Nested queries can also be use in place of tables. That is, a nested query can provide the datasource from which you select, filter, aggregate, etc. For example, what if we wanted to know how many different projects each scientist had worked on. We can begin by finding the distinct list of projects each scientist worked on, which can do like so:

SELECT DISTINCT LoginID, Project FROM Experiment;

We want to count how many projects are listed here for each scientist. Since counting is an aggregation, we need to use the results of this query as input for a separate query that does the aggregation. We can nest this query as the source for a larger query by wrapping it in parentheses, and putting it in the FROM clause:

...
FROM (SELECT DISTINCT LoginID, Project FROM Experiment);

We want the scientist, and count of their projects:

SELECT LoginID, COUNT(*)
FROM (SELECT DISTINCT LoginID, Project FROM Experiment)

...
and we want to count over each scientist:

...
GROUP BY LoginID

Nesting queries like this is really useful if the data you want to write a query on isn't present in exactly the right form in the database. You can use one query to get the data in the form you need it in, and then with nesting you're able to use those results as the input for a larger query. In this screencast we've introduced the idea of nesting queries. We've seen that you can nest a query to supply elemenths in a WHERE condition, and we've also seen we can use a nested query in place of a table in the FROM clause.