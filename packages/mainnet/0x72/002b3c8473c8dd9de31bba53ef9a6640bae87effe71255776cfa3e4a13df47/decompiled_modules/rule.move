module 0x72002b3c8473c8dd9de31bba53ef9a6640bae87effe71255776cfa3e4a13df47::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

