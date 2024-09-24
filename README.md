# Creating Queries with `mysql2`

(**NOTE:** View a rendered version of this file in VS Code with `ctrl-shift-v` or `cmd-shift-v`)

&nbsp;
## The `query` method

Assuming we setup our connection with `mysql2` in a file like `db.js` as:

```js
const mysql = require('mysql2')

const config = process.env.JAWSDB_URL || {
  connectionLimit: 10,
  host: "localhost",
  user: "root",
  database: "my_db",
}

const db = mysql.createPool(config)

module.exports = db.promise()
```
&nbsp;

then we should be able to import our connection with something like `const db = require('./db')` and use the connection object to run queries against our database.

For a simple select query, we could do:

```js
const [rows] = await db.query('SELECT * FROM users')
console.table(rows)
```
&nbsp;

Which will return an array of objects that represents the user data:

```
[
	{
		"id": 1,
		"first_name": "Clark",
		"last_name": "10",
		"email": "clark.kent@daily.planet",
		"age": 30,
		"is_retired": 0
	},
  ...
]
```
&nbsp;

&nbsp;
## Dynamic Queries and SQL Injection

What if we wanted to programmatically create a query? If we had an express app, we might be tempted to do:

```js
app.delete('/user/:id', async (req, res) => {
  try {
    await db.query(`DELETE FROM users WHERE id = ${req.params.id}`)
    res.send('User deleted')
  } catch(err) {
    res.status(500).send('Error deleting user: ' + err.message)
  }
})
```
&nbsp;

This seems simple enough, as we take the id from the URL and place it in the query to delete whichever single user has that id.

However, this would be a grave mistake. Consider if we were to make a `DELETE` request to the following URL: `/user/1 OR 1=1`

This would make the SQL query: `DELETE FROM users WHERE id = 1 OR 1=1`. Because `1=1` is always true, this would cause every row to match in the users table, and delete all of the user table data.

This is an example of a SQL injection attack. SQL injection attacks happen when hackers are able to sidecar in additional queries.

Luckily, the `mysql2` package helps us prevent SQL injection attacks. It not only prevents running more than one statement by default, but also allows us to sanitize our inputs by converting it to strings. Here's an example of how we can fix our code:

```js
app.delete('/user/:id', async (req, res) => {
  try {
    await db.query(`DELETE FROM users WHERE id = ?`, req.params.id)
    res.send('User deleted')
  } catch(err) {
    res.status(500).send('Error deleting user: ' + err.message)
  }
})
```
&nbsp;

We can pass a second argument to the `query` method that will replace any `?` in our queries. The second argument can be a single value, an array of values, or an object.

Here's an example of passing multiple values as an array:

```js
await db.query(`
  INSERT INTO users (first_name, last_name, email, age, is_retired)
  VALUES (?, ?, ?, ?, ?)
`, [first_name, last_name, email, age, is_retired])
```
&nbsp;

And in the event of an update query, it will convert an object:

```js
await db.query(
  `UPDATE users SET ? WHERE id = ?`,
  [{first_name, last_name, email, age, is_retired}, id]
)
```
&nbsp;