module 0xad1bc8586e43086adb2ec6ddc88191a89e8287fb81aea47ca9592aad29ef5c53::suibiblio {
    struct Biblioteca has key {
        id: 0x2::object::UID,
        total_libros: u64,
    }

    struct Libro has store, key {
        id: 0x2::object::UID,
        titulo: 0x1::string::String,
        autor: 0x1::string::String,
        prestado: bool,
        prestado_a: 0x1::option::Option<address>,
    }

    public fun agregar_libro(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Libro{
            id         : 0x2::object::new(arg2),
            titulo     : arg0,
            autor      : arg1,
            prestado   : false,
            prestado_a : 0x1::option::none<address>(),
        };
        0x2::transfer::transfer<Libro>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun crear_biblioteca(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca{
            id           : 0x2::object::new(arg0),
            total_libros : 0,
        };
        0x2::transfer::share_object<Biblioteca>(v0);
    }

    public fun devolver_libro(arg0: &mut Libro) {
        assert!(arg0.prestado, 2);
        arg0.prestado = false;
        arg0.prestado_a = 0x1::option::none<address>();
    }

    public fun esta_prestado(arg0: &Libro) : bool {
        arg0.prestado
    }

    public fun obtener_prestatario(arg0: &Libro) : 0x1::option::Option<address> {
        arg0.prestado_a
    }

    public fun prestar_libro(arg0: &mut Libro, arg1: address) {
        assert!(!arg0.prestado, 1);
        arg0.prestado = true;
        arg0.prestado_a = 0x1::option::some<address>(arg1);
    }

    // decompiled from Move bytecode v6
}

