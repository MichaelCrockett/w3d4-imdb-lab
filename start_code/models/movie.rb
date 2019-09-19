require_relative("../db/sql_runner")

class Movie

      attr_reader :id
      attr_accessor :title, :genre, :budget

      def initialize( details )
        @id = details['id'].to_i if details['id']
        @title = details['title']
        @genre = details['genre']
        @budget = details['budget'].to_i
      end


      def save()
      sql = "INSERT INTO movies
      (
        title,
        genre
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@title, @genre]
      movies = SqlRunner.run( sql, values ).first
      @id = movies['id'].to_i
    end

    def Movie.delete_all
      sql = "DELETE FROM movies"
      SqlRunner.run(sql)
    end

    def Movie.all()
      sql = "SELECT * FROM movies"
      movies = SqlRunner.run(sql)
      result = movies.map { |movie| Movie.new( movie ) }
      return result
    end

    def update()
        sql = "UPDATE movies
        SET title=$1, genre=$2 WHERE id=$3"
        values = [@title, @genre, @id]
        SqlRunner.run( sql, values )
    end

    def all_stars_by_movie
      sql = "SELECT stars.* FROM stars
            INNER JOIN castings
            ON stars.id = castings.star_id
            WHERE movie_id = $1"
      values = [@id]
      stars_arr = SqlRunner.run( sql, values)
      result = stars_arr.map { |star| Star.new( star ) }
      return result
    end

    def total_casting_cost
      sql = "SELECT SUM(castings.fee) FROM castings
      WHERE movie_id = $1"
      values = [@id]
      total_casting_cost = SqlRunner.run( sql, values)
      return total_casting_cost[0]["sum"].to_i
      end

    def remaining_budget
      return @budget - self.total_casting_cost
    end


end #class end
