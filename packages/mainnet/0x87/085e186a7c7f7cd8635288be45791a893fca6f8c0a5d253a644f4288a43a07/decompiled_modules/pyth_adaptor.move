module 0x87085e186a7c7f7cd8635288be45791a893fca6f8c0a5d253a644f4288a43a07::pyth_adaptor {
    fun assert_price_conf_within_range(arg0: u64, arg1: u64) {
        let v0 = 10000;
        assert!(((((arg1 * v0 * 100) as u128) / (arg0 as u128)) as u64) <= 2 * v0, 70297);
    }

    fun assert_price_not_stale(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price, arg1: &0x2::clock::Clock) {
        assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(arg0) == 0x2::clock::timestamp_ms(arg1) / 1000, 70146);
    }

    public fun get_pyth_price(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64, u8, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_conf(&v0);
        let v4 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v5 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v4);
        assert!(v5 <= 255, 70145);
        assert_price_not_stale(&v0, arg2);
        assert_price_conf_within_range(v2, v3);
        (v2, v3, (v5 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0))
    }

    // decompiled from Move bytecode v6
}

