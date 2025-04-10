module 0x935c72796fc1a28ce6ea7df9b25aa2ac3c5ee31ad83d518b3cfe0d377db0469e::abc {
    struct ABC {
        id: u8,
        decimal: u8,
        payload: vector<u8>,
    }

    public entry fun get_pyth_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock) : (u64, u64, u8, u64) {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::update_single_price_feed(arg1, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::create_price_infos_hot_potato(arg1, 0x1::vector::singleton<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg4, arg5)), arg5), arg2, arg3, arg5));
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg1, arg2, arg5);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 0);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_conf(&v0), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0))
    }

    public entry fun get_pyth_price2(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64, u8, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 0);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_conf(&v0), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0))
    }

    public entry fun get_pyth_price3(arg0: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : (u64, u64, u8, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_unsafe(arg0);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 0);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_conf(&v0), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0))
    }

    public fun get_pyth_price4(arg0: vector<ABC>) {
        while (!0x1::vector::is_empty<ABC>(&arg0)) {
            take_info(0x1::vector::pop_back<ABC>(&mut arg0));
        };
        0x1::vector::destroy_empty<ABC>(arg0);
    }

    public fun get_pyth_price7(arg0: &vector<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg0)) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_unsafe(0x1::vector::borrow<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg0, v0));
            v0 = v0 + 1;
        };
    }

    public fun take_info(arg0: ABC) : vector<u8> {
        let ABC {
            id      : _,
            decimal : _,
            payload : v2,
        } = arg0;
        v2
    }

    // decompiled from Move bytecode v6
}

