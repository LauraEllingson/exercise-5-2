const express = require('express')
const db = require('./db')
const PORT = process.env.PORT || 3000
const app = express()

app.use(express.json())

app.get('/user', async (req, res) => {
  try {
    const [rows] = await db.query(`SELECT * FROM users;`)
    res.json(rows)
  } catch (err) {
    res.status(500).send('Error retrieving users: ' + err.message)
  }
})

app.post('/user', async (req, res) => {
  try {
    const {
      first_name,
      last_name,
      email,
      age,
      is_retired
    } = req.body
    if (!(
      first_name &&
      last_name &&
      email &&
      age &&
      typeof is_retired === 'boolean'
    ))
      return res
        .status(400)
        .send('must include first/last name, email, age and is_retired')

    await db.query(`
      INSERT INTO users (first_name, last_name, email, age, is_retired)
      VALUES (?, ?, ?, ?, ?)
    `, [first_name, last_name, email, age, is_retired])
    res.status(201).send('User created')
  } catch (err) {
    res.status(500).send('Error creating user: ' + err.message)
  }
})

app.put('/user/:id', async (req, res) => {
  try {
    const {
      first_name,
      last_name,
      email,
      age,
      is_retired
    } = req.body
    if (!(
      first_name &&
      last_name &&
      email &&
      age &&
      typeof is_retired === 'boolean'
    ))
      return res
        .status(400)
        .send('must include first/last name, email, age and is_retired')

    const [{affectedRows}] = await db.query(
      `UPDATE users SET ? WHERE id = ?`,
      [{first_name, last_name, email, age, is_retired}, req.params.id]
    )
    if (affectedRows === 0) return res.status(404).send('user not found')
    res.status(201).send('User updated')
  } catch (err) {
    res.status(500).send('Error updating user: ' + err.message)
  }
})

app.delete('/user/:id', async (req, res) => {
  try {
    const [{affectedRows}] = await db.query(
      `DELETE FROM users WHERE id = ?`,
      req.params.id
    )
    if (affectedRows === 0) return res.status(404).send('user not found')
    res.send('User deleted')
  } catch(err) {
    res.status(500).send('Error deleting user: ' + err.message)
  }
})

app.listen(PORT, () => {
  console.log('Listening on http://localhost:' + PORT)
})