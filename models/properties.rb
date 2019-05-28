require('pg')

class Property
  attr_reader :address, :num_of_bedrooms, :id
  attr_accessor :value, :buy_status

  def initialize(options)
    @address = options['address']
    @num_of_bedrooms = options['num_of_bedrooms'].to_i
    @value = options['value'].to_i
    @buy_status = options['buy_status']
    @id = options['id'].to_i if options['id']
  end

  def save
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "INSERT INTO property_listings (
    address, value, num_of_bedrooms, buy_status
    ) VALUES (
      $1, $2, $3, $4
    ) RETURNING *"
    values = [@address, @value, @num_of_bedrooms, @buy_status]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close
  end

  def update
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "UPDATE property_listings SET (address, value, num_of_bedrooms, buy_status) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@address, @value, @num_of_bedrooms, @buy_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def delete
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM property_listings WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close
  end

  def Property.read
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM property_listings"
    db.prepare("read", sql)
    properties = db.exec_prepared("read")
    db.close
    return properties.map{|property| Property.new(property)}
  end

  def Property.find(id)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM property_listings WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    property = db.exec_prepared("find", values)
    db.close
    return Property.new(property[0])
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM property_listings WHERE address = $1"
    values = [address]
    db.prepare("find_by_address", sql)
    property = db.exec_prepared("find_by_address", values)
    db.close
    if property.map{} != []
      return Property.new(property[0])
    else
      return nil
    end
  end

  def Property.find_by_value(value)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM property_listings WHERE value >= $1"
    values = [value]
    db.prepare("find_value", sql)
    properties = db.exec_prepared("find_value", values)
    db.close
    if properties.map{} != []
      return properties.map{|property| Property.new(property)}
    else
      return nil
    end
  end
    #Class methods are used when you don't have an object to call it from.
    #instance methods are used when you do hve the object.
end
