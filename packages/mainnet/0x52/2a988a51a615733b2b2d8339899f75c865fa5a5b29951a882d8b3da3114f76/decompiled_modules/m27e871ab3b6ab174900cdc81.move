module 0x522a988a51a615733b2b2d8339899f75c865fa5a5b29951a882d8b3da3114f76::m27e871ab3b6ab174900cdc81 {
    public fun f91c7d7d69f8a859cfc9d0e54(arg0: &mut 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg2: &0x2::clock::Clock) {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::ingest_lazer_update(arg0, arg1, arg2);
    }

    public fun f9aa8d8e1eecfbf4b8ed69daf(arg0: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg1: 0x1::type_name::TypeName) : 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo {
        0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price_info(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

