module 0x5b85890e1e7e69a75332c65568ef56cc6189a2a89d26442355791775fb17a9e8::reservaciones {
    struct Mesa has drop, store {
        numero: u64,
        capacidad: u64,
        reservada: bool,
        reservada_por: address,
    }

    struct Restaurante has drop, store {
        numero_de_mesa: u64,
        maximo_mesas: u64,
    }

    public fun cancelar_reservacion(arg0: &mut Mesa, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.reservada_por == 0x2::tx_context::sender(arg1), 13906834487876255749);
        arg0.reservada = false;
        arg0.reservada_por = @0x0;
    }

    public fun crear_mesa(arg0: &mut Restaurante, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        Mesa{numero: arg1, capacidad: arg2, reservada: false, reservada_por: @0x0};
        assert!(arg0.numero_de_mesa < arg0.maximo_mesas, 13906834401976647681);
        arg0.numero_de_mesa = arg0.numero_de_mesa + 1;
    }

    public fun crear_restaurante(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        Restaurante{numero_de_mesa: 0, maximo_mesas: 25};
    }

    public fun disponibilidad_de_mesa(arg0: &Mesa, arg1: &0x2::tx_context::TxContext) {
    }

    public fun reservar_mesa(arg0: &mut Mesa, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.reservada, 13906834449221419011);
        arg0.reservada = true;
        arg0.reservada_por = 0x2::tx_context::sender(arg1);
    }

    // decompiled from Move bytecode v6
}

