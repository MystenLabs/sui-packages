module 0xee6418f80c173c28af2544aeace5849798c7aa7fa587301834d40d30260fa557::m81109e4e793de98026ac4508 {
    public fun f01bd26b3525a12b9ea0a5201(arg0: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: 0x1::type_name::TypeName) : 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price_info(arg0, arg1)
    }

    public fun f770e8ecad3bb2f799cb28393(arg0: &mut 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::update_price_from_pyth(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

