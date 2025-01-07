module 0xff57dcd4c38fd6dde5861a801f35d95ce5203b7bfaf58ecdb9cf2536fe1f6561::price_source {
    struct KOraclePriceSource has drop {
        dummy_field: bool,
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::PriceReceipt<T0>, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::KriyaOracle, arg3: &0xff57dcd4c38fd6dde5861a801f35d95ce5203b7bfaf58ecdb9cf2536fe1f6561::registry::Registry, arg4: &0xff57dcd4c38fd6dde5861a801f35d95ce5203b7bfaf58ecdb9cf2536fe1f6561::version::Version, arg5: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg6: bool) {
        0xff57dcd4c38fd6dde5861a801f35d95ce5203b7bfaf58ecdb9cf2536fe1f6561::version::assert_current_version(arg4);
        let (v0, v1) = 0xff57dcd4c38fd6dde5861a801f35d95ce5203b7bfaf58ecdb9cf2536fe1f6561::supra_adapter::get_price(arg1, 0xff57dcd4c38fd6dde5861a801f35d95ce5203b7bfaf58ecdb9cf2536fe1f6561::registry::get_pair_id<T0>(arg3, arg4));
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

