module 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::asset_emode {
    struct NewEModeBuilder {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        group: u8,
        collateral_factor_bps: u64,
        liquidation_factor_bps: u64,
        liquidation_incentive_bps: u64,
        max_borrow_amount: u64,
        borrow_weight_bps: u64,
        flash_loan_fee_rate_bps: u64,
        deposit_limiter: 0x1::option::Option<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>,
        borrow_limiter: 0x1::option::Option<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>,
    }

    struct OnboardAssetToEmodeGroupWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        group: u8,
        params: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode::NewEMode,
    }

    struct UpdateAssetInEmodeGroupWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        group: u8,
        params: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode::NewEMode,
    }

    public fun finalize_onboard_emode(arg0: NewEModeBuilder, arg1: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(&arg0.deposit_limiter), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(&arg0.borrow_limiter), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::missing_builder_field());
        let NewEModeBuilder {
            market_type               : v0,
            coin_type                 : v1,
            group                     : v2,
            collateral_factor_bps     : v3,
            liquidation_factor_bps    : v4,
            liquidation_incentive_bps : v5,
            max_borrow_amount         : v6,
            borrow_weight_bps         : v7,
            flash_loan_fee_rate_bps   : v8,
            deposit_limiter           : v9,
            borrow_limiter            : v10,
        } = arg0;
        let v11 = OnboardAssetToEmodeGroupWish{
            market_type : v0,
            coin_type   : v1,
            group       : v2,
            params      : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode_admin::create_emode_params(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg1), v3, v4, v5, v6, v7, v8, 0x1::option::destroy_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(v9), 0x1::option::destroy_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(v10)),
        };
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::store_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<OnboardAssetToEmodeGroupWish>>(arg1, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::new_time_locked<OnboardAssetToEmodeGroupWish>(v11, arg2));
    }

    public fun finalize_update_emode(arg0: NewEModeBuilder, arg1: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(&arg0.deposit_limiter), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(&arg0.borrow_limiter), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::missing_builder_field());
        let NewEModeBuilder {
            market_type               : v0,
            coin_type                 : v1,
            group                     : v2,
            collateral_factor_bps     : v3,
            liquidation_factor_bps    : v4,
            liquidation_incentive_bps : v5,
            max_borrow_amount         : v6,
            borrow_weight_bps         : v7,
            flash_loan_fee_rate_bps   : v8,
            deposit_limiter           : v9,
            borrow_limiter            : v10,
        } = arg0;
        let v11 = UpdateAssetInEmodeGroupWish{
            market_type : v0,
            coin_type   : v1,
            group       : v2,
            params      : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode_admin::create_emode_params(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg1), v3, v4, v5, v6, v7, v8, 0x1::option::destroy_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(v9), 0x1::option::destroy_some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(v10)),
        };
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::store_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<UpdateAssetInEmodeGroupWish>>(arg1, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::new_time_locked<UpdateAssetInEmodeGroupWish>(v11, arg2));
    }

    public fun fulfill_onboard_asset_to_emode_group_wish<T0, T1>(arg0: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg2: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::take_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<OnboardAssetToEmodeGroupWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish>());
        assert!(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::is_active<OnboardAssetToEmodeGroupWish>(&v0, arg3), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::time_locked_not_active());
        let OnboardAssetToEmodeGroupWish {
            market_type : v1,
            coin_type   : v2,
            group       : v3,
            params      : v4,
        } = 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::into_inner<OnboardAssetToEmodeGroupWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_coin_type());
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode_admin::onboard_asset_to_emode_group<T0, T1>(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg0), arg1, arg2, v3, v4, arg4);
    }

    public fun fulfill_update_asset_in_emode_group_wish<T0, T1>(arg0: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg2: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::take_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<UpdateAssetInEmodeGroupWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish>());
        assert!(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::is_active<UpdateAssetInEmodeGroupWish>(&v0, arg3), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::time_locked_not_active());
        let UpdateAssetInEmodeGroupWish {
            market_type : v1,
            coin_type   : v2,
            group       : v3,
            params      : v4,
        } = 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::into_inner<UpdateAssetInEmodeGroupWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::invalid_coin_type());
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode_admin::update_asset_in_emode_group<T0, T1>(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg0), arg1, arg2, v3, v4, arg4);
    }

    public fun onboard_new_emode_group<T0>(arg0: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg2: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode_admin::onboard_new_emode_group<T0>(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun start_creating_emode_params<T0, T1>(arg0: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : NewEModeBuilder {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_can_summon_shenron(arg0);
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
        NewEModeBuilder{
            market_type               : 0x1::type_name::with_defining_ids<T0>(),
            coin_type                 : 0x1::type_name::with_defining_ids<T1>(),
            group                     : arg1,
            collateral_factor_bps     : arg2,
            liquidation_factor_bps    : arg3,
            liquidation_incentive_bps : arg4,
            max_borrow_amount         : arg5,
            borrow_weight_bps         : arg6,
            flash_loan_fee_rate_bps   : arg7,
            deposit_limiter           : 0x1::option::none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(),
            borrow_limiter            : 0x1::option::none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(),
        }
    }

    public fun with_borrow_limiter(arg0: NewEModeBuilder, arg1: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg2: u64, arg3: u32, arg4: u32) : NewEModeBuilder {
        assert!(0x1::option::is_none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(&arg0.borrow_limiter), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::duplicate_builder_call());
        arg0.borrow_limiter = 0x1::option::some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode_admin::create_limiter(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg1), arg2, arg3, arg4));
        arg0
    }

    public fun with_deposit_limiter(arg0: NewEModeBuilder, arg1: &0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg2: u64, arg3: u32, arg4: u32) : NewEModeBuilder {
        assert!(0x1::option::is_none<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(&arg0.deposit_limiter), 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::errors::duplicate_builder_call());
        arg0.deposit_limiter = 0x1::option::some<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::limiter::NewLimiter>(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode_admin::create_limiter(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::lending_admin_cap(arg1), arg2, arg3, arg4));
        arg0
    }

    // decompiled from Move bytecode v6
}

