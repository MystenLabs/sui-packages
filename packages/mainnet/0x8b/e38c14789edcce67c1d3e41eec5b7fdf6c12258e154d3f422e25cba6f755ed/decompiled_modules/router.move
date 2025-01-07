module 0x8be38c14789edcce67c1d3e41eec5b7fdf6c12258e154d3f422e25cba6f755ed::router {
    struct SpringSuiRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut SpringSuiRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut SpringSuiRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpringSuiRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SpringSuiRouterWrapper>(v0);
    }

    public fun mint<T0, T1: drop>(arg0: &mut SpringSuiRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, 0x2::sui::SUI>(arg1, &arg4);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T1>(arg2, arg3, arg4, arg5);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T1>(arg1, &arg0.id, 0x2::coin::value<T1>(&v0));
        v0
    }

    public fun redeem<T0, T1: drop>(arg0: &mut SpringSuiRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg4);
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T1>(arg2, arg4, arg3, arg5);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, 0x2::sui::SUI>(arg1, &arg0.id, 0x2::coin::value<0x2::sui::SUI>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

