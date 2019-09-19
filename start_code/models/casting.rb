require_relative("../db/sql_runner")

class Casting

  attr_reader :id
    attr_accessor :movie_id, :star_id, :fee

    def initialize( details )
      @id = details['id'].to_i if details['id']
      @movie_id = details['movie_id'].to_i
      @star_id = details['star_id'].to_i
      @fee = details['fee'].to_i
    end

    def save()
    sql = "INSERT INTO castings
    (
      star_id,
      movie_id,
      fee
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@star_id, @movie_id, @fee]
    casting = SqlRunner.run( sql,values ).first
    @id = casting['id'].to_i
  end


    def Casting.delete_all
      sql = "DELETE FROM castings"
      SqlRunner.run(sql)
    end

    def Casting.all()
      sql = "SELECT * FROM castings"
      castings = SqlRunner.run(sql)
      result = castings.map { |casting| Castings.new( casting ) }
      return result
    end

    def update
      sql = "UPDATE castings
            SET movie_id=$1, star_id=$2, fee=$3
            WHERE id = $4"
      values = [@movie_id, @star_id, @fee, @id]
            SqlRunner.run( sql, values )
          end


end #class end
