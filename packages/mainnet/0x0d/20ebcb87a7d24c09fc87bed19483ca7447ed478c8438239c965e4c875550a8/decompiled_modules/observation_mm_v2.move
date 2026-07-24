module 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::observation_mm_v2 {
    struct StrategyState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        publisher: address,
        deepbook_pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        momentum_pool_id: 0x2::object::ID,
        cetus_low_pool_id: 0x2::object::ID,
        cetus_high_pool_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        paused: bool,
        latest_publisher_sequence: u64,
        accepted_observations: u64,
        dropped_observations: u64,
        unchanged_observations: u64,
        quantity: u64,
        order_ttl_ms: u64,
        refresh_before_expiry_ms: u64,
        quote_offset: u8,
        inventory_target_base: u64,
        inventory_guard_base: u64,
        external_guard_bps: u64,
        momentum_sell_sqrt_limit: u128,
        momentum_buy_sqrt_limit: u128,
        bluefin_sell_sqrt_limit: u128,
        bluefin_buy_sqrt_limit: u128,
    }

    struct StrategyCreated<phantom T0, phantom T1> has copy, drop {
        strategy_id: 0x2::object::ID,
    }

    struct QuoteReconciled<phantom T0, phantom T1> has copy, drop {
        strategy_id: 0x2::object::ID,
        accepted: bool,
        reason: u8,
        mutation_mask: u8,
    }

    fun assert_common_objects<T0, T1>(arg0: &StrategyState<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.publisher == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.deepbook_pool_id == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg1) && arg0.balance_manager_id == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg2), 1);
    }

    fun cancel_existing<T0, T1>(arg0: &StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, arg2));
        if (0x1::vector::length<u128>(&v0) > 0) {
            let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, arg2, &v1);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_orders<T0, T1>(arg1, arg2, &v1, v0, arg4, arg5);
        };
        emit_outcome<T0, T1>(arg0, true, arg3, false, false, false, false);
    }

    public fun create_strategy<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg1) == 0x2::tx_context::sender(arg17), 0);
        validate_config<T0, T1>(arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg2, arg5, arg13, arg14, arg15, arg16);
        let v0 = StrategyState<T0, T1>{
            id                        : 0x2::object::new(arg17),
            publisher                 : 0x2::tx_context::sender(arg17),
            deepbook_pool_id          : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0),
            balance_manager_id        : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1),
            momentum_pool_id          : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2),
            cetus_low_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3),
            cetus_high_pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4),
            bluefin_pool_id           : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5),
            paused                    : false,
            latest_publisher_sequence : 0,
            accepted_observations     : 0,
            dropped_observations      : 0,
            unchanged_observations    : 0,
            quantity                  : arg6,
            order_ttl_ms              : arg7,
            refresh_before_expiry_ms  : arg8,
            quote_offset              : arg9,
            inventory_target_base     : arg10,
            inventory_guard_base      : arg11,
            external_guard_bps        : arg12,
            momentum_sell_sqrt_limit  : arg13,
            momentum_buy_sqrt_limit   : arg14,
            bluefin_sell_sqrt_limit   : arg15,
            bluefin_buy_sqrt_limit    : arg16,
        };
        let v1 = StrategyCreated<T0, T1>{strategy_id: 0x2::object::id<StrategyState<T0, T1>>(&v0)};
        0x2::event::emit<StrategyCreated<T0, T1>>(v1);
        0x2::transfer::share_object<StrategyState<T0, T1>>(v0);
    }

    fun emit_outcome<T0, T1>(arg0: &StrategyState<T0, T1>, arg1: bool, arg2: u8, arg3: bool, arg4: bool, arg5: bool, arg6: bool) {
        let v0 = if (arg3) {
            1
        } else {
            0
        };
        let v1 = if (arg4) {
            2
        } else {
            0
        };
        let v2 = if (arg5) {
            4
        } else {
            0
        };
        let v3 = if (arg6) {
            8
        } else {
            0
        };
        let v4 = QuoteReconciled<T0, T1>{
            strategy_id   : 0x2::object::id<StrategyState<T0, T1>>(arg0),
            accepted      : arg1,
            reason        : arg2,
            mutation_mask : v0 | v1 | v2 | v3,
        };
        0x2::event::emit<QuoteReconciled<T0, T1>>(v4);
    }

    fun external_bbo<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock) : (bool, u64, u64) {
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 8, arg2);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg0, arg1);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v8)) {
            let v10 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v8, v9);
            let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v10);
            let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v10);
            let v13 = if (v11 > v12) {
                v11 - v12
            } else {
                0
            };
            if (v13 > 0 && 0x2::clock::timestamp_ms(arg2) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v10)) {
                if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v10) >> 127 == 0) {
                    let v14 = &mut v6;
                    subtract_level(&v7, v14, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v10), v13);
                } else {
                    let v15 = &mut v4;
                    subtract_level(&v5, v15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v10), v13);
                };
            };
            v9 = v9 + 1;
        };
        let (v16, v17) = first_live_level(&v7, &v6);
        let (v18, v19) = first_live_level(&v5, &v4);
        let v20 = if (v16) {
            if (v18) {
                v17 < v19
            } else {
                false
            }
        } else {
            false
        };
        (v20, v17, v19)
    }

    fun first_live_level(arg0: &vector<u64>, arg1: &vector<u64>) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg1, v0) > 0) {
                return (true, *0x1::vector::borrow<u64>(arg0, v0))
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public(friend) fun inventory_sides(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : (bool, bool) {
        if ((arg0 as u128) + (arg1 as u128) > (arg2 as u128) + (arg3 as u128)) {
            arg4 = false;
        };
        let v0 = if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        };
        if (arg0 < arg1 || arg0 - arg1 < v0) {
            arg5 = false;
        };
        (arg4, arg5)
    }

    public(friend) fun observation_time_tag(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : vector<u8> {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u64::add_check(arg1, 1317), 3);
        let v0 = (arg1 + 1317) / 2000;
        let v1 = b"lotus/liquidity-mm-v2/time-tag/v1";
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v0));
        0x2::hash::blake2b256(&v1)
    }

    public fun observe_and_quote_all<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: u64, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u8, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_common_objects<T0, T1>(arg0, arg1, arg2, arg13);
        let v0 = preflight<T0, T1>(arg0, arg1, arg2, arg7, &arg8, arg9, arg10, arg11, arg12, arg13);
        if (!v0) {
            return
        };
        let v1 = if (arg0.momentum_pool_id == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3)) {
            if (arg0.cetus_low_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4)) {
                if (arg0.cetus_high_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5)) {
                    arg0.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::merge(0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::merge(0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::quote_momentum<T0, T1>(arg3, arg0.quantity, arg0.momentum_sell_sqrt_limit, arg0.momentum_buy_sqrt_limit), 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::quote_cetus<T0, T1>(arg4, arg5, arg0.quantity)), 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::quote_bluefin<T0, T1>(arg6, arg0.quantity, arg0.bluefin_sell_sqrt_limit, arg0.bluefin_buy_sqrt_limit));
        reconcile<T0, T1>(arg0, arg1, arg2, v2, arg7, arg9, arg10, arg11, arg12, arg13);
    }

    public fun observe_and_quote_bluefin<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_common_objects<T0, T1>(arg0, arg1, arg2, arg10);
        let v0 = preflight<T0, T1>(arg0, arg1, arg2, arg4, &arg5, arg6, arg7, arg8, arg9, arg10);
        if (!v0) {
            return
        };
        assert!(arg0.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 1);
        let v1 = 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::quote_bluefin<T0, T1>(arg3, arg0.quantity, arg0.bluefin_sell_sqrt_limit, arg0.bluefin_buy_sqrt_limit);
        reconcile<T0, T1>(arg0, arg1, arg2, v1, arg4, arg6, arg7, arg8, arg9, arg10);
    }

    public fun observe_and_quote_cetus<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_common_objects<T0, T1>(arg0, arg1, arg2, arg11);
        let v0 = preflight<T0, T1>(arg0, arg1, arg2, arg5, &arg6, arg7, arg8, arg9, arg10, arg11);
        if (!v0) {
            return
        };
        assert!(arg0.cetus_low_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3) && arg0.cetus_high_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4), 1);
        let v1 = 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::quote_cetus<T0, T1>(arg3, arg4, arg0.quantity);
        reconcile<T0, T1>(arg0, arg1, arg2, v1, arg5, arg7, arg8, arg9, arg10, arg11);
    }

    public fun observe_and_quote_momentum<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_common_objects<T0, T1>(arg0, arg1, arg2, arg10);
        let v0 = preflight<T0, T1>(arg0, arg1, arg2, arg4, &arg5, arg6, arg7, arg8, arg9, arg10);
        if (!v0) {
            return
        };
        assert!(arg0.momentum_pool_id == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3), 1);
        let v1 = 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::quote_momentum<T0, T1>(arg3, arg0.quantity, arg0.momentum_sell_sqrt_limit, arg0.momentum_buy_sqrt_limit);
        reconcile<T0, T1>(arg0, arg1, arg2, v1, arg4, arg6, arg7, arg8, arg9, arg10);
    }

    fun plan_orders(arg0: &vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (vector<u128>, bool, bool) {
        let v0 = vector[];
        let v1 = false;
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(arg0)) {
            let v4 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(arg0, v3);
            let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v4);
            let v6 = v5 >> 127 == 0;
            let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v4);
            let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v4);
            let v9 = if (v7 > v8) {
                v7 - v8
            } else {
                0
            };
            let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v4);
            let v11 = v10 > arg6 && v10 - arg6 > arg7;
            let v12 = if (v6) {
                if (arg1) {
                    if (!v1) {
                        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v4) == arg3) {
                            if (v9 == arg5) {
                                v11
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
            } else if (arg2) {
                if (!v2) {
                    if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v4) == arg4) {
                        if (v9 == arg5) {
                            v11
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
            if (v12) {
                if (v6) {
                    v1 = true;
                } else {
                    v2 = true;
                };
            } else {
                0x1::vector::push_back<u128>(&mut v0, v5);
            };
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    fun preflight<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: &vector<u8>, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : bool {
        validate_observation(arg3, arg5, arg6, arg7);
        if (arg3 <= arg0.latest_publisher_sequence) {
            arg0.dropped_observations = arg0.dropped_observations + 1;
            emit_outcome<T0, T1>(arg0, false, 2, false, false, false, false);
            return false
        };
        arg0.latest_publisher_sequence = arg3;
        arg0.accepted_observations = arg0.accepted_observations + 1;
        let v0 = if (!time_tag_is_current(0x2::object::id<StrategyState<T0, T1>>(arg0), arg4, arg3, 0x2::clock::timestamp_ms(arg8))) {
            3
        } else if (arg0.paused) {
            4
        } else if (arg7 == 0) {
            5
        } else {
            255
        };
        if (v0 != 255) {
            cancel_existing<T0, T1>(arg0, arg1, arg2, v0, arg8, arg9);
            return false
        };
        true
    }

    fun reconcile<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::ExecutableGuard, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        if (!0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::is_complete(&arg3)) {
            cancel_existing<T0, T1>(arg0, arg1, arg2, 8, arg8, arg9);
            return
        };
        let (v1, v2, v3) = external_bbo<T0, T1>(arg1, arg2, arg8);
        if (!v1) {
            cancel_existing<T0, T1>(arg0, arg1, arg2, 6, arg8, arg9);
            return
        };
        let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let (v7, v8) = target_prices(v2, v3, v4, arg0.quote_offset);
        let v9 = if (arg7 & 1 != 0) {
            0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::apply_to_bid_ceiling(arg5, &arg3, arg0.external_guard_bps)
        } else {
            0
        };
        let v10 = if (arg7 & 2 != 0) {
            0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard::apply_to_ask_floor(arg6, &arg3, arg0.external_guard_bps)
        } else {
            0
        };
        let v11 = arg7 & 1 != 0 && v7 <= v9;
        let v12 = arg7 & 2 != 0 && v8 >= v10;
        let (v13, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T1>(arg1, arg2);
        let v16 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2) as u128) + (v13 as u128);
        assert!(v16 <= (18446744073709551615 as u128), 3);
        let (v17, v18) = inventory_sides((v16 as u64), arg0.quantity, arg0.inventory_target_base, arg0.inventory_guard_base, v11, v12);
        if (!v17 && !v18) {
            cancel_existing<T0, T1>(arg0, arg1, arg2, 7, arg8, arg9);
            return
        };
        let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg1, arg2);
        let (v20, v21, v22) = plan_orders(&v19, v17, v18, v7, v8, arg0.quantity, v0, arg0.refresh_before_expiry_ms);
        let v23 = v20;
        let v24 = v17 && !v21;
        let v25 = v18 && !v22;
        let v26 = 0x1::vector::length<u128>(&v23);
        let v27 = if (v26 > 0) {
            true
        } else if (v24) {
            true
        } else {
            v25
        };
        if (!v27) {
            arg0.unchanged_observations = arg0.unchanged_observations + 1;
            emit_outcome<T0, T1>(arg0, true, 0, v21, v22, false, false);
            return
        };
        let v28 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, arg2, &v28);
        if (v26 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_orders<T0, T1>(arg1, arg2, &v28, v23, arg8, arg9);
        };
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u64::add_check(v0, arg0.order_ttl_ms), 3);
        let v29 = v0 + arg0.order_ttl_ms;
        let v30 = false;
        let v31 = false;
        if (v24 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg1, arg2, v7, arg0.quantity, true, false, v29, arg8)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg2, &v28, arg4 * 2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v7, arg0.quantity, true, false, v29, arg8, arg9);
            v30 = true;
        };
        if (v25 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg1, arg2, v8, arg0.quantity, false, false, v29, arg8)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg2, &v28, arg4 * 2 + 1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v8, arg0.quantity, false, false, v29, arg8, arg9);
            v31 = true;
        };
        emit_outcome<T0, T1>(arg0, true, 1, v21, v22, v30, v31);
    }

    public fun set_paused<T0, T1>(arg0: &mut StrategyState<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_common_objects<T0, T1>(arg0, arg1, arg2, arg5);
        arg0.paused = arg3;
        if (arg3) {
            let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, arg2, &v0);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, arg2, &v0, arg4, arg5);
        };
    }

    fun subtract_level(arg0: &vector<u64>, arg1: &mut vector<u64>, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg2) {
                let v1 = *0x1::vector::borrow<u64>(arg1, v0);
                let v2 = if (arg3 >= v1) {
                    0
                } else {
                    v1 - arg3
                };
                *0x1::vector::borrow_mut<u64>(arg1, v0) = v2;
                return
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun target_prices(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : (u64, u64) {
        let v0 = if (arg2 > 0) {
            if (arg0 < arg1) {
                if (arg1 >= arg2) {
                    arg3 <= 2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = if (arg3 == 0) {
            assert!(arg0 >= arg2, 3);
            arg0 - arg2
        } else if (arg3 == 1) {
            arg0
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u64::add_check(arg0, arg2), 3);
            let v2 = arg0 + arg2;
            let v3 = arg1 - arg2;
            if (v2 < v3) {
                v2
            } else {
                v3
            }
        };
        let v4 = if (arg3 == 0) {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u64::add_check(arg1, arg2), 3);
            arg1 + arg2
        } else if (arg3 == 1) {
            arg1
        } else {
            let v5 = arg1 - arg2;
            let v6 = arg0 + arg2;
            if (v5 > v6) {
                v5
            } else {
                v6
            }
        };
        if (v1 < v4) {
            (v1, v4)
        } else {
            (arg0, arg1)
        }
    }

    public(friend) fun time_tag_is_current(arg0: 0x2::object::ID, arg1: &vector<u8>, arg2: u64, arg3: u64) : bool {
        if (0x1::vector::length<u8>(arg1) != 32) {
            return false
        };
        let v0 = observation_time_tag(arg0, arg3, arg2);
        if (arg1 == &v0) {
            return true
        };
        if (arg3 >= 2000) {
            let v2 = observation_time_tag(arg0, arg3 - 2000, arg2);
            arg1 == &v2
        } else {
            false
        }
    }

    fun validate_config<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: u128, arg10: u128, arg11: u128, arg12: u128) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg7);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg8);
        let v2 = if (arg0 > 0) {
            if (arg0 <= 2000000000) {
                if (arg1 <= 6000) {
                    if (arg2 > 0) {
                        if (arg2 < arg1) {
                            if (arg3 <= 2) {
                                if (arg4 <= 20000000000) {
                                    if (arg5 > 0) {
                                        if (arg5 <= 20000000000) {
                                            arg6 <= 50
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
        assert!(v2, 2);
        let v3 = if (arg9 > 0) {
            if (arg9 < v0) {
                if (arg10 > v0) {
                    if (arg11 > 0) {
                        if (arg11 < v1) {
                            arg12 > v1
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
        assert!(v3, 2);
    }

    fun validate_observation(arg0: u64, arg1: u64, arg2: u64, arg3: u8) {
        let v0 = if (arg0 > 0) {
            if (arg0 <= 9223372036854775807) {
                if (arg3 <= 3) {
                    let v1 = if (arg3 & 1 != 0) {
                        if (arg1 > 0) {
                            arg1 <= 10000000
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v1 || arg3 & 1 == 0 && arg1 == 0) {
                        let v2 = if (arg3 & 2 != 0) {
                            if (arg2 > 0) {
                                arg2 <= 10000000
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v2 || arg3 & 2 == 0 && arg2 == 0) {
                            arg3 != 3 || arg2 > arg1
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
        assert!(v0, 3);
    }

    // decompiled from Move bytecode v7
}

