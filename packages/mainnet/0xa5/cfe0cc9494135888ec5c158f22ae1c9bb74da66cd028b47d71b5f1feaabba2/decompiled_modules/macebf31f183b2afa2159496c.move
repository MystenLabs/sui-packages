module 0xa5cfe0cc9494135888ec5c158f22ae1c9bb74da66cd028b47d71b5f1feaabba2::macebf31f183b2afa2159496c {
    public fun f13685ec6a8e280ff46c03a17(arg0: &mut 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::update_price_from_pyth(arg0, arg1, arg2);
    }

    public fun f5ca135169a8f85472db3321a(arg0: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: 0x1::type_name::TypeName) : 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price_info(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

