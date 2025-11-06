module 0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::oracle_admin {
    public fun register_pyth_feed<T0>(arg0: &0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::AdminCap, arg1: &mut 0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u64) {
        0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::pyth_adaptor::register_pyth_feed<T0>(0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::pyth_price_feeds_mut(arg1), arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

