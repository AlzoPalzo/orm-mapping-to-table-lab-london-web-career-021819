require 'sqlite3'

class Student
  attr_reader :name, :grade, :id
  
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    query = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
        )
        SQL
        
    DB[:conn].execute(query)
  end

  def self.drop_table
    drop = <<-SQL
    DROP TABLE IF EXISTS students
    SQL
    DB[:conn].execute(drop)
  end

  def save
    push_student = <<-SQL
    INSERT INTO students
    (
      name, grade
    )
    VALUES
    (
      ?,?
    )
    SQL
    DB[:conn].execute(push_student, @name, @grade)
    @id = DB[:conn].execute("SELECT students.id FROM students ORDER BY students.id DESC LIMIT 1").flatten[0]
  end

  def self.create(attributes)
    s = Student.new(attributes[:name], attributes[:grade])
    s.save    
    s
  end
end
