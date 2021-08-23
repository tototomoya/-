const express = require('express')
const app = express()
const port = 3000
const ejs = require('ejs')
const {exec} = require('child_process')
app.use(express.static('public'))


app.get('/', (req, res) => {
  exec('ruby main.rb', (err, out) => {
    console.log(out)
  })
   res.render("index.ejs")
})

app.listen(port)