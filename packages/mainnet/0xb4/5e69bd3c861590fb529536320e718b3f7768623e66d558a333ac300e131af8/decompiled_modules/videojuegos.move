module 0xb45e69bd3c861590fb529536320e718b3f7768623e66d558a333ac300e131af8::videojuegos {
    struct Videojuego has copy, drop, store {
        id: u64,
        nombre: 0x1::string::String,
        genero: 0x1::string::String,
        precio: u64,
    }

    struct Catalogo has drop, store {
        juegos: vector<Videojuego>,
    }

    public fun actualizar_juego(arg0: &mut Catalogo, arg1: u64, arg2: 0x1::string::String, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Videojuego>(&arg0.juegos)) {
            let v1 = 0x1::vector::borrow_mut<Videojuego>(&mut arg0.juegos, v0);
            if (v1.id == arg1) {
                v1.genero = arg2;
                v1.precio = arg3;
                return
            };
            v0 = v0 + 1;
        };
        abort 3
    }

    public fun contar_juegos(arg0: &Catalogo) : u64 {
        0x1::vector::length<Videojuego>(&arg0.juegos)
    }

    public fun crear_catalogo() : Catalogo {
        Catalogo{juegos: 0x1::vector::empty<Videojuego>()}
    }

    public fun crear_juego(arg0: &mut Catalogo, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Videojuego>(&arg0.juegos)) {
            let v1 = *0x1::vector::borrow<Videojuego>(&arg0.juegos, v0);
            if (v1.id == arg1) {
                abort 1
            };
            v0 = v0 + 1;
        };
        let v2 = Videojuego{
            id     : arg1,
            nombre : arg2,
            genero : arg3,
            precio : arg4,
        };
        0x1::vector::push_back<Videojuego>(&mut arg0.juegos, v2);
    }

    public fun eliminar_juego(arg0: &mut Catalogo, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Videojuego>(&arg0.juegos)) {
            let v1 = *0x1::vector::borrow<Videojuego>(&arg0.juegos, v0);
            if (v1.id == arg1) {
                0x1::vector::remove<Videojuego>(&mut arg0.juegos, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 4
    }

    public fun obtener_juego(arg0: &Catalogo, arg1: u64) : 0x1::option::Option<Videojuego> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Videojuego>(&arg0.juegos)) {
            let v1 = *0x1::vector::borrow<Videojuego>(&arg0.juegos, v0);
            if (v1.id == arg1) {
                return 0x1::option::some<Videojuego>(v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<Videojuego>()
    }

    public fun obtener_precio(arg0: &Videojuego) : u64 {
        arg0.precio
    }

    // decompiled from Move bytecode v6
}

