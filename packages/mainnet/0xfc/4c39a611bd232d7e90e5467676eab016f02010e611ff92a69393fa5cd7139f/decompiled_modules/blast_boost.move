module 0xfc4c39a611bd232d7e90e5467676eab016f02010e611ff92a69393fa5cd7139f::blast_boost {
    struct BlastBoost<phantom T0> has key {
        id: 0x2::object::UID,
    }

    public(friend) fun new_currency<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<BlastBoost<T0>>, 0x2::coin_registry::MetadataCap<BlastBoost<T0>>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<BlastBoost<T0>>(arg0, 9, arg1, arg2, arg3, arg4, arg5);
        (v1, 0x2::coin_registry::finalize<BlastBoost<T0>>(v0, arg5))
    }

    // decompiled from Move bytecode v7
}

