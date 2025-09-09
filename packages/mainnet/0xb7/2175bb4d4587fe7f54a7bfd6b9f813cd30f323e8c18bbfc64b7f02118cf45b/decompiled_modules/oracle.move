module 0xb72175bb4d4587fe7f54a7bfd6b9f813cd30f323e8c18bbfc64b7f02118cf45b::oracle {
    struct Oracle<phantom T0> has store, key {
        id: 0x2::object::UID,
        sqrt_price: u128,
        timestamp_ms: u64,
        last_update_ms: u64,
    }

    struct OracleMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    public fun create_oracle<T0: drop>(arg0: T0, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x2::url::Url>, arg5: &mut 0x2::tx_context::TxContext) : (Oracle<T0>, OracleMetadata<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = Oracle<T0>{
            id             : 0x2::object::new(arg5),
            sqrt_price     : 0,
            timestamp_ms   : 0,
            last_update_ms : 0,
        };
        let v1 = OracleMetadata<T0>{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            symbol      : arg2,
            description : arg3,
            icon_url    : arg4,
        };
        (v0, v1)
    }

    public fun update<T0>(arg0: &mut Oracle<T0>, arg1: u128, arg2: u64, arg3: &0x2::clock::Clock) {
        if (arg2 > arg0.timestamp_ms) {
            arg0.last_update_ms = 0x2::clock::timestamp_ms(arg3);
            arg0.timestamp_ms = arg2;
            arg0.sqrt_price = arg1;
        };
    }

    // decompiled from Move bytecode v6
}

