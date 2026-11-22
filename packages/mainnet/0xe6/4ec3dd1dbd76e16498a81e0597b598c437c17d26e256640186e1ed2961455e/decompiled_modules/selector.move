module 0xe1b9fbd9b9de70a494d4ec4aa487ccd24dc926a2ab0060b0bcea116e8ea3db9a::selector {
    public fun bounded_sqrt_limit(arg0: u128, arg1: bool, arg2: u128) : u128 {
        if (arg1) {
            if (arg0 <= 4295048016) {
                return 4295048016
            };
            let v1 = arg0 * arg2 / 10000;
            let v2 = if (arg0 > v1) {
                arg0 - v1
            } else {
                4295048016
            };
            let v3 = 4295048016 + 1;
            if (v2 < v3) {
                if (arg0 > v3) {
                    v3
                } else {
                    4295048016
                }
            } else if (v2 >= arg0) {
                arg0 - 1
            } else {
                v2
            }
        } else {
            if (arg0 >= 79226673515401279992447579055) {
                return 79226673515401279992447579055
            };
            let v4 = arg0 * arg2 / 10000;
            let v5 = 79226673515401279992447579055 - 1;
            let v6 = if (v5 > v4 && arg0 <= v5 - v4) {
                arg0 + v4
            } else {
                v5
            };
            if (v6 > v5) {
                if (arg0 < v5) {
                    v5
                } else {
                    79226673515401279992447579055
                }
            } else if (v6 <= arg0) {
                arg0 + 1
            } else {
                v6
            }
        }
    }

    public fun candidate_sizes(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0);
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 60 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 35 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 20 / 100) as u64));
        v0
    }

    public fun candidate_sizes_6(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0);
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 75 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 55 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 38 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 25 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 15 / 100) as u64));
        v0
    }

    public fun coarse_sizes_v6(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0);
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 50 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 22 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 8 / 100) as u64));
        v0
    }

    public fun evaluate_net_profit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (bool, u64) {
        if (arg0 == 0 || arg1 <= arg0) {
            return (false, 0)
        };
        let v0 = arg0 + (((arg0 as u128) * (arg2 as u128) / 10000) as u64);
        if (arg1 <= v0) {
            return (false, 0)
        };
        let v1 = arg1 - v0;
        (v1 >= arg3, v1)
    }

    public fun evaluate_net_profit_ppm(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (bool, u64) {
        if (arg0 == 0 || arg1 <= arg0) {
            return (false, 0)
        };
        let v0 = arg0 + ((((arg2 as u128) * (arg3 as u128) + 999999) / 1000000) as u64);
        if (arg1 <= v0) {
            return (false, 0)
        };
        let v1 = arg1 - v0;
        (v1 >= arg4, v1)
    }

    public fun is_near_breakeven_v6(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return false
        };
        (arg1 as u128) * 10000 >= ((arg0 as u128) + ((arg2 as u128) * (arg3 as u128) + 999999) / 1000000) * 9985
    }

    public fun micro_fallback_size_v6(arg0: u64) : u64 {
        (((arg0 as u128) * 3 / 100) as u64)
    }

    public fun pick_2hop_bf_bf_v5<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: u64) : u64 {
        let v0 = candidate_sizes_6(arg4);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4)), 0, arg5);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_bf_bf_v6<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg4);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v10));
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg5);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg4, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let (v18, v19) = evaluate_net_profit_ppm(v17, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v17)), v17, v0, arg5);
                if (v18 && v19 > v5) {
                    v3 = v17;
                    v5 = v19;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v20 = micro_fallback_size_v6(arg4);
            let (v21, _) = evaluate_net_profit_ppm(v20, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v20)), v20, v0, arg5);
            assert!(v21, 3001);
            v20
        }
    }

    public fun pick_2hop_bf_db_v5<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = candidate_sizes_6(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4), arg5, arg7), v4)
            } else {
                let (v7, v8) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg5, arg7);
                let v9 = quote_bluefin<T0, T1>(arg0, arg1, v7);
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg6, arg9);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_bf_db_v6<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = coarse_sizes_v6(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v9), arg5, arg7), v9)
            } else {
                let (v12, v13) = quote_db_with_rem<T2, T3>(arg2, arg3, v9, arg5, arg7);
                let v14 = quote_bluefin<T0, T1>(arg0, arg1, v12);
                let v15 = if (v9 > v13) {
                    v9 - v13
                } else {
                    0
                };
                if (v14 == 0) {
                    (0, 0)
                } else {
                    (v14 + v13, v15)
                }
            };
            v5 = v9;
            v6 = v10;
            v7 = v11;
            let (v16, v17) = evaluate_net_profit_ppm(v9, v10, v11, arg6, arg9);
            if (v16 && (v1 == 0 || v17 > v3)) {
                v2 = v9;
                v4 = v17;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v19 = refine_sizes_v6(arg8, 0);
            let v20 = 0;
            while (v20 < 2) {
                let v21 = *0x1::vector::borrow<u64>(&v19, v20);
                let (v22, v23) = if (arg4) {
                    (quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v21), arg5, arg7), v21)
                } else {
                    let (v24, v25) = quote_db_with_rem<T2, T3>(arg2, arg3, v21, arg5, arg7);
                    let v26 = quote_bluefin<T0, T1>(arg0, arg1, v24);
                    let v27 = if (v21 > v25) {
                        v21 - v25
                    } else {
                        0
                    };
                    if (v26 == 0) {
                        (0, 0)
                    } else {
                        (v26 + v25, v27)
                    }
                };
                let (v28, v29) = evaluate_net_profit_ppm(v21, v22, v23, arg6, arg9);
                if (v28 && v29 > v4) {
                    v2 = v21;
                    v4 = v29;
                };
                v20 = v20 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg6), 3001);
            let v30 = micro_fallback_size_v6(arg8);
            let (v31, v32) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v30), arg5, arg7), v30)
            } else {
                let (v33, v34) = quote_db_with_rem<T2, T3>(arg2, arg3, v30, arg5, arg7);
                let v35 = quote_bluefin<T0, T1>(arg0, arg1, v33);
                let v36 = if (v30 > v34) {
                    v30 - v34
                } else {
                    0
                };
                if (v35 == 0) {
                    (0, 0)
                } else {
                    (v35 + v34, v36)
                }
            };
            let (v37, _) = evaluate_net_profit_ppm(v30, v31, v32, arg6, arg9);
            assert!(v37, 3001);
            v30
        }
    }

    public fun pick_2hop_cetus_bf_v5<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = candidate_sizes_6(arg5);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4))
            } else {
                quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v4))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, 0, arg6);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_cetus_bf_v6<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg5);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v10))
            } else {
                quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v10))
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg6);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg5, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg4) {
                    quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v17))
                } else {
                    quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v17))
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg6);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg5);
            let v22 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v21))
            } else {
                quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v21))
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg6);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_2hop_cetus_cetus_v5<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: u64) : u64 {
        let v0 = candidate_sizes_6(arg4);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)), 0, arg5);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_cetus_cetus_v6<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg4);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v10));
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg5);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg4, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let (v18, v19) = evaluate_net_profit_ppm(v17, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v17)), v17, v0, arg5);
                if (v18 && v19 > v5) {
                    v3 = v17;
                    v5 = v19;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v20 = micro_fallback_size_v6(arg4);
            let (v21, _) = evaluate_net_profit_ppm(v20, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v20)), v20, v0, arg5);
            assert!(v21, 3001);
            v20
        }
    }

    public fun pick_2hop_cetus_db_v5<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = candidate_sizes_6(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4), arg5, arg7), v4)
            } else {
                let (v7, v8) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg5, arg7);
                let v9 = quote_cetus<T0, T1>(arg0, arg1, v7);
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg6, arg9);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_cetus_db_v6<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = coarse_sizes_v6(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v9), arg5, arg7), v9)
            } else {
                let (v12, v13) = quote_db_with_rem<T2, T3>(arg2, arg3, v9, arg5, arg7);
                let v14 = quote_cetus<T0, T1>(arg0, arg1, v12);
                let v15 = if (v9 > v13) {
                    v9 - v13
                } else {
                    0
                };
                if (v14 == 0) {
                    (0, 0)
                } else {
                    (v14 + v13, v15)
                }
            };
            v5 = v9;
            v6 = v10;
            v7 = v11;
            let (v16, v17) = evaluate_net_profit_ppm(v9, v10, v11, arg6, arg9);
            if (v16 && (v1 == 0 || v17 > v3)) {
                v2 = v9;
                v4 = v17;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v19 = refine_sizes_v6(arg8, 0);
            let v20 = 0;
            while (v20 < 2) {
                let v21 = *0x1::vector::borrow<u64>(&v19, v20);
                let (v22, v23) = if (arg4) {
                    (quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v21), arg5, arg7), v21)
                } else {
                    let (v24, v25) = quote_db_with_rem<T2, T3>(arg2, arg3, v21, arg5, arg7);
                    let v26 = quote_cetus<T0, T1>(arg0, arg1, v24);
                    let v27 = if (v21 > v25) {
                        v21 - v25
                    } else {
                        0
                    };
                    if (v26 == 0) {
                        (0, 0)
                    } else {
                        (v26 + v25, v27)
                    }
                };
                let (v28, v29) = evaluate_net_profit_ppm(v21, v22, v23, arg6, arg9);
                if (v28 && v29 > v4) {
                    v2 = v21;
                    v4 = v29;
                };
                v20 = v20 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg6), 3001);
            let v30 = micro_fallback_size_v6(arg8);
            let (v31, v32) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v30), arg5, arg7), v30)
            } else {
                let (v33, v34) = quote_db_with_rem<T2, T3>(arg2, arg3, v30, arg5, arg7);
                let v35 = quote_cetus<T0, T1>(arg0, arg1, v33);
                let v36 = if (v30 > v34) {
                    v30 - v34
                } else {
                    0
                };
                if (v35 == 0) {
                    (0, 0)
                } else {
                    (v35 + v34, v36)
                }
            };
            let (v37, _) = evaluate_net_profit_ppm(v30, v31, v32, arg6, arg9);
            assert!(v37, 3001);
            v30
        }
    }

    public fun pick_2hop_cpmm_bf_v6<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: bool, arg8: bool, arg9: u64, arg10: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg9);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg8) {
                quote_bluefin<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v10))
            } else {
                quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, quote_bluefin<T0, T1>(arg6, arg7, v10))
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg10);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg9, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg8) {
                    quote_bluefin<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v17))
                } else {
                    quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, quote_bluefin<T0, T1>(arg6, arg7, v17))
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg10);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg9);
            let v22 = if (arg8) {
                quote_bluefin<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v21))
            } else {
                quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, quote_bluefin<T0, T1>(arg6, arg7, v21))
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg10);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_2hop_cpmm_cetus_v6<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: bool, arg8: bool, arg9: u64, arg10: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg9);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg8) {
                quote_cetus<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v10))
            } else {
                quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, quote_cetus<T0, T1>(arg6, arg7, v10))
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg10);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg9, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg8) {
                    quote_cetus<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v17))
                } else {
                    quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, quote_cetus<T0, T1>(arg6, arg7, v17))
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg10);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg9);
            let v22 = if (arg8) {
                quote_cetus<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v21))
            } else {
                quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, quote_cetus<T0, T1>(arg6, arg7, v21))
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg10);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_2hop_cpmm_db_v6<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64) : u64 {
        let v0 = coarse_sizes_v6(arg12);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg8) {
                (quote_db<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v9), arg9, arg11), v9)
            } else {
                let (v12, v13) = quote_db_with_rem<T0, T1>(arg6, arg7, v9, arg9, arg11);
                let v14 = quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v12);
                let v15 = if (v9 > v13) {
                    v9 - v13
                } else {
                    0
                };
                if (v14 == 0) {
                    (0, 0)
                } else {
                    (v14 + v13, v15)
                }
            };
            v5 = v9;
            v6 = v10;
            v7 = v11;
            let (v16, v17) = evaluate_net_profit_ppm(v9, v10, v11, arg10, arg13);
            if (v16 && (v1 == 0 || v17 > v3)) {
                v2 = v9;
                v4 = v17;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v19 = refine_sizes_v6(arg12, 0);
            let v20 = 0;
            while (v20 < 2) {
                let v21 = *0x1::vector::borrow<u64>(&v19, v20);
                let (v22, v23) = if (arg8) {
                    (quote_db<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v21), arg9, arg11), v21)
                } else {
                    let (v24, v25) = quote_db_with_rem<T0, T1>(arg6, arg7, v21, arg9, arg11);
                    let v26 = quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v24);
                    let v27 = if (v21 > v25) {
                        v21 - v25
                    } else {
                        0
                    };
                    if (v26 == 0) {
                        (0, 0)
                    } else {
                        (v26 + v25, v27)
                    }
                };
                let (v28, v29) = evaluate_net_profit_ppm(v21, v22, v23, arg10, arg13);
                if (v28 && v29 > v4) {
                    v2 = v21;
                    v4 = v29;
                };
                v20 = v20 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg10), 3001);
            let v30 = micro_fallback_size_v6(arg12);
            let (v31, v32) = if (arg8) {
                (quote_db<T0, T1>(arg6, arg7, quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v30), arg9, arg11), v30)
            } else {
                let (v33, v34) = quote_db_with_rem<T0, T1>(arg6, arg7, v30, arg9, arg11);
                let v35 = quote_cpmm_scaled_u64(arg0, arg1, arg2, arg3, arg4, arg5, v33);
                let v36 = if (v30 > v34) {
                    v30 - v34
                } else {
                    0
                };
                if (v35 == 0) {
                    (0, 0)
                } else {
                    (v35 + v34, v36)
                }
            };
            let (v37, _) = evaluate_net_profit_ppm(v30, v31, v32, arg10, arg13);
            assert!(v37, 3001);
            v30
        }
    }

    public fun pick_2hop_ferra_dlmm_bf_v5<T0, T1, T2, T3>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64) : u64 {
        let v0 = candidate_sizes_6(arg6);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v4, arg5))
            } else {
                quote_ferra_dlmm<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v4), arg5)
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, 0, arg7);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_ferra_dlmm_bf_v6<T0, T1, T2, T3>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg6);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v10, arg5))
            } else {
                quote_ferra_dlmm<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v10), arg5)
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg7);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg6, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg4) {
                    quote_bluefin<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v17, arg5))
                } else {
                    quote_ferra_dlmm<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v17), arg5)
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg7);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg6);
            let v22 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v21, arg5))
            } else {
                quote_ferra_dlmm<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v21), arg5)
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg7);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_2hop_ferra_dlmm_cetus_v5<T0, T1, T2, T3>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64) : u64 {
        let v0 = candidate_sizes_6(arg6);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg4) {
                quote_cetus<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v4, arg5))
            } else {
                quote_ferra_dlmm<T0, T1>(arg0, arg1, quote_cetus<T2, T3>(arg2, arg3, v4), arg5)
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, 0, arg7);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_ferra_dlmm_cetus_v6<T0, T1, T2, T3>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg6);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg4) {
                quote_cetus<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v10, arg5))
            } else {
                quote_ferra_dlmm<T0, T1>(arg0, arg1, quote_cetus<T2, T3>(arg2, arg3, v10), arg5)
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg7);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg6, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg4) {
                    quote_cetus<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v17, arg5))
                } else {
                    quote_ferra_dlmm<T0, T1>(arg0, arg1, quote_cetus<T2, T3>(arg2, arg3, v17), arg5)
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg7);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg6);
            let v22 = if (arg4) {
                quote_cetus<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v21, arg5))
            } else {
                quote_ferra_dlmm<T0, T1>(arg0, arg1, quote_cetus<T2, T3>(arg2, arg3, v21), arg5)
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg7);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_2hop_ferra_dlmm_db_v5<T0, T1, T2, T3>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = candidate_sizes_6(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v4, arg7), arg5, arg7), v4)
            } else {
                let (v7, v8) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg5, arg7);
                let v9 = quote_ferra_dlmm<T0, T1>(arg0, arg1, v7, arg7);
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg6, arg9);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_ferra_dlmm_db_v6<T0, T1, T2, T3>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = coarse_sizes_v6(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v9, arg7), arg5, arg7), v9)
            } else {
                let (v12, v13) = quote_db_with_rem<T2, T3>(arg2, arg3, v9, arg5, arg7);
                let v14 = quote_ferra_dlmm<T0, T1>(arg0, arg1, v12, arg7);
                let v15 = if (v9 > v13) {
                    v9 - v13
                } else {
                    0
                };
                if (v14 == 0) {
                    (0, 0)
                } else {
                    (v14 + v13, v15)
                }
            };
            v5 = v9;
            v6 = v10;
            v7 = v11;
            let (v16, v17) = evaluate_net_profit_ppm(v9, v10, v11, arg6, arg9);
            if (v16 && (v1 == 0 || v17 > v3)) {
                v2 = v9;
                v4 = v17;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v19 = refine_sizes_v6(arg8, 0);
            let v20 = 0;
            while (v20 < 2) {
                let v21 = *0x1::vector::borrow<u64>(&v19, v20);
                let (v22, v23) = if (arg4) {
                    (quote_db<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v21, arg7), arg5, arg7), v21)
                } else {
                    let (v24, v25) = quote_db_with_rem<T2, T3>(arg2, arg3, v21, arg5, arg7);
                    let v26 = quote_ferra_dlmm<T0, T1>(arg0, arg1, v24, arg7);
                    let v27 = if (v21 > v25) {
                        v21 - v25
                    } else {
                        0
                    };
                    if (v26 == 0) {
                        (0, 0)
                    } else {
                        (v26 + v25, v27)
                    }
                };
                let (v28, v29) = evaluate_net_profit_ppm(v21, v22, v23, arg6, arg9);
                if (v28 && v29 > v4) {
                    v2 = v21;
                    v4 = v29;
                };
                v20 = v20 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg6), 3001);
            let v30 = micro_fallback_size_v6(arg8);
            let (v31, v32) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_ferra_dlmm<T0, T1>(arg0, arg1, v30, arg7), arg5, arg7), v30)
            } else {
                let (v33, v34) = quote_db_with_rem<T2, T3>(arg2, arg3, v30, arg5, arg7);
                let v35 = quote_ferra_dlmm<T0, T1>(arg0, arg1, v33, arg7);
                let v36 = if (v30 > v34) {
                    v30 - v34
                } else {
                    0
                };
                if (v35 == 0) {
                    (0, 0)
                } else {
                    (v35 + v34, v36)
                }
            };
            let (v37, _) = evaluate_net_profit_ppm(v30, v31, v32, arg6, arg9);
            assert!(v37, 3001);
            v30
        }
    }

    public fun pick_2hop_flowx_v2_bf_v5<T0, T1, T2, T3>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = candidate_sizes_6(arg5);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v4))
            } else {
                quote_flowx_v2<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v4))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, 0, arg6);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_flowx_v2_bf_v6<T0, T1, T2, T3>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg5);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v10))
            } else {
                quote_flowx_v2<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v10))
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg6);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg5, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg4) {
                    quote_bluefin<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v17))
                } else {
                    quote_flowx_v2<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v17))
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg6);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg5);
            let v22 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v21))
            } else {
                quote_flowx_v2<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v21))
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg6);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_2hop_flowx_v2_cetus_v5<T0, T1, T2, T3>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = candidate_sizes_6(arg5);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg4) {
                quote_cetus<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v4))
            } else {
                quote_flowx_v2<T0, T1>(arg0, arg1, quote_cetus<T2, T3>(arg2, arg3, v4))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, 0, arg6);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_flowx_v2_cetus_v6<T0, T1, T2, T3>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg5);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg4) {
                quote_cetus<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v10))
            } else {
                quote_flowx_v2<T0, T1>(arg0, arg1, quote_cetus<T2, T3>(arg2, arg3, v10))
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg6);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg5, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg4) {
                    quote_cetus<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v17))
                } else {
                    quote_flowx_v2<T0, T1>(arg0, arg1, quote_cetus<T2, T3>(arg2, arg3, v17))
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg6);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg5);
            let v22 = if (arg4) {
                quote_cetus<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v21))
            } else {
                quote_flowx_v2<T0, T1>(arg0, arg1, quote_cetus<T2, T3>(arg2, arg3, v21))
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg6);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_2hop_flowx_v2_db_v5<T0, T1, T2, T3>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = candidate_sizes_6(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v4), arg5, arg7), v4)
            } else {
                let (v7, v8) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg5, arg7);
                let v9 = quote_flowx_v2<T0, T1>(arg0, arg1, v7);
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg6, arg9);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_2hop_flowx_v2_db_v6<T0, T1, T2, T3>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = coarse_sizes_v6(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v9), arg5, arg7), v9)
            } else {
                let (v12, v13) = quote_db_with_rem<T2, T3>(arg2, arg3, v9, arg5, arg7);
                let v14 = quote_flowx_v2<T0, T1>(arg0, arg1, v12);
                let v15 = if (v9 > v13) {
                    v9 - v13
                } else {
                    0
                };
                if (v14 == 0) {
                    (0, 0)
                } else {
                    (v14 + v13, v15)
                }
            };
            v5 = v9;
            v6 = v10;
            v7 = v11;
            let (v16, v17) = evaluate_net_profit_ppm(v9, v10, v11, arg6, arg9);
            if (v16 && (v1 == 0 || v17 > v3)) {
                v2 = v9;
                v4 = v17;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v19 = refine_sizes_v6(arg8, 0);
            let v20 = 0;
            while (v20 < 2) {
                let v21 = *0x1::vector::borrow<u64>(&v19, v20);
                let (v22, v23) = if (arg4) {
                    (quote_db<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v21), arg5, arg7), v21)
                } else {
                    let (v24, v25) = quote_db_with_rem<T2, T3>(arg2, arg3, v21, arg5, arg7);
                    let v26 = quote_flowx_v2<T0, T1>(arg0, arg1, v24);
                    let v27 = if (v21 > v25) {
                        v21 - v25
                    } else {
                        0
                    };
                    if (v26 == 0) {
                        (0, 0)
                    } else {
                        (v26 + v25, v27)
                    }
                };
                let (v28, v29) = evaluate_net_profit_ppm(v21, v22, v23, arg6, arg9);
                if (v28 && v29 > v4) {
                    v2 = v21;
                    v4 = v29;
                };
                v20 = v20 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg6), 3001);
            let v30 = micro_fallback_size_v6(arg8);
            let (v31, v32) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_flowx_v2<T0, T1>(arg0, arg1, v30), arg5, arg7), v30)
            } else {
                let (v33, v34) = quote_db_with_rem<T2, T3>(arg2, arg3, v30, arg5, arg7);
                let v35 = quote_flowx_v2<T0, T1>(arg0, arg1, v33);
                let v36 = if (v30 > v34) {
                    v30 - v34
                } else {
                    0
                };
                if (v35 == 0) {
                    (0, 0)
                } else {
                    (v35 + v34, v36)
                }
            };
            let (v37, _) = evaluate_net_profit_ppm(v30, v31, v32, arg6, arg9);
            assert!(v37, 3001);
            v30
        }
    }

    public fun pick_3hop_bf_bf_cetus_v5<T0, T1, T2, T3, T4, T5>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: u64, arg8: u64) : u64 {
        let v0 = candidate_sizes_6(arg7);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg6 == 0) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, quote_cetus<T4, T5>(arg4, arg5, v4)))
            } else if (arg6 == 1) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T0, T1>(arg0, arg1, v4)))
            } else {
                quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4)))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, 0, arg8);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_3hop_bf_bf_cetus_v6<T0, T1, T2, T3, T4, T5>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: u64, arg8: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg7);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg6 == 0) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, quote_cetus<T4, T5>(arg4, arg5, v10)))
            } else if (arg6 == 1) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T0, T1>(arg0, arg1, v10)))
            } else {
                quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v10)))
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg8);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg7, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg6 == 0) {
                    quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, quote_cetus<T4, T5>(arg4, arg5, v17)))
                } else if (arg6 == 1) {
                    quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T0, T1>(arg0, arg1, v17)))
                } else {
                    quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v17)))
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg8);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg7);
            let v22 = if (arg6 == 0) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, quote_cetus<T4, T5>(arg4, arg5, v21)))
            } else if (arg6 == 1) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T0, T1>(arg0, arg1, v21)))
            } else {
                quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v21)))
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg8);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_3hop_bf_db_db_v5<T0, T1, T2, T3, T4, T5>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64) : u64 {
        let v0 = candidate_sizes_6(arg11);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg6 == 0) {
                (v4, quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4), arg7, arg10), arg8, arg10))
            } else {
                let (v7, v8) = if (arg6 == 1) {
                    let (v9, v10) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg7, arg10);
                    let v11 = quote_db<T4, T5>(arg4, arg5, quote_bluefin<T0, T1>(arg0, arg1, v9), arg8, arg10);
                    let v12 = if (v4 > v10) {
                        v4 - v10
                    } else {
                        0
                    };
                    if (v11 == 0) {
                        (0, 0)
                    } else {
                        (v11 + v10, v12)
                    }
                } else {
                    let (v13, v14) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg7, arg10);
                    let v15 = quote_bluefin<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v13, arg8, arg10));
                    let v16 = if (v4 > v14) {
                        v4 - v14
                    } else {
                        0
                    };
                    if (v15 == 0) {
                        (0, 0)
                    } else {
                        (v15 + v14, v16)
                    }
                };
                (v8, v7)
            };
            let (v17, v18) = evaluate_net_profit_ppm(v4, v6, v5, arg9, arg12);
            if (v17 && (v1 == 0 || v18 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_3hop_bf_db_db_v6<T0, T1, T2, T3, T4, T5>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64) : u64 {
        let v0 = coarse_sizes_v6(arg11);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v9), arg7, arg10), arg8, arg10), v9)
            } else if (arg6 == 1) {
                let (v12, v13) = quote_db_with_rem<T2, T3>(arg2, arg3, v9, arg7, arg10);
                let v14 = quote_db<T4, T5>(arg4, arg5, quote_bluefin<T0, T1>(arg0, arg1, v12), arg8, arg10);
                let v15 = if (v9 > v13) {
                    v9 - v13
                } else {
                    0
                };
                if (v14 == 0) {
                    (0, 0)
                } else {
                    (v14 + v13, v15)
                }
            } else {
                let (v16, v17) = quote_db_with_rem<T2, T3>(arg2, arg3, v9, arg7, arg10);
                let v18 = quote_bluefin<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v16, arg8, arg10));
                let v19 = if (v9 > v17) {
                    v9 - v17
                } else {
                    0
                };
                if (v18 == 0) {
                    (0, 0)
                } else {
                    (v18 + v17, v19)
                }
            };
            v5 = v9;
            v6 = v10;
            v7 = v11;
            let (v20, v21) = evaluate_net_profit_ppm(v9, v10, v11, arg9, arg12);
            if (v20 && (v1 == 0 || v21 > v3)) {
                v2 = v9;
                v4 = v21;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v23 = refine_sizes_v6(arg11, 0);
            let v24 = 0;
            while (v24 < 2) {
                let v25 = *0x1::vector::borrow<u64>(&v23, v24);
                let (v26, v27) = if (arg6 == 0) {
                    (quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v25), arg7, arg10), arg8, arg10), v25)
                } else if (arg6 == 1) {
                    let (v28, v29) = quote_db_with_rem<T2, T3>(arg2, arg3, v25, arg7, arg10);
                    let v30 = quote_db<T4, T5>(arg4, arg5, quote_bluefin<T0, T1>(arg0, arg1, v28), arg8, arg10);
                    let v31 = if (v25 > v29) {
                        v25 - v29
                    } else {
                        0
                    };
                    if (v30 == 0) {
                        (0, 0)
                    } else {
                        (v30 + v29, v31)
                    }
                } else {
                    let (v32, v33) = quote_db_with_rem<T2, T3>(arg2, arg3, v25, arg7, arg10);
                    let v34 = quote_bluefin<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v32, arg8, arg10));
                    let v35 = if (v25 > v33) {
                        v25 - v33
                    } else {
                        0
                    };
                    if (v34 == 0) {
                        (0, 0)
                    } else {
                        (v34 + v33, v35)
                    }
                };
                let (v36, v37) = evaluate_net_profit_ppm(v25, v26, v27, arg9, arg12);
                if (v36 && v37 > v4) {
                    v2 = v25;
                    v4 = v37;
                };
                v24 = v24 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg9), 3001);
            let v38 = micro_fallback_size_v6(arg11);
            let (v39, v40) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v38), arg7, arg10), arg8, arg10), v38)
            } else if (arg6 == 1) {
                let (v41, v42) = quote_db_with_rem<T2, T3>(arg2, arg3, v38, arg7, arg10);
                let v43 = quote_db<T4, T5>(arg4, arg5, quote_bluefin<T0, T1>(arg0, arg1, v41), arg8, arg10);
                let v44 = if (v38 > v42) {
                    v38 - v42
                } else {
                    0
                };
                if (v43 == 0) {
                    (0, 0)
                } else {
                    (v43 + v42, v44)
                }
            } else {
                let (v45, v46) = quote_db_with_rem<T2, T3>(arg2, arg3, v38, arg7, arg10);
                let v47 = quote_bluefin<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v45, arg8, arg10));
                let v48 = if (v38 > v46) {
                    v38 - v46
                } else {
                    0
                };
                if (v47 == 0) {
                    (0, 0)
                } else {
                    (v47 + v46, v48)
                }
            };
            let (v49, _) = evaluate_net_profit_ppm(v38, v39, v40, arg9, arg12);
            assert!(v49, 3001);
            v38
        }
    }

    public fun pick_3hop_cetus_bf_db_v5<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = candidate_sizes_6(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)), arg7, arg9), v4)
            } else if (arg6 == 1) {
                (quote_bluefin<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v4), arg7, arg9)), v4)
            } else if (arg6 == 2) {
                (quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v4)), arg7, arg9), v4)
            } else {
                let (v7, v8) = if (arg6 == 3) {
                    (v4, quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, v4), arg7, arg9)))
                } else {
                    let (v9, v10) = if (arg6 == 4) {
                        let (v11, v12) = quote_db_with_rem<T4, T5>(arg4, arg5, v4, arg7, arg9);
                        let v13 = quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v11));
                        let v14 = if (v4 > v12) {
                            v4 - v12
                        } else {
                            0
                        };
                        if (v13 == 0) {
                            (0, 0)
                        } else {
                            (v13 + v12, v14)
                        }
                    } else {
                        let (v15, v16) = quote_db_with_rem<T4, T5>(arg4, arg5, v4, arg7, arg9);
                        let v17 = quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v15));
                        let v18 = if (v4 > v16) {
                            v4 - v16
                        } else {
                            0
                        };
                        if (v17 == 0) {
                            (0, 0)
                        } else {
                            (v17 + v16, v18)
                        }
                    };
                    (v10, v9)
                };
                (v8, v7)
            };
            let (v19, v20) = evaluate_net_profit_ppm(v4, v5, v6, arg8, arg11);
            if (v19 && (v1 == 0 || v20 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_3hop_cetus_bf_db_v6<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = coarse_sizes_v6(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v9)), arg7, arg9), v9)
            } else if (arg6 == 1) {
                (quote_bluefin<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v9), arg7, arg9)), v9)
            } else if (arg6 == 2) {
                (quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v9)), arg7, arg9), v9)
            } else if (arg6 == 3) {
                (quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, v9), arg7, arg9)), v9)
            } else if (arg6 == 4) {
                let (v12, v13) = quote_db_with_rem<T4, T5>(arg4, arg5, v9, arg7, arg9);
                let v14 = quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v12));
                let v15 = if (v9 > v13) {
                    v9 - v13
                } else {
                    0
                };
                if (v14 == 0) {
                    (0, 0)
                } else {
                    (v14 + v13, v15)
                }
            } else {
                let (v16, v17) = quote_db_with_rem<T4, T5>(arg4, arg5, v9, arg7, arg9);
                let v18 = quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v16));
                let v19 = if (v9 > v17) {
                    v9 - v17
                } else {
                    0
                };
                if (v18 == 0) {
                    (0, 0)
                } else {
                    (v18 + v17, v19)
                }
            };
            v5 = v9;
            v6 = v10;
            v7 = v11;
            let (v20, v21) = evaluate_net_profit_ppm(v9, v10, v11, arg8, arg11);
            if (v20 && (v1 == 0 || v21 > v3)) {
                v2 = v9;
                v4 = v21;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v23 = refine_sizes_v6(arg10, 0);
            let v24 = 0;
            while (v24 < 2) {
                let v25 = *0x1::vector::borrow<u64>(&v23, v24);
                let (v26, v27) = if (arg6 == 0) {
                    (quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v25)), arg7, arg9), v25)
                } else if (arg6 == 1) {
                    (quote_bluefin<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v25), arg7, arg9)), v25)
                } else if (arg6 == 2) {
                    (quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v25)), arg7, arg9), v25)
                } else if (arg6 == 3) {
                    (quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, v25), arg7, arg9)), v25)
                } else if (arg6 == 4) {
                    let (v28, v29) = quote_db_with_rem<T4, T5>(arg4, arg5, v25, arg7, arg9);
                    let v30 = quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v28));
                    let v31 = if (v25 > v29) {
                        v25 - v29
                    } else {
                        0
                    };
                    if (v30 == 0) {
                        (0, 0)
                    } else {
                        (v30 + v29, v31)
                    }
                } else {
                    let (v32, v33) = quote_db_with_rem<T4, T5>(arg4, arg5, v25, arg7, arg9);
                    let v34 = quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v32));
                    let v35 = if (v25 > v33) {
                        v25 - v33
                    } else {
                        0
                    };
                    if (v34 == 0) {
                        (0, 0)
                    } else {
                        (v34 + v33, v35)
                    }
                };
                let (v36, v37) = evaluate_net_profit_ppm(v25, v26, v27, arg8, arg11);
                if (v36 && v37 > v4) {
                    v2 = v25;
                    v4 = v37;
                };
                v24 = v24 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg8), 3001);
            let v38 = micro_fallback_size_v6(arg10);
            let (v39, v40) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v38)), arg7, arg9), v38)
            } else if (arg6 == 1) {
                (quote_bluefin<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v38), arg7, arg9)), v38)
            } else if (arg6 == 2) {
                (quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v38)), arg7, arg9), v38)
            } else if (arg6 == 3) {
                (quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, v38), arg7, arg9)), v38)
            } else if (arg6 == 4) {
                let (v41, v42) = quote_db_with_rem<T4, T5>(arg4, arg5, v38, arg7, arg9);
                let v43 = quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v41));
                let v44 = if (v38 > v42) {
                    v38 - v42
                } else {
                    0
                };
                if (v43 == 0) {
                    (0, 0)
                } else {
                    (v43 + v42, v44)
                }
            } else {
                let (v45, v46) = quote_db_with_rem<T4, T5>(arg4, arg5, v38, arg7, arg9);
                let v47 = quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v45));
                let v48 = if (v38 > v46) {
                    v38 - v46
                } else {
                    0
                };
                if (v47 == 0) {
                    (0, 0)
                } else {
                    (v47 + v46, v48)
                }
            };
            let (v49, _) = evaluate_net_profit_ppm(v38, v39, v40, arg8, arg11);
            assert!(v49, 3001);
            v38
        }
    }

    public fun pick_3hop_cetus_cetus_bf_v5<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: u64, arg8: u64) : u64 {
        let v0 = candidate_sizes_6(arg7);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg6 == 0) {
                quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T4, T5>(arg4, arg5, v4)))
            } else if (arg6 == 1) {
                quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v4)))
            } else {
                quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, 0, arg8);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_3hop_cetus_cetus_bf_v6<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: u64, arg8: u64) : u64 {
        let v0 = 0;
        let v1 = coarse_sizes_v6(arg7);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 4) {
            let v10 = *0x1::vector::borrow<u64>(&v1, v9);
            let v11 = if (arg6 == 0) {
                quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T4, T5>(arg4, arg5, v10)))
            } else if (arg6 == 1) {
                quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v10)))
            } else {
                quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v10)))
            };
            v6 = v10;
            v7 = v11;
            v8 = v10;
            let (v12, v13) = evaluate_net_profit_ppm(v10, v11, v10, v0, arg8);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v3 = v10;
                v5 = v13;
            };
            v9 = v9 + 1;
        };
        if (v3 > 0) {
            let v15 = refine_sizes_v6(arg7, 0);
            let v16 = 0;
            while (v16 < 2) {
                let v17 = *0x1::vector::borrow<u64>(&v15, v16);
                let v18 = if (arg6 == 0) {
                    quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T4, T5>(arg4, arg5, v17)))
                } else if (arg6 == 1) {
                    quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v17)))
                } else {
                    quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v17)))
                };
                let (v19, v20) = evaluate_net_profit_ppm(v17, v18, v17, v0, arg8);
                if (v19 && v20 > v5) {
                    v3 = v17;
                    v5 = v20;
                };
                v16 = v16 + 1;
            };
            v3
        } else {
            assert!(is_near_breakeven_v6(v6, v7, v8, v0), 3001);
            let v21 = micro_fallback_size_v6(arg7);
            let v22 = if (arg6 == 0) {
                quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T4, T5>(arg4, arg5, v21)))
            } else if (arg6 == 1) {
                quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v21)))
            } else {
                quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v21)))
            };
            let (v23, _) = evaluate_net_profit_ppm(v21, v22, v21, v0, arg8);
            assert!(v23, 3001);
            v21
        }
    }

    public fun pick_3hop_cetus_cetus_db_v5<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = candidate_sizes_6(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)), arg7, arg9), v4)
            } else if (arg6 == 1) {
                (quote_cetus<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v4), arg7, arg9)), v4)
            } else {
                let (v7, v8) = quote_db_with_rem<T4, T5>(arg4, arg5, v4, arg7, arg9);
                let v9 = quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v7));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg8, arg11);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_3hop_cetus_cetus_db_v6<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = coarse_sizes_v6(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg6 == 0) {
                (v9, quote_db<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v9)), arg7, arg9))
            } else {
                let (v12, v13) = if (arg6 == 1) {
                    (quote_cetus<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v9), arg7, arg9)), v9)
                } else {
                    let (v14, v15) = quote_db_with_rem<T4, T5>(arg4, arg5, v9, arg7, arg9);
                    let v16 = quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v14));
                    let v17 = if (v9 > v15) {
                        v9 - v15
                    } else {
                        0
                    };
                    if (v16 == 0) {
                        (0, 0)
                    } else {
                        (v16 + v15, v17)
                    }
                };
                (v13, v12)
            };
            v5 = v9;
            v6 = v11;
            v7 = v10;
            let (v18, v19) = evaluate_net_profit_ppm(v9, v11, v10, arg8, arg11);
            if (v18 && (v1 == 0 || v19 > v3)) {
                v2 = v9;
                v4 = v19;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v21 = refine_sizes_v6(arg10, 0);
            let v22 = 0;
            while (v22 < 2) {
                let v23 = *0x1::vector::borrow<u64>(&v21, v22);
                let (v24, v25) = if (arg6 == 0) {
                    (quote_db<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v23)), arg7, arg9), v23)
                } else if (arg6 == 1) {
                    (quote_cetus<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v23), arg7, arg9)), v23)
                } else {
                    let (v26, v27) = quote_db_with_rem<T4, T5>(arg4, arg5, v23, arg7, arg9);
                    let v28 = quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v26));
                    let v29 = if (v23 > v27) {
                        v23 - v27
                    } else {
                        0
                    };
                    if (v28 == 0) {
                        (0, 0)
                    } else {
                        (v28 + v27, v29)
                    }
                };
                let (v30, v31) = evaluate_net_profit_ppm(v23, v24, v25, arg8, arg11);
                if (v30 && v31 > v4) {
                    v2 = v23;
                    v4 = v31;
                };
                v22 = v22 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg8), 3001);
            let v32 = micro_fallback_size_v6(arg10);
            let (v33, v34) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v32)), arg7, arg9), v32)
            } else if (arg6 == 1) {
                (quote_cetus<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v32), arg7, arg9)), v32)
            } else {
                let (v35, v36) = quote_db_with_rem<T4, T5>(arg4, arg5, v32, arg7, arg9);
                let v37 = quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v35));
                let v38 = if (v32 > v36) {
                    v32 - v36
                } else {
                    0
                };
                if (v37 == 0) {
                    (0, 0)
                } else {
                    (v37 + v36, v38)
                }
            };
            let (v39, _) = evaluate_net_profit_ppm(v32, v33, v34, arg8, arg11);
            assert!(v39, 3001);
            v32
        }
    }

    public fun pick_3hop_cetus_db_db_v6<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64) : u64 {
        let v0 = coarse_sizes_v6(arg11);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v9), arg7, arg10), arg8, arg10), v9)
            } else if (arg6 == 1) {
                let (v12, v13) = quote_db_with_rem<T2, T3>(arg2, arg3, v9, arg7, arg10);
                let v14 = quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v12), arg8, arg10);
                let v15 = if (v9 > v13) {
                    v9 - v13
                } else {
                    0
                };
                if (v14 == 0) {
                    (0, 0)
                } else {
                    (v14 + v13, v15)
                }
            } else {
                let (v16, v17) = quote_db_with_rem<T2, T3>(arg2, arg3, v9, arg7, arg10);
                let v18 = quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v16, arg8, arg10));
                let v19 = if (v9 > v17) {
                    v9 - v17
                } else {
                    0
                };
                if (v18 == 0) {
                    (0, 0)
                } else {
                    (v18 + v17, v19)
                }
            };
            v5 = v9;
            v6 = v10;
            v7 = v11;
            let (v20, v21) = evaluate_net_profit_ppm(v9, v10, v11, arg9, arg12);
            if (v20 && (v1 == 0 || v21 > v3)) {
                v2 = v9;
                v4 = v21;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v23 = refine_sizes_v6(arg11, 0);
            let v24 = 0;
            while (v24 < 2) {
                let v25 = *0x1::vector::borrow<u64>(&v23, v24);
                let (v26, v27) = if (arg6 == 0) {
                    (quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v25), arg7, arg10), arg8, arg10), v25)
                } else if (arg6 == 1) {
                    let (v28, v29) = quote_db_with_rem<T2, T3>(arg2, arg3, v25, arg7, arg10);
                    let v30 = quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v28), arg8, arg10);
                    let v31 = if (v25 > v29) {
                        v25 - v29
                    } else {
                        0
                    };
                    if (v30 == 0) {
                        (0, 0)
                    } else {
                        (v30 + v29, v31)
                    }
                } else {
                    let (v32, v33) = quote_db_with_rem<T2, T3>(arg2, arg3, v25, arg7, arg10);
                    let v34 = quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v32, arg8, arg10));
                    let v35 = if (v25 > v33) {
                        v25 - v33
                    } else {
                        0
                    };
                    if (v34 == 0) {
                        (0, 0)
                    } else {
                        (v34 + v33, v35)
                    }
                };
                let (v36, v37) = evaluate_net_profit_ppm(v25, v26, v27, arg9, arg12);
                if (v36 && v37 > v4) {
                    v2 = v25;
                    v4 = v37;
                };
                v24 = v24 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg9), 3001);
            let v38 = micro_fallback_size_v6(arg11);
            let (v39, v40) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v38), arg7, arg10), arg8, arg10), v38)
            } else if (arg6 == 1) {
                let (v41, v42) = quote_db_with_rem<T2, T3>(arg2, arg3, v38, arg7, arg10);
                let v43 = quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v41), arg8, arg10);
                let v44 = if (v38 > v42) {
                    v38 - v42
                } else {
                    0
                };
                if (v43 == 0) {
                    (0, 0)
                } else {
                    (v43 + v42, v44)
                }
            } else {
                let (v45, v46) = quote_db_with_rem<T2, T3>(arg2, arg3, v38, arg7, arg10);
                let v47 = quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v45, arg8, arg10));
                let v48 = if (v38 > v46) {
                    v38 - v46
                } else {
                    0
                };
                if (v47 == 0) {
                    (0, 0)
                } else {
                    (v47 + v46, v48)
                }
            };
            let (v49, _) = evaluate_net_profit_ppm(v38, v39, v40, arg9, arg12);
            assert!(v49, 3001);
            v38
        }
    }

    public fun pick_3hop_db_3hop_v6<T0, T1, T2, T3, T4, T5>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64) : u64 {
        let v0 = coarse_sizes_v6(arg11);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 4) {
            let v9 = *0x1::vector::borrow<u64>(&v0, v8);
            let (v10, v11) = quote_db_with_rem<T0, T1>(arg0, arg1, v9, arg6, arg10);
            let v12 = quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, v10, arg7, arg10), arg8, arg10);
            let v13 = if (v9 > v11) {
                v9 - v11
            } else {
                0
            };
            let (v14, v15) = if (v12 == 0) {
                (0, 0)
            } else {
                (v12 + v11, v13)
            };
            v5 = v9;
            v6 = v14;
            v7 = v15;
            let (v16, v17) = evaluate_net_profit_ppm(v9, v14, v15, arg9, arg12);
            if (v16 && (v1 == 0 || v17 > v3)) {
                v2 = v9;
                v4 = v17;
            };
            v8 = v8 + 1;
        };
        if (v2 > 0) {
            let v19 = refine_sizes_v6(arg11, 0);
            let v20 = 0;
            while (v20 < 2) {
                let v21 = *0x1::vector::borrow<u64>(&v19, v20);
                let (v22, v23) = quote_db_with_rem<T0, T1>(arg0, arg1, v21, arg6, arg10);
                let v24 = quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, v22, arg7, arg10), arg8, arg10);
                let v25 = if (v21 > v23) {
                    v21 - v23
                } else {
                    0
                };
                let (v26, v27) = if (v24 == 0) {
                    (0, 0)
                } else {
                    (v24 + v23, v25)
                };
                let (v28, v29) = evaluate_net_profit_ppm(v21, v26, v27, arg9, arg12);
                if (v28 && v29 > v4) {
                    v2 = v21;
                    v4 = v29;
                };
                v20 = v20 + 1;
            };
            v2
        } else {
            assert!(is_near_breakeven_v6(v5, v6, v7, arg9), 3001);
            let v30 = micro_fallback_size_v6(arg11);
            let (v31, v32) = quote_db_with_rem<T0, T1>(arg0, arg1, v30, arg6, arg10);
            let v33 = quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, v31, arg7, arg10), arg8, arg10);
            let v34 = if (v30 > v32) {
                v30 - v32
            } else {
                0
            };
            let (v35, v36) = if (v33 == 0) {
                (0, 0)
            } else {
                (v33 + v32, v34)
            };
            let (v37, _) = evaluate_net_profit_ppm(v30, v35, v36, arg9, arg12);
            assert!(v37, 3001);
            v30
        }
    }

    public fun pick_4hop_bf_bf_bf_db_v5<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg5: bool, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T6, T7>, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64) : u64 {
        let v0 = candidate_sizes_6(arg12);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg8) {
                let (v7, v8) = quote_db_with_rem<T6, T7>(arg6, arg7, v4, arg9, arg11);
                let v9 = quote_bluefin<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v7)));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            } else {
                (quote_db<T6, T7>(arg6, arg7, quote_bluefin<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4))), arg9, arg11), v4)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg10, arg13);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_4hop_bf_bf_cetus_db_v5<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T6, T7>, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64) : u64 {
        let v0 = candidate_sizes_6(arg12);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg8) {
                let (v7, v8) = quote_db_with_rem<T6, T7>(arg6, arg7, v4, arg9, arg11);
                let v9 = quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v7)));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            } else {
                (quote_db<T6, T7>(arg6, arg7, quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4))), arg9, arg11), v4)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg10, arg13);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_4hop_bf_cetus_bf_db_v2<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg5: bool, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T6, T7>, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64) : u64 {
        let v0 = candidate_sizes(arg12);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg8) {
                let (v7, v8) = quote_db_with_rem<T6, T7>(arg6, arg7, v4, arg9, arg11);
                let v9 = quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v7)));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            } else {
                (quote_db<T6, T7>(arg6, arg7, quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4))), arg9, arg11), v4)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg10, arg13);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_4hop_bf_cetus_cetus_db_v5<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T6, T7>, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64) : u64 {
        let v0 = candidate_sizes_6(arg12);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg8) {
                let (v7, v8) = quote_db_with_rem<T6, T7>(arg6, arg7, v4, arg9, arg11);
                let v9 = quote_cetus<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v7)));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            } else {
                (quote_db<T6, T7>(arg6, arg7, quote_cetus<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4))), arg9, arg11), v4)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg10, arg13);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_4hop_cetus_bf_cetus_bf<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T6, T7>, arg7: bool, arg8: u64, arg9: u64, arg10: u64) : u64 {
        let v0 = candidate_sizes(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_bluefin<T6, T7>(arg6, arg7, quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)))), arg9, arg10);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_4hop_cetus_bf_cetus_db_v2<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T6, T7>, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64) : u64 {
        let v0 = candidate_sizes(arg12);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg8) {
                let (v7, v8) = quote_db_with_rem<T6, T7>(arg6, arg7, v4, arg9, arg11);
                let v9 = quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v7)));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            } else {
                (quote_db<T6, T7>(arg6, arg7, quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4))), arg9, arg11), v4)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg10, arg13);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_4hop_cetus_cetus_bf_db_v2<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg5: bool, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T6, T7>, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64) : u64 {
        let v0 = candidate_sizes(arg12);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg8) {
                let (v7, v8) = quote_db_with_rem<T6, T7>(arg6, arg7, v4, arg9, arg11);
                let v9 = quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v7)));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            } else {
                (quote_db<T6, T7>(arg6, arg7, quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4))), arg9, arg11), v4)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg10, arg13);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_4hop_cetus_cetus_cetus_cetus<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>, arg7: bool, arg8: u64, arg9: u64, arg10: u64) : u64 {
        let v0 = candidate_sizes(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_cetus<T6, T7>(arg6, arg7, quote_cetus<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)))), arg9, arg10);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_4hop_cetus_cetus_cetus_db_v5<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T6, T7>, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: u64, arg13: u64) : u64 {
        let v0 = candidate_sizes_6(arg12);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 6) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg8) {
                let (v7, v8) = quote_db_with_rem<T6, T7>(arg6, arg7, v4, arg9, arg11);
                let v9 = quote_cetus<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v7)));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            } else {
                (quote_db<T6, T7>(arg6, arg7, quote_cetus<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4))), arg9, arg11), v4)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg10, arg13);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_best_of_2_cetus_vs_bf_v5<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg5: bool, arg6: u64, arg7: u64) : (u8, u64) {
        let v0 = candidate_sizes_6(arg6);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 6) {
            let v4 = quote_cetus<T0, T1>(arg0, arg1, *0x1::vector::borrow<u64>(&v0, v3));
            0x1::vector::push_back<u64>(&mut v1, quote_cetus<T2, T3>(arg2, arg3, v4));
            0x1::vector::push_back<u64>(&mut v2, quote_bluefin<T4, T5>(arg4, arg5, v4));
            v3 = v3 + 1;
        };
        select_best_of_2(&v0, &v1, &v2, 0, arg7)
    }

    public fun pick_best_of_2_db_exit_v6<T0, T1, T2, T3, T4, T5>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: bool, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg7: bool, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64) : (u8, u64) {
        let v0 = coarse_sizes_v6(arg9);
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 4) {
            let v6 = *0x1::vector::borrow<u64>(&v0, v5);
            let (v7, v8) = quote_db_with_rem<T0, T1>(arg0, arg1, v6, arg2, arg8);
            let v9 = if (v6 > v8) {
                v6 - v8
            } else {
                0
            };
            let v10 = quote_cetus<T2, T3>(arg4, arg5, v7);
            let v11 = if (v10 == 0) {
                0
            } else {
                v10 + v8
            };
            let (v12, v13) = evaluate_net_profit_ppm(v6, v11, v9, arg3, arg10);
            if (v12 && (v2 == 0 || v13 > v4)) {
                v1 = 0;
                v3 = v6;
                v4 = v13;
            };
            let v14 = quote_bluefin<T4, T5>(arg6, arg7, v7);
            let v15 = if (v14 == 0) {
                0
            } else {
                v14 + v8
            };
            let (v16, v17) = evaluate_net_profit_ppm(v6, v15, v9, arg3, arg10);
            if (v16 && (v3 == 0 || v17 > v4)) {
                v1 = 1;
                v3 = v6;
                v4 = v17;
            };
            v5 = v5 + 1;
        };
        assert!(v3 > 0, 3001);
        let v18 = refine_sizes_v6(arg9, 0);
        let v19 = 0;
        while (v19 < 2) {
            let v20 = *0x1::vector::borrow<u64>(&v18, v19);
            let (v21, v22) = quote_db_with_rem<T0, T1>(arg0, arg1, v20, arg2, arg8);
            let v23 = if (v20 > v22) {
                v20 - v22
            } else {
                0
            };
            let v24 = quote_cetus<T2, T3>(arg4, arg5, v21);
            let v25 = if (v24 == 0) {
                0
            } else {
                v24 + v22
            };
            let (v26, v27) = evaluate_net_profit_ppm(v20, v25, v23, arg3, arg10);
            if (v26 && v27 > v4) {
                v1 = 0;
                v3 = v20;
                v4 = v27;
            };
            let v28 = quote_bluefin<T4, T5>(arg6, arg7, v21);
            let v29 = if (v28 == 0) {
                0
            } else {
                v28 + v22
            };
            let (v30, v31) = evaluate_net_profit_ppm(v20, v29, v23, arg3, arg10);
            if (v30 && v31 > v4) {
                v1 = 1;
                v3 = v20;
                v4 = v31;
            };
            v19 = v19 + 1;
        };
        (v1, v3)
    }

    public fun pick_bf_bf_bf<T0, T1, T2, T3, T4, T5>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg5: bool, arg6: u64, arg7: u64, arg8: u64) : u64 {
        let v0 = candidate_sizes(arg6);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_bluefin<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4))), arg7, arg8);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_bf_bf_db_v2<T0, T1, T2, T3, T4, T5>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = candidate_sizes(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg6) {
                let (v7, v8) = quote_db_with_rem<T4, T5>(arg4, arg5, v4, arg7, arg9);
                let v9 = quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v7));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            } else {
                (quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4)), arg7, arg9), v4)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg8, arg11);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_bf_cetus_bf<T0, T1, T2, T3, T4, T5>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg5: bool, arg6: u64, arg7: u64, arg8: u64) : u64 {
        let v0 = candidate_sizes(arg6);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_bluefin<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4))), arg7, arg8);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_bluefin_bluefin<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: u64) : u64 {
        let v0 = candidate_sizes(arg4);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_bluefin<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4)), 0, arg5);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_bluefin_deepbook<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = candidate_sizes(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg4) {
                quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4), arg5, arg7)
            } else {
                quote_bluefin<T0, T1>(arg0, arg1, quote_db<T2, T3>(arg2, arg3, v4, arg5, arg7))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, arg6, arg9);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_bluefin_deepbook_v2<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = candidate_sizes(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_bluefin<T0, T1>(arg0, arg1, v4), arg5, arg7), v4)
            } else {
                let (v7, v8) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg5, arg7);
                let v9 = quote_bluefin<T0, T1>(arg0, arg1, v7);
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg6, arg9);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_bf_cetus<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: u64, arg7: u64, arg8: u64) : u64 {
        let v0 = candidate_sizes(arg6);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_cetus<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4))), arg7, arg8);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_bf_db<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = candidate_sizes(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg6 == 0) {
                quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)), arg7, arg9)
            } else if (arg6 == 1) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v4), arg7, arg9))
            } else if (arg6 == 2) {
                quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v4)), arg7, arg9)
            } else if (arg6 == 3) {
                quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, v4), arg7, arg9))
            } else if (arg6 == 4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v4, arg7, arg9)))
            } else {
                quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, v4, arg7, arg9)))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, arg8, arg11);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_bf_db_v2<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = candidate_sizes(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)), arg7, arg9), v4)
            } else if (arg6 == 1) {
                (quote_bluefin<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v4), arg7, arg9)), v4)
            } else if (arg6 == 2) {
                (quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v4)), arg7, arg9), v4)
            } else {
                let (v7, v8) = if (arg6 == 3) {
                    (v4, quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, quote_bluefin<T2, T3>(arg2, arg3, v4), arg7, arg9)))
                } else {
                    let (v9, v10) = if (arg6 == 4) {
                        let (v11, v12) = quote_db_with_rem<T4, T5>(arg4, arg5, v4, arg7, arg9);
                        let v13 = quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v11));
                        let v14 = if (v4 > v12) {
                            v4 - v12
                        } else {
                            0
                        };
                        if (v13 == 0) {
                            (0, 0)
                        } else {
                            (v13 + v12, v14)
                        }
                    } else {
                        let (v15, v16) = quote_db_with_rem<T4, T5>(arg4, arg5, v4, arg7, arg9);
                        let v17 = quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v15));
                        let v18 = if (v4 > v16) {
                            v4 - v16
                        } else {
                            0
                        };
                        if (v17 == 0) {
                            (0, 0)
                        } else {
                            (v17 + v16, v18)
                        }
                    };
                    (v10, v9)
                };
                (v8, v7)
            };
            let (v19, v20) = evaluate_net_profit_ppm(v4, v5, v6, arg8, arg11);
            if (v19 && (v1 == 0 || v20 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_bluefin<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = candidate_sizes(arg5);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg4) {
                quote_bluefin<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4))
            } else {
                quote_cetus<T0, T1>(arg0, arg1, quote_bluefin<T2, T3>(arg2, arg3, v4))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, 0, arg6);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_cetus<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: u64) : u64 {
        let v0 = candidate_sizes(arg4);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)), 0, arg5);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_cetus_cetus<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg5: bool, arg6: u64, arg7: u64, arg8: u64) : u64 {
        let v0 = candidate_sizes(arg6);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_cetus<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4))), arg7, arg8);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_cetus_db<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = candidate_sizes(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg6 == 0) {
                quote_db<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)), arg7, arg9)
            } else if (arg6 == 1) {
                quote_cetus<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v4), arg7, arg9))
            } else {
                quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v4, arg7, arg9)))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, arg8, arg11);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_cetus_db_v2<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64) : u64 {
        let v0 = candidate_sizes(arg10);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg6 == 0) {
                (quote_db<T4, T5>(arg4, arg5, quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4)), arg7, arg9), v4)
            } else if (arg6 == 1) {
                (quote_cetus<T2, T3>(arg2, arg3, quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v4), arg7, arg9)), v4)
            } else {
                let (v7, v8) = quote_db_with_rem<T4, T5>(arg4, arg5, v4, arg7, arg9);
                let v9 = quote_cetus<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v7));
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg8, arg11);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_db_db<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64) : u64 {
        let v0 = candidate_sizes(arg11);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg6 == 0) {
                quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4), arg7, arg10), arg8, arg10)
            } else if (arg6 == 1) {
                quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, quote_db<T2, T3>(arg2, arg3, v4, arg7, arg10)), arg8, arg10)
            } else {
                quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, v4, arg7, arg10), arg8, arg10))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, arg9, arg12);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_db_db_v2<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: u8, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64) : u64 {
        let v0 = candidate_sizes(arg11);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg6 == 0) {
                (v4, quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4), arg7, arg10), arg8, arg10))
            } else {
                let (v7, v8) = if (arg6 == 1) {
                    let (v9, v10) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg7, arg10);
                    let v11 = quote_db<T4, T5>(arg4, arg5, quote_cetus<T0, T1>(arg0, arg1, v9), arg8, arg10);
                    let v12 = if (v4 > v10) {
                        v4 - v10
                    } else {
                        0
                    };
                    if (v11 == 0) {
                        (0, 0)
                    } else {
                        (v11 + v10, v12)
                    }
                } else {
                    let (v13, v14) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg7, arg10);
                    let v15 = quote_cetus<T0, T1>(arg0, arg1, quote_db<T4, T5>(arg4, arg5, v13, arg8, arg10));
                    let v16 = if (v4 > v14) {
                        v4 - v14
                    } else {
                        0
                    };
                    if (v15 == 0) {
                        (0, 0)
                    } else {
                        (v15 + v14, v16)
                    }
                };
                (v8, v7)
            };
            let (v17, v18) = evaluate_net_profit_ppm(v4, v6, v5, arg9, arg12);
            if (v17 && (v1 == 0 || v18 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_deepbook<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = candidate_sizes(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let v5 = if (arg4) {
                quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4), arg5, arg7)
            } else {
                quote_cetus<T0, T1>(arg0, arg1, quote_db<T2, T3>(arg2, arg3, v4, arg5, arg7))
            };
            let (v6, v7) = evaluate_net_profit(v4, v5, arg6, arg9);
            if (v6 && (v1 == 0 || v7 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_cetus_deepbook_v2<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64) : u64 {
        let v0 = candidate_sizes(arg8);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = if (arg4) {
                (quote_db<T2, T3>(arg2, arg3, quote_cetus<T0, T1>(arg0, arg1, v4), arg5, arg7), v4)
            } else {
                let (v7, v8) = quote_db_with_rem<T2, T3>(arg2, arg3, v4, arg5, arg7);
                let v9 = quote_cetus<T0, T1>(arg0, arg1, v7);
                let v10 = if (v4 > v8) {
                    v4 - v8
                } else {
                    0
                };
                if (v9 == 0) {
                    (0, 0)
                } else {
                    (v9 + v8, v10)
                }
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v5, v6, arg6, arg9);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_db_3hop<T0, T1, T2, T3, T4, T5>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64) : u64 {
        let v0 = candidate_sizes(arg11);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = evaluate_net_profit(v4, quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, quote_db<T0, T1>(arg0, arg1, v4, arg6, arg10), arg7, arg10), arg8, arg10), arg9, arg12);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun pick_db_3hop_v2<T0, T1, T2, T3, T4, T5>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T4, T5>, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64) : u64 {
        let v0 = candidate_sizes(arg11);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 4) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            let (v5, v6) = quote_db_with_rem<T0, T1>(arg0, arg1, v4, arg6, arg10);
            let v7 = quote_db<T4, T5>(arg4, arg5, quote_db<T2, T3>(arg2, arg3, v5, arg7, arg10), arg8, arg10);
            let v8 = if (v4 > v6) {
                v4 - v6
            } else {
                0
            };
            let (v9, v10) = if (v7 == 0) {
                (0, 0)
            } else {
                (v7 + v6, v8)
            };
            let (v11, v12) = evaluate_net_profit_ppm(v4, v9, v10, arg9, arg12);
            if (v11 && (v1 == 0 || v12 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    fun quote_bluefin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        if (arg1 && v0 <= 4295048016) {
            return 0
        };
        if (!arg1 && v0 >= 79226673515401279992447579055) {
            return 0
        };
        let v1 = bounded_sqrt_limit(v0, arg1, 150);
        if (arg1 && v1 >= v0) {
            return 0
        };
        if (!arg1 && v1 <= v0) {
            return 0
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, arg2, v1);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v2)) {
            return 0
        };
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v2) > 0) {
            return 0
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2)
    }

    fun quote_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, arg2);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            return 0
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public fun quote_cpmm_scaled_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = if (arg6 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg5 >= 10000
        };
        if (v0) {
            return 0
        };
        let v1 = (arg0 as u128) * (arg2 as u128) / 1000000000;
        let v2 = (arg1 as u128) * (arg3 as u128) / 1000000000;
        if (v1 == 0 || v2 == 0) {
            return 0
        };
        let (v3, v4) = if (arg4) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        let v5 = (arg6 as u128);
        let v6 = v4 * v5 / (v3 + v5) * ((10000 - arg5) as u128) / 10000;
        if (v6 >= v4 || v6 > 18446744073709551615) {
            0
        } else {
            (v6 as u64)
        }
    }

    fun quote_db<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u64 {
        let (v0, _) = quote_db_with_rem<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        v0
    }

    fun quote_db_with_rem<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        if (arg1) {
            if (arg3) {
                let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg2, arg4);
                (v3, v2)
            } else {
                let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg2, arg4);
                (v6, v5)
            }
        } else if (arg3) {
            let (v8, v9, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg2, arg4);
            (v8, v9)
        } else {
            let (v11, v12, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg2, arg4);
            (v11, v12)
        }
    }

    fun quote_ferra_dlmm<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let (v0, v1, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg2, arg1, arg3);
        if (v0 > 0) {
            0
        } else {
            v1
        }
    }

    fun quote_flowx_v2<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(v0);
        if (v1 == 0 || v2 == 0) {
            return 0
        };
        let (v3, v4) = if (arg1) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_out(arg2, v3, v4, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(v0))
    }

    public fun refine_sizes_v6(arg0: u64, arg1: u64) : vector<u64> {
        if (arg1 == 0) {
            let v1 = 0x1::vector::empty<u64>();
            let v2 = &mut v1;
            0x1::vector::push_back<u64>(v2, (((arg0 as u128) * 80 / 100) as u64));
            0x1::vector::push_back<u64>(v2, (((arg0 as u128) * 65 / 100) as u64));
            v1
        } else if (arg1 == 1) {
            let v3 = 0x1::vector::empty<u64>();
            let v4 = &mut v3;
            0x1::vector::push_back<u64>(v4, (((arg0 as u128) * 72 / 100) as u64));
            0x1::vector::push_back<u64>(v4, (((arg0 as u128) * 34 / 100) as u64));
            v3
        } else if (arg1 == 2) {
            let v5 = 0x1::vector::empty<u64>();
            let v6 = &mut v5;
            0x1::vector::push_back<u64>(v6, (((arg0 as u128) * 34 / 100) as u64));
            0x1::vector::push_back<u64>(v6, (((arg0 as u128) * 14 / 100) as u64));
            v5
        } else {
            let v7 = 0x1::vector::empty<u64>();
            let v8 = &mut v7;
            0x1::vector::push_back<u64>(v8, (((arg0 as u128) * 14 / 100) as u64));
            0x1::vector::push_back<u64>(v8, (((arg0 as u128) * 4 / 100) as u64));
            v7
        }
    }

    public fun select_adaptive_v6(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0x1::vector::length<u64>(arg0);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = *0x1::vector::borrow<u64>(arg0, v5);
            let (v7, v8) = evaluate_net_profit_ppm(v6, *0x1::vector::borrow<u64>(arg1, v5), *0x1::vector::borrow<u64>(arg2, v5), arg9, arg10);
            if (v7 && (v0 == 0 || v8 > v2)) {
                v1 = v6;
                v3 = v8;
            };
            v5 = v5 + 1;
        };
        if (v1 > 0) {
            let v9 = 0;
            while (v9 < 0x1::vector::length<u64>(arg3)) {
                let v10 = *0x1::vector::borrow<u64>(arg3, v9);
                let (v11, v12) = evaluate_net_profit_ppm(v10, *0x1::vector::borrow<u64>(arg4, v9), *0x1::vector::borrow<u64>(arg5, v9), arg9, arg10);
                if (v11 && v12 > v3) {
                    v1 = v10;
                    v3 = v12;
                };
                v9 = v9 + 1;
            };
            return (v1, 0)
        } else {
            if (v4 > 0) {
                let v13 = v4 - 1;
                if (is_near_breakeven_v6(*0x1::vector::borrow<u64>(arg0, v13), *0x1::vector::borrow<u64>(arg1, v13), *0x1::vector::borrow<u64>(arg2, v13), arg9)) {
                    let (v14, _) = evaluate_net_profit_ppm(arg6, arg7, arg8, arg9, arg10);
                    if (v14) {
                        return (arg6, v13)
                    };
                };
            };
            abort 3001
        };
    }

    public fun select_best_amount(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg0)) {
            let v3 = *0x1::vector::borrow<u64>(arg0, v2);
            let (v4, v5) = evaluate_net_profit(v3, *0x1::vector::borrow<u64>(arg1, v2), arg2, arg3);
            if (v4 && (v0 == 0 || v5 > 0)) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 3001);
        v1
    }

    public fun select_best_amount_ppm(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1) && v0 == 0x1::vector::length<u64>(arg2), 3001);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(arg0, v3);
            let (v5, v6) = evaluate_net_profit_ppm(v4, *0x1::vector::borrow<u64>(arg1, v3), *0x1::vector::borrow<u64>(arg2, v3), arg3, arg4);
            if (v5 && (v1 == 0 || v6 > 0)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3001);
        v2
    }

    public fun select_best_of_2(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: u64, arg4: u64) : (u8, u64) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1) && v0 == 0x1::vector::length<u64>(arg2), 3001);
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v0) {
            let v6 = *0x1::vector::borrow<u64>(arg0, v5);
            let (v7, v8) = evaluate_net_profit_ppm(v6, *0x1::vector::borrow<u64>(arg1, v5), v6, arg3, arg4);
            if (v7 && (v2 == 0 || v8 > v4)) {
                v1 = 0;
                v3 = v6;
                v4 = v8;
            };
            let (v9, v10) = evaluate_net_profit_ppm(v6, *0x1::vector::borrow<u64>(arg2, v5), v6, arg3, arg4);
            if (v9 && (v3 == 0 || v10 > v4)) {
                v1 = 1;
                v3 = v6;
                v4 = v10;
            };
            v5 = v5 + 1;
        };
        assert!(v3 > 0, 3001);
        (v1, v3)
    }

    // decompiled from Move bytecode v7
}

