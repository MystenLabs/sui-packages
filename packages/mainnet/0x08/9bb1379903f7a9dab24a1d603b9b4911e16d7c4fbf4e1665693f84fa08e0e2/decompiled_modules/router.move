module 0x89bb1379903f7a9dab24a1d603b9b4911e16d7c4fbf4e1665693f84fa08e0e2::router {
    struct MetaStableRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun swap<T0, T1, T2, T3>(arg0: &mut MetaStableRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T1>, arg3: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::version::Version, arg4: 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::DepositCap<T1, T2>, arg5: 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::WithdrawCap<T1, T3>, arg6: 0x2::coin::Coin<T2>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T2>(arg1, &arg6);
        let v0 = 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::swap<T1, T2, T3>(arg2, arg3, arg4, arg5, arg6, 0, arg7);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T3>(arg1, &arg0.id, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut MetaStableRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut MetaStableRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun deposit<T0, T1, T2>(arg0: &mut MetaStableRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T1>, arg3: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::version::Version, arg4: 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::DepositCap<T1, T2>, arg5: 0x2::coin::Coin<T2>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T2>(arg1, &arg5);
        let v0 = 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::deposit<T1, T2>(arg2, arg3, arg4, arg5, 0, arg6);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T1>(arg1, &arg0.id, 0x2::coin::value<T1>(&v0));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaStableRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetaStableRouterWrapper>(v0);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut MetaStableRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T1>, arg3: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::version::Version, arg4: 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::WithdrawCap<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg5);
        let v0 = 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::withdraw<T1, T2>(arg2, arg3, arg4, arg5, 0, arg6);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

