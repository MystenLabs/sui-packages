module 0xd636605f97cf4aef600be5562d2545dcd0eda25ead3c69d4f2cc532e4e8f28f5::biblioteca {
    struct Biblioteca has store, key {
        id: 0x2::object::UID,
        libros: 0x2::vec_map::VecMap<u64, Libro>,
    }

    struct Libro has copy, drop, store {
        titulo: 0x1::string::String,
        autor: 0x1::string::String,
        publicado: u16,
        disponible: bool,
    }

    public fun actualizar_autor(arg0: &mut Biblioteca, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 11);
        0x2::vec_map::get_mut<u64, Libro>(&mut arg0.libros, &arg1).autor = arg2;
    }

    public fun actualizar_disponibilidad(arg0: &mut Biblioteca, arg1: u64, arg2: bool) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 11);
        0x2::vec_map::get_mut<u64, Libro>(&mut arg0.libros, &arg1).disponible = arg2;
    }

    public fun actualizar_publicado(arg0: &mut Biblioteca, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 11);
        0x2::vec_map::get_mut<u64, Libro>(&mut arg0.libros, &arg1).publicado = arg2;
    }

    public fun actualizar_titulo(arg0: &mut Biblioteca, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 11);
        0x2::vec_map::get_mut<u64, Libro>(&mut arg0.libros, &arg1).titulo = arg2;
    }

    public fun agregar_libro(arg0: &mut Biblioteca, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: bool) {
        let v0 = Libro{
            titulo     : arg2,
            autor      : arg3,
            publicado  : arg4,
            disponible : arg5,
        };
        assert!(!0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 10);
        0x2::vec_map::insert<u64, Libro>(&mut arg0.libros, arg1, v0);
    }

    public fun borrar_libro(arg0: &mut Biblioteca, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 11);
        let (_, _) = 0x2::vec_map::remove<u64, Libro>(&mut arg0.libros, &arg1);
    }

    public fun crear_biblioteca(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca{
            id     : 0x2::object::new(arg0),
            libros : 0x2::vec_map::empty<u64, Libro>(),
        };
        0x2::transfer::transfer<Biblioteca>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_biblioteca(arg0: Biblioteca) {
        let Biblioteca {
            id     : v0,
            libros : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

