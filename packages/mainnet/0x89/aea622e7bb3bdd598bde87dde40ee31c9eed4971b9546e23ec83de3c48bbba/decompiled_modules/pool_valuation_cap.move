module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap {
    struct PoolValuationCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : PoolValuationCap {
        PoolValuationCap{id: 0x2::object::new(arg0)}
    }

    public fun destroy(arg0: PoolValuationCap) {
        let PoolValuationCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun id(arg0: &PoolValuationCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    // decompiled from Move bytecode v7
}

