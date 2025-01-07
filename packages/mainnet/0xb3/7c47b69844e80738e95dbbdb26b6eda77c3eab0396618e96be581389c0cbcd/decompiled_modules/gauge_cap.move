module 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::gauge_cap {
    struct GaugeCap has store, key {
        id: 0x2::object::UID,
        gauger_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    public fun create_gauge_cap(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : GaugeCap {
        GaugeCap{
            id        : 0x2::object::new(arg2),
            gauger_id : arg1,
            pool_id   : arg0,
        }
    }

    public fun get_gauger_id(arg0: &GaugeCap) : 0x2::object::ID {
        arg0.gauger_id
    }

    public fun get_pool_id(arg0: &GaugeCap) : 0x2::object::ID {
        arg0.pool_id
    }

    // decompiled from Move bytecode v6
}

