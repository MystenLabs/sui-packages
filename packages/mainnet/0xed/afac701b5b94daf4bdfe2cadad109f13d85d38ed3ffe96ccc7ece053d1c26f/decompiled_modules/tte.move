module 0xedafac701b5b94daf4bdfe2cadad109f13d85d38ed3ffe96ccc7ece053d1c26f::tte {
    struct SR has copy, drop {
        ai: u64,
        ao: u64,
        fa: u64,
    }

    struct CSR has copy, drop {
        ai: u64,
        ao: u64,
        fa: u64,
        asp: u128,
        ie: bool,
    }

    fun csr<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : CSR {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0);
        let v1 = v0;
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0);
        let v4 = SR{
            ai : 0,
            ao : 0,
            fa : 0,
        };
        let v5 = CSR{
            ai  : 0,
            ao  : 0,
            fa  : 0,
            asp : v0,
            ie  : false,
        };
        while (arg3 > 0 && v1 != arg4) {
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, v3, arg1);
            let v8 = v6;
            if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(v6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636))) {
                v8 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636);
            } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gt(v6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636))) {
                v8 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636);
            };
            let v9 = if (arg1) {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::max(arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v8))
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::min(arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v8))
            };
            let (v10, v11, v12, v13) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(v1, v9, v2, (arg3 as u128), arg2, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0));
            let v14 = (v11 as u64);
            let v15 = (v12 as u64);
            let v16 = (v13 as u64);
            if (v14 != 0 || v16 != 0) {
                if (arg2) {
                    let v17 = arg3 - v14;
                    arg3 = v17 - v16;
                } else {
                    arg3 = arg3 - v15;
                };
                let v18 = &mut v4;
                usr(v18, v14, v15, v16);
            };
            if (v10 == v9) {
                v1 = v9;
                if (v7) {
                    let v19 = if (arg1) {
                        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::neg(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, v8)))
                    } else {
                        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, v8))
                    };
                    v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::add_delta(v2, v19);
                };
                let v20 = if (arg1) {
                    0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v8, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1))
                } else {
                    v8
                };
                v3 = v20;
            } else {
                v1 = v10;
            };
            if (v2 == 0) {
                v5.ie = true;
                break
            };
        };
        v5.ai = v4.ai;
        v5.ao = v4.ao;
        v5.fa = v4.fa;
        v5.asp = v1;
        v5
    }

    fun opt<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64) : u64 {
        assert!(arg4 > 0, 13906835192250826756);
        assert!(arg4 <= arg5, 13906835196545925126);
        assert!(arg8 < arg4, 13906835200841023496);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, v5, v6) = sts<T0>(arg0, v2, arg1, arg2);
            if (v6) {
                break
            };
            if (!pok(v5, arg3, arg1)) {
                break
            };
            v0 = v4;
            if (v2 == arg5) {
                return v4
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return v0
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v7 = (v1 + v2) / 2;
            let (v8, v9, v10) = sts<T0>(arg0, v7, arg1, arg2);
            if (pok(v9, arg3, arg1) && !v10) {
                v0 = v8;
                v1 = v7;
                continue
            };
            v2 = v7;
        };
        v0
    }

    fun pok(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 >= arg1
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun sts<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: u64, arg2: bool, arg3: u128) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = csr<T0>(arg0, !arg2, true, arg1, arg3);
        let v1 = v0.ie || v0.ai + v0.fa < arg1;
        let v2 = v0.ao;
        let v3 = v0.ai + v0.fa;
        if (v2 == 0 || v3 == 0) {
            return (0, 0, true)
        };
        let v4 = if (arg2) {
            (v3 as u128) * 1000000000000 / (v2 as u128) + 1
        } else {
            (v2 as u128) * 1000000000000 / (v3 as u128)
        };
        (v3, v4, v1)
    }

    fun tt<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = arg6 && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0) <= arg5 || 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0) >= arg5;
        if (!v0) {
            return (0, 0)
        };
        let v1 = spstrs(arg5);
        let v2 = opt<T0>(arg0, arg6, arg5, v1, arg7, arg8, arg9, arg10, arg11);
        if (v2 < arg7) {
            return (0, 0)
        };
        let v3 = !arg6;
        let (v4, v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, 0x2::tx_context::sender(arg12), v3, (v2 as u128), true, arg5, arg4, arg3, arg12);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let (_, _, v12) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7);
        let (v13, v14) = if (v3) {
            (v12, 0)
        } else {
            (0, v12)
        };
        let v15 = if (v3) {
            v13
        } else {
            v14
        };
        let v16 = if (v3) {
            0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8)
        } else {
            0x2::coin::value<0x2::sui::SUI>(&v9)
        };
        let v17 = if (arg6) {
            (((v15 as u128) * 1000000000000 / v1) as u64)
        } else {
            (((v15 as u128) * v1 / 1000000000000) as u64)
        };
        assert!(v16 >= v17, 13906835948164939778);
        let (v18, v19) = if (v3) {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<0x2::sui::SUI>(arg1, arg2, v13, arg12), 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg12))
        } else {
            (0x2::coin::zero<0x2::sui::SUI>(arg12), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v14, arg12))
        };
        let v20 = v19;
        let v21 = v18;
        let (v22, v23) = if (v3) {
            (0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg12), 0x2::coin::split<0x2::sui::SUI>(&mut v21, v13, arg12))
        } else {
            (0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v20, v14, arg12), 0x2::coin::zero<0x2::sui::SUI>(arg12))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, v23, v22, v7, arg3);
        0x2::coin::join<0x2::sui::SUI>(&mut v21, v9);
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v20, v8);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<0x2::sui::SUI>(arg1, arg2, v21, arg12);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v20, arg12);
        (v15, v16)
    }

    public fun ttb<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg5)) {
            let v3 = *0x1::vector::borrow<u64>(&arg6, v2);
            let v4 = if (v3 > v0) {
                v0
            } else {
                v3
            };
            if (v4 < arg8) {
                break
            };
            let (v5, v6) = tt<T0>(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg5, v2), true, arg8, v4, arg13, arg14, *0x1::vector::borrow<u64>(&arg7, v2), arg15);
            if (v5 == 0 || v6 == 0) {
                break
            };
            v0 = v0 - v5;
            v1 = v1 + v6;
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg9)) {
            let v7 = *0x1::vector::borrow<u64>(&arg10, v2);
            let v8 = if (v7 > v1) {
                v1
            } else {
                v7
            };
            if (v8 < arg12) {
                break
            };
            let (v9, v10) = tt<T0>(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg9, v2), false, arg12, v8, arg13, arg14, *0x1::vector::borrow<u64>(&arg11, v2), arg15);
            if (v9 == 0 || v10 == 0) {
                break
            };
            v1 = v1 - v9;
            v0 = v0 + v10;
            v2 = v2 + 1;
        };
    }

    fun usr(arg0: &mut SR, arg1: u64, arg2: u64, arg3: u64) {
        arg0.ai = arg0.ai + arg1;
        arg0.ao = arg0.ao + arg2;
        arg0.fa = arg0.fa + arg3;
    }

    // decompiled from Move bytecode v6
}

