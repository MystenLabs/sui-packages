module 0x320142ed28a3c062c73469539da556f9ae808e507a88d9e8b701cd7506a789a2::router {
    struct HopFunRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut HopFunRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun buy<T0, T1>(arg0: &mut HopFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T1>, arg3: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 426
    }

    public fun buy_w1<T0, T1, T2>(arg0: &mut HopFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T2>, arg3: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::tx_context::sender(arg5);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, 0x2::sui::SUI>(arg1, &arg4);
        let (v1, v2) = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy_returns<T2>(arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(arg4, arg5), 18446744073709551615, 0, v0, arg5);
        let v3 = v1;
        let v4 = 0x2::coin::into_balance<T2>(v2);
        if (0x2::coin::value<0x2::sui::SUI>(&v3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v0);
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T2>(arg1, &arg0.id, 0x2::balance::value<T2>(&v4));
        v4
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut HopFunRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HopFunRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<HopFunRouterWrapper>(v0);
    }

    public fun sell<T0, T1>(arg0: &mut HopFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T1>, arg3: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 426
    }

    public fun sell_w1<T0, T1, T2>(arg0: &mut HopFunRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T2>, arg3: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg4: 0x2::balance::Balance<T2>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg4);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T2>(arg2, arg3, 0x2::coin::from_balance<T2>(arg4, arg5), 0, arg5));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, 0x2::sui::SUI>(arg1, &arg0.id, 0x2::balance::value<0x2::sui::SUI>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

