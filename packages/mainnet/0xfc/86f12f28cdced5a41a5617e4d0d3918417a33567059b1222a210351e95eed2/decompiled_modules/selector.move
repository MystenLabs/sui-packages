module 0xe1b9fbd9b9de70a494d4ec4aa487ccd24dc926a2ab0060b0bcea116e8ea3db9a::selector {
    public fun candidate_sizes(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0);
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 60 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 35 / 100) as u64));
        0x1::vector::push_back<u64>(v1, (((arg0 as u128) * 20 / 100) as u64));
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
        let v0 = if (arg1) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, arg2, v0);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v1)) {
            return 0
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1)
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

    // decompiled from Move bytecode v7
}

