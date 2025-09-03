module 0xaa6574d1289e8be15a9533c4eedb81741a83e0452b0e2e370d4fc1d768011842::tienda_ropa {
    struct Tienda has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        prendas: 0x2::vec_map::VecMap<u8, Prenda>,
    }

    struct Prenda has drop, store {
        tipo: 0x1::string::String,
        talla: 0x1::string::String,
        codigo: u8,
        cantidad: u8,
        estado: 0x1::string::String,
    }

    public fun agregar_prenda(arg0: &mut Tienda, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<u8, Prenda>(&arg0.prendas, &arg2), 13906834333257170945);
        let v0 = Prenda{
            tipo     : arg1,
            talla    : arg3,
            codigo   : arg2,
            cantidad : 0,
            estado   : 0x1::string::utf8(b"En tienda"),
        };
        0x2::vec_map::insert<u8, Prenda>(&mut arg0.prendas, arg2, v0);
    }

    public fun borrar_prenda(arg0: &mut Tienda, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Prenda>(&arg0.prendas, &arg1), 13906834453516386307);
        let (_, _) = 0x2::vec_map::remove<u8, Prenda>(&mut arg0.prendas, &arg1);
    }

    public fun crear_tienda(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Tienda{
            id      : 0x2::object::new(arg1),
            nombre  : arg0,
            prendas : 0x2::vec_map::empty<u8, Prenda>(),
        };
        0x2::transfer::transfer<Tienda>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun reponer_prenda(arg0: &mut Tienda, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Prenda>(&arg0.prendas, &arg1), 13906834419156647939);
        let v0 = 0x2::vec_map::get_mut<u8, Prenda>(&mut arg0.prendas, &arg1);
        v0.cantidad = v0.cantidad + arg2;
        v0.estado = 0x1::string::utf8(b"En tienda");
    }

    public fun vender_prenda(arg0: &mut Tienda, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Prenda>(&arg0.prendas, &arg1), 13906834384796909571);
        let v0 = 0x2::vec_map::get_mut<u8, Prenda>(&mut arg0.prendas, &arg1);
        v0.cantidad = v0.cantidad - arg2;
        v0.estado = 0x1::string::utf8(b"Vendida");
    }

    // decompiled from Move bytecode v6
}

