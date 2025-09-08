module 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Recompensas {
    struct Recompensa has store, key {
        id: 0x2::object::UID,
        descripcion: vector<u8>,
        puntos_requeridos: u64,
    }

    struct RespuestaCanje has drop, store {
        puntos: u64,
        mensaje: vector<u8>,
    }

    public fun canjear_recompensa(arg0: &mut 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::Cliente, arg1: &Recompensa) : RespuestaCanje {
        if (0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::obtener_puntos(arg0) >= arg1.puntos_requeridos) {
            0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::restar_puntos(arg0, arg1.puntos_requeridos);
            RespuestaCanje{puntos: 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::obtener_puntos(arg0), mensaje: b"Recompensa realizada"}
        } else {
            RespuestaCanje{puntos: 0xa3a7e8e4105f62a2e143ef80baf89fe975e28ac8676cc9e30782461fc46fc95d::Clientes::obtener_puntos(arg0), mensaje: b"No tienes suficientes puntos"}
        }
    }

    public fun crear_recompensa(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Recompensa{
            id                : 0x2::object::new(arg2),
            descripcion       : arg0,
            puntos_requeridos : arg1,
        };
        0x2::transfer::transfer<Recompensa>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

