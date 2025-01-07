module 0xb2bf156a02aaddb006368cf134a27a46d9106a818050f4a2406b05139cf96b18::price_source {
    struct KOraclePriceSource has drop {
        dummy_field: bool,
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::PriceReceipt<T0>, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::KriyaOracle, arg3: &0xb2bf156a02aaddb006368cf134a27a46d9106a818050f4a2406b05139cf96b18::registry::Registry, arg4: &0xb2bf156a02aaddb006368cf134a27a46d9106a818050f4a2406b05139cf96b18::version::Version, arg5: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg6: bool) {
        0xb2bf156a02aaddb006368cf134a27a46d9106a818050f4a2406b05139cf96b18::version::assert_current_version(arg4);
        let (v0, v1) = 0xb2bf156a02aaddb006368cf134a27a46d9106a818050f4a2406b05139cf96b18::supra_adapter::get_price(arg1, 0xb2bf156a02aaddb006368cf134a27a46d9106a818050f4a2406b05139cf96b18::registry::get_pair_id<T0>(arg3, arg4));
        if (arg6) {
            let v2 = KOraclePriceSource{dummy_field: false};
            0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::set_primary_price<T0, KOraclePriceSource>(arg5, v2, arg0, arg2, v0, v1);
        } else {
            let v3 = KOraclePriceSource{dummy_field: false};
            0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::set_secondary_price<T0, KOraclePriceSource>(arg5, v3, arg0, arg2, v0, v1);
        };
    }

    // decompiled from Move bytecode v6
}

