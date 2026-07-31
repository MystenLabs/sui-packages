module 0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_adaptor::get_pyth_price(arg1, arg2, 0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_registry::pyth_feed_data(arg3, 0x1::type_name::get<T0>()), arg4);
        let v4 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x1::u64::pow(10, v4 - v2)
        } else {
            v0 / 0x1::u64::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::new(v5, v3));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_adaptor::get_pyth_price(arg1, arg2, 0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_registry::pyth_feed_data(arg3, 0x1::type_name::get<T0>()), arg4);
        let v4 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x1::u64::pow(10, v4 - v2)
        } else {
            v0 / 0x1::u64::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::set_secondary_price<T0, Rule>(v6, arg0, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::new(v5, v3));
    }

    // decompiled from Move bytecode v7
}

