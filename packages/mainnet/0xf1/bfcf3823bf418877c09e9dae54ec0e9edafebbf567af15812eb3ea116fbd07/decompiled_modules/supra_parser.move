module 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::supra_parser {
    public fun parse_price(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32, arg2: u8) : 0x1::option::Option<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo> {
        let (v0, v1, v2, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg1);
        let v4 = (v1 as u8);
        let v5 = if (v4 > arg2) {
            v0 / (0x2::math::pow(10, v4 - arg2) as u128)
        } else {
            v0 * (0x2::math::pow(10, arg2 - v4) as u128)
        };
        0x1::option::some<0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::PriceInfo>(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator::new((v5 as u64), (v2 as u64)))
    }

    // decompiled from Move bytecode v6
}

