module 0x959ab9b5d84d528959fedbc6a4cd97e16cbabe9e0a555ca96d036428b7126a15::tienda {
    struct Tienda has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        productos: 0x2::vec_map::VecMap<u8, Producto>,
    }

    struct Producto has drop, store {
        nombre: 0x1::string::String,
        precio: u64,
        cantidad: u8,
        id_producto: u8,
    }

    public fun agregar_producto(arg0: &mut Tienda, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: u8) {
        assert!(!0x2::vec_map::contains<u8, Producto>(&arg0.productos, &arg4), 13906834414861549569);
        let v0 = Producto{
            nombre      : arg1,
            precio      : arg2,
            cantidad    : arg3,
            id_producto : arg4,
        };
        0x2::vec_map::insert<u8, Producto>(&mut arg0.productos, arg4, v0);
    }

    public fun crear_tienda(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Tienda{
            id        : 0x2::object::new(arg1),
            nombre    : arg0,
            productos : 0x2::vec_map::empty<u8, Producto>(),
        };
        0x2::transfer::transfer<Tienda>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_producto(arg0: &mut Tienda, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, Producto>(&arg0.productos, &arg1), 13906834573775470595);
        let (_, _) = 0x2::vec_map::remove<u8, Producto>(&mut arg0.productos, &arg1);
    }

    public fun reabastecer_producto(arg0: &mut Tienda, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Producto>(&arg0.productos, &arg1), 13906834526530830339);
        let v0 = 0x2::vec_map::get_mut<u8, Producto>(&mut arg0.productos, &arg1);
        v0.cantidad = v0.cantidad + arg2;
    }

    public fun vender_producto(arg0: &mut Tienda, arg1: u8, arg2: u8) {
        assert!(0x2::vec_map::contains<u8, Producto>(&arg0.productos, &arg1), 13906834479286190083);
        let v0 = 0x2::vec_map::get_mut<u8, Producto>(&mut arg0.productos, &arg1);
        assert!(v0.cantidad >= arg2, 13906834496466190341);
        v0.cantidad = v0.cantidad - arg2;
    }

    // decompiled from Move bytecode v6
}

