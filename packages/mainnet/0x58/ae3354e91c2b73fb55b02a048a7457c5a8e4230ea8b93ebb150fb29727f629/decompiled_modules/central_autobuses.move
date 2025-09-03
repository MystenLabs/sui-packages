module 0x58ae3354e91c2b73fb55b02a048a7457c5a8e4230ea8b93ebb150fb29727f629::central_autobuses {
    struct Central has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        autobuses: 0x2::vec_map::VecMap<u8, Autobus>,
    }

    struct Autobus has drop, store {
        chofer: 0x1::string::String,
        ruta: 0x1::string::String,
        numero: u8,
        pasajeros: u8,
        estado: 0x1::string::String,
    }

    public fun agregar_ruta(arg0: &mut Central, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8) {
        assert!(!0x2::vec_map::contains<u8, Autobus>(&arg0.autobuses, &arg3), 13906834346142072833);
        let v0 = Autobus{
            chofer    : arg1,
            ruta      : arg2,
            numero    : arg3,
            pasajeros : 0,
            estado    : 0x1::string::utf8(b"En la central"),
        };
        0x2::vec_map::insert<u8, Autobus>(&mut arg0.autobuses, arg3, v0);
    }

    public fun borrar_ruta(arg0: &mut Central, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Autobus>(&arg0.autobuses, &arg1), 13906834496466059267);
        let (_, _) = 0x2::vec_map::remove<u8, Autobus>(&mut arg0.autobuses, &arg1);
    }

    public fun crear_central(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Central{
            id        : 0x2::object::new(arg1),
            nombre    : arg0,
            autobuses : 0x2::vec_map::empty<u8, Autobus>(),
        };
        0x2::transfer::transfer<Central>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun llegada_autobus(arg0: &mut Central, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Autobus>(&arg0.autobuses, &arg1), 13906834453516386307);
        let v0 = 0x2::vec_map::get_mut<u8, Autobus>(&mut arg0.autobuses, &arg1);
        v0.pasajeros = 0;
        v0.estado = 0x1::string::utf8(b"En central");
    }

    public fun salida_autobus(arg0: &mut Central, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Autobus>(&arg0.autobuses, &arg1), 13906834410566713347);
        let v0 = 0x2::vec_map::get_mut<u8, Autobus>(&mut arg0.autobuses, &arg1);
        v0.pasajeros = arg2;
        v0.estado = 0x1::string::utf8(b"En viaje");
    }

    // decompiled from Move bytecode v6
}

