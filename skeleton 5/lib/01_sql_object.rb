require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @coulumns if nil
    col = DBConnection.execute.(<<-SQL).first
      SELECT
        *
      FROM
        '#{table_name}'
      LIMIT
        0
    SQL
     col.map!(&:to_sym)
     @columns = col
  end

  def self.finalize!
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    # debugger
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # ...
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(results)
  end

  def self.parse_all(results)
    results.map {|result| self.new(result)}
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        (id = self.id)
    SQL
    parse_all(results)
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # debugger
    self.class.columns.map {|attr| self.send(attr)}
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
