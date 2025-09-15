module 0x76d9031fd2b56826c68a70b293b3295a45350e2fc6713eb56857c1aa2a88c721::Intercambio_P2P_Energia {
    struct Biblioteca has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        libros: 0x2::vec_map::VecMap<u64, Libro>,
    }

    struct Libro has store {
        usuario: 0x1::string::String,
        ubicacion: 0x1::string::String,
        consumokWh: u16,
        disponible: bool,
    }

    public fun agregar_libro(arg0: &mut Biblioteca, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16) {
        assert!(!0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 13906834298897432577);
        let v0 = Libro{
            usuario    : arg2,
            ubicacion  : arg3,
            consumokWh : arg4,
            disponible : true,
        };
        0x2::vec_map::insert<u64, Libro>(&mut arg0.libros, arg1, v0);
    }

    public fun crear_biblioteca(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca{
            id     : 0x2::object::new(arg0),
            nombre : 0x1::string::utf8(b"Intercambio P2P de Energia"),
            libros : 0x2::vec_map::empty<u64, Libro>(),
        };
        0x2::transfer::transfer<Biblioteca>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

