module 0xee6418f80c173c28af2544aeace5849798c7aa7fa587301834d40d30260fa557::maf7ae53e1205e61a97add116 {
    public fun f411cf8a8ec3db0f930c96fb3(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate {
        0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

