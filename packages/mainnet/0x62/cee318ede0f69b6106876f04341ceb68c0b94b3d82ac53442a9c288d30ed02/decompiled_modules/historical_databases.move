module 0x62cee318ede0f69b6106876f04341ceb68c0b94b3d82ac53442a9c288d30ed02::historical_databases {
    struct Principal has drop, store {
        id_principal: u64,
        nombre: 0x1::string::String,
        titulo: 0x1::string::String,
        descripcion: 0x1::string::String,
        precio: u8,
        sintac: bool,
    }

    struct Postre has drop, store {
        id_postre: u64,
        nombre: 0x1::string::String,
        titulo: 0x1::string::String,
        descripcion: 0x1::string::String,
        precio: u8,
        sintac: bool,
    }

    struct Entrada has drop, store {
        id_entrada: u64,
        nombre: 0x1::string::String,
        titulo: 0x1::string::String,
        descripcion: 0x1::string::String,
        precio: u8,
        sintac: bool,
    }

    struct Menu has store, key {
        id: 0x2::object::UID,
        entradas: 0x2::vec_map::VecMap<u64, Entrada>,
        principales: 0x2::vec_map::VecMap<u64, Principal>,
        postres: 0x2::vec_map::VecMap<u64, Postre>,
    }

    public fun actualizar_principal(arg0: &mut Menu, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: bool) {
        assert!(0x2::vec_map::contains<u64, Principal>(&arg0.principales, &arg1), 13906834625315340295);
        let v0 = 0x2::vec_map::get_mut<u64, Principal>(&mut arg0.principales, &arg1);
        v0.nombre = arg2;
        v0.titulo = arg3;
        v0.descripcion = arg4;
    }

    public fun crear_menu(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Menu{
            id          : 0x2::object::new(arg1),
            entradas    : 0x2::vec_map::empty<u64, Entrada>(),
            principales : 0x2::vec_map::empty<u64, Principal>(),
            postres     : 0x2::vec_map::empty<u64, Postre>(),
        };
        0x2::transfer::transfer<Menu>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_principal(arg0: &mut Menu, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Principal>(&arg0.principales, &arg1), 13906834474991484935);
        let (_, _) = 0x2::vec_map::remove<u64, Principal>(&mut arg0.principales, &arg1);
    }

    public fun registrar_entrada(arg0: &mut Menu, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: bool) {
        assert!(0x2::vec_map::contains<u64, Entrada>(&arg0.entradas, &arg1), 13906834492171091971);
        let v0 = Entrada{
            id_entrada  : arg1,
            nombre      : arg2,
            titulo      : arg3,
            descripcion : arg4,
            precio      : arg5,
            sintac      : arg6,
        };
        0x2::vec_map::insert<u64, Entrada>(&mut arg0.entradas, arg1, v0);
    }

    public fun registrar_postre(arg0: &mut Menu, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: bool) {
        assert!(0x2::vec_map::contains<u64, Postre>(&arg0.postres, &arg1), 13906834543710830597);
        let v0 = Postre{
            id_postre   : arg1,
            nombre      : arg2,
            titulo      : arg3,
            descripcion : arg4,
            precio      : arg5,
            sintac      : arg6,
        };
        0x2::vec_map::insert<u64, Postre>(&mut arg0.postres, arg1, v0);
    }

    public fun registrar_principal(arg0: &mut Menu, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: bool) {
        assert!(0x2::vec_map::contains<u64, Principal>(&arg0.principales, &arg1), 13906834423451484161);
        let v0 = Principal{
            id_principal : arg1,
            nombre       : arg2,
            titulo       : arg3,
            descripcion  : arg4,
            precio       : arg5,
            sintac       : arg6,
        };
        0x2::vec_map::insert<u64, Principal>(&mut arg0.principales, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

