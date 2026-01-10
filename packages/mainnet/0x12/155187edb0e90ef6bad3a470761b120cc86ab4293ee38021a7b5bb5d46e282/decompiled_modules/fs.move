module 0x12155187edb0e90ef6bad3a470761b120cc86ab4293ee38021a7b5bb5d46e282::fs {
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

    public fun bt(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::partner::Partner, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0x2::sui::SUI>, arg6: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: vector<u128>, arg14: vector<u64>, arg15: vector<u64>, arg16: u64, arg17: u8, arg18: u8, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg10), 4);
        assert!(0x1::vector::length<u128>(&arg9) == 0x1::vector::length<u64>(&arg11), 4);
        assert!(0x1::vector::length<u128>(&arg13) == 0x1::vector::length<u64>(&arg14), 4);
        assert!(0x1::vector::length<u128>(&arg13) == 0x1::vector::length<u64>(&arg15), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<0x2::sui::SUI>(arg5);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < (0x1::vector::length<u128>(&arg9) as u64)) {
            let v9 = *0x1::vector::borrow<u64>(&arg10, v8);
            let v10 = if (v9 > v0) {
                v0
            } else {
                v9
            };
            if (v10 < arg12) {
                break
            };
            let (v11, v12) = sw(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, *0x1::vector::borrow<u128>(&arg9, v8), true, arg12, v10, arg17, arg18, *0x1::vector::borrow<u64>(&arg11, v8), arg19);
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
        while (v8 < (0x1::vector::length<u128>(&arg13) as u64)) {
            let v13 = *0x1::vector::borrow<u64>(&arg14, v8);
            let v14 = if (v13 > v1) {
                v1
            } else {
                v13
            };
            if (v14 < arg16) {
                break
            };
            let (v15, v16) = sw(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, *0x1::vector::borrow<u128>(&arg13, v8), false, arg16, v14, arg17, arg18, *0x1::vector::borrow<u64>(&arg15, v8), arg19);
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

    fun iv(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun op(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64) : u64 {
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
            let (v4, v5, v6) = sm(arg0, arg1, v2, arg2);
            if (v6) {
                break
            };
            if (!pk(v5, arg3, arg2)) {
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
            let (v8, v9, v10) = sm(arg0, arg1, v7, arg2);
            if (pk(v9, arg3, arg2) && !v10) {
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

    fun sm(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg2: u64, arg3: bool) : (u64, u128, bool) {
        if (arg2 == 0) {
            return (0, 0, true)
        };
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, arg3, true, arg2);
        let (v1, _, _, _) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_fees_amount(&v0);
        let v5 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_in(&v0) + v1;
        let v6 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v0);
        if (v5 == 0 || v6 == 0) {
            return (0, 0, true)
        };
        let v7 = if (arg3) {
            (v5 as u128) * 1000000000000 / (v6 as u128) + 1
        } else {
            (v6 as u128) * 1000000000000 / (v5 as u128)
        };
        (v5, v7, false)
    }

    fun sp(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun sw(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::partner::Partner, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0x2::sui::SUI>, arg6: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u128, arg10: bool, arg11: u64, arg12: u64, arg13: u8, arg14: u8, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = iv(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0));
        let v1 = arg10 && v0 <= arg9 || !arg10 && v0 >= arg9;
        if (!v1) {
            return (0, 0)
        };
        let v2 = sp(arg9);
        let v3 = op(arg7, arg0, arg10, v2, arg11, arg12, arg13, arg14, arg15);
        if (v3 < arg11) {
            return (0, 0)
        };
        let (v4, v5, v6) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap_with_partner<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg7, arg2, arg0, arg1, arg10, true, v3, iv(arg9), arg3, arg4, arg8);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v7);
        assert!(v10 <= arg12, 5);
        let v11 = if (arg10) {
            0x2::balance::value<0x2::sui::SUI>(&v8)
        } else {
            0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v9)
        };
        let v12 = if (arg10) {
            (((v10 as u128) * 1000000000000 / v2) as u64)
        } else {
            (((v10 as u128) * v2 / 1000000000000) as u64)
        };
        assert!(v11 >= v12, 6);
        let (v13, v14) = if (arg10) {
            (0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, v10, arg16), 0x2::coin::zero<0x2::sui::SUI>(arg16))
        } else {
            (0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg16), 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<0x2::sui::SUI>(arg5, v10, arg16))
        };
        let v15 = v14;
        let v16 = v13;
        let (v17, v18) = if (arg10) {
            (0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v16, v10, arg16)), 0x2::balance::zero<0x2::sui::SUI>())
        } else {
            (0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v15, v10, arg16)))
        };
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap_with_partner<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg7, arg0, arg1, v17, v18, v7);
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v16, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, arg16));
        0x2::coin::join<0x2::sui::SUI>(&mut v15, 0x2::coin::from_balance<0x2::sui::SUI>(v8, arg16));
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, v16);
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<0x2::sui::SUI>(arg5, v15);
        (v10, v11)
    }

    // decompiled from Move bytecode v6
}

