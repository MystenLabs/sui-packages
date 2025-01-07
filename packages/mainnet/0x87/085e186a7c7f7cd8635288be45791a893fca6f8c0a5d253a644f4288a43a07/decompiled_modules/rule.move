module 0x87085e186a7c7f7cd8635288be45791a893fca6f8c0a5d253a644f4288a43a07::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price<T0>(arg0: &mut 0x8148535d4a3f22d09468a9e101ec10ef8803c94e7aae3993897907aeec288f32::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &0x87085e186a7c7f7cd8635288be45791a893fca6f8c0a5d253a644f4288a43a07::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x87085e186a7c7f7cd8635288be45791a893fca6f8c0a5d253a644f4288a43a07::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0x87085e186a7c7f7cd8635288be45791a893fca6f8c0a5d253a644f4288a43a07::pyth_adaptor::get_pyth_price(arg1, arg2, arg4);
        let v4 = 0x8148535d4a3f22d09468a9e101ec10ef8803c94e7aae3993897907aeec288f32::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x2::math::pow(10, v4 - v2)
        } else {
            v0 / 0x2::math::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x8148535d4a3f22d09468a9e101ec10ef8803c94e7aae3993897907aeec288f32::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0x8148535d4a3f22d09468a9e101ec10ef8803c94e7aae3993897907aeec288f32::price_feed::new(v5, v3));
    }

    // decompiled from Move bytecode v6
}

