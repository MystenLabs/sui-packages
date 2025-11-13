module 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::asset_emode {
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
        deposit_limiter: 0x1::option::Option<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>,
        borrow_limiter: 0x1::option::Option<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>,
    }

    struct OnboardAssetToEmodeGroupWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        group: u8,
        params: 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode::NewEMode,
    }

    struct UpdateAssetInEmodeGroupWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        group: u8,
        params: 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode::NewEMode,
    }

    public fun finalize_onboard_emode(arg0: NewEModeBuilder, arg1: &mut 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(&arg0.deposit_limiter), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(&arg0.borrow_limiter), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::missing_builder_field());
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
            params      : 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode_admin::create_emode_params(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg1), v3, v4, v5, v6, v7, v8, 0x1::option::destroy_some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(v9), 0x1::option::destroy_some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(v10)),
        };
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::store_locked_update<0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::TimeLock<OnboardAssetToEmodeGroupWish>>(arg1, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish>(), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::new_time_locked<OnboardAssetToEmodeGroupWish>(v11, arg2, 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::time_lock_duration_seconds(arg1), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::time_lock_expriration_seconds(arg1)));
    }

    public fun finalize_update_emode(arg0: NewEModeBuilder, arg1: &mut 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(&arg0.deposit_limiter), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(&arg0.borrow_limiter), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::missing_builder_field());
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
            params      : 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode_admin::create_emode_params(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg1), v3, v4, v5, v6, v7, v8, 0x1::option::destroy_some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(v9), 0x1::option::destroy_some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(v10)),
        };
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::store_locked_update<0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::TimeLock<UpdateAssetInEmodeGroupWish>>(arg1, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish>(), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::new_time_locked<UpdateAssetInEmodeGroupWish>(v11, arg2, 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::time_lock_duration_seconds(arg1), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::time_lock_expriration_seconds(arg1)));
    }

    public fun fulfill_onboard_asset_to_emode_group_wish<T0, T1>(arg0: &mut 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg1: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::ProtocolApp, arg2: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_can_summon_shenron(arg0);
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::take_locked_update<0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::TimeLock<OnboardAssetToEmodeGroupWish>>(arg0, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish>());
        assert!(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::is_active<OnboardAssetToEmodeGroupWish>(&v0, arg3), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::time_locked_not_active());
        let OnboardAssetToEmodeGroupWish {
            market_type : v1,
            coin_type   : v2,
            group       : v3,
            params      : v4,
        } = 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::into_inner<OnboardAssetToEmodeGroupWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::invalid_coin_type());
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode_admin::onboard_asset_to_emode_group<T0, T1>(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg0), arg1, arg2, v3, v4, arg4);
    }

    public fun fulfill_update_asset_in_emode_group_wish<T0, T1>(arg0: &mut 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg1: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::ProtocolApp, arg2: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_can_summon_shenron(arg0);
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::take_locked_update<0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::TimeLock<UpdateAssetInEmodeGroupWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish>());
        assert!(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::is_active<UpdateAssetInEmodeGroupWish>(&v0, arg3), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::time_locked_not_active());
        let UpdateAssetInEmodeGroupWish {
            market_type : v1,
            coin_type   : v2,
            group       : v3,
            params      : v4,
        } = 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::into_inner<UpdateAssetInEmodeGroupWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::invalid_coin_type());
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode_admin::update_asset_in_emode_group<T0, T1>(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg0), arg1, arg2, v3, v4, arg4);
    }

    public fun onboard_new_emode_group<T0>(arg0: &0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg1: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::ProtocolApp, arg2: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_can_summon_shenron(arg0);
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode_admin::onboard_new_emode_group<T0>(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun start_creating_emode_params<T0, T1>(arg0: &0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : NewEModeBuilder {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_can_summon_shenron(arg0);
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
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
            deposit_limiter           : 0x1::option::none<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(),
            borrow_limiter            : 0x1::option::none<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(),
        }
    }

    public fun with_borrow_limiter(arg0: NewEModeBuilder, arg1: &0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg2: u64, arg3: u32, arg4: u32) : NewEModeBuilder {
        assert!(0x1::option::is_none<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(&arg0.borrow_limiter), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::duplicate_builder_call());
        arg0.borrow_limiter = 0x1::option::some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode_admin::create_limiter(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg1), arg2, arg3, arg4));
        arg0
    }

    public fun with_deposit_limiter(arg0: NewEModeBuilder, arg1: &0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg2: u64, arg3: u32, arg4: u32) : NewEModeBuilder {
        assert!(0x1::option::is_none<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(&arg0.deposit_limiter), 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::errors::duplicate_builder_call());
        arg0.deposit_limiter = 0x1::option::some<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::limiter::NewLimiter>(0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::emode_admin::create_limiter(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg1), arg2, arg3, arg4));
        arg0
    }

    // decompiled from Move bytecode v6
}

