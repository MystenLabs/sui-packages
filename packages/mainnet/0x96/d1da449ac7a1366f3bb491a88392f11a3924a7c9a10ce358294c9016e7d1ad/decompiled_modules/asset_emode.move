module 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::asset_emode {
    struct NewEModeBuilder<phantom T0, phantom T1> {
        group: u8,
        collateral_factor_bps: u64,
        liquidation_factor_bps: u64,
        liquidation_incentive_bps: u64,
        max_borrow_amount: u64,
        borrow_weight_bps: u64,
        flash_loan_fee_rate_bps: u64,
        deposit_limiter: 0x1::option::Option<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>,
        borrow_limiter: 0x1::option::Option<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>,
    }

    struct OnboardAssetToEmodeGroupWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        group: u8,
        params: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::NewEMode,
    }

    struct UpdateAssetInEmodeGroupWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        group: u8,
        params: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode::NewEMode,
    }

    public fun onboard_new_emode_group<T0>(arg0: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode_admin::onboard_new_emode_group<T0>(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun finalize_onboard_emode<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg2: NewEModeBuilder<T0, T1>, arg3: &mut 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(&arg2.deposit_limiter), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::missing_builder_field());
        assert!(0x1::option::is_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(&arg2.borrow_limiter), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::missing_builder_field());
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
            protocol_app_id : 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>>(arg1),
            group           : v0,
            params          : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode_admin::create_emode_params(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg3), arg0, v1, v2, v3, v4, v5, v6, 0x1::option::destroy_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(v7), 0x1::option::destroy_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(v8)),
        };
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::wish_event::emit_new_wish_event<OnboardAssetToEmodeGroupWish<T0, T1>>(v9);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::store_locked_update<0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::TimeLock<OnboardAssetToEmodeGroupWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish<T0, T1>>(), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::new_time_locked<OnboardAssetToEmodeGroupWish<T0, T1>>(v9, arg4, 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::time_lock_duration_seconds(arg3), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun finalize_update_emode<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg2: NewEModeBuilder<T0, T1>, arg3: &mut 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg4: &0x2::clock::Clock) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg3);
        assert!(0x1::option::is_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(&arg2.deposit_limiter), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::missing_builder_field());
        assert!(0x1::option::is_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(&arg2.borrow_limiter), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::missing_builder_field());
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
            protocol_app_id : 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp>(arg0),
            market_id       : 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>>(arg1),
            group           : v0,
            params          : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode_admin::create_emode_params(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg3), arg0, v1, v2, v3, v4, v5, v6, 0x1::option::destroy_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(v7), 0x1::option::destroy_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(v8)),
        };
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::wish_event::emit_new_wish_event<UpdateAssetInEmodeGroupWish<T0, T1>>(v9);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::store_locked_update<0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::TimeLock<UpdateAssetInEmodeGroupWish<T0, T1>>>(arg3, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish<T0, T1>>(), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::new_time_locked<UpdateAssetInEmodeGroupWish<T0, T1>>(v9, arg4, 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::time_lock_duration_seconds(arg3), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::time_lock_expriration_seconds(arg3)));
    }

    public fun fulfill_onboard_asset_to_emode_group_wish<T0, T1>(arg0: &mut 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::take_locked_update<0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::TimeLock<OnboardAssetToEmodeGroupWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish<T0, T1>>());
        assert!(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::is_active<OnboardAssetToEmodeGroupWish<T0, T1>>(&v0, arg3), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::time_locked_not_active());
        let v1 = 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::into_inner<OnboardAssetToEmodeGroupWish<T0, T1>>(v0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::wish_event::emit_fulfill_wish_event<OnboardAssetToEmodeGroupWish<T0, T1>>(v1);
        let OnboardAssetToEmodeGroupWish {
            protocol_app_id : _,
            market_id       : _,
            group           : v4,
            params          : v5,
        } = v1;
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode_admin::onboard_asset_to_emode_group<T0, T1>(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, arg4);
    }

    public fun fulfill_update_asset_in_emode_group_wish<T0, T1>(arg0: &mut 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::take_locked_update<0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::TimeLock<UpdateAssetInEmodeGroupWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish<T0, T1>>());
        assert!(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::is_active<UpdateAssetInEmodeGroupWish<T0, T1>>(&v0, arg3), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::time_locked_not_active());
        let v1 = 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::into_inner<UpdateAssetInEmodeGroupWish<T0, T1>>(v0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::wish_event::emit_fulfill_wish_event<UpdateAssetInEmodeGroupWish<T0, T1>>(v1);
        let UpdateAssetInEmodeGroupWish {
            protocol_app_id : _,
            market_id       : _,
            group           : v4,
            params          : v5,
        } = v1;
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode_admin::update_asset_in_emode_group<T0, T1>(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, arg4);
    }

    public fun start_creating_emode_params<T0, T1>(arg0: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) : NewEModeBuilder<T0, T1> {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
        NewEModeBuilder<T0, T1>{
            group                     : arg1,
            collateral_factor_bps     : arg2,
            liquidation_factor_bps    : arg3,
            liquidation_incentive_bps : arg4,
            max_borrow_amount         : arg5,
            borrow_weight_bps         : arg6,
            flash_loan_fee_rate_bps   : arg7,
            deposit_limiter           : 0x1::option::none<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(),
            borrow_limiter            : 0x1::option::none<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(),
        }
    }

    public fun with_borrow_limiter<T0, T1>(arg0: NewEModeBuilder<T0, T1>, arg1: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg3: u64, arg4: u32, arg5: u32) : NewEModeBuilder<T0, T1> {
        assert!(0x1::option::is_none<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(&arg0.borrow_limiter), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::duplicate_builder_call());
        arg0.borrow_limiter = 0x1::option::some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode_admin::create_limiter(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg1), arg2, arg3, arg4, arg5));
        arg0
    }

    public fun with_deposit_limiter<T0, T1>(arg0: NewEModeBuilder<T0, T1>, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg3: u64, arg4: u32, arg5: u32) : NewEModeBuilder<T0, T1> {
        assert!(0x1::option::is_none<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(&arg0.deposit_limiter), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::duplicate_builder_call());
        arg0.deposit_limiter = 0x1::option::some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::limiter::NewLimiter>(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::emode_admin::create_limiter(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg2), arg1, arg3, arg4, arg5));
        arg0
    }

    // decompiled from Move bytecode v6
}

