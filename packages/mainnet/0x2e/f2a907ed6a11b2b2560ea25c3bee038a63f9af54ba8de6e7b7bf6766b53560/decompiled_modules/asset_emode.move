module 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::asset_emode {
    struct NewEModeBuilder<phantom T0, phantom T1> {
        group: u8,
        collateral_factor_bps: u64,
        liquidation_factor_bps: u64,
        liquidation_incentive_bps: u64,
        max_borrow_amount: u64,
        borrow_weight_bps: u64,
        flash_loan_fee_rate_bps: u64,
        deposit_limiter: 0x1::option::Option<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>,
        borrow_limiter: 0x1::option::Option<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>,
    }

    struct OnboardAssetToEmodeGroupWish<phantom T0, phantom T1> has copy, drop, store {
        group: u8,
        params: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode::NewEMode,
    }

    struct UpdateAssetInEmodeGroupWish<phantom T0, phantom T1> has copy, drop, store {
        group: u8,
        params: 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode::NewEMode,
    }

    public fun onboard_new_emode_group<T0>(arg0: &0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode_admin::onboard_new_emode_group<T0>(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun finalize_onboard_emode<T0, T1>(arg0: NewEModeBuilder<T0, T1>, arg1: &mut 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(&arg0.deposit_limiter), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(&arg0.borrow_limiter), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::missing_builder_field());
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
        } = arg0;
        let v9 = OnboardAssetToEmodeGroupWish<T0, T1>{
            group  : v0,
            params : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode_admin::create_emode_params(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg1), v1, v2, v3, v4, v5, v6, 0x1::option::destroy_some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(v7), 0x1::option::destroy_some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(v8)),
        };
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::wish_event::emit_new_wish_event<OnboardAssetToEmodeGroupWish<T0, T1>>(v9);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::store_locked_update<0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::TimeLock<OnboardAssetToEmodeGroupWish<T0, T1>>>(arg1, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish<T0, T1>>(), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::new_time_locked<OnboardAssetToEmodeGroupWish<T0, T1>>(v9, arg2, 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::time_lock_duration_seconds(arg1), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::time_lock_expriration_seconds(arg1)));
    }

    public fun finalize_update_emode<T0, T1>(arg0: NewEModeBuilder<T0, T1>, arg1: &mut 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg2: &0x2::clock::Clock) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg1);
        assert!(0x1::option::is_some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(&arg0.deposit_limiter), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::missing_builder_field());
        assert!(0x1::option::is_some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(&arg0.borrow_limiter), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::missing_builder_field());
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
        } = arg0;
        let v9 = UpdateAssetInEmodeGroupWish<T0, T1>{
            group  : v0,
            params : 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode_admin::create_emode_params(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg1), v1, v2, v3, v4, v5, v6, 0x1::option::destroy_some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(v7), 0x1::option::destroy_some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(v8)),
        };
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::wish_event::emit_new_wish_event<UpdateAssetInEmodeGroupWish<T0, T1>>(v9);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::store_locked_update<0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::TimeLock<UpdateAssetInEmodeGroupWish<T0, T1>>>(arg1, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish<T0, T1>>(), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::new_time_locked<UpdateAssetInEmodeGroupWish<T0, T1>>(v9, arg2, 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::time_lock_duration_seconds(arg1), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::time_lock_expriration_seconds(arg1)));
    }

    public fun fulfill_onboard_asset_to_emode_group_wish<T0, T1>(arg0: &mut 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::take_locked_update<0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::TimeLock<OnboardAssetToEmodeGroupWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<OnboardAssetToEmodeGroupWish<T0, T1>>());
        assert!(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::is_active<OnboardAssetToEmodeGroupWish<T0, T1>>(&v0, arg3), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::time_locked_not_active());
        let v1 = 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::into_inner<OnboardAssetToEmodeGroupWish<T0, T1>>(v0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::wish_event::emit_fulfill_wish_event<OnboardAssetToEmodeGroupWish<T0, T1>>(v1);
        let OnboardAssetToEmodeGroupWish {
            group  : v2,
            params : v3,
        } = v1;
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode_admin::onboard_asset_to_emode_group<T0, T1>(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg0), arg1, arg2, v2, v3, arg4);
    }

    public fun fulfill_update_asset_in_emode_group_wish<T0, T1>(arg0: &mut 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg1: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::app::ProtocolApp, arg2: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::take_locked_update<0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::TimeLock<UpdateAssetInEmodeGroupWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateAssetInEmodeGroupWish<T0, T1>>());
        assert!(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::is_active<UpdateAssetInEmodeGroupWish<T0, T1>>(&v0, arg3), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::time_locked_not_active());
        let v1 = 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::time_lock::into_inner<UpdateAssetInEmodeGroupWish<T0, T1>>(v0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::wish_event::emit_fulfill_wish_event<UpdateAssetInEmodeGroupWish<T0, T1>>(v1);
        let UpdateAssetInEmodeGroupWish {
            group  : v2,
            params : v3,
        } = v1;
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode_admin::update_asset_in_emode_group<T0, T1>(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg0), arg1, arg2, v2, v3, arg4);
    }

    public fun start_creating_emode_params<T0, T1>(arg0: &0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : NewEModeBuilder<T0, T1> {
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_can_summon_shenron(arg0);
        0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
        NewEModeBuilder<T0, T1>{
            group                     : arg1,
            collateral_factor_bps     : arg2,
            liquidation_factor_bps    : arg3,
            liquidation_incentive_bps : arg4,
            max_borrow_amount         : arg5,
            borrow_weight_bps         : arg6,
            flash_loan_fee_rate_bps   : arg7,
            deposit_limiter           : 0x1::option::none<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(),
            borrow_limiter            : 0x1::option::none<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(),
        }
    }

    public fun with_borrow_limiter<T0, T1>(arg0: NewEModeBuilder<T0, T1>, arg1: &0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg2: u64, arg3: u32, arg4: u32) : NewEModeBuilder<T0, T1> {
        assert!(0x1::option::is_none<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(&arg0.borrow_limiter), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::duplicate_builder_call());
        arg0.borrow_limiter = 0x1::option::some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode_admin::create_limiter(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg1), arg2, arg3, arg4));
        arg0
    }

    public fun with_deposit_limiter<T0, T1>(arg0: NewEModeBuilder<T0, T1>, arg1: &0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::DragonBallCollector, arg2: u64, arg3: u32, arg4: u32) : NewEModeBuilder<T0, T1> {
        assert!(0x1::option::is_none<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(&arg0.deposit_limiter), 0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::errors::duplicate_builder_call());
        arg0.deposit_limiter = 0x1::option::some<0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::limiter::NewLimiter>(0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::emode_admin::create_limiter(0x2ef2a907ed6a11b2b2560ea25c3bee038a63f9af54ba8de6e7b7bf6766b53560::governance::lending_admin_cap(arg1), arg2, arg3, arg4));
        arg0
    }

    // decompiled from Move bytecode v6
}

