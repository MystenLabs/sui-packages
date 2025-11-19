module 0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::bluefin {
    struct SwapErrorEvent has copy, drop {
        error_code: u64,
        phase: u64,
    }

    struct SwapSummaryEvent<phantom T0, phantom T1> has copy, drop {
        total_in_t0: u64,
        total_in_t1: u64,
        total_out_t0: u64,
        total_out_t1: u64,
    }

    public fun batch<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: u64, arg6: vector<bool>, arg7: vector<u64>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::utils::check_deadline(arg3, arg5, true);
        if (v0 != 0) {
            let v1 = SwapErrorEvent{
                error_code : v0,
                phase      : 1,
            };
            0x2::event::emit<SwapErrorEvent>(v1);
            return
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg1);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<bool>(&arg6)) {
            let v9 = *0x1::vector::borrow<bool>(&arg6, v8);
            let v10 = *0x1::vector::borrow<u64>(&arg8, v8);
            let v11 = if (v9) {
                0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::min_sqrt_price() + 1
            } else {
                0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::max_sqrt_price() - 1
            };
            let (v12, v13) = vbac_exact_in<T0, T1>(arg0, v2, v3, v9, *0x1::vector::borrow<u64>(&arg7, v8), v10, v11);
            if (v12 != 0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::e_no_error()) {
                let v14 = SwapErrorEvent{
                    error_code : v12,
                    phase      : 2,
                };
                0x2::event::emit<SwapErrorEvent>(v14);
                v8 = v8 + 1;
                continue
            };
            let (v15, v16, v17, v18, v19) = swap_exact_in<T0, T1>(arg1, arg2, arg4, arg0, v9, v13, v10, v11, arg3, arg9);
            if (v15 != 0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::e_no_error()) {
                let v20 = SwapErrorEvent{
                    error_code : v15,
                    phase      : 3,
                };
                0x2::event::emit<SwapErrorEvent>(v20);
                v8 = v8 + 1;
                continue
            };
            let v21 = v2 + v18;
            v2 = v21 - v16;
            let v22 = v3 + v19;
            v3 = v22 - v17;
            v4 = v4 + v16;
            v5 = v5 + v17;
            v6 = v6 + v18;
            v7 = v7 + v19;
            v8 = v8 + 1;
        };
        let v23 = if (v4 > 0) {
            true
        } else if (v5 > 0) {
            true
        } else if (v6 > 0) {
            true
        } else {
            v7 > 0
        };
        if (v23) {
            let v24 = SwapSummaryEvent<T0, T1>{
                total_in_t0  : v4,
                total_in_t1  : v5,
                total_out_t0 : v6,
                total_out_t1 : v7,
            };
            0x2::event::emit<SwapSummaryEvent<T0, T1>>(v24);
        };
    }

    fun swap_exact_in<T0, T1>(arg0: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
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
        assert!(v8 >= arg6, 0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::e_amount_out_too_low());
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
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin_with_event<T0>(arg0, v15);
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin_with_event<T1>(arg1, v14);
        (0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::e_no_error(), v10, v11, v6, v7)
    }

    fun vbac_exact_in<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u128) : (u64, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg3, true, arg4, arg6);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v0);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0) < arg5) {
            return (0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::e_amount_out_too_low(), 0)
        };
        if (arg3) {
            if (v1 > arg1) {
                return (0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::e_insufficient_input_balance(), 0)
            };
        } else if (v1 > arg2) {
            return (0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::e_insufficient_input_balance(), 0)
        };
        (0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts::e_no_error(), v1)
    }

    // decompiled from Move bytecode v6
}

