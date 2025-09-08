module 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::CafeRewards {
    entry fun agregarPuntosCliente(arg0: &mut 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::Cliente, arg1: &mut 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Transacciones::Transaccion, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Transacciones::puntos_transaccion_cliente(arg1, arg2, arg0, arg3);
    }

    entry fun canjearRecompensa(arg0: &mut 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::Cliente, arg1: &0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Recompensas::Recompensa) {
        0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Recompensas::canjear_recompensa(arg0, arg1);
    }

    entry fun crearCliente(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::crear_cliente(arg0, arg1, arg2);
    }

    entry fun crearRecompensa(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Recompensas::crear_recompensa(arg0, arg1, arg2);
    }

    entry fun crearTransaccion(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Transacciones::crear_transaccion(0x2::tx_context::sender(arg1), arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

