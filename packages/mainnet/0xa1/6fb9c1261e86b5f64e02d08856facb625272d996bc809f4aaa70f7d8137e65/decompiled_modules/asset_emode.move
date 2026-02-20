module 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::asset_emode {
    struct NewEModeBuilder<phantom T0, phantom T1> {
        group: u8,
        collateral_factor_bps: u64,
        liquidation_factor_bps: u64,
        liquidation_incentive_bps: u64,
        max_borrow_amount: u64,
        borrow_weight_bps: u64,
        flash_loan_fee_rate_bps: u64,
        deposit_limiter: 0x1::option::Option<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>,
        borrow_limiter: 0x1::option::Option<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>,
    }

    struct OnboardAssetToEmodeGroupWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        group: u8,
        params: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode::NewEMode,
    }

    struct UpdateAssetInEmodeGroupWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        group: u8,
        params: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode::NewEMode,
    }

    public fun finalize_onboard_emode<T0, T1>(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: NewEModeBuilder<T0, T1>, arg3: &mut 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(&arg2.deposit_limiter), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(&arg2.borrow_limiter), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::errors::missing_builder_field());
        let NewEModeBuilder {
            group                     : v0,
            collateral_factor_bps     : v1,
            liquidation_factor_bps    : v2,
            liquidation_incentive_bps : v3,
            max_borrow_amount         : v4,
            borrow_weight_bps         : v5,
            flash_loan_fee_rate_bps   : v6,
            deposit_limiter           : v7,
            borrow_limiter            : v8,
        } = arg2;
        let v9 = OnboardAssetToEmodeGroupWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1),
            group           : v0,
            params          : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode_admin::create_emode_params(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg3), arg0, v1, v2, v3, v4, v5, v6, 0x1::option::destroy_some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(v7), 0x1::option::destroy_some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(v8)),
        };
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::wish_event::emit_new_wish_event<OnboardAssetToEmodeGroupWish<T0, T1>>(v9);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::store_locked_update<0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::TimeLock<OnboardAssetToEmodeGroupWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish<T0, T1>>(), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::new_time_locked<OnboardAssetToEmodeGroupWish<T0, T1>>(v9, arg4, 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::time_lock_duration_seconds(arg3), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun finalize_update_emode<T0, T1>(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: NewEModeBuilder<T0, T1>, arg3: &mut 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(&arg2.deposit_limiter), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(&arg2.borrow_limiter), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::errors::missing_builder_field());
        let NewEModeBuilder {
            group                     : v0,
            collateral_factor_bps     : v1,
            liquidation_factor_bps    : v2,
            liquidation_incentive_bps : v3,
            max_borrow_amount         : v4,
            borrow_weight_bps         : v5,
            flash_loan_fee_rate_bps   : v6,
            deposit_limiter           : v7,
            borrow_limiter            : v8,
        } = arg2;
        let v9 = UpdateAssetInEmodeGroupWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1),
            group           : v0,
            params          : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode_admin::create_emode_params(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg3), arg0, v1, v2, v3, v4, v5, v6, 0x1::option::destroy_some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(v7), 0x1::option::destroy_some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(v8)),
        };
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::wish_event::emit_new_wish_event<UpdateAssetInEmodeGroupWish<T0, T1>>(v9);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::store_locked_update<0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::TimeLock<UpdateAssetInEmodeGroupWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish<T0, T1>>(), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::new_time_locked<UpdateAssetInEmodeGroupWish<T0, T1>>(v9, arg4, 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::time_lock_duration_seconds(arg3), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun fulfill_onboard_asset_to_emode_group_wish<T0, T1>(arg0: &mut 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::take_locked_update<0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::TimeLock<OnboardAssetToEmodeGroupWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish<T0, T1>>());
        assert!(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::is_active<OnboardAssetToEmodeGroupWish<T0, T1>>(&v0, arg3), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::errors::time_locked_not_active());
        let v1 = 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::into_inner<OnboardAssetToEmodeGroupWish<T0, T1>>(v0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::wish_event::emit_fulfill_wish_event<OnboardAssetToEmodeGroupWish<T0, T1>>(v1);
        let OnboardAssetToEmodeGroupWish {
            protocol_app_id : _,
            market_id       : _,
            group           : v4,
            params          : v5,
        } = v1;
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode_admin::onboard_asset_to_emode_group<T0, T1>(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, arg4);
    }

    public fun fulfill_update_asset_in_emode_group_wish<T0, T1>(arg0: &mut 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::take_locked_update<0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::TimeLock<UpdateAssetInEmodeGroupWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish<T0, T1>>());
        assert!(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::is_active<UpdateAssetInEmodeGroupWish<T0, T1>>(&v0, arg3), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::errors::time_locked_not_active());
        let v1 = 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::into_inner<UpdateAssetInEmodeGroupWish<T0, T1>>(v0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::wish_event::emit_fulfill_wish_event<UpdateAssetInEmodeGroupWish<T0, T1>>(v1);
        let UpdateAssetInEmodeGroupWish {
            protocol_app_id : _,
            market_id       : _,
            group           : v4,
            params          : v5,
        } = v1;
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode_admin::update_asset_in_emode_group<T0, T1>(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, arg4);
    }

    public fun onboard_new_emode_group<T0>(arg0: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode_admin::onboard_new_emode_group<T0>(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun start_creating_emode_params<T0, T1>(arg0: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) : NewEModeBuilder<T0, T1> {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
        NewEModeBuilder<T0, T1>{
            group                     : arg1,
            collateral_factor_bps     : arg2,
            liquidation_factor_bps    : arg3,
            liquidation_incentive_bps : arg4,
            max_borrow_amount         : arg5,
            borrow_weight_bps         : arg6,
            flash_loan_fee_rate_bps   : arg7,
            deposit_limiter           : 0x1::option::none<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(),
            borrow_limiter            : 0x1::option::none<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(),
        }
    }

    public fun with_borrow_limiter<T0, T1>(arg0: NewEModeBuilder<T0, T1>, arg1: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: u64, arg4: u32, arg5: u32) : NewEModeBuilder<T0, T1> {
        assert!(0x1::option::is_none<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(&arg0.borrow_limiter), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::errors::duplicate_builder_call());
        arg0.borrow_limiter = 0x1::option::some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode_admin::create_limiter(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5));
        arg0
    }

    public fun with_deposit_limiter<T0, T1>(arg0: NewEModeBuilder<T0, T1>, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg3: u64, arg4: u32, arg5: u32) : NewEModeBuilder<T0, T1> {
        assert!(0x1::option::is_none<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(&arg0.deposit_limiter), 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::errors::duplicate_builder_call());
        arg0.deposit_limiter = 0x1::option::some<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::limiter::NewLimiter>(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::emode_admin::create_limiter(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg2), arg1, arg3, arg4, arg5));
        arg0
    }

    // decompiled from Move bytecode v6
}

