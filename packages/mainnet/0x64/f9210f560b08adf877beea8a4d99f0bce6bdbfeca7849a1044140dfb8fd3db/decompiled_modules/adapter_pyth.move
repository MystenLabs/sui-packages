module 0x64f9210f560b08adf877beea8a4d99f0bce6bdbfeca7849a1044140dfb8fd3db::adapter_pyth {
    public fun get_pyth_price_unsafe(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : (u64, u8, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_unsafe(arg0);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 20001);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0) * 1000)
    }

    // decompiled from Move bytecode v6
}

