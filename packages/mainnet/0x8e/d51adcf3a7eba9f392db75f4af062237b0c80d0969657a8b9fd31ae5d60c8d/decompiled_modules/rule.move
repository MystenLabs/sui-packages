module 0x8ed51adcf3a7eba9f392db75f4af062237b0c80d0969657a8b9fd31ae5d60c8d::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price<T0>(arg0: &mut 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: &0x8ed51adcf3a7eba9f392db75f4af062237b0c80d0969657a8b9fd31ae5d60c8d::pyth_registry::PythRegistry, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock) {
        0x8ed51adcf3a7eba9f392db75f4af062237b0c80d0969657a8b9fd31ae5d60c8d::pyth_registry::assert_pyth_price_info_object<T0>(arg4, arg3);
        let (v0, _, v2, v3) = 0x8ed51adcf3a7eba9f392db75f4af062237b0c80d0969657a8b9fd31ae5d60c8d::pyth_adaptor::get_pyth_price(arg1, arg2, arg3, arg5, arg6, arg7);
        let v4 = 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x2::math::pow(10, v4 - v2)
        } else {
            v0 / 0x2::math::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::price_feed::new(v5, v3));
    }

    // decompiled from Move bytecode v6
}

