module 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::leverage {
    struct OnboardLeverageMarketWish<phantom T0> has copy, drop, store {
        market_id: 0x2::object::ID,
        emode_group: u8,
    }

    public fun fulfill_onboard_leverage_market_wish<T0>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::take_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>());
        assert!(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::is_active<OnboardLeverageMarketWish<T0>>(&v0, arg3), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::time_locked_not_active());
        let v1 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::into_inner<OnboardLeverageMarketWish<T0>>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_fulfill_wish_event<OnboardLeverageMarketWish<T0>>(v1);
        let OnboardLeverageMarketWish {
            market_id   : v2,
            emode_group : v3,
        } = v1;
        assert!(v2 == 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg2), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::invalid_market_id());
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_admin::onboard_market<T0>(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::lending_admin_cap(arg0), arg1, arg2, v3, arg4);
    }

    public fun grant_leverage_app_permissions(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp, arg3: &mut 0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::whitelist_admin::mint_new_whitelist(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::lending_admin_cap(arg0), arg1, arg3);
        let v1 = 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::PackageCallerCap>(&v0);
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::whitelist_admin::update_permission(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::lending_admin_cap(arg0), arg1, v1, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::whitelist_admin::enter_market_with_emode(), true);
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::whitelist_admin::update_permission(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::lending_admin_cap(arg0), arg1, v1, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::whitelist_admin::flash_loan(), true);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_admin::inject_protocol_caller_cap(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::lending_admin_cap(arg0), arg2, v0);
    }

    public fun wish_onboard_leverage_market<T0>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = OnboardLeverageMarketWish<T0>{
            market_id   : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1),
            emode_group : arg2,
        };
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_new_wish_event<OnboardLeverageMarketWish<T0>>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::store_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<OnboardLeverageMarketWish<T0>>>(arg0, 0x1::type_name::with_defining_ids<OnboardLeverageMarketWish<T0>>(), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::new_time_locked<OnboardLeverageMarketWish<T0>>(v0, arg3, 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_duration_seconds(arg0), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

