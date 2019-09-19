require_relative( 'models/casting' )
require_relative( 'models/movie' )
require_relative( 'models/star' )

require( 'pry' )

Movie.delete_all()
Star.delete_all()
Casting.delete_all()

star1 = Star.new({ 'first_name' => 'George', 'last_name' => 'Clooney'})
star2 = Star.new({ 'first_name' => 'Hugh', 'last_name' => 'Grant'})
star3 = Star.new({ 'first_name' => 'Liz', 'last_name' => 'Bacon'})

star1.save()
star2.save()
star3.save()

movie1 = Movie.new({ 'title' => 'Halloween', 'genre' => 'horror', 'budget' => '20000000'})
movie2 = Movie.new({ 'title' => 'Gladiator', 'genre' => 'drama', 'budget' => '25000000'})
movie3 = Movie.new({ 'title' => 'Groundhog Day', 'genre' => 'comedy', 'budget' => '30000000'})

movie1.save()
movie2.save()
movie3.save()

all_movies = Movie.all
all_stars = Star.all

movie1.genre = 'comedy'
movie1.update

star3.last_name = 'Hurley'
star3.update

casting1 = Casting.new({ 'star_id' => star3.id, 'movie_id' => movie3.id, 'fee' => 1000000})
casting1.save()
casting2 = Casting.new({ 'star_id' => star1.id, 'movie_id' => movie3.id, 'fee' => 4000000})
casting2.save()
casting3 = Casting.new({ 'star_id' => star2.id, 'movie_id' => movie1.id, 'fee' => 50})
casting3.save()
casting4 = Casting.new({ 'star_id' => star2.id, 'movie_id' => movie2.id, 'fee' => 2000000})
casting4.save()




casting1.fee = 800000
casting1.update

movie3.all_stars_by_movie
star2.all_movies_by_star

movie3.total_casting_cost

binding.pry
