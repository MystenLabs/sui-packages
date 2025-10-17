module 0xb1cd48272d00cb39a429dd50eddde8be557f3beaa0b75ebaf2c19e2230cacdc6::biblioteca {
    struct Biblioteca has store, key {
        id: 0x2::object::UID,
        libros: 0x2::vec_map::VecMap<u64, Libro>,
    }

    struct Libro has copy, drop, store {
        titulo: 0x1::string::String,
        ubicacion: 0x1::string::String,
    }

    public fun agregar_libro(arg0: &mut Biblioteca, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 1);
        let v0 = Libro{
            titulo    : arg2,
            ubicacion : arg3,
        };
        0x2::vec_map::insert<u64, Libro>(&mut arg0.libros, arg1, v0);
    }

    public fun crear_biblioteca(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca{
            id     : 0x2::object::new(arg0),
            libros : 0x2::vec_map::empty<u64, Libro>(),
        };
        0x2::transfer::transfer<Biblioteca>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

