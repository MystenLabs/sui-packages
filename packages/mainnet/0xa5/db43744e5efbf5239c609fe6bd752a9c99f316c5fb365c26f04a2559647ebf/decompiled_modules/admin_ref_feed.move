module 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::admin_ref_feed {
    struct AdminRefPriceUpdated has copy, drop {
        x_oracle: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        spot: u64,
        ema: u64,
        who: address,
        timestamp_ms: u64,
    }

    public fun admin_set_ref_price<T0>(arg0: &0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::AdminCap, arg1: &mut 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::admin_ref_feed_registry_mut(arg1);
        if (0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::asset_registry::has_asset<0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::AdminReference>(v2, v0)) {
            0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::update(0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::asset_registry::borrow_mut<0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::AdminReference>(v2, v0), arg2, arg3, v1);
        } else {
            0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::asset_registry::set<0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::AdminReference>(v2, v0, 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::new(arg2, arg3, v1));
        };
        let v3 = AdminRefPriceUpdated{
            x_oracle     : 0x2::object::id<0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle>(arg1),
            coin_type    : v0,
            spot         : arg2,
            ema          : arg3,
            who          : 0x2::tx_context::sender(arg5),
            timestamp_ms : v1,
        };
        0x2::event::emit<AdminRefPriceUpdated>(v3);
    }

    public fun refresh_admin_ref_price_feed<T0>(arg0: &0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg1: 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::update::OracleUpdateHotPotato<T0>) : 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::update::OracleUpdateHotPotato<T0> {
        0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::ensure_version_matches(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::admin_ref_feed_registry(arg0);
        assert!(0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::asset_registry::has_asset<0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::AdminReference>(v1, v0), 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::oracle_error::admin_ref_not_set());
        let v2 = 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::asset_registry::borrow<0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::AdminReference>(v1, v0);
        let v3 = 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::updated_at(v2) / 1000;
        0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::update::insert_price_feed<T0>(arg1, 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::asset::admin_ref_source(), 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::price_feed::new(0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::price_feed::new_component(0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::spot(v2), v3), 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::price_feed::new_component(0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::reference::ema(v2), v3)))
    }

    // decompiled from Move bytecode v6
}

