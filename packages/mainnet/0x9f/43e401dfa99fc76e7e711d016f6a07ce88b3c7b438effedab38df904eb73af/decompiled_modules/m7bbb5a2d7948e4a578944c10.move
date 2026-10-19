module 0x9f43e401dfa99fc76e7e711d016f6a07ce88b3c7b438effedab38df904eb73af::m7bbb5a2d7948e4a578944c10 {
    public fun f2ec834c710aa740116562cf4(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate {
        0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

