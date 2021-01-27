# Data Analysis Using SQL 

### Objectives

In this analysis, I will go through my data analysis process by analyzing an enterprise database of a DVD rental company and providing insights and recommedation for the company.
 
**About the sample database:** This database is comprised of 15 tables representing many business aspects of the company. The [Entity Relationship Model](https://sp.postgresqltutorial.com/wp-content/uploads/2018/03/printable-postgresql-sample-database-diagram.pdf). (ERM) depicts this database schema. Data source and SQL scripts is posted on the repository.
	
### Analysis  
These are 3 big questions I want to explore in the DVD rental company: how's business doing in their physical stores?, what are trends in film demands?, and what characteristic of their customer base?

###### Physical stores
The DVD rental company acquires two physical stores in which one employee manages one store. I'm curious to know their total sales and what drives sales in each store.

	- What are total sales by each DVD store? 
	- Which store do better in terms of sales and customer base by weeks?
	- What are the most popular genres by each store?

I first identified what tables I need to join to answer these sub questions. Ther are in the order 
	>store >staff >payment >rental >inventory >film >film_category >category
###### Films on Demand
	- What are the most and the least rented movie genres by demand?
	- What genres drive the most sales and customers' interest? 
###### Customers: 	
	- Who are the top customers by ammount paid?
	- What countries that customers come from? 
	- Who are the inactive custommers? When was the last time they have made a rental? 
	- How many rented films were returned late, early, and on time? 
	

