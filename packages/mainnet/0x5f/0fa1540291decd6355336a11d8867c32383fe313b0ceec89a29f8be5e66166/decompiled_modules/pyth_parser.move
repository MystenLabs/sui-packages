module 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::pyth_parser {
    public fun parse_config(arg0: 0x1::option::Option<address>) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_none<address>(&arg0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg0)))
        }
    }

    public fun parse_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &0x2::clock::Clock, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u8) : 0x1::option::Option<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo> {
        let v0 = 0x1::vector::empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>();
        0x1::vector::push_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&mut v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg4, arg2));
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::update_single_price_feed(arg1, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::create_price_infos_hot_potato(arg1, v0, arg2), arg3, arg5, arg2));
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg1, arg3, arg2);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v1);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v1);
        if (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_is_negative(&v2)) {
            return 0x1::option::none<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>()
        };
        if (!0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_is_negative(&v3)) {
            return 0x1::option::none<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>()
        };
        let v4 = (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2) as u8);
        let v5 = if (v4 > arg6) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v3) / 0x2::math::pow(10, v4 - arg6)
        } else {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v3) * 0x2::math::pow(10, arg6 - v4)
        };
        0x1::option::some<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::new(v5, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v1) * 1000))
    }

    public fun parse_price_read_only(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg1: &0x2::clock::Clock, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: u8) : 0x1::option::Option<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo> {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg0, arg2, arg1);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        if (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_is_negative(&v1)) {
            return 0x1::option::none<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>()
        };
        if (!0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_is_negative(&v2)) {
            return 0x1::option::none<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>()
        };
        let v3 = (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v1) as u8);
        let v4 = if (v3 > arg3) {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v2) / 0x2::math::pow(10, v3 - arg3)
        } else {
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v2) * 0x2::math::pow(10, arg3 - v3)
        };
        0x1::option::some<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::new(v4, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0) * 1000))
    }

    // decompiled from Move bytecode v6
}

