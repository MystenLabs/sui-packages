module 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes {
    struct Cliente has store, key {
        id: 0x2::object::UID,
        nombre: vector<u8>,
        email: vector<u8>,
        puntos: u64,
    }

    public fun agregar_puntos(arg0: &mut Cliente, arg1: u64) {
        arg0.puntos = arg0.puntos + arg1;
    }

    public fun crear_cliente(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Cliente{
            id     : 0x2::object::new(arg2),
            nombre : arg0,
            email  : arg1,
            puntos : 0,
        };
        0x2::transfer::transfer<Cliente>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun obtener_puntos(arg0: &Cliente) : u64 {
        arg0.puntos
    }

    public fun restar_puntos(arg0: &mut Cliente, arg1: u64) {
        assert!(arg0.puntos >= arg1, 1);
        arg0.puntos = arg0.puntos - arg1;
    }

    // decompiled from Move bytecode v6
}

