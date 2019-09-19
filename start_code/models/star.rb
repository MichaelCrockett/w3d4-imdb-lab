require_relative("../db/sql_runner")

class Star

    attr_reader :id
    attr_accessor :first_name, :last_name

    def initialize( details )
      @id = details['id'].to_i if details['id']
      @first_name = details['first_name']
      @last_name = details['last_name']
    end


    def save()
    sql = "INSERT INTO stars
    (
      first_name,
      last_name
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @last_name]
    star = SqlRunner.run( sql, values ).first
    @id = star['id'].to_i
  end

  def Star.delete_all
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def Star.all()
    sql = "SELECT * FROM stars"
    stars = SqlRunner.run(sql)
    result = stars.map { |star| Star.new( star ) }
    return result
  end

  def update()
      sql = "UPDATE stars
      SET first_name=$1, last_name=$2 WHERE id=$3"
      values = [@first_name, @last_name, @id]
      SqlRunner.run( sql, values )
  end

  def all_movies_by_star
    sql = "SELECT movies.* FROM movies
          INNER JOIN castings
          ON movies.id = castings.movie_id
          WHERE star_id = $1"
    values = [@id]
    movie_arr = SqlRunner.run( sql, values)
    result = movie_arr.map { |movie| Movie.new( movie ) }
    return result
  end

end #class end
