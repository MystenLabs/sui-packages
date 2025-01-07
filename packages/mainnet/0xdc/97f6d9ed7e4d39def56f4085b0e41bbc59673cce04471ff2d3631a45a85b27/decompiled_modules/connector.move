module 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector {
    struct Connector<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        metadata: 0x2::coin::CoinMetadata<T0>,
        creator: address,
    }

    public fun get_decimals<T0>(arg0: &Connector<T0>) : u8 {
        0x2::coin::get_decimals<T0>(&arg0.metadata)
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Connector<T0> {
        Connector<T0>{
            id           : 0x2::object::new(arg3),
            treasury_cap : arg0,
            metadata     : arg1,
            creator      : arg2,
        }
    }

    public fun deconstruct<T0>(arg0: Connector<T0>) : (0x2::object::UID, 0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>, address) {
        let Connector {
            id           : v0,
            treasury_cap : v1,
            metadata     : v2,
            creator      : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun get_creator<T0>(arg0: &Connector<T0>) : address {
        arg0.creator
    }

    public fun get_id<T0>(arg0: &Connector<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

