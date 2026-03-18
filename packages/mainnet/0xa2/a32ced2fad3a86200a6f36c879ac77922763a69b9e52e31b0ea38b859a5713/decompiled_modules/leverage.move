module 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg2: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::take_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg3), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::time_locked_not_active());
        let v1 = 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(arg2), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::errors::invalid_market_id());
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_admin::onboard_market<T0>(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, arg2, v3, arg4);
    }

    public fun grant_leverage_app_permissions(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::whitelist_admin::mint_new_whitelist(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, arg3);
        let v1 = 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::PackageCallerCap>(&v0);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::whitelist_admin::update_permission(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, v1, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::whitelist_admin::enter_market_with_emode(), true);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::whitelist_admin::update_permission(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, v1, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::whitelist_admin::flash_loan(), true);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_admin::inject_protocol_caller_cap(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg2, v0);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::store_locked_update<0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_duration_seconds(arg0), 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

