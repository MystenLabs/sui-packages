module 0xe465760b80731513196af0745172ee6813d10273dcf069d821b01bfc4f17f003::biblioteca {
    struct Biblioteca has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        libros: 0x2::vec_map::VecMap<0x1::string::String, Libro>,
    }

    struct Libro has copy, drop, store {
        titulo: 0x1::string::String,
        autor: 0x1::string::String,
        publicado: u16,
        disponible: bool,
    }

    public fun actualizar_autor(arg0: &mut Biblioteca, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, Libro>(&arg0.libros, &arg1), 2);
        0x2::vec_map::get_mut<0x1::string::String, Libro>(&mut arg0.libros, &arg1).autor = arg2;
    }

    public fun actualizar_disponibilidad(arg0: &mut Biblioteca, arg1: 0x1::string::String, arg2: bool) {
        assert!(0x2::vec_map::contains<0x1::string::String, Libro>(&arg0.libros, &arg1), 2);
        0x2::vec_map::get_mut<0x1::string::String, Libro>(&mut arg0.libros, &arg1).disponible = arg2;
    }

    public fun actualizar_publicado(arg0: &mut Biblioteca, arg1: 0x1::string::String, arg2: u16) {
        assert!(0x2::vec_map::contains<0x1::string::String, Libro>(&arg0.libros, &arg1), 2);
        0x2::vec_map::get_mut<0x1::string::String, Libro>(&mut arg0.libros, &arg1).publicado = arg2;
    }

    public fun actualizar_titulo(arg0: &mut Biblioteca, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, Libro>(&arg0.libros, &arg1), 2);
        0x2::vec_map::get_mut<0x1::string::String, Libro>(&mut arg0.libros, &arg1).titulo = arg2;
    }

    public fun agregar_libro(arg0: &mut Biblioteca, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: bool) {
        assert!(!0x2::vec_map::contains<0x1::string::String, Libro>(&arg0.libros, &arg1), 1);
        let v0 = Libro{
            titulo     : arg2,
            autor      : arg3,
            publicado  : arg4,
            disponible : arg5,
        };
        0x2::vec_map::insert<0x1::string::String, Libro>(&mut arg0.libros, arg1, v0);
    }

    public fun borrar_libro(arg0: &mut Biblioteca, arg1: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, Libro>(&arg0.libros, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, Libro>(&mut arg0.libros, &arg1);
    }

    public fun crear_biblioteca(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca{
            id     : 0x2::object::new(arg1),
            nombre : arg0,
            libros : 0x2::vec_map::empty<0x1::string::String, Libro>(),
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

    // decompiled from Move bytecode v6
}

