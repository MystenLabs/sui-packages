module 0x174649fa61d4108fbd04b88ddd1258b48fdcd71735d9fc92d1bd28d88484c6e6::m71b3e4c8bb4075caf92771ac {
    public fun fddefccfa3f515072513f4527(arg0: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: 0x1::type_name::TypeName) : 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price_info(arg0, arg1)
    }

    public fun fe9299c57c0feb805675331c6(arg0: &mut 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::update_price_from_pyth(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

