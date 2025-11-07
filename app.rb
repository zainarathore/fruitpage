require 'sinatra'
require 'slim'
require 'sinatra/reloader'
require 'sqlite3'


post('/fruits/:id/delete') do  
 id = params[:id].to_i
 db = SQLite3::Database.new("db/fruits.db")

 db.execute("DELETE FROM fruits WHERE id = ?",id)

redirect('/fruits')
end

post('/fruits/:id/update') do
  id = params[:id].to_i
  name = params[:name]
  amount = params[:amount].to_i

  db = SQLite3::Database.new("db/fruits.db")
  db.execute("UPDATE fruits SET name=?, amount=? WHERE id=?",[name,amount,id])

  redirect('/fruits')

end


get('/fruits/:id/edit') do
  db = SQLite3::Database.new("db/fruits.db")
  db.results_as_hash = true
  id = params[:id].to_i
  @special_animal = db.execute("SELECT * FROM fruits WHERE id = ?",id).first
  slim(:"fruits/edit")
end

get('/fruits/new') do
  slim(:"fruits/new")
end

post('/fruit') do
  
  new_fruit = params[:newanimal]
  amount = params[:amount].to_i

  db = SQLite3::Database.new('db/animals.db') 
  db.execute("INSERT INTO fruits (name, amount) VALUES (?,?)",[new_animal,amount])

  redirect('/fruits') 

end
 

get('/fruits') do

  query = params[:q]
  

  db = SQLite3::Database.new("db/fruits.db")

  db.results_as_hash = true 

  if query && !query.empty?
    @dataflutt = db.execute("SELECT * FROM fruits WHERE name LIKE ?", "%#{query}%")
  else 
    @dataflutt = db.execute("SELECT * FROM fruits")
  end

  p @dataflutt


  slim(:"fruits/index")
end



get('/') do
  redirect('/home')

end

get('/home') do
  slim(:home)

end


get('/about') do
  slim(:about)

end

get('/flutts') do 
  @fruits = ["apple", "banana", "orange"]
  slim(:fruits)
end

get('/flutts/:id') do 
  @fruits = params[:id]
  slim(:youlike)
end

get('/fluttinfo') do 
  @flutts = [  
    {
      "name" => "banan",
    "color" => "yellow", 
    "weight" => "100"
    },

    {
    "name" => "apple",
    "color" => "red", 
    "weight" => "75"

    }
    

]

  slim(:fluttinfo)
end


# animals


post('/animals/:id/delete') do  
 id = params[:id].to_i
 db = SQLite3::Database.new("db/animals.db")

 db.execute("DELETE FROM animals WHERE id = ?",id)

redirect('/animals')
end

post('/animals/:id/update') do
  id = params[:id].to_i
  name = params[:name]
  amount = params[:amount].to_i

  db = SQLite3::Database.new("db/animals.db")
  db.execute("UPDATE animals SET name=?, amount=? WHERE id=?",[name,amount,id])

  redirect('/animals')

end


get('/animals/:id/edit') do
  db = SQLite3::Database.new("db/animals.db")
  db.results_as_hash = true
  id = params[:id].to_i
  @special_animal = db.execute("SELECT * FROM animals WHERE id = ?",id).first
  slim(:"animals/edit")
end

get('/animals/new') do
  slim(:"animals/new")
end

post('/animal') do
  
  new_animal = params[:newanimal]
  amount = params[:amount].to_i

  db = SQLite3::Database.new('db/animals.db') 
  db.execute("INSERT INTO animals (name, amount) VALUES (?,?)",[new_animal,amount])

  redirect('/animals') 

end
 

get('/animals') do

  query = params[:q]
  

  db = SQLite3::Database.new("db/animals.db")

  db.results_as_hash = true 

  if query && !query.empty?
    @dataanimals = db.execute("SELECT * FROM animals WHERE name LIKE ?", "%#{query}%")
  else 
    @dataanimals = db.execute("SELECT * FROM animals")
  end

  p @dataanimals


  slim(:"animals/index")
end



get('/') do
  redirect('/home')

end

get('/home') do
  slim(:home)

end


get('/about') do
  slim(:about)

end

get('/flutts') do 
  @fruits = ["apple", "banana", "orange"]
  slim(:fruits)
end

get('/flutts/:id') do 
  @fruits = params[:id]
  slim(:youlike)
end

get('/fluttinfo') do 
  @animal = [  
    {
      "name" => "banan",
    "color" => "yellow", 
    "weight" => "100"
    },

    {
    "name" => "apple",
    "color" => "red", 
    "weight" => "75"

    }
    

]

  slim(:animalinfo)
end