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
require 'cassandra'

class Cassandra_db

  def initialize

    @obj_cluster = nil
    @user = '' #YOUR CASSANDRA USER HERE
    @password = '' #YOUR CASSANDRA PASSWORD HERE
    #@database='tracking'
    @hosts = ['localhost']
    @keyspace = 'opencellid'
    @session = nil

  end
  attr_accessor :keyspace


################Connections################
  def open_connection
    begin

      @obj_cluster = Cassandra.cluster(username: @user,
                                       password: @password,
                                       hosts: @hosts)

    rescue => e
      puts 'Error connection to cassandra cluster'
      puts e
      return false
    end

    return true

  end

  def connect_keyspace

    begin
      @session = @obj_cluster.connect(@keyspace)
      return true
    rescue
      return false
    end

  end

  def close_connection
    begin
      @session.close
      return true
    rescue => e
      return false

    end

  end
############################################

###########CREATION_OF_KEYSPACE#############
  def create_keyspace
    begin

      keyspace_definition = <<-KSDEF
        CREATE KEYSPACE opencellid
        WITH REPLICATION = {
          'class': 'SimpleStrategy',
          'replication_factor': 3
        }
      KSDEF

      @session.execute(keyspace_definition)
      #@session.execute("CREATE KEYSPACE opencellid WITH replication={'class':'SimpleStrategy','replication_factor':3};")
      return true
    rescue
      puts "Error creating keyspace \"opencellid\" class: #{create_keyspace.class}"
      return false
    end

  end

  def check_ks_existence
    begin
      @obj_cluster.inspect.include?("opencellid") ? true :  false
    rescue
      puts "Error retriving available keyspaces #{check_ks_existence.class}"
    end

  end

  def create_table

    begin
      @session.execute("create table opencellid.antennas(antenna text primary key, radio text, mcc text, mnc text, lac text, cid text, unit text, lon text, lat text, range text, averagesignal text);")
      true
    rescue
      puts "Error trying to create table! #{create_table.class}"
      false
    end

  end

  def check_table_existence

    begin
      tmp_res = @session.execute("select table_name from system_schema.tables where keyspace_name='opencellid'").each do |row|

        if row.has_value?"antennas"
          return true
        end

      end
      return false
    rescue
      puts "Error retriving available tables! #{check_table_existence.class}"
      false
    end

  end

  def insert_row(row)

    begin
      tmp_antenna = row[1].concat("-").concat(row[2]).concat("-").concat(row[3]).concat("-").concat(row[4])
      statement = "insert into antennas(antenna, radio, mcc, mnc, lac, cid, unit, lon, lat, range, averagesignal) values('#{tmp_antenna}','#{row[0]}','#{row[1]}','#{row[2]}','#{row[3]}','#{row[4]}','#{row[5]}','#{row[6]}','#{row[7]}','#{row[8]}','#{row[13]}')"
      puts statement
      @session.execute(statement)
      true
    rescue
      puts "Error trying to insert row! #{create_table.class}"
      false
    end

  end


end
