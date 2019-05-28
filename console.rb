require('pry-byebug')
require_relative('models/properties.rb')

property1 = Property.new ({
  'address' => '17 Magdalen Road, Exeter',
  'value' => '200000',
  'num_of_bedrooms' => '3',
  'buy_status' => false
  })

  property2 = Property.new ({
    'address' => '93 Dean Bank Lane, Edinburgh',
    'value' => '300000',
    'num_of_bedrooms' => '2',
    'buy_status' => true
    })

  property3 = Property.new ({
    'address' => '51 Torver Crescent, Sunderland',
    'value' => '150000',
    'num_of_bedrooms' => '4',
    'buy_status' => false
    })

  property4 = Property.new ({
    'address' => '10 Watson Place, Exeter',
    'value' => '400000',
    'num_of_bedrooms' => '5',
    'buy_status' => true
    })


property1.save
property2.save
property3.save
property4.save

binding.pry
nil
