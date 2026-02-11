# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!
# - Note rubric explanation for appropriate use of external resources.

# Rubric
#
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)
# - You are welcome to use external resources for help with the assignment (including
#   colleagues, AI, internet search, etc). However, the solution you submit must
#   utilize the skills and strategies covered in class. Alternate solutions which
#   do not demonstrate an understanding of the approaches used in class will receive
#   significant deductions. Any concern should be raised with faculty prior to the due date.

# Submission
#
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======
# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========
# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Represented by agent
# ====================
# Christian Bale

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
Actor.destroy_all
Agent.destroy_all
Movie.destroy_all
Role.destroy_all
Studio.destroy_all

# Generate models and tables, according to the domain model.
new_studio = Studio.new
new_studio["name"] = "Warner Bros."
new_studio.save
warner_bros = Studio.find_by({ "name" => "Warner Bros." })

movies_data = [
  { "title" => "Batman Begins", "year" => 2005 },
  { "title" => "The Dark Knight", "year" => 2008 },
  { "title" => "The Dark Knight Rises", "year" => 2012 }
]

for movie in movies_data
  new_movie = Movie.new
  new_movie["title"] = movie["title"]
  new_movie["year_released"] = movie["year"]
  new_movie["rated"] = "PG-13"
  new_movie["studio_id"] = warner_bros["id"]
  new_movie.save
end

actor_data = [
  { "name" => "Christian Bale"},
  { "name" => "Michael Caine"},
  { "name" => "Liam Neeson"},
  { "name" => "Katie Holmes"},
  { "name" => "Gary Oldman"}
]

for actor in actor_data
  new_actor = Actor.new
  new_actor["name"] = actor["name"]
  new_actor.save
end

batman_begins_roles_data = [
  { "actor" => "Christian Bale", "character" => "Bruce Wayne"},
  { "actor" => "Michael Caine", "character" => "Alfred"},
  { "actor" => "Liam Neeson", "character" => "Ra's Al Ghul"},
  { "actor" => "Katie Holmes", "character" => "Rachel Dawes"},
  { "actor" => "Gary Oldman", "character" => "Commissioner Gordon"}
]

movie = Movie.find_by({ "title" => "Batman Begins" })
for role in batman_begins_roles_data
  actor = Actor.find_by({ "name" => role["actor"] })

  new_role = Role.new
  new_role["movie_id"] = movie["id"]
  new_role["actor_id"] = actor["id"]
  new_role["character_name"] = role["character"]
  new_role.save
end

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

# Prints a header for the agent's list of represented actors output
puts ""
puts "Represented by agent"
puts "===================="
puts ""

# Query the actor data and loop through the results to display the agent's list of represented actors output.
# TODO!
