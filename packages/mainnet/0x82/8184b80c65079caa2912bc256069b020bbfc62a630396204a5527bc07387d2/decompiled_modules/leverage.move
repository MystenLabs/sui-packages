module 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &mut 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_app::LeverageApp, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::take_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg3), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::time_locked_not_active());
        let v1 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>>(arg2), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::invalid_market_id());
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_admin::onboard_market<T0>(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg2, v3, arg4);
    }

    public fun grant_leverage_app_permissions(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::whitelist_admin::mint_new_whitelist(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, arg3);
        let v1 = 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::PackageCallerCap>(&v0);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::whitelist_admin::update_permission(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, v1, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::whitelist_admin::enter_market_with_emode(), true);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::whitelist_admin::update_permission(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg1, v1, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::whitelist_admin::flash_loan(), true);
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_admin::inject_protocol_caller_cap(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::lending_admin_cap(arg0), arg2, v0);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::store_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_duration_seconds(arg0), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

