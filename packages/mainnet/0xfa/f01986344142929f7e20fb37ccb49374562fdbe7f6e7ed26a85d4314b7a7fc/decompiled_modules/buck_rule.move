module 0xfaf01986344142929f7e20fb37ccb49374562fdbe7f6e7ed26a85d4314b7a7fc::buck_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct PythPriceInfoObject has copy, drop {
        id: 0x2::object::ID,
    }

    fun get_price(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2))
    }

    entry fun emit_price_info_object_id(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: vector<u8>) {
        let v0 = PythPriceInfoObject{id: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_price_info_object_id(arg0, arg1)};
        0x2::event::emit<PythPriceInfoObject>(v0);
    }

    fun err_invalid_price_info_object() {
        abort 0
    }

    public fun update_blast_off_oracle(arg0: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::oracle::Oracle, arg1: &0x2::clock::Clock, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        if (0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg3) != 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::get_price_info_object_id(arg2, x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744")) {
            err_invalid_price_info_object();
        };
        let (v0, v1) = get_price(arg2, arg3, arg1);
        let v2 = Rule{dummy_field: false};
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::oracle::update_price<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, Rule>(v2, arg0, arg1, 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::precision() * (0x2::math::pow(10, (v1 as u8)) as u128) / (v0 as u128) * 10 / 9);
    }

    // decompiled from Move bytecode v6
}

