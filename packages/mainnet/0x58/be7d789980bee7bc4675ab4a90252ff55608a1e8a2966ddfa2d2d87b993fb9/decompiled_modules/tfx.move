module 0x58be7d789980bee7bc4675ab4a90252ff55608a1e8a2966ddfa2d2d87b993fb9::tfx {
    struct BSE has copy, drop {
        bs: u64,
        ss: u64,
        bi: u64,
        bo: u64,
        si: u64,
        so: u64,
    }

    struct EE has copy, drop {
        EE: u64,
    }

    struct R has copy, drop {
        i: u64,
        o: u64,
        f: u64,
    }

    struct C has copy, drop {
        i: u64,
        o: u64,
        f: u64,
        p: u128,
        e: bool,
    }

    public fun bt<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0x2::sui::SUI>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::partner::Partner, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg8), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg11), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg12), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<0x2::sui::SUI>(arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < (0x1::vector::length<u128>(&arg6) as u64)) {
            let v9 = *0x1::vector::borrow<u64>(&arg7, v8);
            let v10 = if (v9 > v0) {
                v0
            } else {
                v9
            };
            if (v10 < arg9) {
                break
            };
            let (v11, v12) = sw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, *0x1::vector::borrow<u128>(&arg6, v8), true, arg9, v10, arg14, arg15, *0x1::vector::borrow<u64>(&arg8, v8), arg16);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v11;
            v5 = v5 + v12;
            v0 = v0 - v11;
            v1 = v1 + v12;
            v8 = v8 + 1;
        };
        v8 = 0;
        while (v8 < (0x1::vector::length<u128>(&arg10) as u64)) {
            let v13 = *0x1::vector::borrow<u64>(&arg11, v8);
            let v14 = if (v13 > v1) {
                v1
            } else {
                v13
            };
            if (v14 < arg13) {
                break
            };
            let (v15, v16) = sw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, *0x1::vector::borrow<u128>(&arg10, v8), false, arg13, v14, arg14, arg15, *0x1::vector::borrow<u64>(&arg12, v8), arg16);
            if (v15 == 0 || v16 == 0) {
                break
            };
            v3 = v3 + 1;
            v6 = v6 + v15;
            v7 = v7 + v16;
            v1 = v1 - v15;
            v0 = v0 + v16;
            v8 = v8 + 1;
        };
        if (v2 > 0 || v3 > 0) {
            let v17 = BSE{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                si : v6,
                so : v7,
            };
            0x2::event::emit<BSE>(v17);
        } else {
            let v18 = EE{EE: 999};
            0x2::event::emit<EE>(v18);
        };
    }

    fun cs<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : C {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0);
        let v1 = v0;
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0);
        let v4 = R{
            i : 0,
            o : 0,
            f : 0,
        };
        let v5 = C{
            i : 0,
            o : 0,
            f : 0,
            p : v0,
            e : false,
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
                ur(v18, v14, v15, v16);
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
                v5.e = true;
                break
            };
        };
        v5.i = v4.i;
        v5.o = v4.o;
        v5.f = v4.f;
        v5.p = v1;
        v5
    }

    fun op<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64) : u64 {
        assert!(arg4 > 0, 1);
        assert!(arg4 <= arg5, 2);
        assert!(arg8 < arg4, 3);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, v5, v6) = st<T0>(arg0, v2, arg1, arg2);
            if (v6) {
                break
            };
            if (!pk(v5, arg3, arg1)) {
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
            return 0
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v7 = (v1 + v2) / 2;
            let (v8, v9, v10) = st<T0>(arg0, v7, arg1, arg2);
            if (pk(v9, arg3, arg1) && !v10) {
                v0 = v8;
                v1 = v7;
                continue
            };
            v2 = v7;
        };
        v0
    }

    fun pk(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || !arg2 && arg0 >= arg1
    }

    fun sp(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun st<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: u64, arg2: bool, arg3: u128) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = cs<T0>(arg0, !arg2, true, arg1, arg3);
        let v1 = v0.i + v0.f;
        let v2 = v0.o;
        let v3 = v0.e || v1 < arg1;
        if (v2 == 0 || v1 == 0) {
            return (0, 0, true)
        };
        let v4 = if (arg2) {
            (v1 as u128) * 1000000000000 / (v2 as u128) + 1
        } else {
            (v2 as u128) * 1000000000000 / (v1 as u128)
        };
        (v1, v4, v3)
    }

    fun sw<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0x2::sui::SUI>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::partner::Partner, arg5: &0x2::clock::Clock, arg6: u128, arg7: bool, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0);
        let v1 = arg7 && v0 <= arg6 || !arg7 && v0 >= arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = sp(arg6);
        let v3 = op<T0>(arg0, arg7, arg6, v2, arg8, arg9, arg10, arg11, arg12);
        if (v3 < arg8) {
            return (0, 0)
        };
        let v4 = !arg7;
        let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap_partner<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, arg4, v4, (v3 as u128), true, arg6, arg5, arg3, arg13);
        let v8 = v6;
        let v9 = v5;
        assert!(v3 <= arg9, 5);
        let v10 = if (v4) {
            0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8)
        } else {
            0x2::coin::value<0x2::sui::SUI>(&v9)
        };
        let v11 = if (arg7) {
            (((v3 as u128) * 1000000000000 / v2) as u64)
        } else {
            (((v3 as u128) * v2 / 1000000000000) as u64)
        };
        assert!(v10 >= v11, 6);
        let (v12, v13) = if (v4) {
            (0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<0x2::sui::SUI>(arg1, v3, arg13), 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg13))
        } else {
            (0x2::coin::zero<0x2::sui::SUI>(arg13), 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v3, arg13))
        };
        let v14 = v13;
        let v15 = v12;
        let (v16, v17) = if (v4) {
            (0x2::coin::split<0x2::sui::SUI>(&mut v15, v3, arg13), 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg13))
        } else {
            (0x2::coin::zero<0x2::sui::SUI>(arg13), 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v14, v3, arg13))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap_partner<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg0, arg4, v16, v17, v7, arg3);
        0x2::coin::join<0x2::sui::SUI>(&mut v15, v9);
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v14, v8);
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0x2::sui::SUI>(arg1, v15);
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v14);
        (v3, v10)
    }

    fun ur(arg0: &mut R, arg1: u64, arg2: u64, arg3: u64) {
        arg0.i = arg0.i + arg1;
        arg0.o = arg0.o + arg2;
        arg0.f = arg0.f + arg3;
    }

    // decompiled from Move bytecode v6
}

