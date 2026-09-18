module 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::view {
    struct PriceQuote has copy, drop {
        oracle_id: 0x2::object::ID,
        rate_liquidate: u128,
        rate_operate: u128,
    }

    public fun oracle_id(arg0: &PriceQuote) : 0x2::object::ID {
        arg0.oracle_id
    }

    public fun quote(arg0: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::Oracle) : PriceQuote {
        0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::assert_version(arg0);
        PriceQuote{
            oracle_id      : 0x2::object::id<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::Oracle>(arg0),
            rate_liquidate : 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::rate(arg0),
            rate_operate   : 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::rate(arg0),
        }
    }

    public fun rate_liquidate(arg0: &PriceQuote) : u128 {
        arg0.rate_liquidate
    }

    public fun rate_operate(arg0: &PriceQuote) : u128 {
        arg0.rate_operate
    }

    // decompiled from Move bytecode v7
}

