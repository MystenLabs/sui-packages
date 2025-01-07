module 0x2ec233b2ef0b8be3722819f2b15334cbaf9365d5cda83cba59fdde7549fd7d13::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price<T0>(arg0: &mut 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: &0x2ec233b2ef0b8be3722819f2b15334cbaf9365d5cda83cba59fdde7549fd7d13::pyth_registry::PythRegistry, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock) {
        0x2ec233b2ef0b8be3722819f2b15334cbaf9365d5cda83cba59fdde7549fd7d13::pyth_registry::assert_pyth_price_info_object<T0>(arg4, arg3);
        let (v0, _, v2, v3) = 0x2ec233b2ef0b8be3722819f2b15334cbaf9365d5cda83cba59fdde7549fd7d13::pyth_adaptor::get_pyth_price(arg1, arg2, arg3, arg5, arg6, arg7);
        let v4 = 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x2::math::pow(10, v4 - v2)
        } else {
            v0 / 0x2::math::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::price_feed::new(v5, v3));
    }

    // decompiled from Move bytecode v6
}

