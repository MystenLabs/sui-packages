module 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::asset_adl {
    struct EnableCollateralAdlWish<phantom T0, phantom T1> has copy, drop, store {
        params: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::adl::DeleverageParams,
        seconds_from_now: u64,
    }

    struct EnableDebtAdlWish<phantom T0, phantom T1> has copy, drop, store {
        emode_group_id: u8,
        params: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::adl::DeleverageParams,
        seconds_from_now: u64,
    }

    public fun fulfill_enable_collateral_adl_wish<T0, T1>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg2: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::take_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<EnableCollateralAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableCollateralAdlWish<T0, T1>>());
        assert!(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::is_active<EnableCollateralAdlWish<T0, T1>>(&v0, arg3), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::errors::time_locked_not_active());
        let v1 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::into_inner<EnableCollateralAdlWish<T0, T1>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_fulfill_wish_event<EnableCollateralAdlWish<T0, T1>>(v1);
        let EnableCollateralAdlWish {
            params           : v2,
            seconds_from_now : v3,
        } = v1;
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::adl_admin::enable_collateral_adl<T0, T1>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2, v2, v3, arg3, arg4);
    }

    public fun fulfill_enable_debt_adl_wish<T0, T1>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg2: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::take_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<EnableDebtAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableDebtAdlWish<T0, T1>>());
        assert!(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::is_active<EnableDebtAdlWish<T0, T1>>(&v0, arg3), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::errors::time_locked_not_active());
        let v1 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::into_inner<EnableDebtAdlWish<T0, T1>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_fulfill_wish_event<EnableDebtAdlWish<T0, T1>>(v1);
        let EnableDebtAdlWish {
            emode_group_id   : v2,
            params           : v3,
            seconds_from_now : v4,
        } = v1;
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::adl_admin::enable_debt_adl<T0, T1>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2, v2, v3, v4, arg3, arg4);
    }

    public fun wish_enable_collateral_adl<T0, T1>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg2: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg11));
        let v0 = EnableCollateralAdlWish<T0, T1>{
            params           : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::adl_admin::new_adl_params<T0>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8),
            seconds_from_now : arg9,
        };
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_new_wish_event<EnableCollateralAdlWish<T0, T1>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::store_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<EnableCollateralAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableCollateralAdlWish<T0, T1>>(), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::new_time_locked<EnableCollateralAdlWish<T0, T1>>(v0, arg10, 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::time_lock_duration_seconds(arg0), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_enable_debt_adl<T0, T1>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg2: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg12));
        let v0 = EnableDebtAdlWish<T0, T1>{
            emode_group_id   : arg3,
            params           : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::adl_admin::new_adl_params<T0>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg2, arg1, arg4, arg5, arg6, arg7, arg8, arg9),
            seconds_from_now : arg10,
        };
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_new_wish_event<EnableDebtAdlWish<T0, T1>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::store_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<EnableDebtAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableDebtAdlWish<T0, T1>>(), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::new_time_locked<EnableDebtAdlWish<T0, T1>>(v0, arg11, 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::time_lock_duration_seconds(arg0), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

