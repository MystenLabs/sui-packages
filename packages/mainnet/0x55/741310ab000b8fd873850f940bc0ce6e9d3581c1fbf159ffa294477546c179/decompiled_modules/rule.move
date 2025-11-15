module 0x55741310ab000b8fd873850f940bc0ce6e9d3581c1fbf159ffa294477546c179::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

