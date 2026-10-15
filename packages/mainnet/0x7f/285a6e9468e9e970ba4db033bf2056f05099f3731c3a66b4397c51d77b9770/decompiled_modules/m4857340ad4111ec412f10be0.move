module 0x7f285a6e9468e9e970ba4db033bf2056f05099f3731c3a66b4397c51d77b9770::m4857340ad4111ec412f10be0 {
    public fun fa910502fb5b495ce7bd3eba7(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate {
        0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

