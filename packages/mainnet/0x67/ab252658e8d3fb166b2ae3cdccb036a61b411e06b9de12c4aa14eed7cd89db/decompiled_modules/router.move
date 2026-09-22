module 0xcbb0d8b9f7a54348c3166dadd926db68ad3e1e68aabee4d594afafb9c1122517::router {
    struct PerpsplexityRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut PerpsplexityRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun buy_cash_w1<T0, T1, T2, T3, T4>(arg0: &mut PerpsplexityRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T3>, arg3: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::CompositePool<T4, T2, T3>, arg4: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg5: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T3>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T3>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T2, T3>, arg8: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg9: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::CashPrices<T3>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T4> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg2);
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::withdraw<T4, T2, T3>(arg3, arg4, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::buy_cash<T4, T2, T3>(arg3, arg4, arg7, arg5, arg6, arg8, 0x2::coin::from_balance<T3>(arg2, arg11), arg9, 0, 0x2::clock::timestamp_ms(arg10), arg10, arg11), arg10, arg11);
        let v2 = v1;
        let v3 = 0x2::coin::into_balance<T4>(v0);
        if (0x2::coin::value<T3>(&v2) == 0) {
            0x2::coin::destroy_zero<T3>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, 0x2::tx_context::sender(arg11));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T4>(arg1, &arg0.id, 0x2::balance::value<T4>(&v3));
        v3
    }

    public fun buy_composite_w1<T0, T1, T2, T3, T4>(arg0: &mut PerpsplexityRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T3>, arg3: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::CompositePool<T4, T2, T3>, arg4: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg5: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T2, T3>, arg6: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T3>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T3>, arg8: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T3>, arg9: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T2, T3>, arg10: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg11: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T2, T3>, arg12: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T3>, arg13: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T3>, arg14: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg15: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg16: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T3>, 0x2::balance::Balance<T4>) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg2);
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::buy<T4, T2, T3>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x2::coin::from_balance<T3>(arg2, arg18), 0, 0x2::clock::timestamp_ms(arg17), arg17, arg18);
        let (v2, v3) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::withdraw<T4, T2, T3>(arg3, arg4, v1, arg17, arg18);
        let v4 = v3;
        let v5 = 0x2::coin::into_balance<T4>(v2);
        if (0x2::coin::value<T3>(&v4) == 0) {
            0x2::coin::destroy_zero<T3>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v4, 0x2::tx_context::sender(arg18));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T4>(arg1, &arg0.id, 0x2::balance::value<T4>(&v5));
        (v0, v5)
    }

    public fun buy_w1<T0, T1, T2, T3>(arg0: &mut PerpsplexityRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T3, T2>, arg4: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::withdraw<T3, T2>(arg3, arg4, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::buy<T3, T2>(arg3, arg4, 0x2::coin::from_balance<T2>(arg2, arg6), 0, 18446744073709551615, arg5, arg6), arg5, arg6);
        let v2 = v1;
        let v3 = 0x2::coin::into_balance<T3>(v0);
        if (0x2::coin::value<T2>(&v2) == 0) {
            0x2::coin::destroy_zero<T2>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg6));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v3));
        v3
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut PerpsplexityRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PerpsplexityRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PerpsplexityRouterWrapper>(v0);
    }

    public fun sell_cash_w1<T0, T1, T2, T3, T4>(arg0: &mut PerpsplexityRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T3>, arg3: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::CompositePool<T3, T2, T4>, arg4: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg5: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T4>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T4>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T2, T4>, arg8: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg9: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg10: 0x1::option::Option<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::CashPrices<T4>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T4> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T4>(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::sell_cash<T3, T2, T4>(arg3, arg4, arg7, arg5, arg6, arg8, arg9, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::deposit<T3, T2, T4>(arg3, arg4, 0x2::coin::from_balance<T3>(arg2, arg12), arg11, arg12), arg10, false, false, 0, 0x2::clock::timestamp_ms(arg11), arg11, arg12));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T4>(arg1, &arg0.id, 0x2::balance::value<T4>(&v0));
        v0
    }

    public fun sell_composite_w1<T0, T1, T2, T3, T4>(arg0: &mut PerpsplexityRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T3>, arg3: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::CompositePool<T3, T2, T4>, arg4: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg5: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T2, T4>, arg6: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T4>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T4>, arg8: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T4>, arg9: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T2, T4>, arg10: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg11: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T2, T4>, arg12: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T4>, arg13: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T4>, arg14: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg15: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg16: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T4>, 0x2::balance::Balance<T4>) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg2);
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::sell<T3, T2, T4>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::deposit<T3, T2, T4>(arg3, arg4, 0x2::coin::from_balance<T3>(arg2, arg18), arg17, arg18), false, false, 0, 0x2::clock::timestamp_ms(arg17), arg17, arg18);
        let v2 = 0x2::coin::into_balance<T4>(v1);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T4>(arg1, &arg0.id, 0x2::balance::value<T4>(&v2));
        (v0, v2)
    }

    public fun sell_w1<T0, T1, T2, T3>(arg0: &mut PerpsplexityRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T2, T3>, arg4: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::sell<T2, T3>(arg3, arg4, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::deposit<T2, T3>(arg3, arg4, 0x2::coin::from_balance<T2>(arg2, arg6), arg5, arg6), 0, 18446744073709551615, arg5, arg6));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    // decompiled from Move bytecode v7
}

