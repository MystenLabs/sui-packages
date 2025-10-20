module 0x554acad5db8b4bb9ade90fd5098a077b1e29426c3f0bc67beb744831510cd51e::taxidrivervc {
    struct TarifaBase has store, key {
        id: 0x2::object::UID,
        costo_km: u64,
        cuota_caseta_max: u64,
    }

    struct TicketServicio has store, key {
        id: 0x2::object::UID,
        costo_final: u64,
        destino: 0x1::string::String,
        conductor_id: 0x1::string::String,
        num_unidad: u64,
        es_efectivo: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun actualizar_tarifa(arg0: &AdminCap, arg1: &mut TarifaBase, arg2: u64, arg3: u64) {
        arg1.costo_km = arg2;
        arg1.cuota_caseta_max = arg3;
    }

    public fun emitir_ticket(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 1);
        let v0 = TicketServicio{
            id           : 0x2::object::new(arg5),
            costo_final  : arg0,
            destino      : arg1,
            conductor_id : arg2,
            num_unidad   : arg3,
            es_efectivo  : arg4,
        };
        0x2::transfer::transfer<TicketServicio>(v0, 0x2::tx_context::sender(arg5));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TarifaBase{
            id               : 0x2::object::new(arg0),
            costo_km         : 10,
            cuota_caseta_max : 50,
        };
        0x2::transfer::transfer<TarifaBase>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

