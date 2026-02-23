module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals {
    struct CoinDecimals {
        pos0: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
    }

    public fun add<T0>(arg0: &mut CoinDecimals, arg1: &0x2::coin::CoinMetadata<T0>) {
        0x2::vec_map::insert<0x1::type_name::TypeName, u8>(&mut arg0.pos0, 0x1::type_name::get<T0>(), 0x2::coin::get_decimals<T0>(arg1));
    }

    public(friend) fun destroy(arg0: CoinDecimals) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8> {
        let CoinDecimals { pos0: v0 } = arg0;
        v0
    }

    public fun new() : CoinDecimals {
        CoinDecimals{pos0: 0x2::vec_map::empty<0x1::type_name::TypeName, u8>()}
    }

    // decompiled from Move bytecode v6
}

