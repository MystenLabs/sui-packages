module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::pairs {
    public fun b_ab__b_ab__from_t0<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg3, arg9);
        let v0 = arg7;
        let v1 = 0;
        if (arg7 == 0) {
            assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg4;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg4));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v3);
            let v6 = 0;
            while (v6 < arg6 && arg4 < arg5) {
                let v7 = (arg5 - arg4) / 3;
                let v8 = arg4 + v7;
                let v9 = arg5 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg4 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg5 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg8);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v18 = v17;
        0x2::balance::destroy_zero<T0>(v15);
        let v19 = v16;
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg2, false, true, 0x2::balance::value<T1>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v19, v22);
        0x2::balance::destroy_zero<T1>(v21);
        let v23 = v20;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v18)), 0x2::balance::zero<T1>(), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T0>(v23, v0, v1, arg7, arg6, arg9, arg8, arg10);
    }

    public fun b_ab__b_ab__from_t1<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg3, arg9);
        let v0 = arg7;
        let v1 = 0;
        if (arg7 == 0) {
            assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg4;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg4));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v3);
            let v6 = 0;
            while (v6 < arg6 && arg4 < arg5) {
                let v7 = (arg5 - arg4) / 3;
                let v8 = arg4 + v7;
                let v9 = arg5 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg4 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg5 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg8);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v18 = v17;
        0x2::balance::destroy_zero<T1>(v16);
        let v19 = v15;
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg2, true, true, 0x2::balance::value<T0>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg2, v19, 0x2::balance::zero<T1>(), v22);
        0x2::balance::destroy_zero<T0>(v20);
        let v23 = v21;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v18)), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T1>(v23, v0, v1, arg7, arg6, arg9, arg8, arg10);
    }

    public fun b_ab__b_ba__from_t0<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg3, arg9);
        let v0 = arg7;
        let v1 = 0;
        if (arg7 == 0) {
            assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg4;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg4));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v3);
            let v6 = 0;
            while (v6 < arg6 && arg4 < arg5) {
                let v7 = (arg5 - arg4) / 3;
                let v8 = arg4 + v7;
                let v9 = arg5 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg4 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg5 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg8);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v18 = v17;
        0x2::balance::destroy_zero<T0>(v15);
        let v19 = v16;
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg2, true, true, 0x2::balance::value<T1>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, v19, 0x2::balance::zero<T0>(), v22);
        0x2::balance::destroy_zero<T1>(v20);
        let v23 = v21;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v18)), 0x2::balance::zero<T1>(), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T0>(v23, v0, v1, arg7, arg6, arg9, arg8, arg10);
    }

    public fun b_ab__b_ba__from_t1<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg3, arg9);
        let v0 = arg7;
        let v1 = 0;
        if (arg7 == 0) {
            assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg4;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg4));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v3);
            let v6 = 0;
            while (v6 < arg6 && arg4 < arg5) {
                let v7 = (arg5 - arg4) / 3;
                let v8 = arg4 + v7;
                let v9 = arg5 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg4 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg5 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg8);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v18 = v17;
        0x2::balance::destroy_zero<T1>(v16);
        let v19 = v15;
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg3, arg0, arg2, false, true, 0x2::balance::value<T0>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), v19, v22);
        0x2::balance::destroy_zero<T0>(v21);
        let v23 = v20;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v18)), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T1>(v23, v0, v1, arg7, arg6, arg9, arg8, arg10);
    }

    public fun b_ab__c_ab__from_t0<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg10);
        let v0 = arg8;
        let v1 = 0;
        if (arg8 == 0) {
            assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg5;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg5));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v3);
            let v6 = 0;
            while (v6 < arg7 && arg5 < arg6) {
                let v7 = (arg6 - arg5) / 3;
                let v8 = arg5 + v7;
                let v9 = arg6 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg5 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg6 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg9);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v18 = v17;
        0x2::balance::destroy_zero<T0>(v15);
        let v19 = v16;
        let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, true, 0x2::balance::value<T1>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), v19, v22);
        0x2::balance::destroy_zero<T1>(v21);
        let v23 = v20;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v18)), 0x2::balance::zero<T1>(), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T0>(v23, v0, v1, arg8, arg7, arg10, arg9, arg11);
    }

    public fun b_ab__c_ab__from_t1<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg10);
        let v0 = arg8;
        let v1 = 0;
        if (arg8 == 0) {
            assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg5;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg5));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v3);
            let v6 = 0;
            while (v6 < arg7 && arg5 < arg6) {
                let v7 = (arg6 - arg5) / 3;
                let v8 = arg5 + v7;
                let v9 = arg6 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg5 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg6 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg9);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v18 = v17;
        0x2::balance::destroy_zero<T1>(v16);
        let v19 = v15;
        let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, true, true, 0x2::balance::value<T0>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, v19, 0x2::balance::zero<T1>(), v22);
        0x2::balance::destroy_zero<T0>(v20);
        let v23 = v21;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v18)), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T1>(v23, v0, v1, arg8, arg7, arg10, arg9, arg11);
    }

    public fun b_ab__c_ba__from_t0<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg10);
        let v0 = arg8;
        let v1 = 0;
        if (arg8 == 0) {
            assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg5;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, arg5));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v3);
            let v6 = 0;
            while (v6 < arg7 && arg5 < arg6) {
                let v7 = (arg6 - arg5) / 3;
                let v8 = arg5 + v7;
                let v9 = arg6 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, true, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg5 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg6 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg9);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        let v18 = v17;
        0x2::balance::destroy_zero<T0>(v15);
        let v19 = v16;
        let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, true, true, 0x2::balance::value<T1>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, v19, 0x2::balance::zero<T0>(), v22);
        0x2::balance::destroy_zero<T1>(v20);
        let v23 = v21;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v18)), 0x2::balance::zero<T1>(), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T0>(v23, v0, v1, arg8, arg7, arg10, arg9, arg11);
    }

    public fun b_ab__c_ba__from_t1<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg10);
        let v0 = arg8;
        let v1 = 0;
        if (arg8 == 0) {
            assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg5;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, arg5));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v3);
            let v6 = 0;
            while (v6 < arg7 && arg5 < arg6) {
                let v7 = (arg6 - arg5) / 3;
                let v8 = arg5 + v7;
                let v9 = arg6 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg1, false, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg5 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg6 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg9);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        let v18 = v17;
        0x2::balance::destroy_zero<T1>(v16);
        let v19 = v15;
        let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, false, true, 0x2::balance::value<T0>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::zero<T1>(), v19, v22);
        0x2::balance::destroy_zero<T0>(v21);
        let v23 = v20;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v23, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v18)), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T1>(v23, v0, v1, arg8, arg7, arg10, arg9, arg11);
    }

    public fun c_ab__b_ab__from_t0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg10);
        let v0 = arg8;
        let v1 = 0;
        if (arg8 == 0) {
            assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg5;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg5));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v3);
            let v6 = 0;
            while (v6 < arg7 && arg5 < arg6) {
                let v7 = (arg6 - arg5) / 3;
                let v8 = arg5 + v7;
                let v9 = arg6 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg5 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg6 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg9);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        let v18 = v17;
        0x2::balance::destroy_zero<T0>(v15);
        let v19 = v16;
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg2, arg3, false, true, 0x2::balance::value<T1>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), v19, v22);
        0x2::balance::destroy_zero<T1>(v21);
        let v23 = v20;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18)), 0x2::balance::zero<T1>(), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T0>(v23, v0, v1, arg8, arg7, arg10, arg9, arg11);
    }

    public fun c_ab__b_ab__from_t1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg10);
        let v0 = arg8;
        let v1 = 0;
        if (arg8 == 0) {
            assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg5;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg5));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v3);
            let v6 = 0;
            while (v6 < arg7 && arg5 < arg6) {
                let v7 = (arg6 - arg5) / 3;
                let v8 = arg5 + v7;
                let v9 = arg6 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T0, T1>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg5 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg6 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg9);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        let v18 = v17;
        0x2::balance::destroy_zero<T1>(v16);
        let v19 = v15;
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg2, arg3, true, true, 0x2::balance::value<T0>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg2, arg3, v19, 0x2::balance::zero<T1>(), v22);
        0x2::balance::destroy_zero<T0>(v20);
        let v23 = v21;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v23, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18)), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T1>(v23, v0, v1, arg8, arg7, arg10, arg9, arg11);
    }

    public fun c_ab__b_ba__from_t0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg10);
        let v0 = arg8;
        let v1 = 0;
        if (arg8 == 0) {
            assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg5;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg5));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v3);
            let v6 = 0;
            while (v6 < arg7 && arg5 < arg6) {
                let v7 = (arg6 - arg5) / 3;
                let v8 = arg5 + v7;
                let v9 = arg6 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg5 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg6 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg9);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg4);
        let v18 = v17;
        0x2::balance::destroy_zero<T0>(v15);
        let v19 = v16;
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg2, arg3, true, true, 0x2::balance::value<T1>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg2, arg3, v19, 0x2::balance::zero<T0>(), v22);
        0x2::balance::destroy_zero<T1>(v20);
        let v23 = v21;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18)), 0x2::balance::zero<T1>(), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T0>(v23, v0, v1, arg8, arg7, arg10, arg9, arg11);
    }

    public fun c_ab__b_ba__from_t1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg4, arg10);
        let v0 = arg8;
        let v1 = 0;
        if (arg8 == 0) {
            assert!(arg7 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg5 <= arg6, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg5;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg5));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg5, v3);
            let v6 = 0;
            while (v6 < arg7 && arg5 < arg6) {
                let v7 = (arg6 - arg5) / 3;
                let v8 = arg5 + v7;
                let v9 = arg6 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_out<T1, T0>(arg3, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg5 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg6 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg9);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg4);
        let v18 = v17;
        0x2::balance::destroy_zero<T1>(v16);
        let v19 = v15;
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg4, arg2, arg3, false, true, 0x2::balance::value<T0>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::zero<T1>(), v19, v22);
        0x2::balance::destroy_zero<T0>(v21);
        let v23 = v20;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v23, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18)), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T1>(v23, v0, v1, arg8, arg7, arg10, arg9, arg11);
    }

    public fun c_ab__c_ab__from_t0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg3, arg9);
        let v0 = arg7;
        let v1 = 0;
        if (arg7 == 0) {
            assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg4;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg4));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v3);
            let v6 = 0;
            while (v6 < arg6 && arg4 < arg5) {
                let v7 = (arg5 - arg4) / 3;
                let v8 = arg4 + v7;
                let v9 = arg5 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg4 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg5 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg8);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        let v18 = v17;
        0x2::balance::destroy_zero<T0>(v15);
        let v19 = v16;
        let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v19, v22);
        0x2::balance::destroy_zero<T1>(v21);
        let v23 = v20;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18)), 0x2::balance::zero<T1>(), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T0>(v23, v0, v1, arg7, arg6, arg9, arg8, arg10);
    }

    public fun c_ab__c_ab__from_t1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg3, arg9);
        let v0 = arg7;
        let v1 = 0;
        if (arg7 == 0) {
            assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg4;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg4));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v3);
            let v6 = 0;
            while (v6 < arg6 && arg4 < arg5) {
                let v7 = (arg5 - arg4) / 3;
                let v8 = arg4 + v7;
                let v9 = arg5 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg4 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg5 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg8);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        let v18 = v17;
        0x2::balance::destroy_zero<T1>(v16);
        let v19 = v15;
        let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v19, 0x2::balance::zero<T1>(), v22);
        0x2::balance::destroy_zero<T0>(v20);
        let v23 = v21;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v23, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18)), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T1>(v23, v0, v1, arg7, arg6, arg9, arg8, arg10);
    }

    public fun c_ab__c_ba__from_t0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg3, arg9);
        let v0 = arg7;
        let v1 = 0;
        if (arg7 == 0) {
            assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg4;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, arg4));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v3);
            let v6 = 0;
            while (v6 < arg6 && arg4 < arg5) {
                let v7 = (arg5 - arg4) / 3;
                let v8 = arg4 + v7;
                let v9 = arg5 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, true, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, true, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg4 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg5 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg8);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        let v18 = v17;
        0x2::balance::destroy_zero<T0>(v15);
        let v19 = v16;
        let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, v19, 0x2::balance::zero<T0>(), v22);
        0x2::balance::destroy_zero<T1>(v20);
        let v23 = v21;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v23, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18)), 0x2::balance::zero<T1>(), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T0>(v23, v0, v1, arg7, arg6, arg9, arg8, arg10);
    }

    public fun c_ab__c_ba__from_t1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::guard::assert_before(arg3, arg9);
        let v0 = arg7;
        let v1 = 0;
        if (arg7 == 0) {
            assert!(arg6 <= 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::max_probes(), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_too_many_probes());
            assert!(arg4 <= arg5, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::e_bad_bounds());
            let v2 = arg4;
            let v3 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, arg4));
            let v4 = v3;
            let v5 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(arg4, v3);
            let v6 = 0;
            while (v6 < arg6 && arg4 < arg5) {
                let v7 = (arg5 - arg4) / 3;
                let v8 = arg4 + v7;
                let v9 = arg5 - v7;
                let v10 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v8));
                let v11 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v8, v10);
                if (v11 > v5) {
                    v5 = v11;
                    v2 = v8;
                    v4 = v10;
                };
                let v12 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T1, T0>(arg2, false, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::cetus_out<T0, T1>(arg1, false, v9));
                let v13 = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::search::score(v9, v12);
                if (v13 > v5) {
                    v5 = v13;
                    v2 = v9;
                    v4 = v12;
                };
                if (v11 < v13) {
                    arg4 = v8 + 1;
                } else {
                    let v14 = if (v9 == 0) {
                        0
                    } else {
                        v9 - 1
                    };
                    arg5 = v14;
                };
                v6 = v6 + 1;
            };
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::assert_worth_firing(v2, v4, arg8);
            v0 = v2;
            v1 = v4;
        };
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        let v18 = v17;
        0x2::balance::destroy_zero<T1>(v16);
        let v19 = v15;
        let (v20, v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v19), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::zero<T1>(), v19, v22);
        0x2::balance::destroy_zero<T0>(v21);
        let v23 = v20;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v23, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v18)), v18);
        0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::router::settle<T1>(v23, v0, v1, arg7, arg6, arg9, arg8, arg10);
    }

    // decompiled from Move bytecode v7
}

