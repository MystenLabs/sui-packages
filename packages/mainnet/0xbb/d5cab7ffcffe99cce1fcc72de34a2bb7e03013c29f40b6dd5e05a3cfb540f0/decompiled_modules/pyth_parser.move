module 0xbbd5cab7ffcffe99cce1fcc72de34a2bb7e03013c29f40b6dd5e05a3cfb540f0::pyth_parser {
    struct PythPriceInfoObject has copy, drop {
        id: 0x2::object::ID,
    }

    struct PythPrice has copy, drop {
        price: u64,
        conf: u64,
        timestamp: u64,
        decimal: u64,
    }

    public(friend) entry fun get_price(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1);
        let v4 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        let v5 = PythPrice{
            price     : v3,
            conf      : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_conf(&v0),
            timestamp : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0),
            decimal   : v4,
        };
        0x2::event::emit<PythPrice>(v5);
        (v3, v4)
    }

    entry fun get_price_info_object_id(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: vector<u8>) {
        let v0 = PythPriceInfoObject{id: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_price_info_object_id(arg0, arg1)};
        0x2::event::emit<PythPriceInfoObject>(v0);
    }

    public(friend) entry fun get_ema_price(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : (u64, u64, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed::get_price(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_feed(&v0));
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v1);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v1);
        let v4 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v1);
        let v5 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v2);
        let v6 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v3);
        let v7 = PythPrice{
            price     : v5,
            conf      : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_conf(&v1),
            timestamp : v4,
            decimal   : v6,
        };
        0x2::event::emit<PythPrice>(v7);
        (v5, v6, v4)
    }

    // decompiled from Move bytecode v6
}

