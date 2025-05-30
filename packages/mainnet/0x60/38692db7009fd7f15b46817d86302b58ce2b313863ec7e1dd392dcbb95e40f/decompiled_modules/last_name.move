module 0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::last_name {
    public(friend) fun select(arg0: u16) : 0x1::string::String {
        let v0 = arg0 % 146;
        let v1 = &v0;
        let v2 = if (*v1 == 0) {
            vector[b"Charlesworth", b"Ball", b"Smith", b"Johnson", b"Sanderson", b"White", b"Smith", b"Savage", b"Waite", b"Noble"]
        } else if (*v1 == 1) {
            vector[b"Mae", b"Abbott", b"Abney", b"Abnett", b"Acevedo", b"Acosta", b"Adams", b"Adkins", b"Adrichem", b"Aguilar"]
        } else if (*v1 == 2) {
            vector[b"Aguirre", b"Albert", b"Alexander", b"Alford", b"Allen", b"Allison", b"Alston", b"Alvarado", b"Alvarez", b"Anderson"]
        } else if (*v1 == 3) {
            vector[b"Andrews", b"Anthony", b"Appleton", b"Appleby", b"Armstrong", b"Archibald", b"Arnold", b"Ashley", b"Aston", b"Ashworth"]
        } else if (*v1 == 4) {
            vector[b"Atkins", b"Atkinson", b"Austin", b"Avery", b"Avila", b"Ayala", b"Ayers", b"Ayton", b"Bailey", b"Baird"]
        } else if (*v1 == 5) {
            vector[b"Baker", b"Baldwin", b"Ball", b"Ballard", b"Banks", b"Barber", b"Barker", b"Barlow", b"Barnes", b"Barnett"]
        } else if (*v1 == 6) {
            vector[b"Barr", b"Barrera", b"Barrett", b"Barron", b"Barry", b"Bartlett", b"Barton", b"Bass", b"Bates", b"Battle"]
        } else if (*v1 == 7) {
            vector[b"Bauer", b"Baxter", b"Bagshaw", b"Backshawl", b"Beach", b"Bean", b"Beard", b"Beasley", b"Beck", b"Becker"]
        } else if (*v1 == 8) {
            vector[b"Bell", b"Bender", b"Benjamin", b"Bennett", b"Benson", b"Bentley", b"Benton", b"Berg", b"Berger", b"Bernard"]
        } else if (*v1 == 9) {
            vector[b"Berry", b"Best", b"Bird", b"Bishop", b"Black", b"Blackburn", b"Blackwell", b"Blair", b"Blake", b"Blanchard"]
        } else if (*v1 == 10) {
            vector[b"Blankenship", b"Blevins", b"Bolton", b"Bond", b"Bonner", b"Booker", b"Boone", b"Booth", b"Bowen", b"Bowers"]
        } else if (*v1 == 11) {
            vector[b"Bowman", b"Boyd", b"Boyer", b"Boyle", b"Bradford", b"Bradley", b"Bradshaw", b"Brady", b"Branch", b"Bray"]
        } else if (*v1 == 12) {
            vector[b"Brennan", b"Brewer", b"Bridges", b"Briggs", b"Bright", b"Britt", b"Brock", b"Brooks", b"Brown", b"Browning"]
        } else if (*v1 == 13) {
            vector[b"Bruce", b"Bryan", b"Bryant", b"Buchanan", b"Buck", b"Buckley", b"Buckner", b"Budd", b"Bullock", b"Burch"]
        } else if (*v1 == 14) {
            vector[b"Burgess", b"Burke", b"Burks", b"Burnett", b"Burns", b"Burris", b"Burt", b"Burton", b"Busto", b"Bush"]
        } else if (*v1 == 15) {
            vector[b"Butler", b"Byers", b"Byrd", b"Cabrera", b"Cain", b"Calderon", b"Caldwell", b"Calhoun", b"Callahan", b"Camacho"]
        } else if (*v1 == 16) {
            vector[b"Cameron", b"Campbell", b"Campos", b"Cannon", b"Cantrell", b"Cantu", b"Cardenas", b"Carey", b"Carlson", b"Carlyle"]
        } else if (*v1 == 17) {
            vector[b"Carlisle", b"Carney", b"Carpenter", b"Carr", b"Caron", b"Carrillo", b"Carroll", b"Carson", b"Carter", b"Carver"]
        } else if (*v1 == 18) {
            vector[b"Case", b"Casey", b"Cason", b"Cash", b"Castaneda", b"Castillo", b"Castro", b"Cervantes", b"Chambers", b"Chan"]
        } else if (*v1 == 19) {
            vector[b"Chandler", b"Chaney", b"Chang", b"Chapman", b"Charles", b"Chase", b"Chatman", b"Chavez", b"Chen", b"Cherry"]
        } else if (*v1 == 20) {
            vector[b"Chevrolet", b"Christensen", b"Christian", b"Church", b"Clark", b"Clarke", b"Clay", b"Clayton", b"Clements", b"Clemons"]
        } else if (*v1 == 21) {
            vector[b"Cleveland", b"Cline", b"Cobb", b"Cochran", b"Coffey", b"Cohen", b"Cole", b"Coleman", b"Collier", b"Collins"]
        } else if (*v1 == 22) {
            vector[b"Colon", b"Combs", b"Compton", b"Conley", b"Conner", b"Conrad", b"Contreras", b"Conway", b"Cook", b"Cooke"]
        } else if (*v1 == 23) {
            vector[b"Cooley", b"Cooper", b"Copeland", b"Cortez", b"Cote", b"Cotton", b"Couture", b"Cox", b"Craft", b"Craig"]
        } else if (*v1 == 24) {
            vector[b"Crane", b"Crawford", b"Crosby", b"Cross", b"Cruz", b"Cummings", b"Cunningham", b"Curry", b"Curtis", b"Dale"]
        } else if (*v1 == 25) {
            vector[b"Dalton", b"Daniel", b"Daniels", b"Daugherty", b"Davenport", b"David", b"Davidson", b"Davis", b"Dawson", b"Day"]
        } else if (*v1 == 26) {
            vector[b"Dean", b"Decker", b"Dejesus", b"Delacruz", b"Delaney", b"Deleon", b"Delgado", b"Dennis", b"Diaz", b"Dickerson"]
        } else if (*v1 == 27) {
            vector[b"Dickson", b"Dillard", b"Dillon", b"Dixon", b"Dodson", b"Dominguez", b"Donaldson", b"Donovan", b"Dorsey", b"Dotson"]
        } else if (*v1 == 28) {
            vector[b"Douglas", b"Downs", b"Doyle", b"Drake", b"Dudley", b"Duffy", b"Duke", b"Duncan", b"Dunlap", b"Dunn"]
        } else if (*v1 == 29) {
            vector[b"Duran", b"Durham", b"Dyer", b"Eaton", b"Edwards", b"Elliott", b"Ellis", b"Ellison", b"Ellwood", b"Emerson"]
        } else if (*v1 == 30) {
            vector[b"England", b"English", b"Erickson", b"Espinoza", b"Estes", b"Estrada", b"Evans", b"Everett", b"Ewing", b"Farley"]
        } else if (*v1 == 31) {
            vector[b"Farmer", b"Farrell", b"Faulkner", b"Ferguson", b"Fernandez", b"Ferrell", b"Fields", b"Figueroa", b"Finch", b"Finley"]
        } else if (*v1 == 32) {
            vector[b"Fischer", b"Fisher", b"Fitzgerald", b"Fitzpatrick", b"Fleming", b"Fletcher", b"Flores", b"Flowers", b"Floyd", b"Flynn"]
        } else if (*v1 == 33) {
            vector[b"Foley", b"Forbes", b"Ford", b"Foreman", b"Foster", b"Fowler", b"Fox", b"Francis", b"Franco", b"Frank"]
        } else if (*v1 == 34) {
            vector[b"Franklin", b"Franks", b"Frazier", b"Frederick", b"Freeman", b"French", b"Frost", b"Fry", b"Frye", b"Fuentes"]
        } else if (*v1 == 35) {
            vector[b"Fuller", b"Fulton", b"Gaines", b"Gallagher", b"Gallegos", b"Galloway", b"Gamble", b"Garcia", b"Gardner", b"Garner"]
        } else if (*v1 == 36) {
            vector[b"Garrett", b"Garrison", b"Garza", b"Gates", b"Gay", b"Gentry", b"George", b"Gibbs", b"Gibson", b"Gilbert"]
        } else if (*v1 == 37) {
            vector[b"Giles", b"Gill", b"Gillespie", b"Gilliam", b"Gilmore", b"Glass", b"Glenn", b"Glover", b"Goff", b"Golden"]
        } else if (*v1 == 38) {
            vector[b"Gomez", b"Gonzales", b"Gonzalez", b"Good", b"Goodman", b"Goodwin", b"Gordon", b"Gould", b"Graham", b"Grant"]
        } else if (*v1 == 39) {
            vector[b"Graves", b"Gray", b"Green", b"Greene", b"Greer", b"Gregory", b"Griffin", b"Griffith", b"Grimes", b"Gross"]
        } else if (*v1 == 40) {
            vector[b"Guerra", b"Guerrero", b"Guthrie", b"Gutierrez", b"Guy", b"Guzman", b"Hahn", b"Hale", b"Haley", b"Hall"]
        } else if (*v1 == 41) {
            vector[b"Hamilton", b"Hammond", b"Hampton", b"Hancock", b"Haney", b"Hansen", b"Hanson", b"Hardin", b"Harding", b"Hardy"]
        } else if (*v1 == 42) {
            vector[b"Harmon", b"Harper", b"Harrell", b"Harrington", b"Harris", b"Harrison", b"Hart", b"Hartman", b"Harvey", b"Hatfield"]
        } else if (*v1 == 43) {
            vector[b"Hawkins", b"Hayden", b"Hayes", b"Haynes", b"Hays", b"Head", b"Heath", b"Hebert", b"Henderson", b"Hendricks"]
        } else if (*v1 == 44) {
            vector[b"Hendrix", b"Henry", b"Hensley", b"Henson", b"Herman", b"Hernandez", b"Herrera", b"Herring", b"Hess", b"Hester"]
        } else if (*v1 == 45) {
            vector[b"Hewitt", b"Hickman", b"Hicks", b"Higgins", b"Hill", b"Hines", b"Hinton", b"Hobbs", b"Hodge", b"Hodges"]
        } else if (*v1 == 46) {
            vector[b"Hoffman", b"Hogan", b"Holcomb", b"Holden", b"Holder", b"Holland", b"Holloway", b"Holman", b"Holmes", b"Holt"]
        } else if (*v1 == 47) {
            vector[b"Hood", b"Hooper", b"Hoover", b"Hopkins", b"Hopper", b"Horn", b"Horne", b"Horton", b"House", b"Houston"]
        } else if (*v1 == 48) {
            vector[b"Howard", b"Howe", b"Howell", b"Hubbard", b"Huber", b"Hudson", b"Huff", b"Huffman", b"Hughes", b"Hull"]
        } else if (*v1 == 49) {
            vector[b"Humphrey", b"Hunt", b"Hunter", b"Hurley", b"Hurst", b"Hutchinson", b"Hyde", b"Ingram", b"Irwin", b"Jackson"]
        } else if (*v1 == 50) {
            vector[b"Jacobs", b"Jacobson", b"James", b"Jarvis", b"Jefferson", b"Jenkins", b"Jennings", b"Jensen", b"Jimenez", b"Johns"]
        } else if (*v1 == 51) {
            vector[b"Johnson", b"Johnston", b"Jones", b"Jordan", b"Joseph", b"Joyce", b"Joyner", b"Juarez", b"Justice", b"Kane"]
        } else if (*v1 == 52) {
            vector[b"Kaufman", b"Keith", b"Keller", b"Kelley", b"Kelly", b"Kemp", b"Kennedy", b"Kent", b"Kerr", b"Key"]
        } else if (*v1 == 53) {
            vector[b"Kidd", b"Kim", b"King", b"Kinney", b"Kirby", b"Kirk", b"Kirkland", b"Klein", b"Kline", b"Knapp"]
        } else if (*v1 == 54) {
            vector[b"Knight", b"Knowles", b"Knox", b"Koch", b"Kramer", b"Lamb", b"Lambert", b"Lancaster", b"Landry", b"Lane"]
        } else if (*v1 == 55) {
            vector[b"Lang", b"Langley", b"Lara", b"Larsen", b"Larson", b"Lawrence", b"Lawson", b"Le", b"Leach", b"Leblanc"]
        } else if (*v1 == 56) {
            vector[b"Lee", b"Leon", b"Leonard", b"Lester", b"Levine", b"Levy", b"Lewis", b"Lindsay", b"Lindsey", b"Little"]
        } else if (*v1 == 57) {
            vector[b"Livingston", b"Lloyd", b"Logan", b"Long", b"Lopez", b"Lott", b"Love", b"Lowe", b"Lofthouse", b"Lowery"]
        } else if (*v1 == 58) {
            vector[b"Lucas", b"Luna", b"Lynch", b"Lynn", b"Lyons", b"Macdonald", b"Macias", b"Mack", b"Madden", b"Maddox"]
        } else if (*v1 == 59) {
            vector[b"Maldonado", b"Malone", b"Mann", b"Manning", b"Marks", b"Marquez", b"Marsh", b"Marshall", b"Martin", b"Martinez"]
        } else if (*v1 == 60) {
            vector[b"Mason", b"Massey", b"Mathews", b"Mathis", b"Matthews", b"Maxwell", b"May", b"Mayer", b"Maynard", b"Mayo"]
        } else if (*v1 == 61) {
            vector[b"Mays", b"Magdalen", b"Magdalin", b"Mcbride", b"Mccall", b"Mccarthy", b"Mccarty", b"Mcclain", b"Mcclure", b"Mcconnell"]
        } else if (*v1 == 62) {
            vector[b"Mccormick", b"Mccoy", b"Mccray", b"Mccullough", b"Mcdaniel", b"Mcdonald", b"Mcdowell", b"Mcfadden", b"Mcfarland", b"Mcgee"]
        } else if (*v1 == 63) {
            vector[b"Mcgowan", b"Mcguire", b"Mcintosh", b"Mcintyre", b"Mckay", b"Mckee", b"Mckenzie", b"Mckinney", b"Mcknight", b"Mclaughlin"]
        } else if (*v1 == 64) {
            vector[b"Mclean", b"Mcleod", b"Mcmahon", b"Mcmillan", b"Mcneil", b"Mcpherson", b"Meadows", b"Medina", b"Mejia", b"Melendez"]
        } else if (*v1 == 65) {
            vector[b"Melton", b"Mendez", b"Mendoza", b"Mercado", b"Mercer", b"Merrill", b"Merritt", b"Meyer", b"Meyers", b"Michael"]
        } else if (*v1 == 66) {
            vector[b"Middleton", b"Miles", b"Miller", b"Mills", b"Miranda", b"Mitchell", b"Molina", b"Monroe", b"Montgomery", b"Montoya"]
        } else if (*v1 == 67) {
            vector[b"Moody", b"Moon", b"Mooney", b"Moore", b"Morales", b"Moran", b"Moreno", b"Morgan", b"Morin", b"Morris"]
        } else if (*v1 == 68) {
            vector[b"Morrison", b"Morrow", b"Morse", b"Morton", b"Moses", b"Mosley", b"Moss", b"Mueller", b"Mullen", b"Mullins"]
        } else if (*v1 == 69) {
            vector[b"Munoz", b"Murphy", b"Murray", b"Myers", b"Nash", b"Navarro", b"Naylor", b"Neal", b"Nelson", b"Newman"]
        } else if (*v1 == 70) {
            vector[b"Newton", b"Nevin", b"Nguyen", b"Nichols", b"Nicholson", b"Nielsen", b"Nieves", b"Nixon", b"Noble", b"Noel"]
        } else if (*v1 == 71) {
            vector[b"Nolan", b"Norman", b"Norris", b"Norton", b"Nunez", b"Obrien", b"Ochoa", b"Oconnor", b"Odom", b"Odonnell"]
        } else if (*v1 == 72) {
            vector[b"Oliver", b"Olsen", b"Olson", b"Oluo", b"Oneal", b"Oneil", b"Oneill", b"Orr", b"Ortega", b"Ortiz"]
        } else if (*v1 == 73) {
            vector[b"Osborn", b"Osborne", b"Owen", b"Owens", b"Pace", b"Pacheco", b"Padilla", b"Page", b"Palmer", b"Park"]
        } else if (*v1 == 74) {
            vector[b"Parker", b"Parks", b"Parkinson", b"Parrish", b"Parsons", b"Pate", b"Patel", b"Patrick", b"Patterson", b"Patton"]
        } else if (*v1 == 75) {
            vector[b"Paul", b"Payne", b"Pearson", b"Peck", b"Pena", b"Pennington", b"Perez", b"Perkins", b"Perry", b"Peters"]
        } else if (*v1 == 76) {
            vector[b"Petersen", b"Peterson", b"Petty", b"Phelps", b"Phillips", b"Pickett", b"Pierce", b"Pittman", b"Pitts", b"Pollard"]
        } else if (*v1 == 77) {
            vector[b"Poole", b"Pope", b"Porter", b"Potter", b"Potts", b"Powell", b"Powers", b"Pratt", b"Preston", b"Price"]
        } else if (*v1 == 78) {
            vector[b"Prince", b"Pruitt", b"Puckett", b"Pugh", b"Quinn", b"Ramirez", b"Ramos", b"Ramsey", b"Randall", b"Randolph"]
        } else if (*v1 == 79) {
            vector[b"Rasmussen", b"Ratliff", b"Ratly", b"Ratkinson", b"Ray", b"Raymond", b"Reed", b"Reese", b"Reeves", b"Reid"]
        } else if (*v1 == 80) {
            vector[b"Reilly", b"Reyes", b"Reynolds", b"Rhodes", b"Rice", b"Rich", b"Richard", b"Richards", b"Richardson", b"Richmond"]
        } else if (*v1 == 81) {
            vector[b"Riddle", b"Riggs", b"Riley", b"Rios", b"Rivas", b"Rivera", b"Rivers", b"Roach", b"Robbins", b"Roberson"]
        } else if (*v1 == 82) {
            vector[b"Roberts", b"Robertson", b"Robinson", b"Robles", b"Rocha", b"Rodgers", b"Rodriguez", b"Rodriquez", b"Rogers", b"Rojas"]
        } else if (*v1 == 83) {
            vector[b"Rollins", b"Roman", b"Romero", b"Rosa", b"Rosales", b"Rosario", b"Rose", b"Ross", b"Roth", b"Rowe"]
        } else if (*v1 == 84) {
            vector[b"Rowland", b"Roy", b"Ruiz", b"Rush", b"Russell", b"Russo", b"Rutledge", b"Ryan", b"Salas", b"Salazar"]
        } else if (*v1 == 85) {
            vector[b"Salinas", b"Sampson", b"Sanchez", b"Sanders", b"Sandoval", b"Sanford", b"Santana", b"Santiago", b"Santos", b"Sargent"]
        } else if (*v1 == 86) {
            vector[b"Saunders", b"Savage", b"Sawyer", b"Schmidt", b"Schneider", b"Schroeder", b"Schultz", b"Schwartz", b"Scott", b"Sears"]
        } else if (*v1 == 87) {
            vector[b"Sellers", b"Serrano", b"Sethin", b"Sexton", b"Shaffer", b"Shannon", b"Sharp", b"Sharpe", b"Shaw", b"Shelton"]
        } else if (*v1 == 88) {
            vector[b"Shepard", b"Shepherd", b"Sheppard", b"Sherman", b"Shields", b"Short", b"Silva", b"Simmons", b"Simon", b"Simpson"]
        } else if (*v1 == 89) {
            vector[b"Sims", b"Singleton", b"Skinner", b"Slater", b"Sloan", b"Small", b"Smith", b"Snider", b"Snow", b"Snyder"]
        } else if (*v1 == 90) {
            vector[b"Solis", b"Solomon", b"Sosa", b"Soto", b"Sparks", b"Spears", b"Spence", b"Spencer", b"Stafford", b"Stanley"]
        } else if (*v1 == 91) {
            vector[b"Stanton", b"Standish", b"Stark", b"Steele", b"Stein", b"Stephens", b"Stephenson", b"Stevens", b"Stevenson", b"Stewart"]
        } else if (*v1 == 92) {
            vector[b"Stokes", b"Stone", b"Stout", b"Strickland", b"Strong", b"Stuart", b"Suarez", b"Sullivan", b"Summers", b"Sutton"]
        } else if (*v1 == 93) {
            vector[b"Swanson", b"Sweeney", b"Sweet", b"Sykes", b"Talley", b"Tanner", b"Tate", b"Taylor", b"Terrell", b"Terry"]
        } else if (*v1 == 94) {
            vector[b"Thomas", b"Thompson", b"Thornton", b"Tillman", b"Todd", b"Torres", b"Townsend", b"Tran", b"Travis", b"Trevino"]
        } else if (*v1 == 95) {
            vector[b"Trujillo", b"Tucker", b"Turner", b"Tyler", b"Tyson", b"Underwood", b"Valdez", b"Valencia", b"Valentine", b"Valenzuela"]
        } else if (*v1 == 96) {
            vector[b"Vance", b"Vang", b"Vargas", b"Vasquez", b"Vaughan", b"Vaughn", b"Vazquez", b"Vega", b"Velasquez", b"Velazquez"]
        } else if (*v1 == 97) {
            vector[b"Velez", b"Villarreal", b"Vincent", b"Vinson", b"Wade", b"Wagner", b"Walker", b"Wall", b"Wallace", b"Waller"]
        } else if (*v1 == 98) {
            vector[b"Walls", b"Walsh", b"Walter", b"Walters", b"Walton", b"Ward", b"Ware", b"Warner", b"Warren", b"Washington"]
        } else if (*v1 == 99) {
            vector[b"Waters", b"Watkins", b"Watson", b"Watts", b"Weaver", b"Webb", b"Weber", b"Webster", b"Weeks", b"Weiss"]
        } else if (*v1 == 100) {
            vector[b"Welch", b"Wells", b"West", b"Wheeler", b"Whitaker", b"White", b"Whitehead", b"Whitfield", b"Whitley", b"Whitney"]
        } else if (*v1 == 101) {
            vector[b"Wiggins", b"Wilcox", b"Wilder", b"Wiley", b"Wilkerson", b"Wilkins", b"Wilkinson", b"William", b"Williams", b"Williamson"]
        } else if (*v1 == 102) {
            vector[b"Willis", b"Wilson", b"Winters", b"Wise", b"Witt", b"Wolf", b"Wolfe", b"Wong", b"Wood", b"Woodard"]
        } else if (*v1 == 103) {
            vector[b"Woods", b"Woodward", b"Woodhouse", b"Woodly", b"Wooten", b"Wooton", b"Workman", b"Wright", b"Wyatt", b"Wynn"]
        } else if (*v1 == 104) {
            vector[b"Wutang", b"Yang", b"Yates", b"Yarrow", b"Yarr", b"Yarbrough", b"York", b"Young", b"Xanders", b"Xanthos"]
        } else if (*v1 == 105) {
            vector[b"Xenakis", b"Xing", b"Xian", b"Xavier", b"Xue", b"Zamora", b"Zimmerman", b"Pro", b"Autodatter", b"Autoson"]
        } else if (*v1 == 106) {
            vector[b"Abend", b"Adleman", b"Amdahl", b"Angstrom", b"Ajaxman", b"Apoc", b"Babbage", b"Bacon", b"Baconsmith", b"Band"]
        } else if (*v1 == 107) {
            vector[b"Bayes", b"Batty", b"Batunas", b"Baxter", b"Berkeley", b"Beers", b"Bezier", b"Black", b"Block", b"Blockchains"]
        } else if (*v1 == 108) {
            vector[b"Blue", b"Bits", b"Bochs", b"Boon", b"Boomsmith", b"Boomboom", b"Bombom", b"Bogey", b"Bogie", b"Bogieface"]
        } else if (*v1 == 109) {
            vector[b"Bohr", b"Bolt", b"Boltfetcher", b"Boltmason", b"Bolten", b"Booth", b"Borg", b"Bounce", b"Bourne", b"Bracket"]
        } else if (*v1 == 110) {
            vector[b"Buff", b"Buffer", b"Bufferson", b"Buffers", b"Cable", b"Cabledatter", b"Cabler", b"Cambridge", b"Carbon", b"Carrier"]
        } else if (*v1 == 111) {
            vector[b"Carmack", b"Chiller", b"Chenguang", b"Choke", b"Circuit", b"Circuitsmith", b"Circuitmacer", b"Click", b"Clicksmith", b"Clicker"]
        } else if (*v1 == 112) {
            vector[b"Clickoff", b"Cluster", b"Clusterson", b"Clusterface", b"Cobalt", b"Codd", b"Coil", b"Coilson", b"Coleman", b"Copper"]
        } else if (*v1 == 113) {
            vector[b"Copperface", b"Core", b"Crosswalks", b"Curie", b"Current", b"Cuifen", b"Cybers", b"Cyberson", b"Cyberface", b"Cyberdatter"]
        } else if (*v1 == 114) {
            vector[b"Cybermancer", b"Cypher", b"Datas", b"Datason", b"Datamason", b"Datamancer", b"Datasmith", b"Daiquiri", b"Deadmouse", b"Deadman"]
        } else if (*v1 == 115) {
            vector[b"Deckard", b"Disk", b"Diskdatter", b"Diskson", b"Discsmith", b"Dolby", b"Dongle", b"Dondongle", b"Dongleface", b"Dongleson"]
        } else if (*v1 == 116) {
            vector[b"Donglefetcher", b"Donglecarrier", b"Donglemancer", b"Drive", b"Driver", b"Dvorak", b"Ellsworth", b"Edison", b"Eight", b"Eleven"]
        } else if (*v1 == 117) {
            vector[b"Eleventy", b"Erlang", b"Farad", b"Faraday", b"Fiber", b"Fiberson", b"Fiberman", b"Fiberfetcher", b"Fibersmith", b"Fibermason"]
        } else if (*v1 == 118) {
            vector[b"Fibermancer", b"Five", b"Four", b"Foster", b"Frequenza", b"Futzing", b"Gate", b"Gategate", b"Gates", b"Gater"]
        } else if (*v1 == 119) {
            vector[b"Gold", b"Goldsmith", b"Granville", b"Gray", b"Green", b"Gilberts", b"Gitson", b"Gitdatter", b"Glitter", b"Harakiri"]
        } else if (*v1 == 120) {
            vector[b"Hardman", b"Hertz", b"Hopper", b"Hobbs", b"Hobbins", b"Iron", b"Irons", b"Jennings", b"Joule", b"Joulesmith"]
        } else if (*v1 == 121) {
            vector[b"Jouleson", b"Jouleton", b"Jool", b"Kato", b"Kelvin", b"Kernel", b"Key", b"Kiri", b"Kowasaki", b"Kobayashi"]
        } else if (*v1 == 122) {
            vector[b"Kilby", b"Kingston", b"Kuwata", b"Ladlad", b"Lamarr", b"Laser", b"Laserface", b"Lasersmith", b"Lasermason", b"Lasermancer"]
        } else if (*v1 == 123) {
            vector[b"Le", b"Lee", b"Letterhead", b"Li", b"Link", b"Linksen", b"Linkinson", b"Linkmason", b"Legacy", b"Lichtermann"]
        } else if (*v1 == 124) {
            vector[b"Loader", b"Loadbolt", b"Logic", b"Logicson", b"Login", b"Loop", b"Lovelace", b"Master", b"Macarena", b"McNulty"]
        } else if (*v1 == 125) {
            vector[b"Mech", b"Mechsmith", b"Mechanick", b"Meier", b"Metal", b"Metall", b"Metalic", b"Metalik", b"Metalmann", b"Metalson"]
        } else if (*v1 == 126) {
            vector[b"Metalski", b"Mezzanine", b"Minimak", b"Monad", b"Monadi", b"Mosfet", b"Morpheus", b"Morton", b"Molyneux", b"Munge"]
        } else if (*v1 == 127) {
            vector[b"Munger", b"Munt", b"Munter", b"Mux", b"Nagle", b"Nakamura", b"Nett", b"Nettson", b"Netwall", b"Netzen"]
        } else if (*v1 == 128) {
            vector[b"Netizen", b"Neo", b"Neon", b"Newton", b"Nine", b"Niven", b"Northbridge", b"Null", b"One", b"Optekar"]
        } else if (*v1 == 129) {
            vector[b"Onishi", b"Optic", b"Parse", b"Parser", b"Perlman", b"Phillips", b"Phasers", b"Phaserface", b"Phaserson", b"Phaserbekker"]
        } else if (*v1 == 130) {
            vector[b"Phiser", b"Pieface", b"Pim", b"Pin", b"Pinface", b"Pisano", b"Plug", b"Pocket", b"Port", b"Portal"]
        } else if (*v1 == 131) {
            vector[b"Portalla", b"Portlet", b"Power", b"Powerbekker", b"Powermason", b"Powell", b"Prime", b"Primetime", b"Process", b"Proto"]
        } else if (*v1 == 132) {
            vector[b"Protosmith", b"Protoface", b"Proxy", b"Pulse", b"Pulseface", b"Quadrano", b"Quadro", b"Quartz", b"Quanta", b"Quantic"]
        } else if (*v1 == 133) {
            vector[b"Rambus", b"Rand", b"Render", b"Rendersmith", b"Renderman", b"Resistor", b"Rivest", b"Rhodes", b"Rhineheart", b"Robertson"]
        } else if (*v1 == 134) {
            vector[b"Rocker", b"Robot", b"Robotson", b"Robotis", b"Robotka", b"Robosmith", b"Robomancer", b"Root", b"Router", b"Routerman"]
        } else if (*v1 == 135) {
            vector[b"Rowe", b"Rowrow", b"Romero", b"Sadeghpour", b"Salome", b"Sato", b"Sammet", b"Schema", b"Schottky", b"Screw"]
        } else if (*v1 == 136) {
            vector[b"Screws", b"Screwsmith", b"Scrum", b"Scruescrue", b"Serial", b"Server", b"Seven", b"Shamir", b"Shannon", b"Shocks"]
        } else if (*v1 == 137) {
            vector[b"Shocksmith", b"Shocksen", b"Shima", b"Shocker", b"Shell", b"Silicon", b"Siliconman", b"Siliconsmith", b"Signal", b"Signalsmith"]
        } else if (*v1 == 138) {
            vector[b"Signalton", b"Signalface", b"Silver", b"Silverface", b"Silverlock", b"Silverman", b"Silvers", b"Silversmith", b"Sim", b"Sine"]
        } else if (*v1 == 139) {
            vector[b"Sinewaves", b"Sink", b"Six", b"Sixdigits", b"Slag", b"Smart", b"Socket", b"Socketson", b"Southbridge", b"Song"]
        } else if (*v1 == 140) {
            vector[b"Sparks", b"Sparkles", b"Sparx", b"Spiz", b"Spizza", b"Spizzo", b"Standard", b"Stanford", b"Stattom", b"Statohm"]
        } else if (*v1 == 141) {
            vector[b"Statvolt", b"Statwatt", b"Steel", b"Steele", b"Steelman", b"Steelton", b"Steely", b"Stoll", b"Suzuki", b"Swan"]
        } else if (*v1 == 142) {
            vector[b"Swift", b"Switch", b"Sweeney", b"Takeyama", b"Ten", b"Tesla", b"Teslaface", b"Teslasmith", b"Teslamancer", b"Tesla Warrior"]
        } else if (*v1 == 143) {
            vector[b"Thermos", b"Three", b"Torrent", b"Torrentface", b"Torrentson", b"Transistor", b"Trimpot", b"Tron", b"Tronton", b"Tronman"]
        } else if (*v1 == 144) {
            vector[b"Tronek", b"Turing", b"Turingsen", b"Turner", b"Twelve", b"Two", b"Units", b"Volt", b"Voight", b"Watt"]
        } else if (*v1 == 145) {
            vector[b"Wattface", b"Wattsmith", b"Wave", b"Wescoff", b"Williams", b"Wilson", b"Wire", b"Wiresen", b"Wiresson", b"Wire Warrior"]
        } else if (*v1 == 146) {
            vector[b"Wireback", b"Wireman", b"Wiresmith", b"Wiremancer", b"Wires", b"Yamamoto", b"Yamaha", b"Zener", b"Zero", b"Zip"]
        } else {
            assert!(*v1 == 147, 13906835505783242751);
            vector[b"Zipface", b"Zipper"]
        };
        let v3 = v2;
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v3, (arg0 as u64) % 0x1::vector::length<vector<u8>>(&v3)))
    }

    // decompiled from Move bytecode v6
}

