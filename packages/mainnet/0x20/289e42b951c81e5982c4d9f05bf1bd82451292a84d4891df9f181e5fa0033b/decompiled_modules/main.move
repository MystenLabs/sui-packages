module 0x20289e42b951c81e5982c4d9f05bf1bd82451292a84d4891df9f181e5fa0033b::main {
    struct Price has copy, drop {
        price: u64,
        decimals: u64,
        timestamp: u64,
    }

    public fun use_pyth_price(arg0: &0x2::clock::Clock, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_no_older_than(arg1, arg0, 60);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_identifier(&v1);
        assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::get_bytes(&v2) != x"ff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace", 1);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v4 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v5 = if (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_is_negative(&v4)) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v4)
        } else {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v4)
        };
        let v6 = if (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_is_negative(&v3)) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v3)
        } else {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v3)
        };
        let v7 = Price{
            price     : v5,
            decimals  : v6,
            timestamp : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0),
        };
        0x2::event::emit<Price>(v7);
    }

    // decompiled from Move bytecode v6
}

