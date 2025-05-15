module 0x57f649c7dbd778b1300d2100b7d4ba3aa6904d71759a2b51e0ae95009a026f39::connector {
    struct Connector<phantom T0> has store, key {
        id: 0x2::object::UID,
        temp_id: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        metadata: 0x2::coin::CoinMetadata<T0>,
        twitter: 0x1::string::String,
        website: 0x1::string::String,
        telegram: 0x1::string::String,
        creator: address,
    }

    public fun get_decimals<T0>(arg0: &Connector<T0>) : u8 {
        0x2::coin::get_decimals<T0>(&arg0.metadata)
    }

    public fun deconstruct<T0>(arg0: Connector<T0>) : (0x2::object::UID, 0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>, address, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let Connector {
            id           : v0,
            temp_id      : _,
            treasury_cap : v2,
            metadata     : v3,
            twitter      : v4,
            website      : v5,
            telegram     : v6,
            creator      : v7,
        } = arg0;
        (v0, v2, v3, v7, v4, v5, v6)
    }

    public fun get_creator<T0>(arg0: &Connector<T0>) : address {
        arg0.creator
    }

    public fun get_id<T0>(arg0: &Connector<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_supply<T0>(arg0: &Connector<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public fun get_temp_id<T0>(arg0: &Connector<T0>) : u64 {
        arg0.temp_id
    }

    public fun new<T0>(arg0: u64, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : Connector<T0> {
        abort 200
    }

    // decompiled from Move bytecode v6
}

