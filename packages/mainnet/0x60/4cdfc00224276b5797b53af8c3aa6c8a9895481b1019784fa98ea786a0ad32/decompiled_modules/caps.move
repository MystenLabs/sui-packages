module 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps {
    struct CAPS has drop {
        dummy_field: bool,
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CAPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = MarketAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MarketAdminCap>(v1, v0);
        let v2 = PauseCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PauseCap>(v2, v0);
    }

    public fun market_admin_id(arg0: &MarketAdminCap) : 0x2::object::ID {
        0x2::object::id<MarketAdminCap>(arg0)
    }

    public fun pause_id(arg0: &PauseCap) : 0x2::object::ID {
        0x2::object::id<PauseCap>(arg0)
    }

    // decompiled from Move bytecode v7
}

