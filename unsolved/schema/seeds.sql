USE my_db;

INSERT INTO users (
  first_name,
  last_name,
  email,
  age,
  is_retired
  )
  VALUES
    ("Bob", "Smith", "bob@lawblah.blog", 30, false),
    ("Howard", "Carr", "howard.carr@example.com", 52, true),
    ("Marcia", "Davis", "marcia.davis@company.com", 28, false),
    ("Rodney", "Baker", "rodney.baker@example.com", 42, false),
    ("Jackson", "Romero", "jackson.romero@company.com", 32, false),
    ("Lois", "Ford", "lois.ford@example.com", 19, false),
    ("Regina", "Warren", "regina.warren@example.com", 60, true),
    ("Jessica", "Henry", "jessica.henry@gmail.com", 25, false),
    ("Melvin", "Jimenez", "melvin.jimenez@gmail.com", 45, false),
    ("Billy", "Batson", "capt.marvel@shazam.com", 13, false);

INSERT INTO addresses (
  street_address,
  city,
  state,
  zip_code,
  user_id
) VALUES
  (
    "1193 Miller Ave",
    "Seymour",
    "Florida",
    83503,
    1
  ),
  (
    "1843 Country Club Rd",
    "Cape Fear",
    "New Jersey",
    24178,
    2
  ),
  (
    "7262 Dogwood Ave",
    "Antioch",
    "Georgia",
    67330,
    3
  ),
  (
    "6596 Groveland Terrace",
    "Centennial",
    "New Jersey",
    50037,
    4
  ),
  (
    "3466 Adams St",
    "Salem",
    "Missouri",
    78111,
    5
  ),
  (
    "2559 Cackson St",
    "Orlando",
    "Florida",
    30553,
    6
  ),
  (
    "4792 Mcgowen St",
    "Tyler",
    "Minnesota",
    84834,
    7
  ),
  (
    "762 Pecan Acres Ln",
    "Shreveport",
    "Louisiana",
    95963,
    8
  ),
  (
    "2470 E Little York Rd",
    "Scottsdale",
    "North Carolina",
    81891,
    9
  );

INSERT INTO permissions (action)
  VALUES ("read"), ("write"), ("delete");

INSERT INTO user_permissions (user_id, permission_id)
  VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (4, 2),
    (5, 1),
    (6, 1),
    (6, 2),
    (7, 1),
    (7, 2),
    (7, 3),
    (8, 1),
    (9, 1),
    (9, 2),
    (9, 3);