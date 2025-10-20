module 0xe7ed8ff5ef68c61ba48aa312d62b4c24396d8a54b7a0f7e4fda370ed8e2e11f::biblioteca {
    struct Biblioteca has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        libros: 0x2::vec_map::VecMap<ISBN, Libro>,
    }

    struct Libro has copy, drop, store {
        titulo: 0x1::string::String,
        autor: 0x1::string::String,
        publicacion: u16,
        disponible: bool,
    }

    struct ISBN has copy, drop, store {
        value: u16,
    }

    public fun actualizar_disponibilidad(arg0: u16, arg1: &mut Biblioteca) {
        let v0 = ISBN{value: arg0};
        let v1 = 0x2::vec_map::get_mut<ISBN, Libro>(&mut arg1.libros, &v0);
        v1.disponible = !v1.disponible;
    }

    public fun agregar_libro(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u16, arg3: u16, arg4: &mut Biblioteca) {
        let v0 = Libro{
            titulo      : arg0,
            autor       : arg1,
            publicacion : arg2,
            disponible  : true,
        };
        let v1 = ISBN{value: arg3};
        0x2::vec_map::insert<ISBN, Libro>(&mut arg4.libros, v1, v0);
    }

    public fun crear_biblioteca(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca{
            id     : 0x2::object::new(arg1),
            nombre : arg0,
            libros : 0x2::vec_map::empty<ISBN, Libro>(),
        };
        0x2::transfer::transfer<Biblioteca>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun editar_titulo(arg0: u16, arg1: 0x1::string::String, arg2: &mut Biblioteca) {
        let v0 = ISBN{value: arg0};
        0x2::vec_map::get_mut<ISBN, Libro>(&mut arg2.libros, &v0).titulo = arg1;
    }

    public fun eliminar_biblioteca(arg0: Biblioteca) {
        let Biblioteca {
            id     : v0,
            nombre : _,
            libros : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_libro(arg0: u16, arg1: &mut Biblioteca) {
        let v0 = ISBN{value: arg0};
        let (_, _) = 0x2::vec_map::remove<ISBN, Libro>(&mut arg1.libros, &v0);
    }

    // decompiled from Move bytecode v6
}

