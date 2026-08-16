module 0xcac8cfce94faf15ecbfe12eb5160d512e383d4c25403179515c654f5975fffb9::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun build_price_feed<T0>(arg0: &0xcac8cfce94faf15ecbfe12eb5160d512e383d4c25403179515c654f5975fffb9::authorized_price_registry::AuthorizedPriceRegistry, arg1: &0x2::clock::Clock) : 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed {
        let (v0, v1) = 0xcac8cfce94faf15ecbfe12eb5160d512e383d4c25403179515c654f5975fffb9::authorized_price_registry::get_price<T0>(arg0, arg1);
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::new(v0, v1)
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0xcac8cfce94faf15ecbfe12eb5160d512e383d4c25403179515c654f5975fffb9::authorized_price_registry::AuthorizedPriceRegistry, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::set_primary_price<T0, Rule>(v0, arg0, build_price_feed<T0>(arg1, arg2));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0xcac8cfce94faf15ecbfe12eb5160d512e383d4c25403179515c654f5975fffb9::authorized_price_registry::AuthorizedPriceRegistry, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, build_price_feed<T0>(arg1, arg2));
    }

    // decompiled from Move bytecode v7
}

