module 0xabb298819622ddf159d8d9162b7f2ffc8fc39114962bd6836c4ad10362fe96bb::greeting {
    struct SuiPriceLogged has copy, drop {
        price: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64,
        timestamp_sec: u64,
    }

    public fun get_sui_price(arg0: &0x2::clock::Clock, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
    }

    public fun get_sui_price_2(arg0: &0x2::clock::Clock, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg1, arg0, 60);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v0);
        let v2 = SuiPriceLogged{
            price         : v1,
            timestamp_sec : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v0),
        };
        0x2::event::emit<SuiPriceLogged>(v2);
        v1
    }

    // decompiled from Move bytecode v7
}

