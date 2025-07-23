module 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils {
    struct SwapSafeBeforeEvent has copy, drop {
        coin_a: u64,
        coin_b: u64,
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

    public fun get_pool_price_amount_ratio<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : (u128, u128) {
        get_price_amount_ratio(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0))
    }

    public fun get_price_amount_ratio(arg0: u128, arg1: u128) : (u128, u128) {
        (mul_div_u128(arg0, 18446744073709551616, arg1), mul_div_u128(arg0, arg1, 18446744073709551616))
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2000);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun swap_exact_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, _) = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::price_oracle::get_price(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v2 = if (arg8) {
            if (arg7) {
                if (arg3 >= arg2) {
                    ((((10000 as u128) - (arg10 as u128)) * (arg9 as u128) * (v0 as u128) * (0x2::math::pow(10, arg3 - arg2) as u128) / (10000 as u128) / (100000000 as u128)) as u64)
                } else {
                    ((((10000 as u128) - (arg10 as u128)) * (arg9 as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128) / (0x2::math::pow(10, arg2 - arg3) as u128)) as u64)
                }
            } else if (arg2 >= arg3) {
                ((((10000 as u128) - (arg10 as u128)) * (arg9 as u128) * (100000000 as u128) * (0x2::math::pow(10, arg2 - arg3) as u128) / (v0 as u128) / (10000 as u128)) as u64)
            } else {
                ((((10000 as u128) - (arg10 as u128)) * (arg9 as u128) * (100000000 as u128) / (10000 as u128) / (0x2::math::pow(10, arg3 - arg2) as u128) / (v0 as u128)) as u64)
            }
        } else if (arg7) {
            if (arg2 >= arg3) {
                ((((10000 as u128) + (arg10 as u128)) * (arg9 as u128) * (0x2::math::pow(10, arg2 - arg3) as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128)) as u64)
            } else {
                ((((10000 as u128) + (arg10 as u128)) * (arg9 as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128) / (0x2::math::pow(10, arg3 - arg2) as u128)) as u64)
            }
        } else if (arg3 >= arg2) {
            ((((10000 as u128) + (arg10 as u128)) * (arg9 as u128) * (0x2::math::pow(10, arg3 - arg2) as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128)) as u64)
        } else {
            ((((10000 as u128) + (arg10 as u128)) * (arg9 as u128) * (v0 as u128) / (10000 as u128) / (100000000 as u128) / (0x2::math::pow(10, arg2 - arg3) as u128)) as u64)
        };
        let v3 = SwapSafeBeforeEvent{
            coin_a : 0x2::coin::value<T0>(&arg5),
            coin_b : 0x2::coin::value<T1>(&arg6),
        };
        0x2::event::emit<SwapSafeBeforeEvent>(v3);
        let v4 = if (arg7) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1
        };
        let (v5, v6) = swap_safe<T0, T1>(arg4, arg5, arg6, arg7, arg8, arg9, v2, v4, arg11, arg12, arg13);
        let v7 = v6;
        let v8 = v5;
        let v9 = SwapSafeAfterEvent{
            amount                 : arg9,
            amount_limit           : v2,
            by_amount_in           : arg8,
            a2b                    : arg7,
            price                  : v0,
            amount_limit_tolerance : arg10,
            coin_a_decimals        : arg2,
            coin_b_decimals        : arg3,
            coin_a_back            : 0x2::coin::value<T0>(&v8),
            coin_b_back            : 0x2::coin::value<T1>(&v7),
        };
        0x2::event::emit<SwapSafeAfterEvent>(v9);
        (v8, v7)
    }

    public fun swap_exact_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, _) = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::price_oracle::get_price(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v2 = if (arg8) {
            if (arg7) {
                if (arg3 >= arg2) {
                    ((((10000 as u128) - (arg10 as u128)) * (arg9 as u128) * (v0 as u128) * (0x2::math::pow(10, arg3 - arg2) as u128) / (10000 as u128) / (100000000 as u128)) as u64)
                } else {
                    ((((10000 as u128) - (arg10 as u128)) * (arg9 as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128) / (0x2::math::pow(10, arg2 - arg3) as u128)) as u64)
                }
            } else if (arg2 >= arg3) {
                ((((10000 as u128) - (arg10 as u128)) * (arg9 as u128) * (100000000 as u128) * (0x2::math::pow(10, arg2 - arg3) as u128) / (v0 as u128) / (10000 as u128)) as u64)
            } else {
                ((((10000 as u128) - (arg10 as u128)) * (arg9 as u128) * (100000000 as u128) / (10000 as u128) / (0x2::math::pow(10, arg3 - arg2) as u128) / (v0 as u128)) as u64)
            }
        } else if (arg7) {
            if (arg2 >= arg3) {
                ((((10000 as u128) + (arg10 as u128)) * (arg9 as u128) * (0x2::math::pow(10, arg2 - arg3) as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128)) as u64)
            } else {
                ((((10000 as u128) + (arg10 as u128)) * (arg9 as u128) * (100000000 as u128) / (v0 as u128) / (10000 as u128) / (0x2::math::pow(10, arg3 - arg2) as u128)) as u64)
            }
        } else if (arg3 >= arg2) {
            ((((10000 as u128) + (arg10 as u128)) * (arg9 as u128) * (0x2::math::pow(10, arg3 - arg2) as u128) * (v0 as u128) / (100000000 as u128) / (10000 as u128)) as u64)
        } else {
            ((((10000 as u128) + (arg10 as u128)) * (arg9 as u128) * (v0 as u128) / (10000 as u128) / (100000000 as u128) / (0x2::math::pow(10, arg2 - arg3) as u128)) as u64)
        };
        let v3 = SwapSafeBeforeEvent{
            coin_a : 0x2::coin::value<T0>(&arg5),
            coin_b : 0x2::coin::value<T1>(&arg6),
        };
        0x2::event::emit<SwapSafeBeforeEvent>(v3);
        let v4 = if (!arg7) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1
        };
        let (v5, v6) = swap_safe<T1, T0>(arg4, arg6, arg5, !arg7, arg8, arg9, v2, v4, arg11, arg12, arg13);
        let v7 = v6;
        let v8 = v5;
        let v9 = SwapSafeAfterEvent{
            amount                 : arg9,
            amount_limit           : v2,
            by_amount_in           : arg8,
            a2b                    : arg7,
            price                  : v0,
            amount_limit_tolerance : arg10,
            coin_a_decimals        : arg2,
            coin_b_decimals        : arg3,
            coin_a_back            : 0x2::coin::value<T0>(&v7),
            coin_b_back            : 0x2::coin::value<T1>(&v8),
        };
        0x2::event::emit<SwapSafeAfterEvent>(v9);
        (v7, v8)
    }

    public fun swap_safe<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg7, arg9, arg8, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v8 = if (arg3) {
            v6
        } else {
            v7
        };
        let v9 = if (arg3) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg4) {
            assert!(v8 == arg5, 1);
            assert!(v9 >= arg6, 2);
        } else {
            assert!(v9 == arg5, 3);
            assert!(v8 <= arg6, 4);
        };
        let (v10, v11) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v8, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v8, arg10)))
        };
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v4, arg10));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, v10, v11, arg8, arg10);
        (arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

