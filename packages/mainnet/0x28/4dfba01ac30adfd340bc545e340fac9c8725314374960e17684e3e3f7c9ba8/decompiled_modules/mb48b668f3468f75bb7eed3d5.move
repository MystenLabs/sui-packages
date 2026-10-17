module 0x284dfba01ac30adfd340bc545e340fac9c8725314374960e17684e3e3f7c9ba8::mb48b668f3468f75bb7eed3d5 {
    public fun fc753680aa6837cbd94e73abb(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate {
        0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

