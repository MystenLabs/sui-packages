module 0x93b67b8ba9d95dfec993a64fb6efda9c81cbff1a9b8037d853a70606a2f8192d::router {
    struct StableKitchenRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun burn<T0, T1, T2>(arg0: &mut StableKitchenRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::vault::Vault<T1, T2>, arg3: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg4: 0x2::coin::Coin<T2>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T2>(arg1, &arg4);
        let v0 = 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::vault::burn<T1, T2>(arg2, arg3, arg4, arg5);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T1>(arg1, &arg0.id, 0x2::coin::value<T1>(&v0));
        v0
    }

    public fun mint<T0, T1, T2>(arg0: &mut StableKitchenRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::vault::Vault<T1, T2>, arg3: &0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::Config, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg4);
        let v0 = 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::vault::mint<T1, T2>(arg2, arg3, arg4, arg5);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut StableKitchenRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut StableKitchenRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StableKitchenRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<StableKitchenRouterWrapper>(v0);
    }

    // decompiled from Move bytecode v6
}

