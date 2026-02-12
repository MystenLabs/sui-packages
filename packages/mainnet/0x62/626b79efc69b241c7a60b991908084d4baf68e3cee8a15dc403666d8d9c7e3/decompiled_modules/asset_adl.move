module 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::asset_adl {
    struct EnableCollateralAdlWish<phantom T0, phantom T1> has copy, drop, store {
        params: 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::adl::DeleverageParams,
        seconds_from_now: u64,
    }

    struct EnableDebtAdlWish<phantom T0, phantom T1> has copy, drop, store {
        emode_group_id: u8,
        params: 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::adl::DeleverageParams,
        seconds_from_now: u64,
    }

    public fun cancel_collateral_adl<T0, T1>(arg0: &mut 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::DragonBallCollector, arg1: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::ProtocolApp, arg2: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_can_summon_shenron(arg0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::adl_admin::cancel_collateral_adl<T0, T1>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun cancel_debt_adl<T0, T1>(arg0: &mut 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::DragonBallCollector, arg1: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::ProtocolApp, arg2: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_can_summon_shenron(arg0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::adl_admin::cancel_debt_adl<T0, T1>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun fulfill_enable_collateral_adl_wish<T0, T1>(arg0: &mut 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::DragonBallCollector, arg1: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::ProtocolApp, arg2: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_can_summon_shenron(arg0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::take_locked_update<0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::TimeLock<EnableCollateralAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableCollateralAdlWish<T0, T1>>());
        assert!(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::is_active<EnableCollateralAdlWish<T0, T1>>(&v0, arg3), 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::errors::time_locked_not_active());
        let v1 = 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::into_inner<EnableCollateralAdlWish<T0, T1>>(v0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::wish_event::emit_fulfill_wish_event<EnableCollateralAdlWish<T0, T1>>(v1);
        let EnableCollateralAdlWish {
            params           : v2,
            seconds_from_now : v3,
        } = v1;
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::adl_admin::enable_collateral_adl<T0, T1>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::lending_admin_cap(arg0), arg1, arg2, v2, v3, arg3, arg4);
    }

    public fun fulfill_enable_debt_adl_wish<T0, T1>(arg0: &mut 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::DragonBallCollector, arg1: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::ProtocolApp, arg2: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_can_summon_shenron(arg0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::take_locked_update<0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::TimeLock<EnableDebtAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableDebtAdlWish<T0, T1>>());
        assert!(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::is_active<EnableDebtAdlWish<T0, T1>>(&v0, arg3), 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::errors::time_locked_not_active());
        let v1 = 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::into_inner<EnableDebtAdlWish<T0, T1>>(v0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::wish_event::emit_fulfill_wish_event<EnableDebtAdlWish<T0, T1>>(v1);
        let EnableDebtAdlWish {
            emode_group_id   : v2,
            params           : v3,
            seconds_from_now : v4,
        } = v1;
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::adl_admin::enable_debt_adl<T0, T1>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::lending_admin_cap(arg0), arg1, arg2, v2, v3, v4, arg3, arg4);
    }

    public fun wish_enable_collateral_adl<T0, T1>(arg0: &mut 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::DragonBallCollector, arg1: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg2: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_can_summon_shenron(arg0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg11));
        let v0 = EnableCollateralAdlWish<T0, T1>{
            params           : 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::adl_admin::new_adl_params<T0>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::lending_admin_cap(arg0), arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8),
            seconds_from_now : arg9,
        };
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::wish_event::emit_new_wish_event<EnableCollateralAdlWish<T0, T1>>(v0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::store_locked_update<0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::TimeLock<EnableCollateralAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableCollateralAdlWish<T0, T1>>(), 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::new_time_locked<EnableCollateralAdlWish<T0, T1>>(v0, arg10, 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::time_lock_duration_seconds(arg0), 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_enable_debt_adl<T0, T1>(arg0: &mut 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::DragonBallCollector, arg1: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg2: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::ProtocolApp, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_can_summon_shenron(arg0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg12));
        let v0 = EnableDebtAdlWish<T0, T1>{
            emode_group_id   : arg3,
            params           : 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::adl_admin::new_adl_params<T0>(0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::lending_admin_cap(arg0), arg2, arg1, arg4, arg5, arg6, arg7, arg8, arg9),
            seconds_from_now : arg10,
        };
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::wish_event::emit_new_wish_event<EnableDebtAdlWish<T0, T1>>(v0);
        0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::store_locked_update<0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::TimeLock<EnableDebtAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableDebtAdlWish<T0, T1>>(), 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::time_lock::new_time_locked<EnableDebtAdlWish<T0, T1>>(v0, arg11, 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::time_lock_duration_seconds(arg0), 0x62626b79efc69b241c7a60b991908084d4baf68e3cee8a15dc403666d8d9c7e3::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

