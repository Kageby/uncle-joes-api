-- Uncle Joe's Coffee Company — BigQuery Table Definitions
-- Dataset: uncle_joes
--
-- Run each statement in the BigQuery console (or bq CLI) after creating the dataset.
-- Replace `your-project` with your actual GCP project ID.

-- ============================================================
-- 1. Locations
-- ============================================================
CREATE TABLE IF NOT EXISTS `your-project.uncle_joes.locations` (
  id                   STRING    NOT NULL,
  open_for_business    BOOL,
  city                 STRING,
  state                STRING,
  wifi                 BOOL,
  drive_thru           BOOL,
  door_dash            BOOL,
  email                STRING,
  phone_number         STRING,
  fax_number           STRING,
  location_map_address STRING,
  location_map_lat     FLOAT64,
  location_map_lng     FLOAT64,
  address_one          STRING,
  address_two          STRING,
  zip_code             STRING,
  near_by              STRING,
  hours_monday_open    STRING,
  hours_monday_close   STRING,
  hours_tuesday_open   STRING,
  hours_tuesday_close  STRING,
  hours_wednesday_open  STRING,
  hours_wednesday_close STRING,
  hours_thursday_open  STRING,
  hours_thursday_close STRING,
  hours_friday_open    STRING,
  hours_friday_close   STRING,
  hours_saturday_open  STRING,
  hours_saturday_close STRING,
  hours_sunday_open    STRING,
  hours_sunday_close   STRING
);

-- ============================================================
-- 2. Menu Items
-- ============================================================
CREATE TABLE IF NOT EXISTS `your-project.uncle_joes.menu_items` (
  id        STRING  NOT NULL,
  name      STRING,
  category  STRING,   -- Coffee | Espresso | Tea | Other
  size      STRING,   -- Small | Medium | Large
  calories  INT64,
  price     NUMERIC
);

-- ============================================================
-- 3. Coffee Club Members
-- ============================================================
CREATE TABLE IF NOT EXISTS `your-project.uncle_joes.members` (
  id           STRING  NOT NULL,
  first_name   STRING,
  last_name    STRING,
  email        STRING,
  phone_number STRING,
  home_store   STRING,  -- FK → locations.id
  password     STRING,  -- bcrypt hash; all members share Coffee123!
  api_token    STRING
);

-- ============================================================
-- 4. Orders
-- ============================================================
CREATE TABLE IF NOT EXISTS `your-project.uncle_joes.orders` (
  order_id        STRING    NOT NULL,
  member_id       STRING,   -- nullable FK → members.id (NULL = anonymous)
  store_id        STRING,   -- FK → locations.id
  order_date      TIMESTAMP,
  items_subtotal  NUMERIC,
  order_discount  NUMERIC,  -- 15% discount applied when member_id is present
  order_subtotal  NUMERIC,
  sales_tax       NUMERIC,
  order_total     NUMERIC
);

-- ============================================================
-- 5. Order Items (line items)
-- ============================================================
CREATE TABLE IF NOT EXISTS `your-project.uncle_joes.order_items` (
  id           STRING  NOT NULL,
  order_id     STRING,   -- FK → orders.order_id
  menu_item_id STRING,   -- FK → menu_items.id
  item_name    STRING,
  size         STRING,
  quantity     INT64,
  price        NUMERIC   -- historically adjusted price at time of order
);
