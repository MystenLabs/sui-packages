module 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::asset_adl {
    struct EnableCollateralAdlWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        params: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::adl::DeleverageParams,
        seconds_from_now: u64,
    }

    struct EnableDebtAdlWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        emode_group_id: u8,
        params: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::adl::DeleverageParams,
        seconds_from_now: u64,
    }

    public fun cancel_collateral_adl<T0, T1>(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::adl_admin::cancel_collateral_adl<T0, T1>(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun cancel_debt_adl<T0, T1>(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::adl_admin::cancel_debt_adl<T0, T1>(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun fulfill_enable_collateral_adl_wish<T0, T1>(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::take_locked_update<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<EnableCollateralAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableCollateralAdlWish<T0, T1>>());
        assert!(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::is_active<EnableCollateralAdlWish<T0, T1>>(&v0, arg3), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::errors::time_locked_not_active());
        let v1 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::into_inner<EnableCollateralAdlWish<T0, T1>>(v0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_fulfill_wish_event<EnableCollateralAdlWish<T0, T1>>(v1);
        let EnableCollateralAdlWish {
            protocol_app_id  : _,
            market_id        : _,
            params           : v4,
            seconds_from_now : v5,
        } = v1;
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::adl_admin::enable_collateral_adl<T0, T1>(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, arg3, arg4);
    }

    public fun fulfill_enable_debt_adl_wish<T0, T1>(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::take_locked_update<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<EnableDebtAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableDebtAdlWish<T0, T1>>());
        assert!(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::is_active<EnableDebtAdlWish<T0, T1>>(&v0, arg3), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::errors::time_locked_not_active());
        let v1 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::into_inner<EnableDebtAdlWish<T0, T1>>(v0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_fulfill_wish_event<EnableDebtAdlWish<T0, T1>>(v1);
        let EnableDebtAdlWish {
            protocol_app_id  : _,
            market_id        : _,
            emode_group_id   : v4,
            params           : v5,
            seconds_from_now : v6,
        } = v1;
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::adl_admin::enable_debt_adl<T0, T1>(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg1, arg2, v4, v5, v6, arg3, arg4);
    }

    public fun wish_enable_collateral_adl<T0, T1>(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg11));
        let v0 = EnableCollateralAdlWish<T0, T1>{
            protocol_app_id  : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp>(arg2),
            market_id        : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>>(arg1),
            params           : 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::adl_admin::new_adl_params<T0>(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8),
            seconds_from_now : arg9,
        };
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_new_wish_event<EnableCollateralAdlWish<T0, T1>>(v0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::store_locked_update<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<EnableCollateralAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableCollateralAdlWish<T0, T1>>(), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::new_time_locked<EnableCollateralAdlWish<T0, T1>>(v0, arg10, 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::time_lock_duration_seconds(arg0), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_enable_debt_adl<T0, T1>(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg12));
        let v0 = EnableDebtAdlWish<T0, T1>{
            protocol_app_id  : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp>(arg2),
            market_id        : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>>(arg1),
            emode_group_id   : arg3,
            params           : 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::adl_admin::new_adl_params<T0>(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg2, arg1, arg4, arg5, arg6, arg7, arg8, arg9),
            seconds_from_now : arg10,
        };
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_new_wish_event<EnableDebtAdlWish<T0, T1>>(v0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::store_locked_update<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<EnableDebtAdlWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<EnableDebtAdlWish<T0, T1>>(), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::new_time_locked<EnableDebtAdlWish<T0, T1>>(v0, arg11, 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::time_lock_duration_seconds(arg0), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

