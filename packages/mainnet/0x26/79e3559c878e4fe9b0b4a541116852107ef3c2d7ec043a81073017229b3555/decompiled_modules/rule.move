module 0x2679e3559c878e4fe9b0b4a541116852107ef3c2d7ec043a81073017229b3555::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

