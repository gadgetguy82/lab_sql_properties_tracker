DROP TABLE IF EXISTS property_listings;

CREATE TABLE property_listings(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT4,
  num_of_bedrooms INT2,
  buy_status BOOLEAN
);
