module 0xc51d6279b040a90fec7d71edc4a6e7793304f2560a9f94225e88b5d82670396d::connector {
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

    public fun new<T0>(arg0: u64, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : Connector<T0> {
        assert!(0x2::tx_context::sender(arg7) == @0x96902b51ca838a02efd12bb4c6dafcc9bf2a0a4018f1ea0dd2cfa73b8715c61d, 0);
        Connector<T0>{
            id           : 0x2::object::new(arg7),
            temp_id      : arg0,
            treasury_cap : arg1,
            metadata     : arg2,
            twitter      : arg3,
            website      : arg4,
            telegram     : arg5,
            creator      : arg6,
        }
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

    // decompiled from Move bytecode v6
}

