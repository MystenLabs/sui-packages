module 0x4a6b2d6d25e19fdb48e77d05ad1f9cc57e9e4e6e542bae348b420055895fa70::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

