module 0xc48fb37ee39cf435e7fec75814eebb647a2ac74df10ed8c376a9332c2375ef42::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

