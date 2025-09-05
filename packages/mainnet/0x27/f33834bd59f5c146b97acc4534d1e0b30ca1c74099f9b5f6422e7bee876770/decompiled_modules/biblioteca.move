module 0x27f33834bd59f5c146b97acc4534d1e0b30ca1c74099f9b5f6422e7bee876770::biblioteca {
    struct Biblioteca has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        libros: 0x2::vec_map::VecMap<u64, Libro>,
    }

    struct Libro has drop, store {
        titulo: 0x1::string::String,
        autor: 0x1::string::String,
        publicacion: u16,
        disponible: bool,
    }

    public fun actualizar_disponibilidad(arg0: &mut Biblioteca, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 13906834371912007683);
        let v0 = 0x2::vec_map::get_mut<u64, Libro>(&mut arg0.libros, &arg1);
        v0.disponible = !v0.disponible;
    }

    public fun agregar_libro(arg0: &mut Biblioteca, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16) {
        assert!(!0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 13906834320372269057);
        let v0 = Libro{
            titulo      : arg2,
            autor       : arg3,
            publicacion : arg4,
            disponible  : true,
        };
        0x2::vec_map::insert<u64, Libro>(&mut arg0.libros, arg1, v0);
    }

    public fun crear_biblioteca(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca{
            id     : 0x2::object::new(arg1),
            nombre : arg0,
            libros : 0x2::vec_map::empty<u64, Libro>(),
        };
        0x2::transfer::transfer<Biblioteca>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_biblioteca(arg0: Biblioteca) {
        let Biblioteca {
            id     : v0,
            nombre : _,
            libros : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_libro(arg0: &mut Biblioteca, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 13906834350437171203);
        let (_, _) = 0x2::vec_map::remove<u64, Libro>(&mut arg0.libros, &arg1);
    }

    // decompiled from Move bytecode v6
}

