module 0xb1ab59c69082939f44c63c5ffc8eedd944207563f1ef4098e343cec71c77a2d4::price_source {
    struct KOraclePriceSource has drop {
        dummy_field: bool,
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::PriceReceipt<T0>, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg3: &0xb1ab59c69082939f44c63c5ffc8eedd944207563f1ef4098e343cec71c77a2d4::registry::Registry, arg4: bool) {
        let (v0, v1) = 0xb1ab59c69082939f44c63c5ffc8eedd944207563f1ef4098e343cec71c77a2d4::supra_adapter::get_price(arg1, 0xb1ab59c69082939f44c63c5ffc8eedd944207563f1ef4098e343cec71c77a2d4::registry::get_pair_id<T0>(arg3));
        if (arg4) {
            let v2 = KOraclePriceSource{dummy_field: false};
            0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::set_primary_price<T0, KOraclePriceSource>(v2, arg0, arg2, v0, v1);
        } else {
            let v3 = KOraclePriceSource{dummy_field: false};
            0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::set_secondary_price<T0, KOraclePriceSource>(v3, arg0, arg2, v0, v1);
        };
    }

    // decompiled from Move bytecode v6
}

