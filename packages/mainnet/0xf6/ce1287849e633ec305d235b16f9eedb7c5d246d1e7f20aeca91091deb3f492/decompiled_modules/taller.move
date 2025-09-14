module 0xf6ce1287849e633ec305d235b16f9eedb7c5d246d1e7f20aeca91091deb3f492::taller {
    struct Taller has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        cliente: 0x2::vec_map::VecMap<u64, Cliente>,
    }

    struct Cliente has drop, store {
        nombre_Cliente: 0x1::string::String,
        modelo_Vehiculo: u8,
        color: 0x1::string::String,
        reparado: bool,
        estado: 0x1::string::String,
    }

    public fun agregar_cliente(arg0: &mut Taller, arg1: u64, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: bool, arg6: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<u64, Cliente>(&arg0.cliente, &arg1), 13906834337552138241);
        let v0 = Cliente{
            nombre_Cliente  : arg2,
            modelo_Vehiculo : arg3,
            color           : arg4,
            reparado        : true,
            estado          : arg6,
        };
        0x2::vec_map::insert<u64, Cliente>(&mut arg0.cliente, arg1, v0);
    }

    public fun crear_taller(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Taller{
            id      : 0x2::object::new(arg1),
            nombre  : arg0,
            cliente : 0x2::vec_map::empty<u64, Cliente>(),
        };
        0x2::transfer::transfer<Taller>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_cliente(arg0: &mut Taller, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Cliente>(&arg0.cliente, &arg1), 13906834393386844163);
        let (_, _) = 0x2::vec_map::remove<u64, Cliente>(&mut arg0.cliente, &arg1);
    }

    // decompiled from Move bytecode v6
}

