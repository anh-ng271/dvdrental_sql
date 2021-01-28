# Data Analysis Using SQL 

### Objectives

In this analysis, I will go through my data analysis process by analyzing an enterprise database of a DVD rental company and providing insights and recommedation for the company.
 
**About the sample database:** This database is comprised of 15 tables representing many business aspects of the company. The [Entity Relationship Model](https://sp.postgresqltutorial.com/wp-content/uploads/2018/03/printable-postgresql-sample-database-diagram.pdf). (ERM) depicts this database schema. Data source and SQL scripts is posted on the repository.
	
### Analysis  
These are three areas I want to explore in the DVD rental company: their physical stores, films on demand, the customer base?

#### How is business doing in their physical stores? 
The DVD rental company acquires two physical stores in which one employee manages one store. below are the sub questions:

	- What are total sales by each DVD store? 
![q1](https://user-images.githubusercontent.com/77992392/106076122-c8e0d880-60c3-11eb-8dea-f8d906ff5496.PNG)

	- Which store do better in weekly sales?
![result_weekly_sales](https://user-images.githubusercontent.com/77992392/106076184-e746d400-60c3-11eb-828a-aab0d4ce5012.PNG)
	
	- What are the most popular genres by each store?

>
Store 1
![q1c](https://user-images.githubusercontent.com/77992392/106076243-0f363780-60c4-11eb-9320-3863aa273b7b.PNG)

> 
Store 2
![q1cc](https://user-images.githubusercontent.com/77992392/106076617-c468ef80-60c4-11eb-8a38-828942813259.PNG)


#### Films on Demand
	- What genres drive the most sales and customers' interest? 
![q2a](https://user-images.githubusercontent.com/77992392/106077237-09d9ec80-60c6-11eb-8cae-5af71a806c40.PNG)

	- How many distinct customers for each genre?
![q2b](https://user-images.githubusercontent.com/77992392/106077364-3ee63f00-60c6-11eb-9ddf-d60d51968a83.PNG)

#### Customers: 	
	- How many rented films were returned late, early, and on time? 
![q3a](https://user-images.githubusercontent.com/77992392/106078298-047da180-60c8-11eb-812f-4f112a5faaca.PNG)

	- What countries that customers come from? 
![q3b](https://user-images.githubusercontent.com/77992392/106078345-1bbc8f00-60c8-11eb-91e1-45359d5eaefb.PNG)

	- Who are the top 10 customers by ammount paid? List their name and contact infomation. 
![q3c](https://user-images.githubusercontent.com/77992392/106078380-2a0aab00-60c8-11eb-9fc3-efcf90b5b6e8.PNG)
