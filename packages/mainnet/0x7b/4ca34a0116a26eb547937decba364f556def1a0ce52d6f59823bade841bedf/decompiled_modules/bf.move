module 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::bf {
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

    public fun bee<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: u64, arg6: vector<bool>, arg7: vector<u64>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ut::check_deadline(arg3, arg5);
        if (v0 != 0) {
            let v1 = EE{
                ec : v0,
                ph : 1,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg1);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x1::vector::length<bool>(&arg6);
        while (v9 < v10) {
            let v11 = *0x1::vector::borrow<bool>(&arg6, v9);
            let v12 = *0x1::vector::borrow<u64>(&arg8, v9);
            let v13 = if (v11) {
                0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::min_sp() + 1
            } else {
                0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::max_sp() - 1
            };
            let (v14, v15) = vs<T0, T1>(arg0, v2, v3, v11, *0x1::vector::borrow<u64>(&arg7, v9), v12, v13);
            if (v14 != 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good()) {
                let v16 = EE{
                    ec : v14,
                    ph : 2,
                };
                0x2::event::emit<EE>(v16);
                break
            };
            let (v17, v18, v19, v20, v21) = do<T0, T1>(arg1, arg2, arg4, arg0, v11, v15, v12, v13, arg3, arg9);
            if (v17 != 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good()) {
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
            let v26 = if (v10 > 0 && *0x1::vector::borrow<bool>(&arg6, 0)) {
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

    fun do<T0, T1>(arg0: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg8, arg2, arg3, arg4, true, arg5, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let v8 = if (arg4) {
            v7
        } else {
            v6
        };
        assert!(v8 >= arg6, 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::e_slip());
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        let (v10, v11) = if (arg4) {
            (v9, 0)
        } else {
            (0, v9)
        };
        let (v12, v13) = if (arg4) {
            (0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg0, v9, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg1, v9, arg9))
        };
        let v14 = v13;
        let v15 = v12;
        let (v16, v17) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v15, v9, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v14, v9, arg9)))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg2, arg3, v16, v17, v3);
        0x2::coin::join<T0>(&mut v15, 0x2::coin::from_balance<T0>(v5, arg9));
        0x2::coin::join<T1>(&mut v14, 0x2::coin::from_balance<T1>(v4, arg9));
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg0, v15);
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v14);
        (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good(), v10, v11, v6, v7)
    }

    fun vs<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u128) : (u64, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg3, true, arg4, arg6);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v0);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0) < arg5) {
            return (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::e_slip(), 0)
        };
        if (arg3) {
            if (v1 > arg1) {
                return (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::e_inp(), 0)
            };
        } else if (v1 > arg2) {
            return (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::e_inp(), 0)
        };
        (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good(), v1)
    }

    // decompiled from Move bytecode v6
}

