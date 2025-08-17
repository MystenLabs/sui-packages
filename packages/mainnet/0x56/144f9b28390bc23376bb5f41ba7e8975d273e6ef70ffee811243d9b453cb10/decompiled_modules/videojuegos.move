module 0x56144f9b28390bc23376bb5f41ba7e8975d273e6ef70ffee811243d9b453cb10::videojuegos {
    struct Coleccion has store, key {
        id: 0x2::object::UID,
        juegos: 0x2::vec_map::VecMap<u64, Videojuego>,
    }

    struct Videojuego has copy, drop, store {
        titulo: 0x1::string::String,
        desarrollador: 0x1::string::String,
        lanzamiento: u16,
        disponible: bool,
    }

    public fun actualizar_anio(arg0: &mut Coleccion, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Videojuego>(&arg0.juegos, &arg1), 13906834552300634115);
        0x2::vec_map::get_mut<u64, Videojuego>(&mut arg0.juegos, &arg1).lanzamiento = arg2;
    }

    public fun actualizar_desarrollador(arg0: &mut Coleccion, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Videojuego>(&arg0.juegos, &arg1), 13906834509350961155);
        0x2::vec_map::get_mut<u64, Videojuego>(&mut arg0.juegos, &arg1).desarrollador = arg2;
    }

    public fun actualizar_disponibilidad(arg0: &mut Coleccion, arg1: u64, arg2: bool) {
        assert!(0x2::vec_map::contains<u64, Videojuego>(&arg0.juegos, &arg1), 13906834595250307075);
        0x2::vec_map::get_mut<u64, Videojuego>(&mut arg0.juegos, &arg1).disponible = arg2;
    }

    public fun actualizar_titulo(arg0: &mut Coleccion, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Videojuego>(&arg0.juegos, &arg1), 13906834466401288195);
        0x2::vec_map::get_mut<u64, Videojuego>(&mut arg0.juegos, &arg1).titulo = arg2;
    }

    public fun agregar_juego(arg0: &mut Coleccion, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: bool) {
        assert!(!0x2::vec_map::contains<u64, Videojuego>(&arg0.juegos, &arg1), 13906834397681680385);
        assert!(0x1::string::length(&arg2) > 0, 13906834401976909829);
        assert!(0x1::string::length(&arg3) > 0, 13906834406272008199);
        assert!(arg4 > 1950 && arg4 <= 2100, 13906834410567106569);
        let v0 = Videojuego{
            titulo        : arg2,
            desarrollador : arg3,
            lanzamiento   : arg4,
            disponible    : arg5,
        };
        0x2::vec_map::insert<u64, Videojuego>(&mut arg0.juegos, arg1, v0);
    }

    public fun borrar_juego(arg0: &mut Coleccion, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Videojuego>(&arg0.juegos, &arg1), 13906834633905012739);
        let (_, _) = 0x2::vec_map::remove<u64, Videojuego>(&mut arg0.juegos, &arg1);
    }

    public fun crear_coleccion(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Coleccion{
            id     : 0x2::object::new(arg0),
            juegos : 0x2::vec_map::empty<u64, Videojuego>(),
        };
        0x2::transfer::transfer<Coleccion>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_coleccion(arg0: Coleccion) {
        let Coleccion {
            id     : v0,
            juegos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

