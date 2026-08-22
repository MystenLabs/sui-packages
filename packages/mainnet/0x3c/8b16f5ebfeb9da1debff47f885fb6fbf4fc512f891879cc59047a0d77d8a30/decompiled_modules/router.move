module 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::router {
    public fun cycle_bluefin_bq_bluefin_bq<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg7, arg8);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg3, arg4, arg5);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg4 - arg3) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg3, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg1, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg1, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg5 && arg4 > arg3 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v13);
                v5 = v14;
                if (v14 <= arg3 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg1, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg4 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg1, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg6);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::borrow_b2a<T1, T0>(arg0, arg1, v0, arg7);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::swap_a2b<T1, T0>(arg0, arg2, v23, arg7);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::settle_b2a<T1, T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::owed<T1, T0>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg6);
        v28
    }

    public fun cycle_bluefin_bq_bluefin_qb<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg7, arg8);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg3, arg4, arg5);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg4 - arg3) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg3, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg1, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg1, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg5 && arg4 > arg3 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v13);
                v5 = v14;
                if (v14 <= arg3 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg1, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg4 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg1, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg6);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::borrow_b2a<T1, T0>(arg0, arg1, v0, arg7);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::swap_b2a<T0, T1>(arg0, arg2, v23, arg7);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::settle_b2a<T1, T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::owed<T1, T0>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg6);
        v28
    }

    public fun cycle_bluefin_bq_cetus_bq<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg8, arg9);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg4, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg5 - arg4) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg4, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg2, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg2, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg6 && arg5 > arg4 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v13);
                v5 = v14;
                if (v14 <= arg4 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg2, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg5 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg2, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg7);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::borrow_b2a<T1, T0>(arg0, arg2, v0, arg8);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::swap_a2b<T1, T0>(arg1, arg3, v23, arg8);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::settle_b2a<T1, T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::owed<T1, T0>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg7);
        v28
    }

    public fun cycle_bluefin_bq_cetus_qb<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg8, arg9);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg4, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg5 - arg4) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg4, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg2, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg2, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg6 && arg5 > arg4 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v13);
                v5 = v14;
                if (v14 <= arg4 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg2, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg5 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T1, T0>(arg2, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg7);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::borrow_b2a<T1, T0>(arg0, arg2, v0, arg8);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::swap_b2a<T0, T1>(arg1, arg3, v23, arg8);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::settle_b2a<T1, T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::owed<T1, T0>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg7);
        v28
    }

    public fun cycle_bluefin_qb_bluefin_bq<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg7, arg8);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg3, arg4, arg5);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg4 - arg3) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg3, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg1, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg1, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg5 && arg4 > arg3 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v13);
                v5 = v14;
                if (v14 <= arg3 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg1, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg4 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg1, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg6);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::borrow_a2b<T0, T1>(arg0, arg1, v0, arg7);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::swap_a2b<T1, T0>(arg0, arg2, v23, arg7);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::settle_a2b<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::owed<T0, T1>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg6);
        v28
    }

    public fun cycle_bluefin_qb_bluefin_qb<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg7, arg8);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg3, arg4, arg5);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg4 - arg3) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg3, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg1, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg1, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg5 && arg4 > arg3 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v13);
                v5 = v14;
                if (v14 <= arg3 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg1, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg4 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg1, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg6);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::borrow_a2b<T0, T1>(arg0, arg1, v0, arg7);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::swap_b2a<T0, T1>(arg0, arg2, v23, arg7);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::settle_a2b<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::owed<T0, T1>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg6);
        v28
    }

    public fun cycle_bluefin_qb_cetus_bq<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg8, arg9);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg4, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg5 - arg4) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg4, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg2, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg2, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg6 && arg5 > arg4 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v13);
                v5 = v14;
                if (v14 <= arg4 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg2, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg5 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg2, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg7);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::borrow_a2b<T0, T1>(arg0, arg2, v0, arg8);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::swap_a2b<T1, T0>(arg1, arg3, v23, arg8);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::settle_a2b<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::owed<T0, T1>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg7);
        v28
    }

    public fun cycle_bluefin_qb_cetus_qb<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg8, arg9);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg4, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg5 - arg4) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg4, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg2, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg2, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg6 && arg5 > arg4 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v13);
                v5 = v14;
                if (v14 <= arg4 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg2, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg5 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T0, T1>(arg2, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg7);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::borrow_a2b<T0, T1>(arg0, arg2, v0, arg8);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::swap_b2a<T0, T1>(arg1, arg3, v23, arg8);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::settle_a2b<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::owed<T0, T1>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg7);
        v28
    }

    public fun cycle_cetus_bq_bluefin_bq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg8, arg9);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg4, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg5 - arg4) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg4, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg2, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg2, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg6 && arg5 > arg4 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v13);
                v5 = v14;
                if (v14 <= arg4 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg2, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg5 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg2, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg7);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::borrow_b2a<T1, T0>(arg0, arg2, v0, arg8);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::swap_a2b<T1, T0>(arg1, arg3, v23, arg8);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::settle_b2a<T1, T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::owed<T1, T0>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg7);
        v28
    }

    public fun cycle_cetus_bq_bluefin_qb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg8, arg9);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg4, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg5 - arg4) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg4, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg2, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg2, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg6 && arg5 > arg4 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v13);
                v5 = v14;
                if (v14 <= arg4 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg2, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg5 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg2, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg7);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::borrow_b2a<T1, T0>(arg0, arg2, v0, arg8);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::swap_b2a<T0, T1>(arg1, arg3, v23, arg8);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::settle_b2a<T1, T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::owed<T1, T0>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg7);
        v28
    }

    public fun cycle_cetus_bq_cetus_bq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg7, arg8);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg3, arg4, arg5);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg4 - arg3) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg3, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg1, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg1, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg5 && arg4 > arg3 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v13);
                v5 = v14;
                if (v14 <= arg3 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg1, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg4 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg1, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg6);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::borrow_b2a<T1, T0>(arg0, arg1, v0, arg7);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::swap_a2b<T1, T0>(arg0, arg2, v23, arg7);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::settle_b2a<T1, T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::owed<T1, T0>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg6);
        v28
    }

    public fun cycle_cetus_bq_cetus_qb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg7, arg8);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg3, arg4, arg5);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg4 - arg3) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg3, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg1, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg1, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg5 && arg4 > arg3 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v13);
                v5 = v14;
                if (v14 <= arg3 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg1, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg4 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T1, T0>(arg1, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg6);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::borrow_b2a<T1, T0>(arg0, arg1, v0, arg7);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::swap_b2a<T0, T1>(arg0, arg2, v23, arg7);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::settle_b2a<T1, T0>(arg0, arg1, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::owed<T1, T0>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg6);
        v28
    }

    public fun cycle_cetus_qb_bluefin_bq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg8, arg9);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg4, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg5 - arg4) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg4, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg2, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg2, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg6 && arg5 > arg4 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v13);
                v5 = v14;
                if (v14 <= arg4 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg2, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg5 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_a2b<T1, T0>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg2, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg7);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::borrow_a2b<T0, T1>(arg0, arg2, v0, arg8);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::swap_a2b<T1, T0>(arg1, arg3, v23, arg8);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::settle_a2b<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::owed<T0, T1>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg7);
        v28
    }

    public fun cycle_cetus_qb_bluefin_qb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg8, arg9);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg4, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg5 - arg4) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg4, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg2, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg2, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg6 && arg5 > arg4 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg4, v13);
                v5 = v14;
                if (v14 <= arg4 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg2, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg5 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::quote_b2a<T0, T1>(arg3, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg2, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg7);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::borrow_a2b<T0, T1>(arg0, arg2, v0, arg8);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::bluefin::swap_b2a<T0, T1>(arg1, arg3, v23, arg8);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::settle_a2b<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::owed<T0, T1>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg7);
        v28
    }

    public fun cycle_cetus_qb_cetus_bq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg7, arg8);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg3, arg4, arg5);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg4 - arg3) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg3, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg1, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg1, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg5 && arg4 > arg3 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v13);
                v5 = v14;
                if (v14 <= arg3 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg1, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg4 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T1, T0>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg1, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg6);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::borrow_a2b<T0, T1>(arg0, arg1, v0, arg7);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::swap_a2b<T1, T0>(arg0, arg2, v23, arg7);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::settle_a2b<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::owed<T0, T1>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg6);
        v28
    }

    public fun cycle_cetus_qb_cetus_qb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64) : 0x2::balance::Balance<T0> {
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_before(arg7, arg8);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::check_bounds(arg3, arg4, arg5);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = ((arg4 - arg3) as u128);
        let v5 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v4);
        let v6 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(arg3, v4);
        let v7 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg1, v5));
        let v8 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg1, v6));
        let v9 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v5, v7);
        if (v9 > v2) {
            v3 = v9;
            v0 = v5;
            v1 = v7;
        };
        let v10 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v6, v8);
        if (v10 > v3) {
            v3 = v10;
            v0 = v6;
            v1 = v8;
        };
        let v11 = 0;
        while (v11 < arg5 && arg4 > arg3 + 1) {
            if (0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v5, v7) > 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::score(v6, v8)) {
                let v12 = v5;
                v6 = v5;
                v8 = v7;
                let v13 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v13;
                let v14 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::left(arg3, v13);
                v5 = v14;
                if (v14 <= arg3 || v14 >= v12) {
                    break
                };
                let v15 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg1, v14));
                v7 = v15;
                let v16 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v14, v15);
                if (v16 > v3) {
                    v3 = v16;
                    v0 = v14;
                    v1 = v15;
                };
            } else {
                let v17 = v5;
                let v18 = v6;
                v5 = v6;
                v7 = v8;
                let v19 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::shrink(v4);
                v4 = v19;
                let v20 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::right(v17, v19);
                v6 = v20;
                if (v20 >= arg4 || v20 <= v18) {
                    break
                };
                let v21 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_b2a<T0, T1>(arg2, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::quote_a2b<T0, T1>(arg1, v20));
                v8 = v21;
                let v22 = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v20, v21);
                if (v22 > v3) {
                    v3 = v22;
                    v0 = v20;
                    v1 = v21;
                };
            };
            v11 = v11 + 1;
        };
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::search::profit(v0, v1), arg6);
        let (v23, v24) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::borrow_a2b<T0, T1>(arg0, arg1, v0, arg7);
        let v25 = v24;
        let (v26, v27) = 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::swap_b2a<T0, T1>(arg0, arg2, v23, arg7);
        let v28 = v26;
        0x2::balance::destroy_zero<T1>(v27);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::settle_a2b<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v28, 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::cetus::owed<T0, T1>(&v25)), v25);
        0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard::assert_min(0x2::balance::value<T0>(&v28), arg6);
        v28
    }

    // decompiled from Move bytecode v7
}

