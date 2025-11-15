module 0x25254d2866332d820109c9769ad4fa72d3a6ac727b1e42f52c82ec7f9e4842d::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

