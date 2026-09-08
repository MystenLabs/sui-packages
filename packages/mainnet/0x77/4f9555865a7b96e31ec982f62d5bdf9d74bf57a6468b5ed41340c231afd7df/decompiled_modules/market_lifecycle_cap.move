module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::market_lifecycle_cap {
    struct MarketLifecycleCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : MarketLifecycleCap {
        MarketLifecycleCap{id: 0x2::object::new(arg0)}
    }

    public fun destroy(arg0: MarketLifecycleCap) {
        let MarketLifecycleCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun id(arg0: &MarketLifecycleCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    // decompiled from Move bytecode v7
}

