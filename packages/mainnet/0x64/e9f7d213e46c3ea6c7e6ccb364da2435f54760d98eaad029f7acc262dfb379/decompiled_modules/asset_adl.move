module 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::asset_adl {
    struct EnableCollateralAdlWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        params: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::adl::DeleverageParams,
        seconds_from_now: u64,
    }

    struct EnableDebtAdlWish has copy, drop, store {
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        emode_group_id: u8,
        params: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::adl::DeleverageParams,
        seconds_from_now: u64,
    }

    public fun fulfill_enable_collateral_adl_wish<T0, T1>(arg0: &mut 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::take_locked_update<0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::TimeLock<EnableCollateralAdlWish>>(arg0, 0x1::type_name::with_defining_ids<EnableCollateralAdlWish>());
        assert!(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::is_active<EnableCollateralAdlWish>(&v0, arg3), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::time_locked_not_active());
        let EnableCollateralAdlWish {
            market_type      : v1,
            coin_type        : v2,
            params           : v3,
            seconds_from_now : v4,
        } = 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::into_inner<EnableCollateralAdlWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::invalid_coin_type());
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::adl_admin::enable_collateral_adl<T0, T1>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg0), arg1, arg2, v3, v4, arg3, arg4);
    }

    public fun fulfill_enable_debt_adl_wish<T0, T1>(arg0: &mut 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::take_locked_update<0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::TimeLock<EnableDebtAdlWish>>(arg0, 0x1::type_name::with_defining_ids<EnableDebtAdlWish>());
        assert!(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::is_active<EnableDebtAdlWish>(&v0, arg3), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::time_locked_not_active());
        let EnableDebtAdlWish {
            market_type      : v1,
            coin_type        : v2,
            emode_group_id   : v3,
            params           : v4,
            seconds_from_now : v5,
        } = 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::into_inner<EnableDebtAdlWish>(v0);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::invalid_market_type());
        assert!(v2 == 0x1::type_name::with_defining_ids<T1>(), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::errors::invalid_coin_type());
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::adl_admin::enable_debt_adl<T0, T1>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg0), arg1, arg2, v3, v4, v5, arg3, arg4);
    }

    public fun wish_enable_collateral_adl<T0, T1>(arg0: &mut 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg2: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg11));
        let v0 = EnableCollateralAdlWish{
            market_type      : 0x1::type_name::with_defining_ids<T0>(),
            coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            params           : 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::adl_admin::new_adl_params<T0>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg0), arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8),
            seconds_from_now : arg9,
        };
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::store_locked_update<0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::TimeLock<EnableCollateralAdlWish>>(arg0, 0x1::type_name::with_defining_ids<EnableCollateralAdlWish>(), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::new_time_locked<EnableCollateralAdlWish>(v0, arg10));
    }

    public fun wish_enable_debt_adl<T0, T1>(arg0: &mut 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg2: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg12));
        let v0 = EnableDebtAdlWish{
            market_type      : 0x1::type_name::with_defining_ids<T0>(),
            coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            emode_group_id   : arg3,
            params           : 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::adl_admin::new_adl_params<T0>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg0), arg2, arg1, arg4, arg5, arg6, arg7, arg8, arg9),
            seconds_from_now : arg10,
        };
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::store_locked_update<0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::TimeLock<EnableDebtAdlWish>>(arg0, 0x1::type_name::with_defining_ids<EnableDebtAdlWish>(), 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::new_time_locked<EnableDebtAdlWish>(v0, arg11));
    }

    // decompiled from Move bytecode v6
}

