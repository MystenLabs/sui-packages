module 0x12069028d6e7c6f6a187946829c342c05a86281322c9027df3dc265787f9d01d::prioridad {
    struct Prioridad has store, key {
        id: 0x2::object::UID,
        precio: u64,
    }

    struct Registro_prioridades has store, key {
        id: 0x2::object::UID,
        prioridades: vector<address>,
    }

    public fun actualizar_precio(arg0: &mut Prioridad, arg1: u64) {
        arg0.precio = arg1;
    }

    public fun asignar_prioridad(arg0: Prioridad, arg1: address) {
        0x2::transfer::transfer<Prioridad>(arg0, arg1);
    }

    public fun crear_prioridad(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Prioridad{
            id     : 0x2::object::new(arg0),
            precio : 0,
        };
        0x2::transfer::transfer<Prioridad>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun crear_registro(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registro_prioridades{
            id          : 0x2::object::new(arg0),
            prioridades : vector[],
        };
        0x2::transfer::transfer<Registro_prioridades>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun registrar_prioridad(arg0: &mut Registro_prioridades, arg1: address) {
        0x1::vector::push_back<address>(&mut arg0.prioridades, arg1);
    }

    // decompiled from Move bytecode v6
}

