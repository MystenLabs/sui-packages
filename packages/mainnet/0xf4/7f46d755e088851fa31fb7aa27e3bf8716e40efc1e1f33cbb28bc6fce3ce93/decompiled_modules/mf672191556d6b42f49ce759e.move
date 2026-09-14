module 0xf47f46d755e088851fa31fb7aa27e3bf8716e40efc1e1f33cbb28bc6fce3ce93::mf672191556d6b42f49ce759e {
    public fun f30edbe2f923ec398579708ce(arg0: &mut 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg2: &0x2::clock::Clock) {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::ingest_lazer_update(arg0, arg1, arg2);
    }

    public fun f5d9bc04354523e91e347dd3f(arg0: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: 0x1::type_name::TypeName) : 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price_info(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

