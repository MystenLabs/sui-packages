module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::choose {
    public fun fire__b_ab__b_ab__from_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg2, false, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v17, v20);
        0x2::balance::destroy_zero<T1>(v19);
        let v21 = v18;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__b_ab__b_ab__from_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg2, true, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, v17, 0x2::balance::zero<T1>(), v20);
        0x2::balance::destroy_zero<T0>(v18);
        let v21 = v19;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__b_ab__b_ba__from_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg2, true, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, v17, 0x2::balance::zero<T0>(), v20);
        0x2::balance::destroy_zero<T1>(v18);
        let v21 = v19;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__b_ab__b_ba__from_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg2, false, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), v17, v20);
        0x2::balance::destroy_zero<T0>(v19);
        let v21 = v18;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__b_ab__c_ab__from_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg2, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg3, false, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::balance::zero<T0>(), v17, v20);
        0x2::balance::destroy_zero<T1>(v19);
        let v21 = v18;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__b_ab__c_ab__from_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg2, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg3, true, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg3, v17, 0x2::balance::zero<T1>(), v20);
        0x2::balance::destroy_zero<T0>(v18);
        let v21 = v19;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__b_ab__c_ba__from_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg2, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg3, true, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg3, v17, 0x2::balance::zero<T0>(), v20);
        0x2::balance::destroy_zero<T1>(v18);
        let v21 = v19;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__b_ab__c_ba__from_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg2, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg3, false, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg3, 0x2::balance::zero<T1>(), v17, v20);
        0x2::balance::destroy_zero<T0>(v19);
        let v21 = v18;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__b_ba__b_ab__from_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg2, false, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v17, v20);
        0x2::balance::destroy_zero<T1>(v19);
        let v21 = v18;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__b_ba__b_ab__from_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg2, true, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, v17, 0x2::balance::zero<T1>(), v20);
        0x2::balance::destroy_zero<T0>(v18);
        let v21 = v19;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::split<T1>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v16)), 0x2::balance::zero<T0>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__b_ba__b_ba__from_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg2, true, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, v17, 0x2::balance::zero<T0>(), v20);
        0x2::balance::destroy_zero<T1>(v18);
        let v21 = v19;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__b_ba__b_ba__from_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg2, false, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), v17, v20);
        0x2::balance::destroy_zero<T0>(v19);
        let v21 = v18;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::split<T1>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v16)), 0x2::balance::zero<T0>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__b_ba__c_ab__from_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg0, arg2, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg3, false, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::balance::zero<T0>(), v17, v20);
        0x2::balance::destroy_zero<T1>(v19);
        let v21 = v18;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__b_ba__c_ab__from_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg0, arg2, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg3, true, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg3, v17, 0x2::balance::zero<T1>(), v20);
        0x2::balance::destroy_zero<T0>(v18);
        let v21 = v19;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::split<T1>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v16)), 0x2::balance::zero<T0>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__b_ba__c_ba__from_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg0, arg2, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg3, true, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg3, v17, 0x2::balance::zero<T0>(), v20);
        0x2::balance::destroy_zero<T1>(v18);
        let v21 = v19;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__b_ba__c_ba__from_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg0, arg2, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg3, false, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg3, 0x2::balance::zero<T1>(), v17, v20);
        0x2::balance::destroy_zero<T0>(v19);
        let v21 = v18;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::split<T1>(&mut v21, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v16)), 0x2::balance::zero<T0>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ab__b_ab__from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg3, false, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::balance::zero<T0>(), v17, v20);
        0x2::balance::destroy_zero<T1>(v19);
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ab__b_ab__from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg3, true, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg3, v17, 0x2::balance::zero<T1>(), v20);
        0x2::balance::destroy_zero<T0>(v18);
        let v21 = v19;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ab__b_ba__from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg1, arg3, true, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg1, arg3, v17, 0x2::balance::zero<T0>(), v20);
        0x2::balance::destroy_zero<T1>(v18);
        let v21 = v19;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ab__b_ba__from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg1, arg3, false, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg1, arg3, 0x2::balance::zero<T1>(), v17, v20);
        0x2::balance::destroy_zero<T0>(v19);
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ab__c_ab__from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v17, v20);
        0x2::balance::destroy_zero<T1>(v19);
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__c_ab__c_ab__from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v17, 0x2::balance::zero<T1>(), v20);
        0x2::balance::destroy_zero<T0>(v18);
        let v21 = v19;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__c_ab__c_ba__from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, v17, 0x2::balance::zero<T0>(), v20);
        0x2::balance::destroy_zero<T1>(v18);
        let v21 = v19;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__c_ab__c_ba__from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), v17, v20);
        0x2::balance::destroy_zero<T0>(v19);
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__c_ba__b_ab__from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg3, false, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::balance::zero<T0>(), v17, v20);
        0x2::balance::destroy_zero<T1>(v19);
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ba__b_ab__from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg3, true, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg3, v17, 0x2::balance::zero<T1>(), v20);
        0x2::balance::destroy_zero<T0>(v18);
        let v21 = v19;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16)), 0x2::balance::zero<T0>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ba__b_ba__from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg1, arg3, true, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg1, arg3, v17, 0x2::balance::zero<T0>(), v20);
        0x2::balance::destroy_zero<T1>(v18);
        let v21 = v19;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ba__b_ba__from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg5;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg5));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v1);
        let v4 = 0;
        while (v4 < arg7 && arg5 < arg6) {
            let v5 = (arg6 - arg5) / 3;
            let v6 = arg5 + v5;
            let v7 = arg6 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg5 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg6 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg1, arg3, false, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg1, arg3, 0x2::balance::zero<T1>(), v17, v20);
        0x2::balance::destroy_zero<T0>(v19);
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16)), 0x2::balance::zero<T0>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    public fun fire__c_ba__c_ab__from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v17, v20);
        0x2::balance::destroy_zero<T1>(v19);
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__c_ba__c_ab__from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v17, 0x2::balance::zero<T1>(), v20);
        0x2::balance::destroy_zero<T0>(v18);
        let v21 = v19;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16)), 0x2::balance::zero<T0>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__c_ba__c_ba__from_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        let v16 = v15;
        0x2::balance::destroy_zero<T0>(v14);
        let v17 = v13;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, v17, 0x2::balance::zero<T0>(), v20);
        0x2::balance::destroy_zero<T1>(v18);
        let v21 = v19;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16)), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T0>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun fire__c_ba__c_ba__from_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
        assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
        let v0 = arg4;
        let v1 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, arg4));
        let v2 = v1;
        let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v1);
        let v4 = 0;
        while (v4 < arg6 && arg4 < arg5) {
            let v5 = (arg5 - arg4) / 3;
            let v6 = arg4 + v5;
            let v7 = arg5 - v5;
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, v6));
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v6, v8);
            if (v9 > v3) {
                v3 = v9;
                v0 = v6;
                v2 = v8;
            };
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, v7));
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v7, v10);
            if (v11 > v3) {
                v3 = v11;
                v0 = v7;
                v2 = v10;
            };
            if (v9 < v11) {
                arg4 = v6 + 1;
            } else {
                let v12 = if (v7 == 0) {
                    0
                } else {
                    v7 - 1
                };
                arg5 = v12;
            };
            v4 = v4 + 1;
        };
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v0, v2, arg8);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v13);
        let v17 = v14;
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v17), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), v17, v20);
        0x2::balance::destroy_zero<T0>(v19);
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v16)), 0x2::balance::zero<T0>(), v16);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle_versioned<T1>(v21, v0, v2, arg7, arg6, arg9, arg8, arg10, arg11);
    }

    public fun pick3__b_ab__b_ab__b_ab<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg11);
        assert!(arg9 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg5) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg9)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg5) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg9)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg5) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg9)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg5) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg9)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg5) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, arg9)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg5) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, arg9)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg5) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, arg9)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg5) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, arg9)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg5) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg9)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg5) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg9)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg5) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg9)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg5) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg9))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 1) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 2) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 3) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 4) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 5) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 6) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 7) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 8) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 9) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 10) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ab__b_ab__from_b<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    public fun pick3__b_ab__b_ab__b_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg11);
        assert!(arg9 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg5) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg9)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg5) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg9)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg5) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg9)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg5) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg9)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg5) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, arg9)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg5) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, arg9)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg5) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, arg9)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg5) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, arg9)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg5) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg9)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg5) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg9)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg5) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg9)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg5) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg9))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 1) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 2) {
            fire__b_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 3) {
            fire__b_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 4) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 5) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 6) {
            fire__b_ab__b_ba__from_a<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 7) {
            fire__b_ab__b_ba__from_b<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 8) {
            fire__b_ba__b_ab__from_a<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 9) {
            fire__b_ba__b_ab__from_b<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 10) {
            fire__b_ba__b_ab__from_a<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__b_ab__from_b<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    public fun pick3__b_ab__b_ba__b_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg11);
        assert!(arg9 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg5) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg9)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg5) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg9)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg5) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg9)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg5) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg9)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg5) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, arg9)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg5) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, arg9)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg5) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, arg9)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg5) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, arg9)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg5) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg9)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg5) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg9)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg5) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg9)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg5) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg9))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__b_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 1) {
            fire__b_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 2) {
            fire__b_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 3) {
            fire__b_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 4) {
            fire__b_ba__b_ab__from_a<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 5) {
            fire__b_ba__b_ab__from_b<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 6) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 7) {
            fire__b_ba__b_ba__from_b<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 8) {
            fire__b_ba__b_ab__from_a<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 9) {
            fire__b_ba__b_ab__from_b<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 10) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__b_ba__from_b<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    public fun pick3__b_ba__b_ba__b_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg11);
        assert!(arg9 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg5) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, arg9)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg5) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, arg9)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg5) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, arg9)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg5) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, arg9)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg5) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, arg9)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg5) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, arg9)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg5) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, arg9)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg5) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, arg9)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg5) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg9)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg5) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg9)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg5) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg9)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg5) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg9))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 1) {
            fire__b_ba__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 2) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 3) {
            fire__b_ba__b_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 4) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 5) {
            fire__b_ba__b_ba__from_b<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 6) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 7) {
            fire__b_ba__b_ba__from_b<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 8) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 9) {
            fire__b_ba__b_ba__from_b<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 10) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__b_ba__from_b<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    public fun pick3__c_ab__b_ab__b_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__b_ab__c_ab__from_a<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__b_ab__c_ab__from_b<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ab__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ab__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ab__b_ab__from_b<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ab__b_ab__b_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__b_ab__c_ab__from_a<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__b_ab__c_ab__from_b<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__b_ab__b_ba__from_a<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__b_ab__b_ba__from_b<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ba__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ba__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ba__b_ab__from_a<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__b_ab__from_b<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ab__b_ba__b_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__b_ba__c_ab__from_a<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__b_ba__c_ab__from_b<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__b_ba__b_ba__from_b<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ba__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ba__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__b_ba__from_b<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ab__c_ab__b_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__c_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__c_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ab__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ab__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ab__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ab__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ab__c_ab__b_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__c_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__c_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ba__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ba__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ba__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ab__c_ab__c_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg11);
        assert!(arg9 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg5) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg9)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg5) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg9)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg5) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg9)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg5) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg9)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg5) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg9)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg5) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg9)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg5) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg9)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg5) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg9)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg5) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, arg9)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg5) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, arg9)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg5) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, arg9)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg5) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, arg9))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 1) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 2) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 3) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 4) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 5) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 6) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 7) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 8) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 9) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 10) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else {
            assert!(v0 == 11, 40);
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    public fun pick3__c_ab__c_ab__c_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg11);
        assert!(arg9 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg5) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg9)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg5) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg9)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg5) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg9)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg5) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg9)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg5) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg9)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg5) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg9)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg5) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg9)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg5) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg9)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg5) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg9)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg5) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg9)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg5) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg9)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg5) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg9))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 1) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 2) {
            fire__c_ab__c_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 3) {
            fire__c_ab__c_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 4) {
            fire__c_ab__c_ab__from_a<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 5) {
            fire__c_ab__c_ab__from_b<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 6) {
            fire__c_ab__c_ba__from_a<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 7) {
            fire__c_ab__c_ba__from_b<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 8) {
            fire__c_ba__c_ab__from_a<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 9) {
            fire__c_ba__c_ab__from_b<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 10) {
            fire__c_ba__c_ab__from_a<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else {
            assert!(v0 == 11, 40);
            fire__c_ba__c_ab__from_b<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    public fun pick3__c_ab__c_ba__b_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__c_ba__from_a<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ab__c_ba__from_b<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ab__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ab__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__c_ba__c_ab__from_a<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__c_ba__c_ab__from_b<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__c_ba__b_ab__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__c_ba__b_ab__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ab__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ab__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ab__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ab__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ab__c_ba__b_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__c_ba__from_a<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ab__c_ba__from_b<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ab__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ab__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__c_ba__c_ab__from_a<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__c_ba__c_ab__from_b<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__c_ba__b_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__c_ba__b_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ba__c_ab__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ba__c_ab__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ba__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ab__c_ba__c_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg11);
        assert!(arg9 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg5) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg9)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg5) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg9)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg5) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg9)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg5) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg9)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg5) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg9)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg5) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg9)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg5) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg9)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg5) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg9)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg5) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg9)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg5) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg9)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg5) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg9)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg5) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg9))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ab__c_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 1) {
            fire__c_ab__c_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 2) {
            fire__c_ab__c_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 3) {
            fire__c_ab__c_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 4) {
            fire__c_ba__c_ab__from_a<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 5) {
            fire__c_ba__c_ab__from_b<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 6) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 7) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 8) {
            fire__c_ba__c_ab__from_a<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 9) {
            fire__c_ba__c_ab__from_b<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 10) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else {
            assert!(v0 == 11, 40);
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    public fun pick3__c_ba__b_ab__b_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ba__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ba__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ba__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ba__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__b_ab__c_ba__from_a<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__b_ab__c_ba__from_b<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__b_ab__b_ab__from_b<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ab__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ab__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ab__b_ab__from_a<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ab__b_ab__from_b<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ba__b_ab__b_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ba__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ba__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ba__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ba__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__b_ab__c_ba__from_a<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__b_ab__c_ba__from_b<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__b_ab__b_ba__from_a<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__b_ab__b_ba__from_b<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ba__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ba__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ba__b_ab__from_a<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__b_ab__from_b<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ba__b_ba__b_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ba__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ba__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ba__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ba__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__b_ba__c_ba__from_a<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__b_ba__c_ba__from_b<T0, T1>(arg1, arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__b_ba__b_ba__from_b<T0, T1>(arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ba__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ba__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ba__b_ba__from_a<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__b_ba__from_b<T0, T1>(arg1, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ba__c_ba__b_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, true, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg4, false, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ba__b_ab__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ba__b_ab__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__c_ba__b_ab__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__c_ba__b_ab__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ab__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ab__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ab__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ab__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ba__c_ba__b_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg5, arg12);
        assert!(arg10 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg6) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg6) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg6) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg10)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg6) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg10)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg6) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg10)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg6) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg10)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg6) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg10)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg6) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg10)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg6) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg6) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg6) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, false, arg10)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg6) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg10, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg4, true, arg10))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 1) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg2, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 2) {
            fire__c_ba__b_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 3) {
            fire__c_ba__b_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 4) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 5) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg3, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 6) {
            fire__c_ba__b_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 7) {
            fire__c_ba__b_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 8) {
            fire__b_ba__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 9) {
            fire__b_ba__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else if (v0 == 10) {
            fire__b_ba__c_ba__from_a<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        } else {
            assert!(v0 == 11, 40);
            fire__b_ba__c_ba__from_b<T0, T1>(arg1, arg0, arg4, arg3, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        };
    }

    public fun pick3__c_ba__c_ba__c_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg11);
        assert!(arg9 > 0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::e_hint_required());
        let v0 = 255;
        let v1 = 0;
        let v2 = v1;
        if (arg5) {
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, arg9)));
            if (v3 > v1) {
                v2 = v3;
                v0 = 0;
            };
        };
        if (!arg5) {
            let v4 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, arg9)));
            if (v4 > v2) {
                v2 = v4;
                v0 = 1;
            };
        };
        if (arg5) {
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, arg9)));
            if (v5 > v2) {
                v2 = v5;
                v0 = 2;
            };
        };
        if (!arg5) {
            let v6 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, arg9)));
            if (v6 > v2) {
                v2 = v6;
                v0 = 3;
            };
        };
        if (arg5) {
            let v7 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg9)));
            if (v7 > v2) {
                v2 = v7;
                v0 = 4;
            };
        };
        if (!arg5) {
            let v8 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg9)));
            if (v8 > v2) {
                v2 = v8;
                v0 = 5;
            };
        };
        if (arg5) {
            let v9 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, arg9)));
            if (v9 > v2) {
                v2 = v9;
                v0 = 6;
            };
        };
        if (!arg5) {
            let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, arg9)));
            if (v10 > v2) {
                v2 = v10;
                v0 = 7;
            };
        };
        if (arg5) {
            let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg9)));
            if (v11 > v2) {
                v2 = v11;
                v0 = 8;
            };
        };
        if (!arg5) {
            let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg1, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg9)));
            if (v12 > v2) {
                v2 = v12;
                v0 = 9;
            };
        };
        if (arg5) {
            let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, arg9)));
            if (v13 > v2) {
                v2 = v13;
                v0 = 10;
            };
        };
        if (!arg5) {
            if (0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg9, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, arg9))) > v2) {
                v0 = 11;
            };
        };
        assert!(v0 != 255, 40);
        if (v0 == 0) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 1) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 2) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 3) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 4) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 5) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg2, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 6) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 7) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 8) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 9) {
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg3, arg1, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else if (v0 == 10) {
            fire__c_ba__c_ba__from_a<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        } else {
            assert!(v0 == 11, 40);
            fire__c_ba__c_ba__from_b<T0, T1>(arg0, arg3, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    // decompiled from Move bytecode v7
}

