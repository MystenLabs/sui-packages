module 0x91f23ecd687a7f3bb70e7f2b9c102a470a40bc1411a081dbb6a85e15081b8988::price_source {
    struct KOraclePriceSource has drop {
        dummy_field: bool,
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::PriceReceipt<T0>, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::KriyaOracle, arg3: &0x91f23ecd687a7f3bb70e7f2b9c102a470a40bc1411a081dbb6a85e15081b8988::registry::Registry, arg4: bool) {
        let (v0, v1) = 0x91f23ecd687a7f3bb70e7f2b9c102a470a40bc1411a081dbb6a85e15081b8988::supra_adapter::get_price(arg1, 0x91f23ecd687a7f3bb70e7f2b9c102a470a40bc1411a081dbb6a85e15081b8988::registry::get_pair_id<T0>(arg3));
        if (arg4) {
            let v2 = KOraclePriceSource{dummy_field: false};
            0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::set_primary_price<T0, KOraclePriceSource>(v2, arg0, arg2, v0, v1);
        } else {
            let v3 = KOraclePriceSource{dummy_field: false};
            0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::set_secondary_price<T0, KOraclePriceSource>(v3, arg0, arg2, v0, v1);
        };
    }

    // decompiled from Move bytecode v6
}

