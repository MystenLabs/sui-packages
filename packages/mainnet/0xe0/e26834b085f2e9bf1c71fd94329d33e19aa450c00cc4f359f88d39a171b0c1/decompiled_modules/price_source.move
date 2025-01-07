module 0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::price_source {
    struct KOraclePriceSource has drop {
        dummy_field: bool,
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::PriceReceipt<T0>, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::KriyaOracle, arg3: &0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::registry::Registry, arg4: &0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::version::Version, arg5: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::version::Version, arg6: bool) {
        0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::version::assert_current_version(arg4);
        let (v0, v1) = 0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::supra_adapter::get_price(arg1, 0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::registry::get_pair_id<T0>(arg3, arg4));
        if (arg6) {
            let v2 = KOraclePriceSource{dummy_field: false};
            0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::set_primary_price<T0, KOraclePriceSource>(arg5, v2, arg0, arg2, v0, v1);
        } else {
            let v3 = KOraclePriceSource{dummy_field: false};
            0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::set_secondary_price<T0, KOraclePriceSource>(arg5, v3, arg0, arg2, v0, v1);
        };
    }

    // decompiled from Move bytecode v6
}

