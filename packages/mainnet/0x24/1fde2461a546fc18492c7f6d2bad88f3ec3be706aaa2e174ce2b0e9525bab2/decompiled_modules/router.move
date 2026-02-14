module 0x42005a3a3cc019e7af12830f92402655322c57e119a032b72f985617df4c9488::router {
    struct BlastFunRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun auction_dump<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::Auction, T1, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun auction_dump_ref<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::Auction, T1, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun auction_dump_ref_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::Auction, T2, T3>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::dump<T2, T3>(arg3, arg5, 0x2::coin::from_balance<T2>(arg2, arg6), 0x1::option::some<address>(@0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg6));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    public fun auction_dump_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::Auction, T2, T3>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::dump<T2, T3>(arg3, arg5, 0x2::coin::from_balance<T2>(arg2, arg6), 0x1::option::none<address>(), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg6));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    public fun auction_pump<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::Auction, T2, T1>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun auction_pump_ref<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::Auction, T2, T1>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun auction_pump_ref_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::Auction, T3, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let (v0, v1) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::pump<T3, T2>(arg3, arg5, 0x2::coin::from_balance<T2>(arg2, arg6), 0x1::option::some<address>(@0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777), 0x1::option::none<vector<u8>>(), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg6);
        let v2 = v0;
        let v3 = 0x2::coin::into_balance<T3>(v1);
        if (0x2::coin::value<T2>(&v2) == 0) {
            0x2::coin::destroy_zero<T2>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg6));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v3));
        v3
    }

    public fun auction_pump_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::Auction, T3, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let (v0, v1) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_auction::pump<T3, T2>(arg3, arg5, 0x2::coin::from_balance<T2>(arg2, arg6), 0x1::option::none<address>(), 0x1::option::none<vector<u8>>(), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg6);
        let v2 = v0;
        let v3 = 0x2::coin::into_balance<T3>(v1);
        if (0x2::coin::value<T2>(&v2) == 0) {
            0x2::coin::destroy_zero<T2>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg6));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v3));
        v3
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut BlastFunRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut BlastFunRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlastFunRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BlastFunRouterWrapper>(v0);
    }

    public fun pump_dump<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T1, T2>, arg4: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun pump_dump_ref<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T1, T2>, arg4: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun pump_dump_ref_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T2, T3>, arg4: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::dump<T2, T3>(arg3, arg4, 0x2::coin::from_balance<T2>(arg2, arg6), 0x1::option::some<address>(@0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777), 0, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg5), arg6));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    public fun pump_dump_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T2, T3>, arg4: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::dump<T2, T3>(arg3, arg4, 0x2::coin::from_balance<T2>(arg2, arg6), 0x1::option::none<address>(), 0, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg5), arg6));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    public fun pump_pump<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T2, T1>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun pump_pump_ref<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T2, T1>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun pump_pump_ref_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T3, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::pump<T3, T2>(arg3, 0x2::coin::from_balance<T2>(arg2, arg5), 0x1::option::some<address>(@0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777), 0x1::option::none<vector<u8>>(), 0, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg5));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    public fun pump_pump_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T3, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::pump<T3, T2>(arg3, 0x2::coin::from_balance<T2>(arg2, arg5), 0x1::option::none<address>(), 0x1::option::none<vector<u8>>(), 0, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg5));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    public fun stable_dump<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::Stable, T1, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun stable_dump_ref<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::Stable, T1, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun stable_dump_ref_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::Stable, T2, T3>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::dump<T2, T3>(arg3, 0x2::coin::from_balance<T2>(arg2, arg5), 0x1::option::some<address>(@0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg5));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    public fun stable_dump_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::Stable, T2, T3>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::dump<T2, T3>(arg3, 0x2::coin::from_balance<T2>(arg2, arg5), 0x1::option::none<address>(), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg5));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    public fun stable_pump<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::Stable, T2, T1>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun stable_pump_ref<T0, T1, T2>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::Stable, T2, T1>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun stable_pump_ref_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::Stable, T3, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let (v0, v1) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::pump<T3, T2>(arg3, 0x2::coin::from_balance<T2>(arg2, arg5), 0x1::option::some<address>(@0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777), 0x1::option::none<vector<u8>>(), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg5);
        let v2 = v0;
        let v3 = 0x2::coin::into_balance<T3>(v1);
        if (0x2::coin::value<T2>(&v2) == 0) {
            0x2::coin::destroy_zero<T2>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg5));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v3));
        v3
    }

    public fun stable_pump_w1<T0, T1, T2, T3>(arg0: &mut BlastFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::Stable, T3, T2>, arg4: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let (v0, v1) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_stable::pump<T3, T2>(arg3, 0x2::coin::from_balance<T2>(arg2, arg5), 0x1::option::none<address>(), 0x1::option::none<vector<u8>>(), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg4), arg5);
        let v2 = v0;
        let v3 = 0x2::coin::into_balance<T3>(v1);
        if (0x2::coin::value<T2>(&v2) == 0) {
            0x2::coin::destroy_zero<T2>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg5));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v3));
        v3
    }

    // decompiled from Move bytecode v6
}

