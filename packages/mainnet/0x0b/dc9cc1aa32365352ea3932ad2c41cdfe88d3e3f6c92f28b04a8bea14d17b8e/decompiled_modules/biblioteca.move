module 0xbdc9cc1aa32365352ea3932ad2c41cdfe88d3e3f6c92f28b04a8bea14d17b8e::biblioteca {
    struct Biblioteca_KIMS has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        libros: 0x2::vec_map::VecMap<u64, Libro>,
    }

    struct Libro has drop, store {
        titulo: 0x1::string::String,
        autor: 0x1::string::String,
        isbn: u16,
        editorial: 0x1::string::String,
        lugar_de_publicacion: 0x1::string::String,
        anio_de_publicacion: u16,
        disponible: bool,
    }

    public fun actualizar_diponibilidad(arg0: &mut Biblioteca_KIMS, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 13906834384796909571);
        let v0 = 0x2::vec_map::get_mut<u64, Libro>(&mut arg0.libros, &arg1);
        v0.disponible = !v0.disponible;
    }

    public fun agregar_libro(arg0: &mut Biblioteca_KIMS, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u16) {
        assert!(!0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 13906834333257170945);
        let v0 = Libro{
            titulo               : arg2,
            autor                : arg3,
            isbn                 : arg4,
            editorial            : arg5,
            lugar_de_publicacion : arg6,
            anio_de_publicacion  : arg7,
            disponible           : true,
        };
        0x2::vec_map::insert<u64, Libro>(&mut arg0.libros, arg1, v0);
    }

    public fun crear_biblioteca(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca_KIMS{
            id     : 0x2::object::new(arg1),
            nombre : arg0,
            libros : 0x2::vec_map::empty<u64, Libro>(),
        };
        0x2::transfer::transfer<Biblioteca_KIMS>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_biblioteca(arg0: Biblioteca_KIMS) {
        let Biblioteca_KIMS {
            id     : v0,
            nombre : _,
            libros : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_libro(arg0: &mut Biblioteca_KIMS, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Libro>(&arg0.libros, &arg1), 13906834363322073091);
        let (_, _) = 0x2::vec_map::remove<u64, Libro>(&mut arg0.libros, &arg1);
    }

    // decompiled from Move bytecode v6
}

