module 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Transacciones {
    struct TransaccionTimeStamp has copy, drop, store {
        descripcion: 0x1::string::String,
        fecha_hora: u64,
    }

    struct Transaccion has store, key {
        id: 0x2::object::UID,
        cliente: address,
        puntos: u64,
        historial: vector<TransaccionTimeStamp>,
    }

    public fun crear_transaccion(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Transaccion{
            id        : 0x2::object::new(arg2),
            cliente   : arg0,
            puntos    : arg1,
            historial : 0x1::vector::empty<TransaccionTimeStamp>(),
        };
        0x2::transfer::transfer<Transaccion>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun puntos_transaccion_cliente(arg0: &mut Transaccion, arg1: 0x1::string::String, arg2: &mut 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::Cliente, arg3: &0x2::tx_context::TxContext) {
        0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::agregar_puntos(arg2, arg0.puntos);
        let v0 = TransaccionTimeStamp{
            descripcion : arg1,
            fecha_hora  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x1::vector::push_back<TransaccionTimeStamp>(&mut arg0.historial, v0);
    }

    // decompiled from Move bytecode v6
}

