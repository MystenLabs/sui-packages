module 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &mut 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp, arg2: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::take_locked_update<0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg3), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::errors::time_locked_not_active());
        let v1 = 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>>(arg2), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::errors::invalid_market_id());
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_admin::onboard_market<T0>(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg0), arg1, arg2, v3, arg4);
    }

    public fun grant_leverage_app_permissions(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg2: &mut 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::whitelist_admin::mint_new_whitelist(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg0), arg1, arg3);
        let v1 = 0x2::object::id<0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::PackageCallerCap>(&v0);
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::whitelist_admin::update_permission(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg0), arg1, v1, 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::whitelist_admin::enter_market_with_emode(), true);
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::whitelist_admin::update_permission(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg0), arg1, v1, 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::whitelist_admin::flash_loan(), true);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_admin::inject_protocol_caller_cap(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg0), arg2, v0);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::store_locked_update<0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::time_lock_duration_seconds(arg0), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

