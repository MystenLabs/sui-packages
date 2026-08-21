module 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::r3 {
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

    struct QuoteV2 has copy, drop {
        desk_id: 0x2::object::ID,
        sequence: u64,
        venue: u8,
        side: u8,
        quantity: u64,
        all_in_price: u64,
        fee: u64,
        slippage_bps: u64,
        net_edge_bps: u64,
        reject: u8,
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

    fun lg<T0, T1>(arg0: &mut 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::D<T0, T1>, arg1: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u8, arg17: u64, arg18: bool, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : (u64, LegV2) {
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
        let v3 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, arg7);
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
        let v6 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::rqd(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v3), 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lx(&v3), arg8, arg7, arg10, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 26), arg13, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::le(&v3), arg15, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 5));
        let v7 = if (v6 == 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::act_keep()) {
            if (0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v3)) {
                0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lq(&v3) == arg11
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            v0.kept = true;
            v0.actual_price = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lx(&v3);
            v0.order_id = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lo(&v3);
            let v8 = if (arg7) {
                4
            } else {
                32
            };
            return (arg19 | v8, v0)
        };
        if (v6 == 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::act_cancel()) {
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
            let v14 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::fv(arg8, arg11, true);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= v14 + 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::fa(arg14, v14)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) >= arg11 + 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::fa(arg14, arg11)
        };
        if (!v13) {
            return (v11, v0)
        };
        let v15 = arg15 + 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 4);
        let v16 = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::cy<T0, T1>(arg0), 3, 1, arg8, arg11, arg7, v15, arg20, arg21);
        0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lset<T0, T1>(arg0, arg7, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::mk(v16, arg8, arg11, arg15, v15, arg9, false));
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

    public fun ap<T0, T1>(arg0: &mut 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::D<T0, T1>, arg1: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg14: u64, arg15: u64, arg16: u64, arg17: u8, arg18: u64, arg19: u64, arg20: u8, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::vid<T0, T1>(arg0) == 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::id<T1>(arg1), 1);
        assert!(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::aid<T0, T1>(arg0) == 0x2::object::id<0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>>(arg2), 1);
        assert!(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::poid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg6), 1);
        assert!(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::mid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg5), 1);
        assert!(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pcid<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg10), 1);
        assert!(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pbid<T0, T1>(arg0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg13), 1);
        assert!(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pmid<T0, T1>(arg0) == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg7), 1);
        assert!(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::xg<T0, T1>(arg0, 1) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg11), 1);
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::assert_executor<T1>(arg1, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::did<T0, T1>(arg0), 0x2::tx_context::sender(arg22));
        let v0 = 0x2::clock::timestamp_ms(arg21);
        let (v1, _) = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::ta<T0, T1>(arg0, arg14, arg15, v0);
        if (!v1) {
            emit_cycle<T0, T1>(arg0, arg14, arg15, arg17, arg18, arg19, 0, empty_anchor(arg16), empty_take(), empty_leg(arg20), empty_leg(arg20), 0, 1, 1024);
            return 1024
        };
        let v3 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::zp<T0, T1>(arg0);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg6);
        let v7 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 18);
        let v8 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::fr<T0, T1>(arg6);
        let v9 = 0;
        let v10 = if (v3) {
            2
        } else {
            0
        };
        let v11 = v10;
        let v12 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, true);
        let v13 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, false);
        let v14 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5));
        let v15 = 0;
        let v16 = 0;
        let v17 = false;
        let v18 = false;
        let v19 = 0;
        while (v19 < 0x1::vector::length<u128>(&v14)) {
            let v20 = *0x1::vector::borrow<u128>(&v14, v19);
            let v21 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v12) && v20 == 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lo(&v12);
            let v22 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v13) && v20 == 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lo(&v13);
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
                0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::cancel_order<T0, T1>(arg1, arg2, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, v20, arg21, arg22);
                v9 = v9 | 128;
            };
            v19 = v19 + 1;
        };
        if (0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v12) && !v17) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lclr<T0, T1>(arg0, true);
        };
        if (0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v13) && !v18) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lclr<T0, T1>(arg0, false);
        };
        let v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg6, arg21);
        let v26 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, true);
        let v27 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, false);
        let v28 = if (0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v26)) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lx(&v26)
        } else {
            0
        };
        let v29 = ex<T0, T1>(arg6, true, v4, v7, v25, v28, v15, arg21);
        let v30 = if (0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v27)) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lx(&v27)
        } else {
            0
        };
        let v31 = ex<T0, T1>(arg6, false, v4, v7, v25, v30, v16, arg21);
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
        let v34 = if (v0 > arg15) {
            v0 - arg15
        } else {
            0
        };
        let v35 = v34 <= 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 21);
        let (v36, v37) = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::ad(arg16, v33, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 20));
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
            source_anchor : arg16,
            live_bid      : v29,
            live_ask      : v31,
            live_mid      : v33,
            drift_bps     : v37,
            drift_ok      : v38,
            source_age_ms : v34,
        };
        let v41 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::tg(arg16, arg17, arg18, false);
        let v42 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::tg(arg16, arg17, arg18, true);
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
        let v44 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 19) + 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 24);
        let v45 = clamp_offset<T0, T1>(arg0, arg20);
        let v46 = arg18 / 10;
        let v47 = if (arg17 == 2) {
            v46
        } else {
            0
        };
        let v48 = if (arg17 == 1) {
            v46
        } else {
            0
        };
        let v49 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, true);
        let v50 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m0::lx(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lf(&v49), v47, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 2), 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 3));
        let v51 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, false);
        let v52 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m0::lx(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lf(&v51), v48, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 2), 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 3));
        0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lflag<T0, T1>(arg0, true, v50);
        0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lflag<T0, T1>(arg0, false, v52);
        let (v53, v54) = if (v43) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::mkp(true, v41, v44, v29, v31, v45, v4)
        } else {
            (0, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::kind_none())
        };
        let (v55, v56) = if (v43) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::mkp(false, v42, v44, v29, v31, v45, v4)
        } else {
            (0, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::kind_none())
        };
        let v57 = if (v43 && v50) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m0::px3(v29, v4, v47, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 1), true)
        } else {
            0
        };
        let v58 = if (v43 && v52) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m0::px3(v31, v4, v48, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 1), false)
        } else {
            0
        };
        let v59 = if (v57 > 0 && v57 < v53) {
            v57
        } else {
            v53
        };
        let v60 = if (v58 > v55) {
            v58
        } else {
            v55
        };
        let v61 = if (v43) {
            if (v50) {
                v59 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v62 = if (v61) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::kind_backoff()
        } else {
            v54
        };
        let v63 = if (v43) {
            if (v52) {
                v60 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v64 = if (v63) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::kind_backoff()
        } else {
            v56
        };
        let v65 = bound(true, v41, v44);
        let v66 = bound(false, v42, v44);
        let v67 = false;
        let v68 = false;
        let v69 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, true);
        if (0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v69) && (!v43 || 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lx(&v69) > v65)) {
            v9 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v9, arg21, arg22);
            v67 = v43;
        };
        let v70 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, false);
        if (0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v70) && (!v43 || 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lx(&v70) < v66)) {
            v9 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, v9, arg21, arg22);
            v68 = v43;
        };
        if (v67 || v68) {
            v9 = v9 | 2048;
        };
        let v71 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let v72 = empty_take();
        let v73 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 14);
        let v74 = if (v73 > 0) {
            (((0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 13) as u128) * (arg19 as u128) / 1000000) as u64) / v73 * v73
        } else {
            (((0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 13) as u128) * (arg19 as u128) / 1000000) as u64)
        };
        let v75 = v74 - v74 % v5;
        let v76 = if (v43) {
            if (arg17 == 1 || arg17 == 2) {
                v75 >= v6
            } else {
                false
            }
        } else {
            false
        };
        if (v76) {
            let v77 = arg17 == 1;
            let v78 = if (v77) {
                v41
            } else {
                v42
            };
            let v79 = if (v77) {
                v31
            } else {
                v29
            };
            let v80 = if (v77) {
                0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::side_buy()
            } else {
                0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::side_sell()
            };
            let v81 = 0;
            let v82 = 0;
            let v83 = v82;
            let v84 = 0;
            let v85 = 0;
            let v86 = 0;
            let v87 = 0;
            let v88 = 0;
            let v89 = 0x1::vector::empty<u8>();
            let v90 = &mut v89;
            0x1::vector::push_back<u8>(v90, 1);
            0x1::vector::push_back<u8>(v90, 2);
            0x1::vector::push_back<u8>(v90, 3);
            0x1::vector::push_back<u8>(v90, 4);
            0x1::vector::push_back<u8>(v90, 5);
            while (!0x1::vector::is_empty<u8>(&v89)) {
                let v91 = 0x1::vector::pop_back<u8>(&mut v89);
                let v92 = core_dex(v91);
                let v93 = if (v91 == 1) {
                    0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg6)
                } else if (v91 == 2) {
                    0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg10)
                } else if (v91 == 3) {
                    0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg11)
                } else if (v91 == 4) {
                    0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg13)
                } else {
                    0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg7)
                };
                let v94 = if (!0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::is_dex_allowed(arg3, v92)) {
                    true
                } else if (!0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::is_dex_allowed<T1>(arg1, v92)) {
                    true
                } else {
                    !0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::is_pool_allowed<T1>(arg1, v93)
                };
                if (v94) {
                    let v95 = QuoteV2{
                        desk_id      : 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::did<T0, T1>(arg0),
                        sequence     : arg14,
                        venue        : v91,
                        side         : arg17,
                        quantity     : v75,
                        all_in_price : 0,
                        fee          : 0,
                        slippage_bps : 0,
                        net_edge_bps : 0,
                        reject       : 12,
                    };
                    0x2::event::emit<QuoteV2>(v95);
                    if (v88 == 0) {
                        v88 = 12;
                        continue
                    } else {
                        continue
                    };
                };
                let v96 = if (v91 == 1) {
                    if (v77) {
                        0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::qd_buy<T0, T1>(arg6, v91, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::fv(v78, v75, true), v75, arg21)
                    } else {
                        0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::qd<T0, T1>(arg6, v91, v75, arg21)
                    }
                } else if (v91 == 2) {
                    0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::qc<T0, T1>(arg10, v91, v80, v75, climit(v77))
                } else if (v91 == 3) {
                    0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::qc<T0, T1>(arg11, v91, v80, v75, climit(v77))
                } else if (v91 == 4) {
                    0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::qb<T0, T1>(arg13, v91, v80, v75, blimit(v77))
                } else {
                    0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::qm<T0, T1>(arg7, v91, v80, v75, blimit(v77))
                };
                let v97 = v96;
                let v98 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::eco_in(&v97);
                let v99 = if (v77) {
                    implied(v98, v75)
                } else {
                    implied(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::tao(&v97), v75)
                };
                let (v100, v101) = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::ed(v77, v78, v99, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 10));
                let v102 = bps_gap(v99, v79);
                let v103 = v77 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= v98 + 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::fa(v8, v98) || v71 >= v75 + 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::fa(v8, v75);
                let v104 = if (!0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::tc_(&v97) || !v100) {
                    7
                } else if (v102 > 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 25)) {
                    8
                } else if (!0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::iv(&v97, v71 + v16, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 16), 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 17))) {
                    9
                } else if (!v103) {
                    10
                } else {
                    0
                };
                let v105 = if (v100) {
                    v101
                } else {
                    0
                };
                let v106 = QuoteV2{
                    desk_id      : 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::did<T0, T1>(arg0),
                    sequence     : arg14,
                    venue        : v91,
                    side         : arg17,
                    quantity     : v75,
                    all_in_price : v99,
                    fee          : 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::tf(&v97),
                    slippage_bps : v102,
                    net_edge_bps : v105,
                    reject       : v104,
                };
                0x2::event::emit<QuoteV2>(v106);
                if (v104 == 0 && v101 > v82) {
                    v83 = v101;
                    v81 = v91;
                    v84 = v99;
                    v85 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::tf(&v97);
                    v86 = v102;
                    v87 = v98;
                    continue
                };
                if (v104 != 0 && v88 == 0) {
                    v88 = v104;
                };
            };
            v72.side = arg17;
            v72.quantity = v75;
            v72.venue = v81;
            v72.all_in_price = v84;
            v72.fee = v85;
            v72.slippage_bps = v86;
            v72.net_edge_bps = v83;
            let (v107, v108) = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::ed(v77, v78, v84, 0);
            let v109 = if (v107) {
                v108
            } else {
                0
            };
            v72.gross_edge_bps = v109;
            if (v81 == 0) {
                if (v11 == 0) {
                    let v110 = if (v88 == 0) {
                        7
                    } else {
                        v88
                    };
                    v11 = v110;
                };
            } else {
                let v111 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
                let v112 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5);
                let v113 = if (v77) {
                    v75
                } else {
                    0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::q0::fv(v78, v75, false)
                };
                if (v81 == 1) {
                    let v114 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, !v77);
                    if (0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v114) && 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m0::xs(v77, v78, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lx(&v114))) {
                        v9 = cx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, !v77, v9, arg21, arg22);
                    };
                    let v115 = tick_align(v78, v4, v77);
                    if (v115 > 0) {
                        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::cy<T0, T1>(arg0), 1, 1, v115, v75, v77, v0 + 1000, arg21, arg22);
                    };
                } else if (v81 == 2) {
                    let (_, _) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::swap_via_manager_cetus<T0, T1>(arg1, arg2, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg9, arg10, !v77, v87, v113, climit(v77), arg21, arg22);
                } else if (v81 == 3) {
                    let (_, _) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::swap_via_manager_cetus<T0, T1>(arg1, arg2, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg9, arg11, !v77, v87, v113, climit(v77), arg21, arg22);
                } else if (v81 == 4) {
                    let (_, _) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::swap_via_manager_bluefin<T0, T1>(arg1, arg2, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg12, arg13, !v77, v87, v113, blimit(v77), arg21, arg22);
                } else {
                    let (_, _) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::swap_via_manager_momentum<T0, T1>(arg1, arg2, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg7, arg8, !v77, v87, v113, blimit(v77), arg21, arg22);
                };
                let v124 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
                let v125 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5);
                let (v126, v127) = if (v124 >= v111) {
                    (v124 - v111, false)
                } else {
                    (v111 - v124, true)
                };
                let (v128, v129) = if (v125 >= v112) {
                    (v125 - v112, false)
                } else {
                    (v112 - v125, true)
                };
                v72.base_delta = v126;
                v72.base_delta_neg = v127;
                v72.quote_delta = v128;
                v72.quote_delta_neg = v129;
                if (v127) {
                    v9 = v9 | 4096;
                };
                if (v129) {
                    v9 = v9 | 8192;
                };
                let v130 = v77 && v126 > 0 && !v127 || v128 > 0 && !v129;
                v72.executed = v130;
                if (v72.executed) {
                    v9 = v9 | 1;
                };
            };
        } else {
            let v131 = if (v43) {
                if (arg17 == 1 || arg17 == 2) {
                    v11 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v131) {
                v11 = 11;
            };
        };
        let (v132, v133) = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m0::iz(0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 6), 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 16), 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 17), 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 14), v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) + v16);
        let (v134, v135) = lg<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v59, v62, v65, v132, v6, v4, v8, v0, arg20, v29, v67, v9, arg21, arg22);
        let (v136, v137) = lg<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, v60, v64, v66, v133, v6, v4, v8, v0, arg20, v31, v68, v134, arg21, arg22);
        emit_cycle<T0, T1>(arg0, arg14, arg15, arg17, arg18, arg19, v41, v40, v72, v135, v137, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) + v16, v11, v136);
        v136
    }

    fun blimit(arg0: bool) : u128 {
        if (arg0) {
            79226673515401279992447579054
        } else {
            4295048017
        }
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

    fun clamp_offset<T0, T1>(arg0: &0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::D<T0, T1>, arg1: u8) : u64 {
        let v0 = (arg1 as u64);
        let v1 = if (v0 == 0) {
            0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 22)
        } else {
            v0
        };
        let v2 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::pv<T0, T1>(arg0, 23);
        if (v1 > v2) {
            v2
        } else {
            v1
        }
    }

    fun climit(arg0: bool) : u128 {
        if (arg0) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    fun core_dex(arg0: u8) : u8 {
        if (arg0 == 1) {
            0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_deepbook()
        } else if (arg0 == 2 || arg0 == 3) {
            0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_cetus()
        } else if (arg0 == 4) {
            0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_bluefin()
        } else {
            0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum()
        }
    }

    fun cx<T0, T1>(arg0: &mut 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::D<T0, T1>, arg1: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lg<T0, T1>(arg0, arg7);
        if (!0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lr(&v0)) {
            return arg8
        };
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5);
        let v2 = 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lo(&v0);
        if (0x2::vec_set::contains<u128>(&v1, &v2)) {
            0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::cancel_order<T0, T1>(arg1, arg2, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lo(&v0), arg9, arg10);
            let v3 = if (arg7) {
                8
            } else {
                64
            };
            arg8 = arg8 | v3;
        };
        0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::lclr<T0, T1>(arg0, arg7);
        arg8
    }

    fun emit_cycle<T0, T1>(arg0: &0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::D<T0, T1>, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: AnchorV2, arg8: TakeV2, arg9: LegV2, arg10: LegV2, arg11: u64, arg12: u8, arg13: u64) {
        let v0 = CycleV2{
            schema         : 2,
            desk_id        : 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::d0::did<T0, T1>(arg0),
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
            kind             : 0x3c57c667e060492b95984d6b8fe8a6ec61bffe54f0b957a74b9ade22590d5d8::m1::kind_none(),
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

