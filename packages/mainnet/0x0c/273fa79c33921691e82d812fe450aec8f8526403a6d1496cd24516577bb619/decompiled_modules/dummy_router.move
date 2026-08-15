module 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::dummy_router {
    struct Router<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance_manager_id: 0x2::object::ID,
        deepbook_pool_id: 0x2::object::ID,
        momentum_pool_id: 0x2::object::ID,
        momentum_version_id: 0x2::object::ID,
        cetus_config_id: 0x2::object::ID,
        cetus_low_pool_id: 0x2::object::ID,
        cetus_high_pool_id: 0x2::object::ID,
        bluefin_config_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        clip_base_raw: u64,
        margin_bps: u64,
        gate_bps: u64,
        gate_window_ms: u64,
        maximum_signal_age_ms: u64,
        maximum_sqrt_move_bps_e4: u64,
        inventory_target_base_raw: u64,
        inventory_guard_base_raw: u64,
        maximum_executions: u64,
        execution_count: u64,
        last_sequence: u64,
        paused: bool,
    }

    struct RouterCreated<phantom T0, phantom T1> has copy, drop {
        router_id: 0x2::object::ID,
        owner: address,
        balance_manager_id: 0x2::object::ID,
        clip_base_raw: u64,
        margin_bps: u64,
        gate_bps: u64,
        gate_window_ms: u64,
        maximum_executions: u64,
    }

    struct VenueQuoteEvaluated<phantom T0, phantom T1> has copy, drop {
        sequence: u64,
        route: u8,
        direction: u8,
        complete: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount_input: u64,
        execution_price_raw: u64,
        adverse_slippage_bps_e4: u64,
        margin_bps: u64,
    }

    struct SignalEvaluated<phantom T0, phantom T1> has copy, drop {
        router_id: 0x2::object::ID,
        sequence: u64,
        anchor_price_raw: u64,
        current_price_raw: u64,
        anchor_source_timestamp_ms: u64,
        current_source_timestamp_ms: u64,
        move_bps_e4: u64,
        direction: u8,
        gate_passed: bool,
        fair_quote_raw: u64,
        buy_max_quote_raw: u64,
        sell_min_quote_raw: u64,
        selected_route: u8,
        selected_amount_in: u64,
        selected_amount_out: u64,
        selected_fee_amount_input: u64,
        selected_surplus_quote_raw: u64,
        executed: bool,
        execution_count: u64,
    }

    struct MarkoutEvaluated<phantom T0, phantom T1> has copy, drop {
        router_id: 0x2::object::ID,
        sequence: u64,
        source_timestamp_ms: u64,
        direction: u8,
        current_touch_price_raw: u64,
        target_price_raw: u64,
        predicted_markout_bps_e4: u64,
        entry_markout_bps_e4: u64,
        clip_base_raw: u64,
        fair_quote_raw: u64,
        buy_max_quote_raw: u64,
        sell_min_quote_raw: u64,
        selected_route: u8,
        selected_amount_in: u64,
        selected_amount_out: u64,
        selected_fee_amount_input: u64,
        selected_surplus_quote_raw: u64,
        executed: bool,
        execution_count: u64,
    }

    struct SignalDiscarded<phantom T0, phantom T1> has copy, drop {
        router_id: 0x2::object::ID,
        sequence: u64,
        signal_timestamp_ms: u64,
        latest_offchain_timestamp_ms: u64,
        chain_timestamp_ms: u64,
    }

    struct U0<phantom T0, phantom T1> has copy, drop {
        r: 0x2::object::ID,
        k: 0x2::object::ID,
        n: u64,
        z: u64,
        x0: u8,
        x1: u64,
        x2: u64,
        x3: u64,
        x4: u64,
    }

    public fun apply<T0, T1>(arg0: &mut Router<T0, T1>, arg1: &mut 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::Kernel<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg15);
        assert!(!arg0.paused, 5);
        assert_objects<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::bind<T0, T1>(arg1, arg2, arg3, arg15);
        if (!is_newer_signal_timestamp(arg0.last_sequence, arg13)) {
            let v0 = U0<T0, T1>{
                r  : 0x2::object::id<Router<T0, T1>>(arg0),
                k  : 0x2::object::id<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::Kernel<T0, T1>>(arg1),
                n  : arg11,
                z  : 1,
                x0 : 0,
                x1 : 0,
                x2 : 0,
                x3 : 0,
                x4 : 0,
            };
            0x2::event::emit<U0<T0, T1>>(v0);
            return
        };
        validate_signal_freshness(arg13, arg0.maximum_signal_age_ms, 0x2::clock::timestamp_ms(arg14));
        let v1 = unpack(arg11, arg12, arg13);
        assert!(v1 > 0, 7);
        arg0.last_sequence = arg13;
        let (_, v3, _, _, v6, _, v8) = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::peek<T0, T1>(arg1, arg2, arg3, arg14);
        let (v9, v10) = target_state(v1, v3, v6, v8);
        let (v11, v12, v13, v14, v15) = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::params<T0, T1>(arg1);
        assert!(v10 <= v15, 7);
        let v16 = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::conviction_clip(v10, v11, v12, arg0.clip_base_raw, v13, v14);
        let v17 = if (v9 != 0) {
            if (v16 > 0) {
                arg0.execution_count < arg0.maximum_executions
            } else {
                false
            }
        } else {
            false
        };
        if (v17) {
            0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::trim<T0, T1>(arg1, arg2, arg3, v9, arg14, arg15);
        };
        let (v18, v19, v20, v21, v22, v23) = if (v17) {
            let v24 = fair_quote_for_clip(v1, v16, true);
            let v25 = mul_div_down(v24, 10000 - arg0.margin_bps, 10000);
            let v26 = mul_div_up(v24, 10000 + arg0.margin_bps, 10000);
            quote_and_execute_markout<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v9, v1, v16, v25, v26, false, arg14, arg15)
        } else {
            (0, 0, 0, 0, 0, false)
        };
        let (_, _, _) = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::apply<T0, T1>(arg1, arg2, arg3, arg11, arg13, v1, v9, v10, v23, arg14, arg15);
        if (v23) {
            let v30 = U0<T0, T1>{
                r  : 0x2::object::id<Router<T0, T1>>(arg0),
                k  : 0x2::object::id<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel::Kernel<T0, T1>>(arg1),
                n  : arg11,
                z  : 2,
                x0 : v18,
                x1 : v19,
                x2 : v20,
                x3 : v21,
                x4 : v22,
            };
            0x2::event::emit<U0<T0, T1>>(v30);
        };
    }

    fun assert_balance_delta<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0);
        if (arg1 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::buy_base_side()) {
            let v2 = if (arg5 >= arg2) {
                if (arg5 - arg2 == v1) {
                    if (v0 >= arg4) {
                        v0 - arg4 >= arg3
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v2, 6);
        } else {
            let v3 = if (arg4 >= arg2) {
                if (arg4 - arg2 == v0) {
                    if (v1 >= arg5) {
                        v1 - arg5 >= arg3
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 6);
        };
    }

    fun assert_objects<T0, T1>(arg0: &Router<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        let v0 = if (arg0.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2)) {
            if (arg0.deepbook_pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1)) {
                if (arg0.momentum_pool_id == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3)) {
                    if (arg0.momentum_version_id == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg4)) {
                        if (arg0.cetus_config_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5)) {
                            if (arg0.cetus_low_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg6)) {
                                if (arg0.cetus_high_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg7)) {
                                    if (arg0.bluefin_config_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg8)) {
                                        arg0.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg9)
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
    }

    fun assert_owner<T0, T1>(arg0: &Router<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
    }

    public fun create<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) : Router<T0, T1> {
        validate_configuration(arg9, arg10, arg11, arg12, arg13, arg14, arg16, arg17);
        let v0 = 0x2::tx_context::sender(arg18);
        let v1 = Router<T0, T1>{
            id                        : 0x2::object::new(arg18),
            owner                     : v0,
            balance_manager_id        : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg0),
            deepbook_pool_id          : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            momentum_pool_id          : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2),
            momentum_version_id       : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg3),
            cetus_config_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg4),
            cetus_low_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5),
            cetus_high_pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg6),
            bluefin_config_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg7),
            bluefin_pool_id           : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg8),
            clip_base_raw             : arg9,
            margin_bps                : arg10,
            gate_bps                  : arg11,
            gate_window_ms            : arg12,
            maximum_signal_age_ms     : arg13,
            maximum_sqrt_move_bps_e4  : arg14,
            inventory_target_base_raw : arg15,
            inventory_guard_base_raw  : arg16,
            maximum_executions        : arg17,
            execution_count           : 0,
            last_sequence             : 0,
            paused                    : false,
        };
        let v2 = RouterCreated<T0, T1>{
            router_id          : 0x2::object::id<Router<T0, T1>>(&v1),
            owner              : v0,
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg0),
            clip_base_raw      : arg9,
            margin_bps         : arg10,
            gate_bps           : arg11,
            gate_window_ms     : arg12,
            maximum_executions : arg17,
        };
        0x2::event::emit<RouterCreated<T0, T1>>(v2);
        v1
    }

    public fun create_shared<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Router<T0, T1>>(create<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18));
    }

    fun emit_candidate_quotes<T0, T1>(arg0: &vector<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(arg0)) {
            let (v1, v2, v3, v4, v5, _, v7) = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::taker_quote_values(0x1::vector::borrow<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(arg0, v0));
            let v8 = if (v1 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::deepbook_route()) {
                v3 + v5
            } else {
                v3
            };
            let v9 = if (v1 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::deepbook_route() && v4 > v5) {
                v4 - v5
            } else {
                v4
            };
            let v10 = if (!v7) {
                true
            } else if (v8 == 0) {
                true
            } else {
                v9 == 0
            };
            let v11 = if (v10) {
                0
            } else if (v2 == 1) {
                ratio_scaled(v8, v4, 1000000000, true)
            } else {
                ratio_scaled(v9, v3, 1000000000, false)
            };
            let v12 = if (v2 == 1 && v11 > arg2) {
                v11 - arg2
            } else {
                let v13 = if (v2 == 2) {
                    if (v11 > 0) {
                        v11 < arg2
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v13) {
                    arg2 - v11
                } else {
                    0
                }
            };
            let v14 = if (v12 == 0) {
                0
            } else {
                ratio_scaled(v12, arg2, 100000000, true)
            };
            let v15 = VenueQuoteEvaluated<T0, T1>{
                sequence                : arg1,
                route                   : v1,
                direction               : v2,
                complete                : v7,
                amount_in               : v3,
                amount_out              : v4,
                fee_amount_input        : v5,
                execution_price_raw     : v11,
                adverse_slippage_bps_e4 : v14,
                margin_bps              : arg3,
            };
            0x2::event::emit<VenueQuoteEvaluated<T0, T1>>(v15);
            v0 = v0 + 1;
        };
    }

    fun emit_markout<T0, T1>(arg0: &Router<T0, T1>, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: bool) {
        let v0 = MarkoutEvaluated<T0, T1>{
            router_id                  : 0x2::object::id<Router<T0, T1>>(arg0),
            sequence                   : arg1,
            source_timestamp_ms        : arg2,
            direction                  : arg3,
            current_touch_price_raw    : arg4,
            target_price_raw           : arg5,
            predicted_markout_bps_e4   : arg6,
            entry_markout_bps_e4       : arg7,
            clip_base_raw              : arg8,
            fair_quote_raw             : arg9,
            buy_max_quote_raw          : arg10,
            sell_min_quote_raw         : arg11,
            selected_route             : arg12,
            selected_amount_in         : arg13,
            selected_amount_out        : arg14,
            selected_fee_amount_input  : arg15,
            selected_surplus_quote_raw : arg16,
            executed                   : arg17,
            execution_count            : arg0.execution_count,
        };
        0x2::event::emit<MarkoutEvaluated<T0, T1>>(v0);
    }

    fun emit_signal<T0, T1>(arg0: &Router<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: bool) {
        let v0 = SignalEvaluated<T0, T1>{
            router_id                   : 0x2::object::id<Router<T0, T1>>(arg0),
            sequence                    : arg1,
            anchor_price_raw            : arg2,
            current_price_raw           : arg3,
            anchor_source_timestamp_ms  : arg4,
            current_source_timestamp_ms : arg5,
            move_bps_e4                 : arg6,
            direction                   : arg7,
            gate_passed                 : arg8,
            fair_quote_raw              : arg9,
            buy_max_quote_raw           : arg10,
            sell_min_quote_raw          : arg11,
            selected_route              : arg12,
            selected_amount_in          : arg13,
            selected_amount_out         : arg14,
            selected_fee_amount_input   : arg15,
            selected_surplus_quote_raw  : arg16,
            executed                    : arg17,
            execution_count             : arg0.execution_count,
        };
        0x2::event::emit<SignalEvaluated<T0, T1>>(v0);
    }

    fun execute_selected<T0, T1>(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg13: u64, arg14: u64, arg15: u64, arg16: u128, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::buy_base_side();
        assert!(v0 || arg1 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::sell_base_side(), 7);
        if (arg0 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::deepbook_route()) {
            assert!(arg16 <= 18446744073709551615, 7);
            0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::deepbook_limit<T0, T1>(arg4, arg5, arg2, arg3, v0, (arg16 as u64), arg14, arg15, arg17, arg18);
        } else if (arg0 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::momentum_route()) {
            if (v0) {
                0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::momentum_buy_base<T0, T1>(arg5, arg6, arg7, arg13, arg14, arg15, arg16, arg17, arg18);
            } else {
                0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::momentum_sell_base<T0, T1>(arg5, arg6, arg7, arg13, arg14, arg15, arg16, arg17, arg18);
            };
        } else if (arg0 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_low_route()) {
            if (v0) {
                0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::cetus_buy_base<T0, T1>(arg5, arg8, arg9, arg13, arg14, arg15, arg16, arg17, arg18);
            } else {
                0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::cetus_sell_base<T0, T1>(arg5, arg8, arg9, arg13, arg14, arg15, arg16, arg17, arg18);
            };
        } else if (arg0 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_high_route()) {
            if (v0) {
                0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::cetus_buy_base<T0, T1>(arg5, arg8, arg10, arg13, arg14, arg15, arg16, arg17, arg18);
            } else {
                0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::cetus_sell_base<T0, T1>(arg5, arg8, arg10, arg13, arg14, arg15, arg16, arg17, arg18);
            };
        } else {
            assert!(arg0 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::bluefin_route(), 7);
            if (v0) {
                0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::bluefin_buy_base<T0, T1>(arg5, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
            } else {
                0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_sweep::bluefin_sell_base<T0, T1>(arg5, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
            };
        };
    }

    public fun execution_count<T0, T1>(arg0: &Router<T0, T1>) : u64 {
        arg0.execution_count
    }

    public fun fair_quote_for_clip(arg0: u64, arg1: u64, arg2: bool) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 7);
        let v0 = if (arg2) {
            ((arg0 as u128) * (arg1 as u128) + 1000000000 - 1) / 1000000000
        } else {
            (arg0 as u128) * (arg1 as u128) / 1000000000
        };
        assert!(v0 > 0 && v0 <= 18446744073709551615, 7);
        (v0 as u64)
    }

    public fun gated_direction(arg0: u64, arg1: u64, arg2: u64) : (u8, u64) {
        assert!(arg0 > 0 && arg1 > 0, 7);
        assert!(arg2 > 0 && arg2 < 10000, 0);
        let v0 = if (arg1 >= arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        let v1 = if (!((v0 as u128) * 10000 > (arg0 as u128) * (arg2 as u128))) {
            0
        } else if (arg1 > arg0) {
            1
        } else {
            2
        };
        (v1, ratio_scaled(v0, arg0, 100000000, true))
    }

    public fun is_newer_signal_timestamp(arg0: u64, arg1: u64) : bool {
        arg1 > arg0
    }

    public fun is_paused<T0, T1>(arg0: &Router<T0, T1>) : bool {
        arg0.paused
    }

    public fun last_sequence<T0, T1>(arg0: &Router<T0, T1>) : u64 {
        arg0.last_sequence
    }

    public fun latest_offchain_timestamp_ms<T0, T1>(arg0: &Router<T0, T1>) : u64 {
        arg0.last_sequence
    }

    fun lower_sqrt_limit(arg0: u128, arg1: u64) : u128 {
        assert!(arg0 > 0 && (arg1 as u128) < 100000000, 0);
        let v0 = (arg0 as u256) * ((100000000 - (arg1 as u128)) as u256) / (100000000 as u256);
        assert!(v0 > 0 && v0 <= 340282366920938463463374607431768211455, 0);
        (v0 as u128)
    }

    public fun markout_target_is_valid(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : bool {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg2 < arg3) {
            true
        } else {
            arg2 >= (100000000 as u64)
        };
        if (v0) {
            return false
        };
        let v1 = if (arg4 == 1) {
            if (arg1 <= arg0) {
                return false
            };
            arg1 - arg0
        } else if (arg4 == 2) {
            if (arg1 >= arg0) {
                return false
            };
            arg0 - arg1
        } else {
            return false
        };
        let v2 = ratio_scaled(v1, arg0, 100000000, false);
        let v3 = if (v2 >= arg2) {
            v2 - arg2
        } else {
            arg2 - v2
        };
        v3 <= 200
    }

    fun mul_div_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        let v0 = ((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public fun observe_and_route<T0, T1>(arg0: &mut Router<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg16);
        assert!(!arg0.paused, 5);
        assert_objects<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        if (!is_newer_signal_timestamp(arg0.last_sequence, arg14)) {
            let v0 = SignalDiscarded<T0, T1>{
                router_id                    : 0x2::object::id<Router<T0, T1>>(arg0),
                sequence                     : arg10,
                signal_timestamp_ms          : arg14,
                latest_offchain_timestamp_ms : arg0.last_sequence,
                chain_timestamp_ms           : 0x2::clock::timestamp_ms(arg15),
            };
            0x2::event::emit<SignalDiscarded<T0, T1>>(v0);
            return
        };
        validate_signal_times(arg13, arg14, arg0.gate_window_ms, arg0.maximum_signal_age_ms, 0x2::clock::timestamp_ms(arg15));
        let (v1, v2) = gated_direction(arg11, arg12, arg0.gate_bps);
        arg0.last_sequence = arg14;
        let v3 = fair_quote_for_clip(arg12, arg0.clip_base_raw, true);
        let v4 = mul_div_down(v3, 10000 - arg0.margin_bps, 10000);
        let v5 = mul_div_up(v3, 10000 + arg0.margin_bps, 10000);
        let v6 = v1 != 0;
        if (!v6 || arg0.execution_count >= arg0.maximum_executions) {
            emit_signal<T0, T1>(arg0, arg10, arg11, arg12, arg13, arg14, v2, v1, v6, v3, v4, v5, 0, 0, 0, 0, 0, false);
            return
        };
        let v7 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg3);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg9);
        let v9 = 0x1::vector::empty<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>();
        if (v1 == 1) {
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_deepbook_buy_exact_base<T0, T1>(arg1, arg2, arg0.clip_base_raw, v4, arg15));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_momentum_buy_exact_base<T0, T1>(arg3, arg0.clip_base_raw, upper_sqrt_limit(v7, arg0.maximum_sqrt_move_bps_e4)));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_cetus_buy_exact_base<T0, T1>(arg6, arg0.clip_base_raw, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_low_route()));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_cetus_buy_exact_base<T0, T1>(arg7, arg0.clip_base_raw, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_high_route()));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_bluefin_buy_exact_base<T0, T1>(arg9, arg0.clip_base_raw, upper_sqrt_limit(v8, arg0.maximum_sqrt_move_bps_e4)));
        } else {
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_deepbook_sell_exact_base<T0, T1>(arg1, arg2, arg0.clip_base_raw, v5, arg15));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_momentum_sell_exact_base<T0, T1>(arg3, arg0.clip_base_raw, lower_sqrt_limit(v7, arg0.maximum_sqrt_move_bps_e4)));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_cetus_sell_exact_base<T0, T1>(arg6, arg0.clip_base_raw, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_low_route()));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_cetus_sell_exact_base<T0, T1>(arg7, arg0.clip_base_raw, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_high_route()));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v9, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_bluefin_sell_exact_base<T0, T1>(arg9, arg0.clip_base_raw, lower_sqrt_limit(v8, arg0.maximum_sqrt_move_bps_e4)));
        };
        emit_candidate_quotes<T0, T1>(&v9, arg10, arg12, arg0.margin_bps);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v12 = if (v1 == 1) {
            0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::buy_base_side()
        } else {
            0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::sell_base_side()
        };
        let v13 = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::select_best_taker(v9, v12, v4, v5, arg0.clip_base_raw, v10, v11, v10, arg0.inventory_target_base_raw, arg0.inventory_guard_base_raw);
        let (v14, v15, v16, v17, v18, v19, v20) = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::taker_selection_values(&v13);
        let v21 = false;
        if (v14 != 0) {
            assert!(0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::selected_taker_is_safe(&v13, arg0.clip_base_raw, v10, v11, v10, arg0.inventory_target_base_raw, arg0.inventory_guard_base_raw), 6);
            let v22 = if (v15 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::buy_base_side() || v14 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::deepbook_route()) {
                v17
            } else {
                v5
            };
            execute_selected<T0, T1>(v14, v15, arg10, arg0.clip_base_raw, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v16, v22, arg12, v19, arg15, arg16);
            assert_balance_delta<T0, T1>(arg2, v15, v16, v22, v10, v11);
            arg0.execution_count = arg0.execution_count + 1;
            v21 = true;
        };
        emit_signal<T0, T1>(arg0, arg10, arg11, arg12, arg13, arg14, v2, v1, true, v3, v4, v5, v14, v16, v17, v18, v20, v21);
    }

    fun quote_and_execute_markout<T0, T1>(arg0: &mut Router<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: u64, arg11: u8, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (u8, u64, u64, u64, u64, bool) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg9);
        let v2 = 0x1::vector::empty<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>();
        if (arg11 == 1) {
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_deepbook_buy_exact_base<T0, T1>(arg1, arg2, arg13, arg14, arg17));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_momentum_buy_exact_base<T0, T1>(arg3, arg13, upper_sqrt_limit(v0, arg0.maximum_sqrt_move_bps_e4)));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_cetus_buy_exact_base<T0, T1>(arg6, arg13, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_low_route()));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_cetus_buy_exact_base<T0, T1>(arg7, arg13, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_high_route()));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_bluefin_buy_exact_base<T0, T1>(arg9, arg13, upper_sqrt_limit(v1, arg0.maximum_sqrt_move_bps_e4)));
        } else {
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_deepbook_sell_exact_base<T0, T1>(arg1, arg2, arg13, arg15, arg17));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_momentum_sell_exact_base<T0, T1>(arg3, arg13, lower_sqrt_limit(v0, arg0.maximum_sqrt_move_bps_e4)));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_cetus_sell_exact_base<T0, T1>(arg6, arg13, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_low_route()));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_cetus_sell_exact_base<T0, T1>(arg7, arg13, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::cetus_high_route()));
            0x1::vector::push_back<0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::TakerQuote>(&mut v2, 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::quote_bluefin_sell_exact_base<T0, T1>(arg9, arg13, lower_sqrt_limit(v1, arg0.maximum_sqrt_move_bps_e4)));
        };
        if (arg16) {
            emit_candidate_quotes<T0, T1>(&v2, arg10, arg12, arg0.margin_bps);
        };
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v5 = if (arg11 == 1) {
            0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::buy_base_side()
        } else {
            0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::sell_base_side()
        };
        let v6 = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::select_best_taker(v2, v5, arg14, arg15, arg13, v3, v4, v3, arg0.inventory_target_base_raw, arg0.inventory_guard_base_raw);
        let (v7, v8, v9, v10, v11, v12, v13) = 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::taker_selection_values(&v6);
        let v14 = false;
        if (v7 != 0) {
            assert!(0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::selected_taker_is_safe(&v6, arg13, v3, v4, v3, arg0.inventory_target_base_raw, arg0.inventory_guard_base_raw), 6);
            let v15 = if (v8 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::buy_base_side() || v7 == 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard::deepbook_route()) {
                v10
            } else {
                arg15
            };
            execute_selected<T0, T1>(v7, v8, arg10, arg13, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v9, v15, arg12, v12, arg17, arg18);
            assert_balance_delta<T0, T1>(arg2, v8, v9, v15, v3, v4);
            arg0.execution_count = arg0.execution_count + 1;
            v14 = true;
        };
        (v7, v9, v10, v11, v13, v14)
    }

    fun ratio_scaled(arg0: u64, arg1: u64, arg2: u128, arg3: bool) : u64 {
        assert!(arg1 > 0, 7);
        let v0 = (arg0 as u128) * arg2;
        let v1 = if (arg3 && v0 > 0) {
            (v0 + (arg1 as u128) - 1) / (arg1 as u128)
        } else {
            v0 / (arg1 as u128)
        };
        assert!(v1 <= 18446744073709551615, 7);
        (v1 as u64)
    }

    public fun route_markout<T0, T1>(arg0: &mut Router<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: u64, arg11: u8, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg19);
        assert!(!arg0.paused, 5);
        assert_objects<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        if (!is_newer_signal_timestamp(arg0.last_sequence, arg17)) {
            let v0 = SignalDiscarded<T0, T1>{
                router_id                    : 0x2::object::id<Router<T0, T1>>(arg0),
                sequence                     : arg10,
                signal_timestamp_ms          : arg17,
                latest_offchain_timestamp_ms : arg0.last_sequence,
                chain_timestamp_ms           : 0x2::clock::timestamp_ms(arg18),
            };
            0x2::event::emit<SignalDiscarded<T0, T1>>(v0);
            return
        };
        validate_signal_freshness(arg17, arg0.maximum_signal_age_ms, 0x2::clock::timestamp_ms(arg18));
        let v1 = if (arg16 > 0) {
            if (arg16 <= arg0.clip_base_raw) {
                markout_target_is_valid(arg12, arg13, arg14, arg15, arg11)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 7);
        arg0.last_sequence = arg17;
        let v2 = fair_quote_for_clip(arg13, arg16, true);
        let v3 = mul_div_down(v2, 10000 - arg0.margin_bps, 10000);
        let v4 = mul_div_up(v2, 10000 + arg0.margin_bps, 10000);
        if (arg0.execution_count >= arg0.maximum_executions) {
            emit_markout<T0, T1>(arg0, arg10, arg17, arg11, arg12, arg13, arg14, arg15, arg16, v2, v3, v4, 0, 0, 0, 0, 0, false);
            return
        };
        let (v5, v6, v7, v8, v9, v10) = quote_and_execute_markout<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg16, v3, v4, true, arg18, arg19);
        emit_markout<T0, T1>(arg0, arg10, arg17, arg11, arg12, arg13, arg14, arg15, arg16, v2, v3, v4, v5, v6, v7, v8, v9, v10);
    }

    public fun set_limits<T0, T1>(arg0: &mut Router<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg10);
        validate_configuration(arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        assert!(arg9 >= arg0.execution_count, 0);
        arg0.clip_base_raw = arg1;
        arg0.margin_bps = arg2;
        arg0.gate_bps = arg3;
        arg0.gate_window_ms = arg4;
        arg0.maximum_signal_age_ms = arg5;
        arg0.maximum_sqrt_move_bps_e4 = arg6;
        arg0.inventory_target_base_raw = arg7;
        arg0.inventory_guard_base_raw = arg8;
        arg0.maximum_executions = arg9;
    }

    public fun set_paused<T0, T1>(arg0: &mut Router<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        arg0.paused = arg1;
    }

    fun target_state(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : (u8, u64) {
        let v0 = if (!arg3) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 <= arg1
        };
        if (v0) {
            return (0, 0)
        };
        let v1 = arg1 + (arg2 - arg1) / 2;
        if (arg0 > v1 && arg0 > arg1) {
            (1, ratio_scaled(arg0 - arg1, arg1, 100000000, false))
        } else if (arg0 < v1 && arg0 < arg2) {
            (2, ratio_scaled(arg2 - arg0, arg2, 100000000, false))
        } else {
            (0, 0)
        }
    }

    fun unpack(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 ^ wire(arg0, arg2)
    }

    fun upper_sqrt_limit(arg0: u128, arg1: u64) : u128 {
        assert!(arg0 > 0 && (arg1 as u128) < 100000000, 0);
        let v0 = ((arg0 as u256) * ((100000000 + (arg1 as u128)) as u256) + (100000000 as u256) - 1) / (100000000 as u256);
        assert!(v0 > 0 && v0 <= 340282366920938463463374607431768211455, 0);
        (v0 as u128)
    }

    fun validate_configuration(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = if (arg0 > 0) {
            if (arg0 <= 100000000000) {
                if (arg1 < 10000) {
                    if (arg2 > 0) {
                        if (arg2 < 10000) {
                            if (arg3 > 0) {
                                if (arg3 <= 60000) {
                                    if (arg4 > 0) {
                                        if (arg4 <= 60000) {
                                            if (arg5 > 0) {
                                                if ((arg5 as u128) < 100000000) {
                                                    if (arg6 > 0) {
                                                        arg7 > 0
                                                    } else {
                                                        false
                                                    }
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
    }

    fun validate_signal_freshness(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 3);
        if (arg0 > arg2) {
            assert!(arg0 - arg2 <= 1000, 3);
        } else {
            assert!(arg2 - arg0 <= arg1, 3);
        };
    }

    fun validate_signal_times(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg0 > 0) {
            if (arg1 > arg0) {
                arg1 - arg0 <= arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        if (arg1 > arg4) {
            assert!(arg1 - arg4 <= 1000, 3);
        } else {
            assert!(arg4 - arg1 <= arg3, 3);
        };
    }

    fun wire(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * 11400714785074694791 % 18446744073709551616 + (arg1 as u128) * 14029467366897019727 % 18446744073709551616) % 18446744073709551616) as u64)
    }

    // decompiled from Move bytecode v7
}

