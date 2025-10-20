module 0xc4ff10a1a50dabb7328f60666aba7c70594175c96ce28242ad764bac1aef9528::la_tiendita {
    struct La_tiendita has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        productos: 0x2::vec_map::VecMap<u8, Productos>,
    }

    struct Productos has drop, store {
        nombre: 0x1::string::String,
        precio: u64,
        cantidad: u8,
        id_produ: u8,
    }

    public fun agregar_producto(arg0: &mut La_tiendita, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: u8) {
        assert!(!0x2::vec_map::contains<u8, Productos>(&arg0.productos, &arg4), 13906834406271614977);
        let v0 = Productos{
            nombre   : arg1,
            precio   : arg2,
            cantidad : arg3,
            id_produ : arg4,
        };
        0x2::vec_map::insert<u8, Productos>(&mut arg0.productos, arg4, v0);
    }

    public fun crear_tiendita(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = La_tiendita{
            id        : 0x2::object::new(arg1),
            nombre    : arg0,
            productos : 0x2::vec_map::empty<u8, Productos>(),
        };
        0x2::transfer::transfer<La_tiendita>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_producto(arg0: &mut La_tiendita, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Productos>(&arg0.productos, &arg1), 13906834560890568707);
        let (_, _) = 0x2::vec_map::remove<u8, Productos>(&mut arg0.productos, &arg1);
    }

    public fun reabastecer_producto(arg0: &mut La_tiendita, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Productos>(&arg0.productos, &arg1), 13906834513645928451);
        let v0 = 0x2::vec_map::get_mut<u8, Productos>(&mut arg0.productos, &arg1);
        v0.cantidad = v0.cantidad + arg2;
    }

    public fun vender_producto(arg0: &mut La_tiendita, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Productos>(&arg0.productos, &arg1), 13906834466401288195);
        let v0 = 0x2::vec_map::get_mut<u8, Productos>(&mut arg0.productos, &arg1);
        assert!(v0.cantidad >= arg2, 13906834483581288453);
        v0.cantidad = v0.cantidad - arg2;
    }

    // decompiled from Move bytecode v6
}

