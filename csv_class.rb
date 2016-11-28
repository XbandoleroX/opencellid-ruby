=begin
____/\\\\\\\\\\\\\\\\\__/\\\\\\\\\\\\\\\\____/\\\________/\\\\\\\\\\\____IT4S______
____\////////\\\//////__\///////\\\//////___/\\\\\______/\\\/////////\\\_TASK______
__________\/\\\\___________\/\\\__________/\\\/\\\_____\//\\\______\///_FORCE______
__________\/\\\\___________\/\\\________/\\\/\/\\\______\////\\\___________________
__________\/\\\\___________\/\\\______/\\\/__\/\\\_________\////\\\________________
__________\/\\\\___________\/\\\____/\\\\\\\\\\\\\\\\_________\////\\\_____________
_________\\/\\\\___________\/\\\___\///////////\\\//___/\\\______\//\\\____________
_____/\\\\\\\\\\\\\\\\\____\/\\\_____________\/\\\____\///\\\\\\\\\\\/_@IT4sMx_____
____\/////////////////_____\///______________\///_______\///////////_@julianstafari
=end

require 'csv'
require 'open-uri'
require './database_class.rb'


class Csv_class


  def initialize

    @csv_file = 'cell_towers.csv'
    @csv_obj = nil
    @db_obj = Cassandra_db.new
    @db_obj.open_connection
    @db_obj.connect_keyspace
    @api_key = '' #YOUR API KEY OF OPENCELLID HERE!

  end


  def open_csv


    if File.file?'cell_towers.csv.gz' == true
      decompress_gz('cell_towers.csv.gz')
      @csv_obj = CSV.open(@csv_file)
    elsif File.file?'cell_towers.csv' == true
      @csv_obj = CSV.open(@csv_file)

    else
      get_csv
    end


  end

  def close_csv

    @csv_obj.close

  end

  def operate

    anal = 0
    @csv_obj.each do |row|


      puts anal
      @db_obj.insert_row(row)
      anal += 1
      #TRY THIS ONE IF OU HAVING PROBLEMS WITH THE CASSANDRA INSERTS (SCRIPT BROKE!)
      #WHERE xxxxx IS THE LAST ROW INSERTED
      #if anal >= xxxxx
      #  puts anal
      #  @db_obj.insert_row(row)
      #end
      #anal += 1
    end


  end

  def delete_past_csv

    begin

      #File.delete('cell_towers.csv.gz') if File.file? 'cell_towers.csv.gz'
      File.delete('cell_towers.csv') if File.file? 'cell_towers.csv'
      return true

    rescue

      return false

    end

  end

  def decompress_gz(file)
    #The simpliest way!
    exec("gzip -d cell_towers.csv.gz ")

  end

  def get_csv

    begin

      delete_past_csv
      link = "http://opencellid.org/downloads/?apiKey=".concat(@api_key).concat("&filename=cell_towers.csv.gz")
      tmp_down = open(link)
      IO.copy_stream(tmp_down, Dir.pwd.to_s.concat('/cell_towers.csv.gz'))
      return true

    rescue

      puts "Some error downloading cell_towers.csv file! #{get_csv.class}"

    end


  end

end