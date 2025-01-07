module 0x2ec233b2ef0b8be3722819f2b15334cbaf9365d5cda83cba59fdde7549fd7d13::pyth_adaptor {
    fun assert_price_not_stale(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price, arg1: &0x2::clock::Clock) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 <= v1 + 10, 70147);
        assert!(v0 >= v1 - 60, 70146);
    }

    public fun get_pyth_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) : (u64, u64, u8, u64) {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::update_single_price_feed(arg1, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::create_price_infos_hot_potato(arg1, 0x1::vector::singleton<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg5)), arg5), arg2, arg4, arg5));
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg1, arg2, arg5);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 70145);
        assert_price_not_stale(&v0, arg5);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_conf(&v0), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0))
    }

    // decompiled from Move bytecode v6
}

