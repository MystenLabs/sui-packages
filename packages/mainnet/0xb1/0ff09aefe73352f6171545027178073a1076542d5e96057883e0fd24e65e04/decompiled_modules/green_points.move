module 0xb10ff09aefe73352f6171545027178073a1076542d5e96057883e0fd24e65e04::green_points {
    struct Activity has copy, drop, store {
        id: u64,
        name: vector<u8>,
        points: u64,
    }

    struct Catalog has key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<u64, Activity>,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        owner: address,
        points: u64,
        rank: vector<u8>,
    }

    struct Board has key {
        id: 0x2::object::UID,
        scores: 0x2::table::Table<address, u64>,
    }

    public fun create_board(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Board{
            id     : 0x2::object::new(arg0),
            scores : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::transfer<Board>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun create_catalog(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u64, Activity>(arg0);
        let v1 = Activity{
            id     : 1,
            name   : b"Plantar arbol",
            points : 60,
        };
        0x2::table::add<u64, Activity>(&mut v0, 1, v1);
        let v2 = Activity{
            id     : 2,
            name   : b"Reciclar",
            points : 40,
        };
        0x2::table::add<u64, Activity>(&mut v0, 2, v2);
        let v3 = Activity{
            id     : 3,
            name   : b"Usar bicicleta",
            points : 30,
        };
        0x2::table::add<u64, Activity>(&mut v0, 3, v3);
        let v4 = Activity{
            id     : 4,
            name   : b"Ahorrar agua",
            points : 10,
        };
        0x2::table::add<u64, Activity>(&mut v0, 4, v4);
        let v5 = Activity{
            id     : 5,
            name   : b"Reducir electricidad",
            points : 20,
        };
        0x2::table::add<u64, Activity>(&mut v0, 5, v5);
        let v6 = Activity{
            id     : 6,
            name   : b"Voluntariado ambiental",
            points : 70,
        };
        0x2::table::add<u64, Activity>(&mut v0, 6, v6);
        let v7 = Activity{
            id     : 7,
            name   : b"Limpiar espacios publicos",
            points : 50,
        };
        0x2::table::add<u64, Activity>(&mut v0, 7, v7);
        let v8 = Catalog{
            id   : 0x2::object::new(arg0),
            list : v0,
        };
        0x2::transfer::transfer<Catalog>(v8, 0x2::tx_context::sender(arg0));
    }

    public fun create_profile(arg0: &signer, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Profile{
            id     : 0x2::object::new(arg1),
            owner  : 0x2::tx_context::sender(arg1),
            points : 0,
            rank   : b"Cobre",
        };
        0x2::transfer::transfer<Profile>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun do_activity(arg0: &signer, arg1: &mut Profile, arg2: &Catalog, arg3: &mut Board, arg4: u64) {
        let v0 = 0x2::table::borrow<u64, Activity>(&arg2.list, arg4);
        let v1 = arg1.points + v0.points;
        arg1.points = v1;
        arg1.rank = rank_for_points(v1);
        if (0x2::table::contains<address, u64>(&arg3.scores, arg1.owner)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg3.scores, arg1.owner);
            *v2 = *v2 + v0.points;
        } else {
            0x2::table::add<address, u64>(&mut arg3.scores, arg1.owner, v0.points);
        };
    }

    public fun get_profile(arg0: &Profile) : (u64, vector<u8>, vector<u8>, vector<u8>) {
        let v0 = arg0.points;
        (v0, arg0.rank, title_for_points(v0), phrase_for_points(v0))
    }

    public fun get_score(arg0: &Board, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.scores, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.scores, arg1)
        } else {
            0
        }
    }

    public fun list_activities(arg0: &Catalog) : vector<Activity> {
        let v0 = 0x1::vector::empty<Activity>();
        let v1 = 1;
        while (v1 <= 7) {
            0x1::vector::push_back<Activity>(&mut v0, *0x2::table::borrow<u64, Activity>(&arg0.list, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun phrase_for_points(arg0: u64) : vector<u8> {
        if (arg0 < 100) {
            b"comienza tu camino hacia la sostenibilidad ambiental"
        } else if (arg0 < 300) {
            b"cada granito importa! contribuye mas al bienestar del planeta"
        } else if (arg0 < 600) {
            b"Tus esfuerzos fortalecen la vida de la naturaleza"
        } else if (arg0 < 1000) {
            b"Continua defendiendo los ecosistemas y su equilibrio"
        } else if (arg0 < 1300) {
            b"tus acciones inican el cambio, el ecosistema te necesita"
        } else if (arg0 < 1700) {
            b"promueves la salud y pureza del agua en el mundo, no te rindas"
        } else {
            b"eres la inspiracion y liderazgo que el planeta necesita"
        }
    }

    fun rank_for_points(arg0: u64) : vector<u8> {
        if (arg0 < 100) {
            b"Cobre"
        } else if (arg0 < 300) {
            b"Plata"
        } else if (arg0 < 600) {
            b"Oro"
        } else if (arg0 < 1000) {
            b"Platino"
        } else if (arg0 < 1300) {
            b"Diamante"
        } else if (arg0 < 1700) {
            b"Zafiro"
        } else {
            b"Legendario"
        }
    }

    fun title_for_points(arg0: u64) : vector<u8> {
        if (arg0 < 100) {
            b"Semillita Exploradora"
        } else if (arg0 < 300) {
            b"Hoja Renovadora"
        } else if (arg0 < 600) {
            b"Raiz Protectora"
        } else if (arg0 < 1000) {
            b"Guardabosques"
        } else if (arg0 < 1300) {
            b"Guardian de la Tierra"
        } else if (arg0 < 1700) {
            b"Protector de los Rios"
        } else {
            b"Heroe Verde"
        }
    }

    // decompiled from Move bytecode v6
}

