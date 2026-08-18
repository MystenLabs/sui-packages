module 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::r3 {
    struct LegV2 has copy, drop {
        desired_price: u64,
        actual_price: u64,
        econ_bound: u64,
        requested_offset: u8,
        realized_offset: u64,
        kind: u8,
        quantity: u64,
        order_id: u128,
        kept: bool,
        cancelled: bool,
        placed: bool,
        breach_cancel: bool,
    }

    struct AnchorV2 has copy, drop {
        source_anchor: u64,
        live_bid: u64,
        live_ask: u64,
        live_mid: u64,
        drift_bps: u64,
        drift_ok: bool,
        source_age_ms: u64,
    }

    struct TakeV2 has copy, drop {
        venue: u8,
        side: u8,
        quantity: u64,
        all_in_price: u64,
        gross_edge_bps: u64,
        fee: u64,
        slippage_bps: u64,
        net_edge_bps: u64,
        executed: bool,
        base_delta: u64,
        base_delta_neg: bool,
        quote_delta: u64,
        quote_delta_neg: bool,
    }

    struct CycleV2 has copy, drop {
        schema: u8,
        desk_id: 0x2::object::ID,
        sequence: u64,
        source_ts_ms: u64,
        markout_side: u8,
        markout_ppb: u64,
        conviction_ppm: u64,
        target_price: u64,
        anchor: AnchorV2,
        take: TakeV2,
        bid: LegV2,
        ask: LegV2,
        inventory_base: u64,
        reason: u8,
        status: u64,
    }

    fun lg<T0, T1>(arg0: &mut 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::D<T0, T1>, arg1: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u8, arg17: u64, arg18: bool, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : (u64, LegV2) {
        let v0 = empty_leg(arg16);
        v0.desired_price = arg8;
        v0.econ_bound = arg10;
        v0.kind = arg9;
        v0.breach_cancel = arg18;
        v0.quantity = arg11;
        let v1 = if (arg8 > 0) {
            if (arg17 > 0) {
                arg13 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = if (arg7) {
                if (arg8 > arg17) {
                    arg8 - arg17
                } else {
                    0
                }
            } else if (arg17 > arg8) {
                arg17 - arg8
            } else {
                0
            };
            v0.realized_offset = v2 / arg13;
        };
        let v3 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, arg7);
        if (arg8 == 0 || arg11 < arg12) {
            let v4 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg19, arg20, arg21);
            let v5 = if (arg7) {
                8
            } else {
                64
            };
            v0.cancelled = v4 & v5 != 0;
            return (v4, v0)
        };
        let v6 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::rqd(0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v3), 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lx(&v3), arg8, arg7, arg10, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 26), arg13, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::le(&v3), arg15, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 5));
        let v7 = if (v6 == 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::act_keep()) {
            if (0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v3)) {
                0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lq(&v3) == arg11
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            v0.kept = true;
            v0.actual_price = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lx(&v3);
            v0.order_id = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lo(&v3);
            let v8 = if (arg7) {
                4
            } else {
                32
            };
            return (arg19 | v8, v0)
        };
        if (v6 == 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::act_cancel()) {
            let v9 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg19, arg20, arg21);
            let v10 = if (arg7) {
                8
            } else {
                64
            };
            v0.cancelled = v9 & v10 != 0;
            return (v9, v0)
        };
        let v11 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg19, arg20, arg21);
        let v12 = if (arg7) {
            8
        } else {
            64
        };
        v0.cancelled = v11 & v12 != 0;
        let v13 = if (arg7) {
            let v14 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::fv(arg8, arg11, true);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= v14 + 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::fa(arg14, v14)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) >= arg11 + 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::fa(arg14, arg11)
        };
        if (!v13) {
            return (v11, v0)
        };
        let v15 = arg15 + 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 4);
        let v16 = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::cy<T0, T1>(arg0), 3, 1, arg8, arg11, arg7, v15, arg20, arg21);
        0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lset<T0, T1>(arg0, arg7, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::mk(v16, arg8, arg11, arg15, v15, arg9, false));
        v0.placed = true;
        v0.actual_price = arg8;
        v0.order_id = v16;
        let v17 = if (arg7) {
            2
        } else {
            16
        };
        (v11 | v17, v0)
    }

    public fun ap<T0, T1>(arg0: &mut 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::D<T0, T1>, arg1: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u64, arg13: u8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::vid<T0, T1>(arg0) == 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::id<T1>(arg1), 1);
        assert!(0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::aid<T0, T1>(arg0) == 0x2::object::id<0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>>(arg2), 1);
        assert!(0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::poid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg6), 1);
        assert!(0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::mid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg5), 1);
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::assert_executor<T1>(arg1, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::did<T0, T1>(arg0), 0x2::tx_context::sender(arg15));
        let v0 = 0x2::clock::timestamp_ms(arg14);
        let (v1, _) = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::ta<T0, T1>(arg0, arg7, arg8, v0);
        if (!v1) {
            emit_cycle<T0, T1>(arg0, arg7, arg8, arg10, arg11, arg12, 0, empty_anchor(arg9), empty_take(), empty_leg(arg13), empty_leg(arg13), 0, 1, 1024);
            return 1024
        };
        let v3 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::zp<T0, T1>(arg0);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg6);
        let v7 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 18);
        let v8 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::fr<T0, T1>(arg6);
        let v9 = 0;
        let v10 = if (v3) {
            2
        } else {
            0
        };
        let v11 = v10;
        let v12 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, true);
        let v13 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, false);
        let v14 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5));
        let v15 = 0;
        let v16 = 0;
        let v17 = false;
        let v18 = false;
        let v19 = 0;
        while (v19 < 0x1::vector::length<u128>(&v14)) {
            let v20 = *0x1::vector::borrow<u128>(&v14, v19);
            let v21 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v12) && v20 == 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lo(&v12);
            let v22 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v13) && v20 == 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lo(&v13);
            if (v21) {
                v17 = true;
                let v23 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg6, v20);
                v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v23) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v23);
            };
            if (v22) {
                v18 = true;
                let v24 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg6, v20);
                v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v24) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v24);
            };
            if (!v21 && !v22) {
                0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::cancel_order<T0, T1>(arg1, arg2, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, v20, arg14, arg15);
                v9 = v9 | 128;
            };
            v19 = v19 + 1;
        };
        if (0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v12) && !v17) {
            0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lclr<T0, T1>(arg0, true);
        };
        if (0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v13) && !v18) {
            0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lclr<T0, T1>(arg0, false);
        };
        let v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg6, arg14);
        let v26 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, true);
        let v27 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, false);
        let v28 = if (0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v26)) {
            0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lx(&v26)
        } else {
            0
        };
        let v29 = ex<T0, T1>(arg6, true, v4, v7, v25, v28, v15, arg14);
        let v30 = if (0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v27)) {
            0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lx(&v27)
        } else {
            0
        };
        let v31 = ex<T0, T1>(arg6, false, v4, v7, v25, v30, v16, arg14);
        let v32 = if (v29 > 0) {
            if (v31 > 0) {
                v31 > v29
            } else {
                false
            }
        } else {
            false
        };
        let v33 = if (v32) {
            (v29 + v31) / 2
        } else {
            0
        };
        if (!v32) {
            v9 = v9 | 256;
            if (v10 == 0) {
                v11 = 3;
            };
        };
        let v34 = if (v0 > arg8) {
            v0 - arg8
        } else {
            0
        };
        let v35 = v34 <= 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 21);
        let (v36, v37) = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::ad(arg9, v33, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 20));
        let v38 = if (v32) {
            if (v35) {
                v36
            } else {
                false
            }
        } else {
            false
        };
        if (!v38) {
            v9 = v9 | 512;
            if (v11 == 0) {
                let v39 = if (!v35) {
                    5
                } else {
                    4
                };
                v11 = v39;
            };
        };
        let v40 = AnchorV2{
            source_anchor : arg9,
            live_bid      : v29,
            live_ask      : v31,
            live_mid      : v33,
            drift_bps     : v37,
            drift_ok      : v38,
            source_age_ms : v34,
        };
        let v41 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::tg(arg9, arg10, arg11, false);
        let v42 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::tg(arg9, arg10, arg11, true);
        if (v41 == 0 || v42 == 0) {
            if (v11 == 0) {
                v11 = 6;
            };
        };
        let v43 = if (v38) {
            if (!v3) {
                v41 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v44 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 19) + 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 24);
        let v45 = clamp_offset<T0, T1>(arg0, arg13);
        let (v46, v47) = if (v43) {
            0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::mkp(true, v41, v44, v29, v31, v45, v4)
        } else {
            (0, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::kind_none())
        };
        let (v48, v49) = if (v43) {
            0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::mkp(false, v42, v44, v29, v31, v45, v4)
        } else {
            (0, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::kind_none())
        };
        let v50 = bound(true, v41, v44);
        let v51 = bound(false, v42, v44);
        let v52 = false;
        let v53 = false;
        let v54 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, true);
        if (0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v54) && (!v43 || 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lx(&v54) > v50)) {
            v9 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v9, arg14, arg15);
            v52 = v43;
        };
        let v55 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, false);
        if (0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v55) && (!v43 || 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lx(&v55) < v51)) {
            v9 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, v9, arg14, arg15);
            v53 = v43;
        };
        if (v52 || v53) {
            v9 = v9 | 2048;
        };
        let v56 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let v57 = empty_take();
        let v58 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 14);
        let v59 = if (v58 > 0) {
            (((0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 13) as u128) * (arg12 as u128) / 1000000) as u64) / v58 * v58
        } else {
            (((0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 13) as u128) * (arg12 as u128) / 1000000) as u64)
        };
        let v60 = v59 - v59 % v5;
        let v61 = if (v43) {
            if (arg10 == 1 || arg10 == 2) {
                v60 >= v6
            } else {
                false
            }
        } else {
            false
        };
        if (v61) {
            let v62 = arg10 == 1;
            let v63 = if (v62) {
                v41
            } else {
                v42
            };
            let v64 = if (v62) {
                0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::qd_buy<T0, T1>(arg6, 1, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::fv(v63, v60, true), v60, arg14)
            } else {
                0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::qd<T0, T1>(arg6, 1, v60, arg14)
            };
            let v65 = v64;
            let v66 = if (v62) {
                implied(0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::eco_in(&v65), v60)
            } else {
                implied(0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::tao(&v65), v60)
            };
            let (v67, v68) = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::ed(v62, v63, v66, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 10));
            let v69 = if (v62) {
                v31
            } else {
                v29
            };
            let v70 = bps_gap(v66, v69);
            let v71 = v62 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::eco_in(&v65) + 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::fa(v8, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::eco_in(&v65)) || v56 >= v60 + 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::fa(v8, v60);
            let (v72, v73) = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::ed(v62, v63, v66, 0);
            v57.venue = 1;
            v57.side = arg10;
            v57.quantity = v60;
            v57.all_in_price = v66;
            let v74 = if (v72) {
                v73
            } else {
                0
            };
            v57.gross_edge_bps = v74;
            v57.fee = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::tf(&v65);
            v57.slippage_bps = v70;
            let v75 = if (v67) {
                v68
            } else {
                0
            };
            v57.net_edge_bps = v75;
            if (!v67) {
                if (v11 == 0) {
                    v11 = 7;
                };
            } else if (!(v70 <= 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 25))) {
                if (v11 == 0) {
                    v11 = 8;
                };
            } else if (!0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::q0::iv(&v65, v56 + v16, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 16), 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 17))) {
                if (v11 == 0) {
                    v11 = 9;
                };
            } else if (!v71) {
                if (v11 == 0) {
                    v11 = 10;
                };
            } else {
                let v76 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, !v62);
                if (0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v76) && 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m0::xs(v62, v63, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lx(&v76))) {
                    v9 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, !v62, v9, arg14, arg15);
                };
                let v77 = tick_align(v63, v4, v62);
                if (v77 > 0) {
                    let v78 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
                    let v79 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5);
                    0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::cy<T0, T1>(arg0), 1, 1, v77, v60, v62, v0 + 1000, arg14, arg15);
                    let v80 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
                    let v81 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5);
                    let (v82, v83) = if (v80 >= v78) {
                        (v80 - v78, false)
                    } else {
                        (v78 - v80, true)
                    };
                    let (v84, v85) = if (v81 >= v79) {
                        (v81 - v79, false)
                    } else {
                        (v79 - v81, true)
                    };
                    v57.base_delta = v82;
                    v57.base_delta_neg = v83;
                    v57.quote_delta = v84;
                    v57.quote_delta_neg = v85;
                    if (v83) {
                        v9 = v9 | 4096;
                    };
                    if (v85) {
                        v9 = v9 | 8192;
                    };
                    let v86 = v62 && v82 > 0 && !v83 || v84 > 0 && !v85;
                    v57.executed = v86;
                    if (v57.executed) {
                        v9 = v9 | 1;
                    };
                };
            };
        } else {
            let v87 = if (v43) {
                if (arg10 == 1 || arg10 == 2) {
                    v11 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v87) {
                v11 = 11;
            };
        };
        let v88 = maker_size<T0, T1>(arg0, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) + v16);
        let (v89, v90) = lg<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v46, v47, v50, v88, v6, v4, v8, v0, arg13, v29, v52, v9, arg14, arg15);
        let (v91, v92) = lg<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, v48, v49, v51, v88, v6, v4, v8, v0, arg13, v31, v53, v89, arg14, arg15);
        emit_cycle<T0, T1>(arg0, arg7, arg8, arg10, arg11, arg12, v41, v40, v57, v90, v92, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) + v16, v11, v91);
        v91
    }

    fun bound(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (arg0) {
            (((arg1 as u128) * 10000 / (10000 + (arg2 as u128))) as u64)
        } else {
            ((((arg1 as u128) * (10000 + (arg2 as u128)) + 9999) / 10000) as u64)
        }
    }

    fun bps_gap(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        ((v2 * 10000 / v1) as u64)
    }

    fun clamp_offset<T0, T1>(arg0: &0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::D<T0, T1>, arg1: u8) : u64 {
        let v0 = (arg1 as u64);
        let v1 = if (v0 == 0) {
            0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 22)
        } else {
            v0
        };
        let v2 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 23);
        if (v1 > v2) {
            v2
        } else {
            v1
        }
    }

    fun cx<T0, T1>(arg0: &mut 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::D<T0, T1>, arg1: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lg<T0, T1>(arg0, arg7);
        if (!0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lr(&v0)) {
            return arg8
        };
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5);
        let v2 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lo(&v0);
        if (0x2::vec_set::contains<u128>(&v1, &v2)) {
            0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::cancel_order<T0, T1>(arg1, arg2, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lo(&v0), arg9, arg10);
            let v3 = if (arg7) {
                8
            } else {
                64
            };
            arg8 = arg8 | v3;
        };
        0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::lclr<T0, T1>(arg0, arg7);
        arg8
    }

    fun emit_cycle<T0, T1>(arg0: &0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::D<T0, T1>, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: AnchorV2, arg8: TakeV2, arg9: LegV2, arg10: LegV2, arg11: u64, arg12: u8, arg13: u64) {
        let v0 = CycleV2{
            schema         : 2,
            desk_id        : 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::did<T0, T1>(arg0),
            sequence       : arg1,
            source_ts_ms   : arg2,
            markout_side   : arg3,
            markout_ppb    : arg4,
            conviction_ppm : arg5,
            target_price   : arg6,
            anchor         : arg7,
            take           : arg8,
            bid            : arg9,
            ask            : arg10,
            inventory_base : arg11,
            reason         : arg12,
            status         : arg13,
        };
        0x2::event::emit<CycleV2>(v0);
    }

    fun empty_anchor(arg0: u64) : AnchorV2 {
        AnchorV2{
            source_anchor : arg0,
            live_bid      : 0,
            live_ask      : 0,
            live_mid      : 0,
            drift_bps     : 0,
            drift_ok      : false,
            source_age_ms : 0,
        }
    }

    fun empty_leg(arg0: u8) : LegV2 {
        LegV2{
            desired_price    : 0,
            actual_price     : 0,
            econ_bound       : 0,
            requested_offset : arg0,
            realized_offset  : 0,
            kind             : 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::m1::kind_none(),
            quantity         : 0,
            order_id         : 0,
            kept             : false,
            cancelled        : false,
            placed           : false,
            breach_cancel    : false,
        }
    }

    fun empty_take() : TakeV2 {
        TakeV2{
            venue           : 0,
            side            : 0,
            quantity        : 0,
            all_in_price    : 0,
            gross_edge_bps  : 0,
            fee             : 0,
            slippage_bps    : 0,
            net_edge_bps    : 0,
            executed        : false,
            base_delta      : 0,
            base_delta_neg  : false,
            quote_delta     : 0,
            quote_delta_neg : false,
        }
    }

    fun ex<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = arg2 * 64;
        let (v1, v2) = if (arg1) {
            let v3 = if (arg4 > v0) {
                arg4 - v0
            } else {
                1
            };
            (v3, arg4)
        } else {
            (arg4, arg4 + v0)
        };
        let (v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, v1, v2, arg1, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&v7) && v8 < arg3) {
            let v9 = *0x1::vector::borrow<u64>(&v7, v8);
            let v10 = if (arg5 != 0 && v9 == arg5) {
                arg6
            } else {
                0
            };
            if (*0x1::vector::borrow<u64>(&v6, v8) > v10) {
                return v9
            };
            v8 = v8 + 1;
        };
        0
    }

    fun implied(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u128) * 1000000000 / (arg1 as u128);
        if (v0 > 18446744073709551615) {
            0
        } else {
            (v0 as u64)
        }
    }

    fun maker_size<T0, T1>(arg0: &0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::D<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 6);
        let v1 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 16);
        let v2 = 0x88aa3217d434ba752102618c774ea19ee744d6d04713525319924e10cfb6e132::d0::pv<T0, T1>(arg0, 17);
        let v3 = if (arg2 >= v1 + v2) {
            0
        } else {
            v1 + v2 - arg2
        };
        let v4 = if (v0 < v3) {
            v0
        } else {
            v3
        };
        if (arg1 == 0) {
            v4
        } else {
            v4 - v4 % arg1
        }
    }

    fun tick_align(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg1 == 0) {
            return 0
        };
        if (arg2) {
            arg0 - arg0 % arg1
        } else {
            let v1 = arg0 % arg1;
            if (v1 == 0) {
                arg0
            } else {
                arg0 + arg1 - v1
            }
        }
    }

    // decompiled from Move bytecode v7
}

