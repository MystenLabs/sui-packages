module 0xf9e5ddf49009827a37596bf105f3a2122691577e7b98165c9742c59105ca5cd::m8267cd3fc03fc04554ee50c8 {
    public fun f4ee4018545af7f568614490b(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate {
        0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

