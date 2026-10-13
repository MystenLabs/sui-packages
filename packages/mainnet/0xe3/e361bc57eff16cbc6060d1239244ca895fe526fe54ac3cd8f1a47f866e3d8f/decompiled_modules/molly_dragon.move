module 0xe3e361bc57eff16cbc6060d1239244ca895fe526fe54ac3cd8f1a47f866e3d8f::molly_dragon {
    struct MOLLY_DRAGON has drop {
        dummy_field: bool,
    }

    struct MollyDragon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        revealed: bool,
    }

    struct Pieza has drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Etapa has store {
        nombre: 0x1::string::String,
        precio: u64,
        inicio_ms: u64,
        fin_ms: u64,
        max_por_billetera: u64,
        activa: bool,
        usa_lista: bool,
        lista: 0x2::table::Table<address, bool>,
        compras: 0x2::table::Table<address, u64>,
        vendidas: u64,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        minted: u64,
        max_supply: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        discord: 0x1::string::String,
        twitter: 0x1::string::String,
        website: 0x1::string::String,
        piezas: 0x2::table::Table<u64, Pieza>,
        disponibles: u64,
        etapas: vector<Etapa>,
        ganancias: 0x2::balance::Balance<0x2::sui::SUI>,
        oculto: bool,
        revelado: bool,
        oculto_nombre: 0x1::string::String,
        oculto_imagen: 0x1::string::String,
        pendientes: 0x2::table::Table<0x2::object::ID, Pieza>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NftMinted has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        recipient: address,
    }

    struct NftRevelado has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun actualizar_info(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String) {
        arg1.name = arg2;
        arg1.description = arg3;
        arg1.image_url = arg4;
        arg1.discord = arg5;
        arg1.twitter = arg6;
        arg1.website = arg7;
    }

    public fun agregar_a_lista(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<address>) {
        assert!(arg2 < 0x1::vector::length<Etapa>(&arg1.etapas), 8);
        let v0 = 0x1::vector::borrow_mut<Etapa>(&mut arg1.etapas, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v1);
            if (!0x2::table::contains<address, bool>(&v0.lista, v2)) {
                0x2::table::add<address, bool>(&mut v0.lista, v2, true);
            };
            v1 = v1 + 1;
        };
    }

    public fun agregar_etapa(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Etapa{
            nombre            : arg2,
            precio            : arg3,
            inicio_ms         : arg4,
            fin_ms            : arg5,
            max_por_billetera : arg6,
            activa            : true,
            usa_lista         : arg7,
            lista             : 0x2::table::new<address, bool>(arg8),
            compras           : 0x2::table::new<address, u64>(arg8),
            vendidas          : 0,
        };
        0x1::vector::push_back<Etapa>(&mut arg1.etapas, v0);
    }

    public fun burn(arg0: MollyDragon) {
        let MollyDragon {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            number      : _,
            attributes  : _,
            revealed    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun cantidad_etapas(arg0: &Collection) : u64 {
        0x1::vector::length<Etapa>(&arg0.etapas)
    }

    public fun cargar_pieza(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>) {
        assert!(hay_cupo(arg1, arg1.disponibles + 1), 0);
        0x2::table::add<u64, Pieza>(&mut arg1.piezas, arg1.disponibles, nueva_pieza(arg2, arg3, arg4, arg5, arg6));
        arg1.disponibles = arg1.disponibles + 1;
    }

    public fun compras_de(arg0: &Collection, arg1: u64, arg2: address) : u64 {
        let v0 = 0x1::vector::borrow<Etapa>(&arg0.etapas, arg1);
        if (0x2::table::contains<address, u64>(&v0.compras, arg2)) {
            *0x2::table::borrow<address, u64>(&v0.compras, arg2)
        } else {
            0
        }
    }

    public fun configurar_oculto(arg0: &AdminCap, arg1: &mut Collection, arg2: bool, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = if (arg1.minted == 0) {
            true
        } else if (!arg2) {
            true
        } else {
            arg1.oculto
        };
        assert!(v0, 11);
        arg1.oculto = arg2;
        arg1.oculto_nombre = arg3;
        arg1.oculto_imagen = arg4;
    }

    fun crear_nft(arg0: &mut Collection, arg1: Pieza, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.minted;
        let v1 = if (arg3) {
            let v2 = arg0.oculto_nombre;
            0x1::string::append(&mut v2, 0x1::string::utf8(b" #"));
            0x1::string::append(&mut v2, 0x1::u64::to_string(v0));
            let v3 = MollyDragon{
                id          : 0x2::object::new(arg4),
                name        : v2,
                description : arg0.description,
                image_url   : arg0.oculto_imagen,
                number      : v0,
                attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                revealed    : false,
            };
            0x2::table::add<0x2::object::ID, Pieza>(&mut arg0.pendientes, 0x2::object::id<MollyDragon>(&v3), arg1);
            v3
        } else {
            let Pieza {
                name        : v4,
                description : v5,
                image_url   : v6,
                attributes  : v7,
            } = arg1;
            MollyDragon{id: 0x2::object::new(arg4), name: v4, description: v5, image_url: v6, number: v0, attributes: v7, revealed: true}
        };
        let v8 = v1;
        let v9 = NftMinted{
            object_id : 0x2::object::id<MollyDragon>(&v8),
            number    : v0,
            recipient : arg2,
        };
        0x2::event::emit<NftMinted>(v9);
        0x2::transfer::public_transfer<MollyDragon>(v8, arg2);
    }

    public fun disponibles(arg0: &Collection) : u64 {
        arg0.disponibles
    }

    public fun editar_etapa(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool) {
        assert!(arg2 < 0x1::vector::length<Etapa>(&arg1.etapas), 8);
        let v0 = 0x1::vector::borrow_mut<Etapa>(&mut arg1.etapas, arg2);
        v0.nombre = arg3;
        v0.precio = arg4;
        v0.inicio_ms = arg5;
        v0.fin_ms = arg6;
        v0.max_por_billetera = arg7;
        v0.usa_lista = arg8;
        v0.activa = arg9;
    }

    public fun en_lista(arg0: &Collection, arg1: u64, arg2: address) : bool {
        0x2::table::contains<address, bool>(&0x1::vector::borrow<Etapa>(&arg0.etapas, arg1).lista, arg2)
    }

    public fun ganancias(arg0: &Collection) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.ganancias)
    }

    fun hay_cupo(arg0: &Collection, arg1: u64) : bool {
        arg0.max_supply == 0 || arg0.minted + arg1 <= arg0.max_supply
    }

    fun init(arg0: MOLLY_DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MOLLY_DRAGON>(arg0, arg1);
        let v1 = 0x2::display::new<MollyDragon>(&v0, arg1);
        0x2::display::add<MollyDragon>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MollyDragon>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MollyDragon>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<MollyDragon>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<MollyDragon>(&mut v1, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Molly Dragon"));
        0x2::display::add<MollyDragon>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b""));
        0x2::display::add<MollyDragon>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b""));
        0x2::display::update_version<MollyDragon>(&mut v1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<0x2::display::Display<MollyDragon>>(v1, v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, v2);
        let v4 = Collection{
            id            : 0x2::object::new(arg1),
            minted        : 0,
            max_supply    : 0,
            name          : 0x1::string::utf8(b"Molly Dragon"),
            description   : 0x1::string::utf8(b""),
            image_url     : 0x1::string::utf8(b""),
            discord       : 0x1::string::utf8(b""),
            twitter       : 0x1::string::utf8(b""),
            website       : 0x1::string::utf8(b""),
            piezas        : 0x2::table::new<u64, Pieza>(arg1),
            disponibles   : 0,
            etapas        : 0x1::vector::empty<Etapa>(),
            ganancias     : 0x2::balance::zero<0x2::sui::SUI>(),
            oculto        : false,
            revelado      : false,
            oculto_nombre : 0x1::string::utf8(b""),
            oculto_imagen : 0x1::string::utf8(b""),
            pendientes    : 0x2::table::new<0x2::object::ID, Pieza>(arg1),
        };
        0x2::transfer::share_object<Collection>(v4);
    }

    public fun max_supply(arg0: &Collection) : u64 {
        arg0.max_supply
    }

    public fun mint(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(hay_cupo(arg1, arg1.disponibles + 1), 0);
        crear_nft(arg1, nueva_pieza(arg2, arg3, arg4, arg5, arg6), arg7, false, arg8);
    }

    entry fun mint_publico(arg0: &mut Collection, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 20, 9);
        assert!(arg1 < 0x1::vector::length<Etapa>(&arg0.etapas), 8);
        assert!(arg0.disponibles >= arg2, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x1::vector::borrow_mut<Etapa>(&mut arg0.etapas, arg1);
        assert!(v2.activa, 3);
        assert!(v2.inicio_ms == 0 || v1 >= v2.inicio_ms, 3);
        assert!(v2.fin_ms == 0 || v1 < v2.fin_ms, 3);
        if (v2.usa_lista) {
            assert!(0x2::table::contains<address, bool>(&v2.lista, v0), 6);
        };
        let v3 = if (0x2::table::contains<address, u64>(&v2.compras, v0)) {
            *0x2::table::borrow<address, u64>(&v2.compras, v0)
        } else {
            0
        };
        assert!(v2.max_por_billetera == 0 || v3 + arg2 <= v2.max_por_billetera, 5);
        if (0x2::table::contains<address, u64>(&v2.compras, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut v2.compras, v0) = v3 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut v2.compras, v0, arg2);
        };
        v2.vendidas = v2.vendidas + arg2;
        let v4 = v2.precio * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v4, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.ganancias, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v4, arg6)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        };
        let v5 = 0x2::random::new_generator(arg5, arg6);
        let v6 = if (arg0.oculto) {
            !arg0.revelado
        } else {
            false
        };
        let v7 = 0;
        while (v7 < arg2) {
            let v8 = arg0.disponibles - 1;
            let v9 = 0x2::random::generate_u64_in_range(&mut v5, 0, v8);
            let v10 = 0x2::table::remove<u64, Pieza>(&mut arg0.piezas, v9);
            if (v9 != v8) {
                0x2::table::add<u64, Pieza>(&mut arg0.piezas, v9, 0x2::table::remove<u64, Pieza>(&mut arg0.piezas, v8));
            };
            arg0.disponibles = v8;
            crear_nft(arg0, v10, v0, v6, arg6);
            v7 = v7 + 1;
        };
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    fun nueva_pieza(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) : Pieza {
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 1);
        Pieza{
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        }
    }

    public fun quitar_de_lista(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<address>) {
        assert!(arg2 < 0x1::vector::length<Etapa>(&arg1.etapas), 8);
        let v0 = 0x1::vector::borrow_mut<Etapa>(&mut arg1.etapas, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v1);
            if (0x2::table::contains<address, bool>(&v0.lista, v2)) {
                0x2::table::remove<address, bool>(&mut v0.lista, v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun quitar_ultima_pieza(arg0: &AdminCap, arg1: &mut Collection) {
        assert!(arg1.disponibles > 0, 2);
        arg1.disponibles = arg1.disponibles - 1;
        0x2::table::remove<u64, Pieza>(&mut arg1.piezas, arg1.disponibles);
    }

    public fun retirar_ganancias(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.ganancias) >= arg2, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.ganancias, arg2), arg4), arg3);
    }

    public fun revelar(arg0: &mut Collection, arg1: &mut MollyDragon) {
        assert!(arg0.revelado, 7);
        let v0 = 0x2::object::id<MollyDragon>(arg1);
        if (0x2::table::contains<0x2::object::ID, Pieza>(&arg0.pendientes, v0)) {
            let Pieza {
                name        : v1,
                description : v2,
                image_url   : v3,
                attributes  : v4,
            } = 0x2::table::remove<0x2::object::ID, Pieza>(&mut arg0.pendientes, v0);
            arg1.name = v1;
            arg1.description = v2;
            arg1.image_url = v3;
            arg1.attributes = v4;
            let v5 = NftRevelado{object_id: v0};
            0x2::event::emit<NftRevelado>(v5);
        };
        arg1.revealed = true;
    }

    public fun revelar_coleccion(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.revelado = true;
    }

    // decompiled from Move bytecode v7
}

