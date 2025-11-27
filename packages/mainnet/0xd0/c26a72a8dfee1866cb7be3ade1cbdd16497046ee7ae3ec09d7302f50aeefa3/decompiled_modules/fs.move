module 0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::fs {
    struct EE has copy, drop {
        ec: u64,
        ph: u64,
    }

    struct SSE<phantom T0, phantom T1> has copy, drop {
        d: u64,
        tit: u64,
        tot: u64,
        l: u64,
    }

    public fun bee<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::partner::Partner, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg7: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg8: &0x2::clock::Clock, arg9: u64, arg10: vector<bool>, arg11: vector<u64>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ut::check_deadline(arg8, arg9);
        if (v0 != 0) {
            let v1 = EE{
                ec : v0,
                ph : 1,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg6);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg7);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x1::vector::length<bool>(&arg10);
        while (v9 < v10) {
            let v11 = *0x1::vector::borrow<bool>(&arg10, v9);
            let v12 = *0x1::vector::borrow<u64>(&arg12, v9);
            let v13 = if (v11) {
                0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::min_sp() + 1
            } else {
                0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::max_sp() - 1
            };
            let (v14, v15) = vs<T0, T1>(arg2, arg0, v2, v3, v11, *0x1::vector::borrow<u64>(&arg11, v9), v12);
            if (v14 != 0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::good()) {
                let v16 = EE{
                    ec : v14,
                    ph : 2,
                };
                0x2::event::emit<EE>(v16);
                break
            };
            let (v17, v18, v19, v20, v21) = do<T0, T1>(arg6, arg7, arg2, arg3, arg0, arg1, arg4, arg5, v11, v15, v12, v13, arg8, arg13);
            if (v17 != 0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::good()) {
                let v22 = EE{
                    ec : v17,
                    ph : 3,
                };
                0x2::event::emit<EE>(v22);
                v9 = v9 + 1;
                continue
            };
            let v23 = v2 + v20;
            v2 = v23 - v18;
            let v24 = v3 + v21;
            v3 = v24 - v19;
            v4 = v4 + v18;
            v5 = v5 + v19;
            v6 = v6 + v20;
            v7 = v7 + v21;
            v8 = v8 + v12;
            v9 = v9 + 1;
        };
        let v25 = if (v4 > 0) {
            true
        } else if (v5 > 0) {
            true
        } else if (v6 > 0) {
            true
        } else {
            v7 > 0
        };
        if (v25) {
            let v26 = if (v10 > 0 && *0x1::vector::borrow<bool>(&arg10, 0)) {
                1
            } else {
                0
            };
            let v27 = SSE<T0, T1>{
                d   : v26,
                tit : v4 + v5,
                tot : v6 + v7,
                l   : v8,
            };
            0x2::event::emit<SSE<T0, T1>>(v27);
        };
    }

    fun do<T0, T1>(arg0: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::partner::Partner, arg6: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg7: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg8: bool, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap_with_partner<T0, T1>(arg2, arg3, arg4, arg5, arg8, true, arg9, arg11, arg6, arg7, arg12);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let v8 = if (arg8) {
            v7
        } else {
            v6
        };
        assert!(v8 >= arg10, 0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::e_slip());
        let v9 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v3);
        let (v10, v11) = if (arg8) {
            (v9, 0)
        } else {
            (0, v9)
        };
        let (v12, v13) = if (arg8) {
            (0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg0, v9, arg13), 0x2::coin::zero<T1>(arg13))
        } else {
            (0x2::coin::zero<T0>(arg13), 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg1, v9, arg13))
        };
        let v14 = v13;
        let v15 = v12;
        let (v16, v17) = if (arg8) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v15, v9, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v14, v9, arg13)))
        };
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg4, arg5, v16, v17, v3);
        0x2::coin::join<T0>(&mut v15, 0x2::coin::from_balance<T0>(v5, arg13));
        0x2::coin::join<T1>(&mut v14, 0x2::coin::from_balance<T1>(v4, arg13));
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg0, v15);
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v14);
        (0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::good(), v10, v11, v6, v7)
    }

    fun vs<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : (u64, u64) {
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg4, true, arg5);
        let (v1, _, _, _) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_fees_amount(&v0);
        if (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v0) < arg6) {
            return (0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::e_slip(), 0)
        };
        if (arg4) {
            if (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_in(&v0) + v1 > arg2) {
                return (0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::e_inp(), 0)
            };
        } else if (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_in(&v0) + v1 > arg3) {
            return (0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::e_inp(), 0)
        };
        (0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ct::good(), arg5)
    }

    // decompiled from Move bytecode v6
}

