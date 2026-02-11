module 0xe7d1887b231e909b719d6647074d041d0bd493ccb3bc35bcedb30144772f4274::router {
    struct StableKitchenRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun burn<T0, T1, T2>(arg0: &mut StableKitchenRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::Vault<T1, T2>, arg3: &0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::config::Config, arg4: 0x2::coin::Coin<T2>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 426
    }

    public fun mint<T0, T1, T2>(arg0: &mut StableKitchenRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::Vault<T1, T2>, arg3: &0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::config::Config, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut StableKitchenRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut StableKitchenRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun burn_w1<T0, T1, T2, T3>(arg0: &mut StableKitchenRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::Vault<T2, T3>, arg3: &0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::config::Config, arg4: 0x2::balance::Balance<T3>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg4);
        let v0 = 0x2::coin::into_balance<T2>(0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::burn<T2, T3>(arg2, arg3, 0x2::coin::from_balance<T3>(arg4, arg5), arg5));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T2>(arg1, &arg0.id, 0x2::balance::value<T2>(&v0));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StableKitchenRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<StableKitchenRouterWrapper>(v0);
    }

    public fun mint_w1<T0, T1, T2, T3>(arg0: &mut StableKitchenRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::Vault<T2, T3>, arg3: &0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::config::Config, arg4: 0x2::balance::Balance<T2>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg4);
        let v0 = 0x2::coin::into_balance<T3>(0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::vault::mint<T2, T3>(arg2, arg3, 0x2::coin::from_balance<T2>(arg4, arg5), arg5));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

