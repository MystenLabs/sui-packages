module 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp, arg2: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::take_locked_update<0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg3), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::time_locked_not_active());
        let v1 = 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>>(arg2), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::invalid_market_id());
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_admin::onboard_market<T0>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::lending_admin_cap(arg0), arg1, arg2, v3, arg4);
    }

    public fun grant_leverage_app_permissions(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg2: &mut 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::whitelist_admin::mint_new_whitelist(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::lending_admin_cap(arg0), arg1, arg3);
        let v1 = 0x2::object::id<0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::PackageCallerCap>(&v0);
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::whitelist_admin::update_permission(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::lending_admin_cap(arg0), arg1, v1, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::whitelist_admin::enter_market_with_emode(), true);
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::whitelist_admin::update_permission(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::lending_admin_cap(arg0), arg1, v1, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::whitelist_admin::flash_loan(), true);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_admin::inject_protocol_caller_cap(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::lending_admin_cap(arg0), arg2, v0);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::store_locked_update<0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::time_lock_duration_seconds(arg0), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v7
}

