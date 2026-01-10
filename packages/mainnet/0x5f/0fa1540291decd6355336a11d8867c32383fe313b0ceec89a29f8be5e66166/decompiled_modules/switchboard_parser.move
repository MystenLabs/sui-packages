module 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::switchboard_parser {
    fun extract_aggregator_info(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) : (u128, u8, u64) {
        let (v0, v1) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::latest_value(arg0);
        let (v2, v3, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::unpack(v0);
        (v2, v3, v1)
    }

    public fun parse_config(arg0: 0x1::option::Option<address>) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_none<address>(&arg0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg0)))
        }
    }

    public fun parse_price(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg1: u8) : 0x1::option::Option<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo> {
        let (v0, v1, v2) = extract_aggregator_info(arg0);
        if (v0 == 0) {
            return 0x1::option::none<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>()
        };
        let v3 = if (v1 > arg1) {
            v0 / (0x2::math::pow(10, v1 - arg1) as u128)
        } else {
            v0 * (0x2::math::pow(10, arg1 - v1) as u128)
        };
        0x1::option::some<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::new((v3 as u64), v2 * 1000))
    }

    // decompiled from Move bytecode v6
}

