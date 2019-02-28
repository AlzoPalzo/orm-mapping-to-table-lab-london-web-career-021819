class Student
  attr_reader :name, :grade
  
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
  end

  def self.create_table
    query = <<_ SQL
      CREATE TABLE students
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
        SQL 

    DB[:conn].execute(sql)
  end
end
