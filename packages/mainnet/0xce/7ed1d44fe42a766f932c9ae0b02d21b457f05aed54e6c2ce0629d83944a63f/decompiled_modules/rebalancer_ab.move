module 0xce7ed1d44fe42a766f932c9ae0b02d21b457f05aed54e6c2ce0629d83944a63f::rebalancer_ab {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        bal_a: 0x2::balance::Balance<T0>,
        bal_b: 0x2::balance::Balance<T1>,
        has_position: bool,
        pos_tick_lower: u32,
        pos_tick_upper: u32,
        range_ticks_out: u32,
        last_sqrt_price_x64: u128,
    }

    fun a_value_of_b_amount(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0, 7);
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg0 as u256) * v0 * v0 / v1 * v1;
        if (v2 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v2 as u64)
        }
    }

    fun assert_owner(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x381fa7b8c35ef12b989638c01e3d46ab9839736fdc13bff0bff5b4505a907c80, 1);
    }

    fun assert_pool<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == arg0.pool_id, 6);
    }

    fun b_amount_for_a_value(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0, 7);
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg0 as u256) * v1 * v1 / v0 * v0;
        if (v2 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v2 as u64)
        }
    }

    fun clamp_signed_u32(arg0: u32, arg1: u32, arg2: u32) : u32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1))) {
            return arg1
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), v0)) {
            return arg2
        };
        arg0
    }

    public entry fun create<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg1);
        let v0 = Vault<T0, T1>{
            id                  : 0x2::object::new(arg1),
            pool_id             : arg0,
            bal_a               : 0x2::balance::zero<T0>(),
            bal_b               : 0x2::balance::zero<T1>(),
            has_position        : false,
            pos_tick_lower      : 0,
            pos_tick_upper      : 0,
            range_ticks_out     : 1,
            last_sqrt_price_x64 : 0,
        };
        0x2::transfer::public_transfer<Vault<T0, T1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun deposit_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::balance::join<T0>(&mut arg0.bal_a, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::balance::join<T1>(&mut arg0.bal_b, 0x2::coin::into_balance<T1>(arg1));
    }

    fun is_current_pos_one_of_three(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32) : bool {
        let v0 = tick_floor_to_spacing_u32(arg2, arg3);
        let v1 = tick_wrap_add(v0, arg4);
        let v2 = tick_wrap_sub(v0, arg4);
        if (arg0 == v0 && arg1 == tick_wrap_add(v0, arg4)) {
            true
        } else if (arg0 == v1 && arg1 == tick_wrap_add(v1, arg4)) {
            true
        } else {
            arg0 == v2 && arg1 == tick_wrap_add(v2, arg4)
        }
    }

    fun ll_balance_a_b_equal_value<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg0.bal_a);
        let v1 = 0x2::balance::value<T1>(&arg0.bal_b);
        if (v0 == 0 && v1 == 0) {
            return
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        assert!(v2 > 0, 7);
        let v3 = v0 + a_value_of_b_amount(v1, v2);
        if (v3 <= 1) {
            return
        };
        let v4 = v3 / 2;
        if (v0 > v4 + 1) {
            let v5 = v0 - v4;
            let v6 = v5;
            if (v5 > 1) {
                v6 = v5 - 1;
            };
            if (v6 > 0) {
                ll_swap_a_to_b_amount<T0, T1>(arg0, arg1, arg2, arg3, v6);
            };
            return
        };
        if (v4 > v0 + 1) {
            let v7 = b_amount_for_a_value(v4 - v0 + 1, v2);
            let v8 = v7;
            if (v7 > 1) {
                v8 = v7 + 1;
            };
            let v9 = 0x2::balance::value<T1>(&arg0.bal_b);
            if (v8 > v9) {
                v8 = v9;
            };
            if (v8 > 0) {
                ll_swap_b_to_a_amount<T0, T1>(arg0, arg1, arg2, arg3, v8);
            };
        };
    }

    fun ll_close_stored_position<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::dynamic_object_field::remove<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, 0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v0, v1, arg3)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v0, false);
        0x2::balance::join<T0>(&mut v5, v6);
        0x2::balance::join<T1>(&mut v4, v7);
        0x2::balance::join<T0>(&mut arg0.bal_a, v5);
        0x2::balance::join<T1>(&mut arg0.bal_b, v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v0);
        arg0.has_position = false;
        arg0.pos_tick_lower = 0;
        arg0.pos_tick_upper = 0;
    }

    fun ll_open_position_store_inside_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.has_position, 4);
        let v0 = 0x2::balance::value<T0>(&arg0.bal_a);
        let v1 = 0x2::balance::value<T1>(&arg0.bal_b);
        assert!(v0 > 0 || v1 > 0, 5);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        let v3 = if (arg6) {
            v0
        } else {
            v1
        };
        assert!(v3 > 0, 5);
        let v4 = if (v3 > 1) {
            v3 - 1
        } else {
            v3
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v2, v4, arg6, arg5);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v5);
        assert!(0x2::balance::value<T0>(&arg0.bal_a) >= v6, 5);
        assert!(0x2::balance::value<T1>(&arg0.bal_b) >= v7, 5);
        let v8 = if (v6 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.bal_a, v6)
        };
        let v9 = if (v7 == 0) {
            0x2::balance::zero<T1>()
        } else {
            0x2::balance::split<T1>(&mut arg0.bal_b, v7)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v8, v9, v5);
        0x2::dynamic_object_field::add<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, 0, v2);
        arg0.has_position = true;
        arg0.pos_tick_lower = arg3;
        arg0.pos_tick_upper = arg4;
    }

    fun ll_swap_a_to_b_amount<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.bal_a) >= arg4, 5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T0>(&arg0.bal_a) >= v4, 5);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.bal_a, v4)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v5, 0x2::balance::zero<T1>(), v3);
        0x2::balance::join<T0>(&mut arg0.bal_a, v0);
        0x2::balance::join<T1>(&mut arg0.bal_b, v1);
    }

    fun ll_swap_all_a_to_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg0.bal_a);
        if (v0 == 0) {
            return
        };
        ll_swap_a_to_b_amount<T0, T1>(arg0, arg1, arg2, arg3, v0);
    }

    fun ll_swap_all_b_to_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T1>(&arg0.bal_b);
        if (v0 == 0) {
            return
        };
        ll_swap_b_to_a_amount<T0, T1>(arg0, arg1, arg2, arg3, v0);
    }

    fun ll_swap_b_to_a_amount<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        assert!(0x2::balance::value<T1>(&arg0.bal_b) >= arg4, 5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T1>(&arg0.bal_b) >= v4, 5);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<T1>()
        } else {
            0x2::balance::split<T1>(&mut arg0.bal_b, v4)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v5, v3);
        0x2::balance::join<T0>(&mut arg0.bal_a, v0);
        0x2::balance::join<T1>(&mut arg0.bal_b, v1);
    }

    fun max_liquidity_for_range(arg0: u64, arg1: u64, arg2: u128, arg3: u32, arg4: u32) : (u128, bool) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        if (!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1)) {
            return (0, true)
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v1);
        let v4 = (arg0 as u128);
        let v5 = (arg1 as u128);
        if (arg2 <= v2) {
            let v6 = v3 - v2;
            if (v4 == 0 || v6 == 0) {
                return (0, true)
            };
            return (mul_div_u128(v4, mul_div_u128(v3, v2, 18446744073709551616), v6), true)
        };
        if (arg2 >= v3) {
            let v7 = v3 - v2;
            if (v5 == 0 || v7 == 0) {
                return (0, false)
            };
            return (mul_div_u128(v5, 18446744073709551616, v7), false)
        };
        let v8 = if (v4 == 0) {
            0
        } else {
            mul_div_u128(v4, mul_div_u128(v3, arg2, 18446744073709551616), v3 - arg2)
        };
        let v9 = if (v5 == 0) {
            0
        } else {
            mul_div_u128(v5, 18446744073709551616, arg2 - v2)
        };
        if (v8 <= v9) {
            (v8, true)
        } else {
            (v9, false)
        }
    }

    fun max_usable_tick(arg0: u32) : u32 {
        443636 - 443636 % arg0
    }

    fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    fun pick_best_range_and_limit_side(arg0: u64, arg1: u64, arg2: u128, arg3: u32, arg4: u32, arg5: u32) : (u32, u32, bool) {
        let (v0, v1) = tick_bounds_u32(arg4);
        let v2 = tick_wrap_sub(v1, arg5);
        let v3 = tick_floor_to_spacing_u32(arg3, arg4);
        let v4 = clamp_signed_u32(v3, v0, v2);
        let v5 = clamp_signed_u32(tick_wrap_add(v3, arg5), v0, v2);
        let v6 = clamp_signed_u32(tick_wrap_sub(v3, arg5), v0, v2);
        if (arg0 > 0 && arg1 == 0) {
            return (v5, tick_wrap_add(v5, arg5), true)
        };
        if (arg1 > 0 && arg0 == 0) {
            return (v6, tick_wrap_add(v6, arg5), false)
        };
        let (v7, v8) = max_liquidity_for_range(arg0, arg1, arg2, v4, tick_wrap_add(v4, arg5));
        let (v9, v10) = max_liquidity_for_range(arg0, arg1, arg2, v5, tick_wrap_add(v5, arg5));
        let (v11, v12) = max_liquidity_for_range(arg0, arg1, arg2, v6, tick_wrap_add(v6, arg5));
        if (v7 >= v9 && v7 >= v11) {
            (v4, tick_wrap_add(v4, arg5), v8)
        } else if (v9 >= v11) {
            (v5, tick_wrap_add(v5, arg5), v10)
        } else {
            (v6, tick_wrap_add(v6, arg5), v12)
        }
    }

    public entry fun rebalance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: bool, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg7);
        assert_pool<T0, T1>(arg0, arg2);
        let v0 = arg5 && arg6;
        assert!(!v0, 8);
        arg0.last_sqrt_price_x64 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v1 = if (arg0.has_position) {
            if (!arg4) {
                if (!arg5) {
                    !arg6
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg2);
            if (is_current_pos_one_of_three(arg0.pos_tick_lower, arg0.pos_tick_upper, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2)), v2, arg0.range_ticks_out * v2)) {
                return
            };
        };
        if (arg0.has_position) {
            ll_close_stored_position<T0, T1>(arg0, arg1, arg2, arg3);
        };
        if (arg5) {
            ll_swap_all_b_to_a<T0, T1>(arg0, arg1, arg2, arg3);
            return
        };
        if (arg6) {
            ll_swap_all_a_to_b<T0, T1>(arg0, arg1, arg2, arg3);
            return
        };
        if (arg4) {
            ll_balance_a_b_equal_value<T0, T1>(arg0, arg1, arg2, arg3);
            return
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg2);
        let (v4, v5, v6) = pick_best_range_and_limit_side(0x2::balance::value<T0>(&arg0.bal_a), 0x2::balance::value<T1>(&arg0.bal_b), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2)), v3, arg0.range_ticks_out * v3);
        ll_open_position_store_inside_vault<T0, T1>(arg0, arg1, arg2, v4, v5, arg3, v6, arg7);
    }

    public entry fun set_pool_id<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        arg0.pool_id = arg1;
    }

    public entry fun set_range_ticks_out<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u32, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg3);
        assert!(arg1 > 0, 9);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg2);
        assert!((arg1 as u64) <= 2 * (max_usable_tick(v0) as u64) / (v0 as u64), 9);
        arg0.range_ticks_out = arg1;
    }

    fun tick_bounds_u32(arg0: u32) : (u32, u32) {
        let v0 = max_usable_tick(arg0);
        let v1 = if (v0 == 0) {
            0
        } else {
            (((4294967296 - (v0 as u64)) % 4294967296) as u32)
        };
        (v1, v0)
    }

    fun tick_floor_to_spacing_u32(arg0: u32, arg1: u32) : u32 {
        if (arg1 == 0) {
            return arg0
        };
        if (arg0 < 2147483648) {
            return arg0 - arg0 % arg1
        };
        let v0 = (((4294967296 - (arg0 as u64)) % (arg1 as u64)) as u32);
        if (v0 == 0) {
            arg0
        } else {
            tick_wrap_sub(arg0, arg1 - v0)
        }
    }

    fun tick_wrap_add(arg0: u32, arg1: u32) : u32 {
        ((((arg0 as u64) + (arg1 as u64)) % 4294967296) as u32)
    }

    fun tick_wrap_sub(arg0: u32, arg1: u32) : u32 {
        ((((arg0 as u64) + 4294967296 - (arg1 as u64)) % 4294967296) as u32)
    }

    public fun vault_state<T0, T1>(arg0: &Vault<T0, T1>) : (address, u64, u64, bool, u32, u32, u32, u128) {
        (arg0.pool_id, 0x2::balance::value<T0>(&arg0.bal_a), 0x2::balance::value<T1>(&arg0.bal_b), arg0.has_position, arg0.pos_tick_lower, arg0.pos_tick_upper, arg0.range_ticks_out, arg0.last_sqrt_price_x64)
    }

    public entry fun withdraw_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal_a, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bal_b, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

