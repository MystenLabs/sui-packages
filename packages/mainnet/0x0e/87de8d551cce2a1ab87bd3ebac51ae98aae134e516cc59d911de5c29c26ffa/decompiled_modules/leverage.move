module 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::leverage {
    struct OnboardLeverageMarketWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::DragonBallCollector, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_can_summon_shenron(arg0);
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::take_locked_update<0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::time_lock::TimeLock<OnboardLeverageMarketWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish>());
        assert!(0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::time_lock::is_active<OnboardLeverageMarketWish>(&v0, arg2), 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::errors::time_locked_not_active());
        let OnboardLeverageMarketWish {
            market_type : v1,
            market_id   : v2,
            emode_group : v3,
        } = 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::time_lock::into_inner<OnboardLeverageMarketWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::errors::invalid_market_type());
        assert!(v2 == 0x2::object::id<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>>(arg1), 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::errors::invalid_market_id());
        0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_admin::onboard_market<T0>(0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::lending_admin_cap(arg0), arg1, v3, arg3);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::DragonBallCollector, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_can_summon_shenron(arg0);
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish{
            market_type : 0x1::type_name::with_defining_ids<T0>(),
            market_id   : 0x2::object::id<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::store_locked_update<0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::time_lock::TimeLock<OnboardLeverageMarketWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish>(), 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::time_lock::new_time_locked<OnboardLeverageMarketWish>(v0, arg3, 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::time_lock_duration_seconds(arg0), 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

