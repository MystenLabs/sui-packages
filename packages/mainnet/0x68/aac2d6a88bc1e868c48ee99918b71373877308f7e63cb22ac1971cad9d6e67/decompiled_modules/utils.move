module 0x68aac2d6a88bc1e868c48ee99918b71373877308f7e63cb22ac1971cad9d6e67::utils {
    public fun CONST_DENOMINATOR() : u128 {
        1000000000
    }

    fun add_liquidity_fix_token<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = 0x2::balance::value<T1>(&arg4);
        let v2 = if (arg5) {
            v0
        } else {
            v1
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, v2, arg5, arg6);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        if (arg5) {
            assert!(v0 == v4 && v5 <= v1, 4);
        } else {
            assert!(v1 == v5 && v4 <= v0, 4);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v4), 0x2::balance::split<T1>(&mut arg4, v5), v3);
        send_coin<T0>(0x2::coin::from_balance<T0>(arg3, arg7), 0x2::tx_context::sender(arg7));
        send_coin<T1>(0x2::coin::from_balance<T1>(arg4, arg7), 0x2::tx_context::sender(arg7));
    }

    public fun create_clmm_pool<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (!is_reverse<T0, T1>()) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::create_pool<T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        };
    }

    public fun current_time(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun get_amount_to_liquidity(arg0: u128, arg1: u64, arg2: u32, arg3: bool) : u64 {
        let (v0, v1) = get_current_sqr_price_tick_lower_and_upper(arg2);
        if (arg3) {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg0), v1), 5);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v1), arg1, false), true)
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg0), v0), 5);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v0), arg0, arg1, false), true)
        }
    }

    public fun get_create_pool_sale_amount<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u32) : u64 {
        let v0 = if (arg3 > 0) {
            get_amount_to_liquidity(arg4, math_u128_mul_div_to_u64((arg2 as u128), (arg3 as u128), 10000), arg5, is_reverse<T0, T1>()) + arg1
        } else {
            arg1
        };
        assert!(arg0 >= v0, 6);
        v0
    }

    fun get_current_sqr_price_tick_lower_and_upper(arg0: u32) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(tick_min(arg0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(tick_max(arg0)))
    }

    public fun inject_liquidity_fix_token<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, tick_min(arg2), tick_max(arg2), arg7);
        let v1 = &mut v0;
        add_liquidity_fix_token<T0, T1>(arg0, arg1, v1, arg3, arg4, arg5, arg6, arg7);
        v0
    }

    public fun is_reverse<T0, T1>() : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let v6 = 0;
        let v7 = false;
        let v8 = false;
        while (v6 < v5) {
            let v9 = *0x1::vector::borrow<u8>(&v3, v6);
            if (!v7 && v6 < v4) {
                let v10 = *0x1::vector::borrow<u8>(&v1, v6);
                if (v10 < v9) {
                    v8 = true;
                };
                if (v10 > v9) {
                    v7 = true;
                };
            };
            v6 = v6 + 1;
        };
        if (!v7) {
            if (v4 < v5) {
                v8 = true;
            };
        };
        v8
    }

    public fun math_u128_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2);
        let (v0, v1) = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::overflowing_mul(arg0, arg1);
        if (v1) {
            abort 1
        };
        v0 / arg2
    }

    public fun math_u128_mul_div_to_u64(arg0: u128, arg1: u128, arg2: u128) : u64 {
        (math_u128_mul_div(arg0, arg1, arg2) as u64)
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    fun pow(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            1
        } else {
            let v1 = 1;
            while (arg1 > 1) {
                if (arg1 % 2 == 1) {
                    v1 = v1 * arg0;
                };
                arg1 = arg1 / 2;
                arg0 = arg0 * arg0;
            };
            v1 * arg0
        }
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun swap_to_fixed_price<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, arg4, true, 9223372036854775807, arg5, arg6);
        let v3 = v2;
        let (v4, v5) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg7)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg7)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v1, arg7));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v0, arg7));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, v4, v5, v3);
        send_coin<T0>(arg2, 0x2::tx_context::sender(arg7));
        send_coin<T1>(arg3, 0x2::tx_context::sender(arg7));
    }

    fun tick_max(arg0: u32) : u32 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick();
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg0))))
    }

    fun tick_min(arg0: u32) : u32 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick();
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg0))))
    }

    public fun to_fixed_clmm_price<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u128, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_coins<T0>(arg2, arg7);
        let v1 = merge_coins<T1>(arg3, arg7);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) == arg4) {
            send_coin<T0>(v0, 0x2::tx_context::sender(arg7));
            send_coin<T1>(v1, 0x2::tx_context::sender(arg7));
        } else {
            swap_to_fixed_price<T0, T1>(arg0, arg1, v0, v1, arg5, arg4, arg6, arg7);
        };
    }

    public fun verify_sqrt_price(arg0: u128, arg1: u128) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u256::shlw((arg0 as u256)) / (CONST_DENOMINATOR() as u256);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u256::shrw((arg1 as u256) * (arg1 as u256));
        if (v0 > v1) {
            assert!(v0 - v1 < (pow(2, 35) as u256), 3);
        } else if (v1 > v0) {
            assert!(v1 - v0 < (pow(2, 35) as u256), 3);
        };
    }

    // decompiled from Move bytecode v6
}

