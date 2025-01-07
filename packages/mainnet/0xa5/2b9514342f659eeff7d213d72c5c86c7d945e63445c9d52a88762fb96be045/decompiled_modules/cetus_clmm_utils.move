module 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils {
    struct SwapSafeBeforeEvent has copy, drop {
        coin_a: u64,
        coin_b: u64,
    }

    struct SwapSafeBeforeSwapEvent has copy, drop {
        coin_a: u64,
        coin_b: u64,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        amount_limit: u64,
        sqrt_price_limit: u128,
    }

    struct SwapSafeAfterEvent has copy, drop {
        amount: u64,
        amount_limit: u64,
        by_amount_in: bool,
        a2b: bool,
        price: u64,
        amount_limit_tolerance: u64,
        coin_a_decimals: u8,
        coin_b_decimals: u8,
        coin_a_back: u64,
        coin_b_back: u64,
    }

    struct SwapSafeComputeEvent has copy, drop {
        a: u128,
        b: u128,
        c: u128,
        d: u128,
        e: u128,
        f: u128,
        g: u64,
    }

    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)))
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
        (arg2, arg3)
    }

    public fun add_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg5, arg6);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg3, v1, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg4, v2, arg7)), v0);
    }

    public fun add_liquidity_reverse<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T1, T0>(arg0, arg1, arg2, arg5, arg6);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg4, v1, arg7)), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg3, v2, arg7)), v0);
    }

    public fun get_liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        if (arg1 > arg2) {
            let v0 = arg2;
            arg2 = arg1;
            arg1 = v0;
        };
        if (arg0 <= arg1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg1, arg2, arg3, false)
        } else if (arg0 < arg2) {
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg0, arg2, arg3, false);
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(arg1, arg0, arg4, false);
            if (v2 < v3) {
                v2
            } else {
                v3
            }
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(arg1, arg2, arg4, false)
        }
    }

    public fun get_pool_price_amount_ratio<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u128, u128) {
        get_price_amount_ratio(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0))
    }

    public fun get_price_amount_ratio(arg0: u128, arg1: u128) : (u128, u128) {
        (mul_div_u128(arg0, 18446744073709551616, arg1), mul_div_u128(arg0, arg1, 18446744073709551616))
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2000);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun pow_negtive(arg0: u64, arg1: u8, arg2: u8) : u64 {
        abort 0
    }

    public fun swap_exact<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1
        };
        swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8)
    }

    public fun swap_exact_limit<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun swap_exact_limit_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun swap_exact_reverse<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (!arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1
        };
        let (v1, v2) = swap<T1, T0>(arg0, arg1, arg3, arg2, !arg4, arg5, arg6, v0, arg7, arg8);
        (v2, v1)
    }

    public fun swap_exact_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, _) = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::price_oracle::get_price(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v2 = if (arg9) {
            if (arg8) {
                if (arg3 >= arg2) {
                    ((((10000 as u128) - (arg11 as u128)) * (arg10 as u128) * (v0 as u128) * (0x2::math::pow(10, arg3 - arg2) as u128) / (10000 as u128) / (100000000 as u128)) as u64)
                } else {
                    ((((10000 as u128) - (arg11 as u128)) * (arg10 as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128) / (0x2::math::pow(10, arg2 - arg3) as u128)) as u64)
                }
            } else if (arg2 > arg3) {
                ((((10000 as u128) - (arg11 as u128)) * (arg10 as u128) * (100000000 as u128) * (0x2::math::pow(10, arg2 - arg3) as u128) / (v0 as u128) / (10000 as u128)) as u64)
            } else {
                ((((10000 as u128) - (arg11 as u128)) * (arg10 as u128) * (100000000 as u128) / (10000 as u128) / (0x2::math::pow(10, arg3 - arg2) as u128) / (v0 as u128)) as u64)
            }
        } else if (arg8) {
            if (arg2 >= arg3) {
                ((((10000 as u128) + (arg11 as u128)) * (arg10 as u128) * (0x2::math::pow(10, arg2 - arg3) as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128)) as u64)
            } else {
                ((((10000 as u128) + (arg11 as u128)) * (arg10 as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128) / (0x2::math::pow(10, arg3 - arg2) as u128)) as u64)
            }
        } else if (arg3 >= arg2) {
            ((((10000 as u128) + (arg11 as u128)) * (arg10 as u128) * (0x2::math::pow(10, arg3 - arg2) as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128)) as u64)
        } else {
            ((((10000 as u128) + (arg11 as u128)) * (arg10 as u128) * (v0 as u128) / (10000 as u128) / (100000000 as u128) / (0x2::math::pow(10, arg2 - arg3) as u128)) as u64)
        };
        let v3 = SwapSafeBeforeEvent{
            coin_a : 0x2::coin::value<T0>(&arg6),
            coin_b : 0x2::coin::value<T1>(&arg7),
        };
        0x2::event::emit<SwapSafeBeforeEvent>(v3);
        let v4 = if (arg8) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1
        };
        let (v5, v6) = swap_safe<T0, T1>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, v2, v4, arg12, arg13);
        let v7 = v6;
        let v8 = v5;
        let v9 = SwapSafeAfterEvent{
            amount                 : arg10,
            amount_limit           : v2,
            by_amount_in           : arg9,
            a2b                    : arg8,
            price                  : v0,
            amount_limit_tolerance : arg11,
            coin_a_decimals        : arg2,
            coin_b_decimals        : arg3,
            coin_a_back            : 0x2::coin::value<T0>(&v8),
            coin_b_back            : 0x2::coin::value<T1>(&v7),
        };
        0x2::event::emit<SwapSafeAfterEvent>(v9);
        (v8, v7)
    }

    public fun swap_exact_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, _) = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::price_oracle::get_price(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v2 = if (arg9) {
            if (!arg8) {
                if (arg3 >= arg2) {
                    ((((10000 as u128) - (arg11 as u128)) * (arg10 as u128) * (0x2::math::pow(10, arg3 - arg2) as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128)) as u64)
                } else {
                    ((((10000 as u128) - (arg11 as u128)) * (arg10 as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128) / (0x2::math::pow(10, arg2 - arg3) as u128)) as u64)
                }
            } else if (arg2 >= arg3) {
                ((((10000 as u128) - (arg11 as u128)) * (arg10 as u128) * (0x2::math::pow(10, arg2 - arg3) as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128)) as u64)
            } else {
                ((((10000 as u128) - (arg11 as u128)) * (arg10 as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128) / (0x2::math::pow(10, arg3 - arg2) as u128)) as u64)
            }
        } else if (!arg8) {
            if (arg2 >= arg3) {
                ((((10000 as u128) + (arg11 as u128)) * (arg10 as u128) * (0x2::math::pow(10, arg2 - arg3) as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128)) as u64)
            } else {
                ((((10000 as u128) + (arg11 as u128)) * (arg10 as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128) / (0x2::math::pow(10, arg3 - arg2) as u128)) as u64)
            }
        } else if (arg3 >= arg2) {
            ((((10000 as u128) + (arg11 as u128)) * (arg10 as u128) * (0x2::math::pow(10, arg3 - arg2) as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128)) as u64)
        } else {
            ((((10000 as u128) + (arg11 as u128)) * (arg10 as u128) * (v0 as u128) / (100000000 as u128) / (0x2::math::pow(10, arg2 - arg3) as u128) / (10000 as u128)) as u64)
        };
        let v3 = SwapSafeBeforeEvent{
            coin_a : 0x2::coin::value<T0>(&arg6),
            coin_b : 0x2::coin::value<T1>(&arg7),
        };
        0x2::event::emit<SwapSafeBeforeEvent>(v3);
        let v4 = if (!arg8) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1
        };
        let (v5, v6) = swap_safe<T1, T0>(arg4, arg5, arg7, arg6, !arg8, arg9, arg10, v2, v4, arg12, arg13);
        let v7 = v6;
        let v8 = v5;
        let v9 = SwapSafeAfterEvent{
            amount                 : arg10,
            amount_limit           : v2,
            by_amount_in           : arg9,
            a2b                    : arg8,
            price                  : v0,
            amount_limit_tolerance : arg11,
            coin_a_decimals        : arg2,
            coin_b_decimals        : arg3,
            coin_a_back            : 0x2::coin::value<T0>(&v7),
            coin_b_back            : 0x2::coin::value<T1>(&v8),
        };
        0x2::event::emit<SwapSafeAfterEvent>(v9);
        (v7, v8)
    }

    public fun swap_safe<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg5) {
            assert!(v6 == arg6, 1);
            assert!(v7 >= arg7, 2);
        } else {
            assert!(v7 == arg6, 3);
            assert!(v6 <= arg7, 4);
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg10)))
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        (arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

