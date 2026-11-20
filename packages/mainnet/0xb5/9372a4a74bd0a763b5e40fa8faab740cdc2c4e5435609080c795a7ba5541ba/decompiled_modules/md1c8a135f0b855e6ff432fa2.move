module 0xb59372a4a74bd0a763b5e40fa8faab740cdc2c4e5435609080c795a7ba5541ba::md1c8a135f0b855e6ff432fa2 {
    public fun f192ac56c6a9cc0dbecd19a37(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate {
        0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

