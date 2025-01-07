module 0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::price_source {
    struct KOraclePriceSource has drop {
        dummy_field: bool,
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::PriceReceipt<T0>, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg3: &0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::registry::Registry, arg4: bool) {
        0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::version::assert_current_version(0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::registry::version(arg3));
        let (v0, v1) = 0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::supra_adapter::get_price(arg1, 0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::registry::get_pair_id<T0>(arg3));
        if (arg4) {
            let v2 = KOraclePriceSource{dummy_field: false};
            0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::set_primary_price<T0, KOraclePriceSource>(v2, arg0, arg2, v0, v1);
        } else {
            let v3 = KOraclePriceSource{dummy_field: false};
            0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::set_secondary_price<T0, KOraclePriceSource>(v3, arg0, arg2, v0, v1);
        };
    }

    // decompiled from Move bytecode v6
}

