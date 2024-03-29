require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true  
  end

end

class User
  attr_accessor :fname, :lname

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
   
    User.new(user.first)
  end

   def self.find_by_questions(title)

    question = Question.find_by_title(title)
    raise "#{name} not found in DB" unless playwright

    users = QuestionsDatabase.instance.execute(<<-SQL, question.id)
      SELECT
        *
      FROM
        users
      WHERE
        question_id = ?
      SQL

    users.map { |user| User.new(user) }
  end

   def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end


  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

    def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
    end

end

  
class Questions
  
end


class Question_Follows

end

class Replies

end

class Question_Likes

end