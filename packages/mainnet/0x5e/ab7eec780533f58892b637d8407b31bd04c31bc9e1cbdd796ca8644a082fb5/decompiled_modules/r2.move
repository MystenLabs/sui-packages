module 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::r2 {
    struct MakerLegV3 has copy, drop {
        requested_mode: u8,
        actual_mode: u8,
        requested_price: u64,
        clamped_price: u64,
        resting_price: u64,
        quantity: u64,
        order_id: u128,
        kept: bool,
        cancelled: bool,
        placed: bool,
        toxic: bool,
        failure: u8,
    }

    struct BookV3 has copy, drop {
        source_bid: u64,
        source_ask: u64,
        ext_bid: u64,
        ext_ask: u64,
        source_mid: u64,
        chain_mid: u64,
        drift_bps: u64,
        drift_ok: bool,
        source_age_ms: u64,
    }

    struct TakerV3 has copy, drop {
        allowed_offchain: bool,
        requested_clip: u64,
        clip: u64,
        venue: u8,
        attempted: bool,
        executed: bool,
        bound: u64,
        surplus: u64,
        est_fee: u64,
        base_delta: u64,
        base_delta_neg: bool,
        quote_delta: u64,
        quote_delta_neg: bool,
    }

    struct CycleResultV3 has copy, drop {
        schema: u8,
        desk_id: 0x2::object::ID,
        sequence: u64,
        source_timestamp_ms: u64,
        target: u64,
        direction: u8,
        model_score_bps_e4: u64,
        book: BookV3,
        taker: TakerV3,
        bid: MakerLegV3,
        ask: MakerLegV3,
        rejection: u8,
        status: u32,
    }

    struct VenueQuoteV3 has copy, drop {
        desk_id: 0x2::object::ID,
        sequence: u64,
        venue: u8,
        direction: u8,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        limit: u128,
        surplus: u64,
        reject: u8,
    }

    public fun ap<T0, T1>(arg0: &mut 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::D<T0, T1>, arg1: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg14: u64, arg15: u64, arg16: u128, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : u32 {
        assert!(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::vid<T0, T1>(arg0) == 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::id<T1>(arg1), 1);
        assert!(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::aid<T0, T1>(arg0) == 0x2::object::id<0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>>(arg2), 1);
        assert!(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::poid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg6), 1);
        assert!(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::mid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg5), 1);
        assert!(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pcid<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg10), 1);
        assert!(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pbid<T0, T1>(arg0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg13), 1);
        assert!(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pmid<T0, T1>(arg0) == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg7), 1);
        assert!(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::xg<T0, T1>(arg0, 1) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg11), 1);
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::assert_executor<T1>(arg1, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::did<T0, T1>(arg0), 0x2::tx_context::sender(arg22));
        let v0 = 0x2::clock::timestamp_ms(arg21);
        let (v1, v2, v3, v4, v5) = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::md(arg17);
        let (v6, _) = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::ta<T0, T1>(arg0, arg14, arg20, v0);
        if (!v6) {
            let v8 = 16384;
            emit_noop<T0, T1>(arg0, arg14, arg20, v4, arg18, v3, arg19, v1, v2, 1, v8);
            return v8
        };
        let v9 = un_target(arg14, arg20, arg15);
        let (v10, v11) = un_book(arg14, arg20, arg16);
        assert!(v9 > 0, 5);
        let (v12, v13, v14) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg6);
        let v15 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 18);
        let v16 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::fr<T0, T1>(arg6);
        let v17 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::zp<T0, T1>(arg0);
        let v18 = 0;
        let v19 = v18;
        let v20 = if (v17) {
            2
        } else {
            0
        };
        let v21 = v20;
        let v22 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, true);
        let v23 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, false);
        let v24 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5));
        let v25 = 0;
        let v26 = 0;
        let v27 = 0;
        let v28 = false;
        let v29 = false;
        let v30 = 0;
        while (v30 < 0x1::vector::length<u128>(&v24)) {
            let v31 = *0x1::vector::borrow<u128>(&v24, v30);
            let v32 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v22) && v31 == 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lo(&v22);
            let v33 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v23) && v31 == 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lo(&v23);
            if (v32) {
                v28 = true;
                let v34 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg6, v31);
                v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v34) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v34);
            };
            if (v33) {
                v29 = true;
                let v35 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg6, v31);
                v26 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v35) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v35);
            };
            if (!v32 && !v33) {
                0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::cancel_order<T0, T1>(arg1, arg2, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, v31, arg21, arg22);
                v27 = v27 + 1;
            };
            v30 = v30 + 1;
        };
        if (0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v22) && !v28) {
            0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lclr<T0, T1>(arg0, true);
        };
        if (0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v23) && !v29) {
            0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lclr<T0, T1>(arg0, false);
        };
        if (v27 > 0) {
            v19 = v18 | 2048;
        };
        let v36 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg6, arg21);
        let v37 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, true);
        let v38 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, false);
        let v39 = if (0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v37)) {
            0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lx(&v37)
        } else {
            0
        };
        let v40 = ex<T0, T1>(arg6, true, v12, v15, v36, v39, v25, arg21);
        let v41 = if (0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v38)) {
            0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lx(&v38)
        } else {
            0
        };
        let v42 = ex<T0, T1>(arg6, false, v12, v15, v36, v41, v26, arg21);
        let v43 = if (v40 > 0) {
            if (v42 > 0) {
                v42 > v40
            } else {
                false
            }
        } else {
            false
        };
        if (!v43) {
            v19 = v19 | 8192;
            if (v20 == 0) {
                v21 = 4;
            };
        };
        let v44 = if (v0 > arg20) {
            v0 - arg20
        } else {
            0
        };
        let v45 = v44 <= 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 21);
        let (v46, v47) = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::dk(v10, v11, v40, v42, v9, v4, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 20));
        let v48 = if (v43) {
            if (v45) {
                v46
            } else {
                false
            }
        } else {
            false
        };
        if (!v48) {
            v19 = v19 | 32768;
            if (v21 == 0) {
                let v49 = if (!v45) {
                    7
                } else {
                    6
                };
                v21 = v49;
            };
        };
        let v50 = arg18 >= 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 11);
        let v51 = if (!v17) {
            if (v3) {
                if (v48) {
                    if (v50) {
                        v4 != 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (!v51 && v21 == 0) {
            let v52 = if (!v3) {
                8
            } else if (!v50) {
                9
            } else if (v4 == 0) {
                3
            } else {
                0
            };
            v21 = v52;
        };
        let v53 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let v54 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 13);
        let v55 = if (arg19 < v54) {
            arg19
        } else {
            v54
        };
        let v56 = if (v51) {
            0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::cc(arg18, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 11), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 12), v55, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 14), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 15))
        } else {
            0
        };
        let v57 = v56 - v56 % v13;
        let v58 = 0;
        let v59 = 0;
        let v60 = v59;
        let v61 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::none();
        let v62 = 0;
        let v63 = 0;
        if (v57 >= v14) {
            let v64 = v4 == 1;
            let (v65, v66) = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::bnd(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::fv(v9, v57, false), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 10));
            let v67 = if (v64) {
                v65
            } else {
                v66
            };
            v63 = v67;
            let v68 = if (v64) {
                0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::side_buy()
            } else {
                0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::side_sell()
            };
            let v69 = 0x1::vector::empty<u8>();
            let v70 = &mut v69;
            0x1::vector::push_back<u8>(v70, 1);
            0x1::vector::push_back<u8>(v70, 5);
            0x1::vector::push_back<u8>(v70, 2);
            0x1::vector::push_back<u8>(v70, 3);
            0x1::vector::push_back<u8>(v70, 4);
            while (!0x1::vector::is_empty<u8>(&v69)) {
                let v71 = 0x1::vector::pop_back<u8>(&mut v69);
                let v72 = if (v71 == 1) {
                    if (v64) {
                        0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::qd_buy<T0, T1>(arg6, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_deepbook(), v65, v57, arg21)
                    } else {
                        0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::qd<T0, T1>(arg6, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_deepbook(), v57, arg21)
                    }
                } else if (v71 == 2) {
                    0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::qc<T0, T1>(arg10, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_cetus(), v68, v57, climit(v64))
                } else if (v71 == 3) {
                    0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::qc<T0, T1>(arg11, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_cetus(), v68, v57, climit(v64))
                } else if (v71 == 4) {
                    0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::qb<T0, T1>(arg13, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_bluefin(), v68, v57, blimit(v64))
                } else {
                    0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::qm<T0, T1>(arg7, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), v68, v57, blimit(v64))
                };
                let v73 = v72;
                let (v74, v75) = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::ed(&v73, v57, v65, v66);
                let v76 = if (v71 == 1) {
                    if (v64) {
                        let v77 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::fv(tick_px(v9, v12, true), v57, true);
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= v77 + 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::fa(v16, v77)
                    } else {
                        v53 >= v57 + 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::fa(v16, v57)
                    }
                } else {
                    v64 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::eco_in(&v73) || v53 >= 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::eco_in(&v73)
                };
                let v78 = if (!v74) {
                    if (!0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::tc_(&v73)) {
                        1
                    } else {
                        2
                    }
                } else if (!0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::iv(&v73, v53 + v26, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 16), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 17))) {
                    3
                } else if (!v76) {
                    4
                } else {
                    0
                };
                let v79 = if (v78 == 0) {
                    v75
                } else {
                    0
                };
                let v80 = VenueQuoteV3{
                    desk_id    : 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::did<T0, T1>(arg0),
                    sequence   : arg14,
                    venue      : v71,
                    direction  : v4,
                    amount_in  : 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::tai(&v73),
                    amount_out : 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::tao(&v73),
                    fee        : 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::tf(&v73),
                    limit      : 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::tl(&v73),
                    surplus    : v79,
                    reject     : v78,
                };
                0x2::event::emit<VenueQuoteV3>(v80);
                if (v78 == 0 && v75 > v59) {
                    v60 = v75;
                    v58 = v71;
                    v61 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::mk_s(v73, v75);
                };
            };
            if (v58 == 0 && v21 == 0) {
                v21 = 5;
            };
        } else if (v51 && v21 == 0) {
            v21 = 5;
        };
        let v81 = v58 != 0;
        if (v81 && v58 == 1) {
            let v82 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, v4 != 1);
            if (0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v82) && 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::xs(v4 == 1, tick_px(v9, v12, v4 == 1), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lx(&v82))) {
                v19 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4 != 1, v19, arg21, arg22);
            };
        };
        let v83 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let v84 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5);
        let v85 = false;
        if (v81) {
            let v86 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::st(&v61);
            v62 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::tf(v86);
            let v87 = v4 == 1;
            let v88 = if (v87) {
                v57
            } else {
                v63
            };
            if (v58 == 1) {
                let v89 = tick_px(v9, v12, v87);
                if (v89 > 0) {
                    0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::cy<T0, T1>(arg0), 1, 1, v89, v57, v87, v0 + 1000, arg21, arg22);
                    v85 = true;
                };
            } else if (v58 == 2 || v58 == 3) {
                let v90 = if (v58 == 2) {
                    arg10
                } else {
                    arg11
                };
                let (_, _) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::swap_via_manager_cetus<T0, T1>(arg1, arg2, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg9, v90, !v87, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::eco_in(v86), v88, climit(v87), arg21, arg22);
                v85 = true;
            } else if (v58 == 4) {
                let (_, _) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::swap_via_manager_bluefin<T0, T1>(arg1, arg2, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg12, arg13, !v87, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::eco_in(v86), v88, blimit(v87), arg21, arg22);
                v85 = true;
            } else {
                let (_, _) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::swap_via_manager_momentum<T0, T1>(arg1, arg2, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg7, arg8, !v87, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::eco_in(v86), v88, blimit(v87), arg21, arg22);
                v85 = true;
            };
            if (v85) {
                v19 = v19 | 1;
            } else {
                v19 = v19 | 4096;
            };
        };
        let v97 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let v98 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5);
        let (v99, v100) = if (v97 >= v83) {
            (v97 - v83, false)
        } else {
            (v83 - v97, true)
        };
        let (v101, v102) = if (v98 >= v84) {
            (v98 - v84, false)
        } else {
            (v84 - v98, true)
        };
        if (v100) {
            v19 = v19 | 65536;
        };
        if (v102) {
            v19 = v19 | 131072;
        };
        let v103 = v85 && (v4 == 1 && v99 > 0 && !v100 || v101 > 0 && !v102);
        let v104 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, true);
        let v105 = if (v4 == 2) {
            arg18
        } else {
            0
        };
        let v106 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::lx(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lf(&v104), v105, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 2), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 3));
        0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lflag<T0, T1>(arg0, true, v106);
        if (v106) {
            v19 = v19 | 128;
        };
        let v107 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, false);
        let v108 = if (v4 == 1) {
            arg18
        } else {
            0
        };
        let v109 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::lx(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lf(&v107), v108, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 2), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 3));
        0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lflag<T0, T1>(arg0, false, v109);
        if (v109) {
            v19 = v19 | 256;
        };
        let (v110, v111) = rc<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v1, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::rs(v1, v17, v106, v43, v48, v5), v40, v42, v9, arg18, v43, v12, v13, v14, v16, v0, v106, v19, arg21, arg22);
        let (v112, v113) = rc<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, v2, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::rs(v2, v17, v109, v43, v48, v5), v42, v40, v9, arg18, v43, v12, v13, v14, v16, v0, v109, v110, arg21, arg22);
        let v114 = if (v10 > 0 && v11 > v10) {
            (v10 + v11) / 2
        } else {
            0
        };
        let v115 = if (v43) {
            (v40 + v42) / 2
        } else {
            0
        };
        let v116 = BookV3{
            source_bid    : v10,
            source_ask    : v11,
            ext_bid       : v40,
            ext_ask       : v42,
            source_mid    : v114,
            chain_mid     : v115,
            drift_bps     : v47,
            drift_ok      : v48,
            source_age_ms : v44,
        };
        let v117 = TakerV3{
            allowed_offchain : v3,
            requested_clip   : arg19,
            clip             : v57,
            venue            : v58,
            attempted        : v81,
            executed         : v103,
            bound            : v63,
            surplus          : v60,
            est_fee          : v62,
            base_delta       : v99,
            base_delta_neg   : v100,
            quote_delta      : v101,
            quote_delta_neg  : v102,
        };
        let v118 = CycleResultV3{
            schema              : 3,
            desk_id             : 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::did<T0, T1>(arg0),
            sequence            : arg14,
            source_timestamp_ms : arg20,
            target              : v9,
            direction           : v4,
            model_score_bps_e4  : arg18,
            book                : v116,
            taker               : v117,
            bid                 : v111,
            ask                 : v113,
            rejection           : v21,
            status              : v112,
        };
        0x2::event::emit<CycleResultV3>(v118);
        v112
    }

    fun blimit(arg0: bool) : u128 {
        if (arg0) {
            79226673515401279992447579054
        } else {
            4295048017
        }
    }

    fun climit(arg0: bool) : u128 {
        if (arg0) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    fun cxl<T0, T1>(arg0: &mut 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::D<T0, T1>, arg1: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, arg7);
        if (!0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v0)) {
            return arg8
        };
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5);
        let v2 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lo(&v0);
        if (0x2::vec_set::contains<u128>(&v1, &v2)) {
            0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::cancel_order<T0, T1>(arg1, arg2, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lo(&v0), arg9, arg10);
            let v3 = if (arg7) {
                8
            } else {
                64
            };
            arg8 = arg8 | v3;
        };
        0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lclr<T0, T1>(arg0, arg7);
        arg8
    }

    fun emit_noop<T0, T1>(arg0: &0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::D<T0, T1>, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: u64, arg7: u8, arg8: u8, arg9: u8, arg10: u32) {
        let v0 = BookV3{
            source_bid    : 0,
            source_ask    : 0,
            ext_bid       : 0,
            ext_ask       : 0,
            source_mid    : 0,
            chain_mid     : 0,
            drift_bps     : 0,
            drift_ok      : false,
            source_age_ms : 0,
        };
        let v1 = TakerV3{
            allowed_offchain : arg5,
            requested_clip   : arg6,
            clip             : 0,
            venue            : 0,
            attempted        : false,
            executed         : false,
            bound            : 0,
            surplus          : 0,
            est_fee          : 0,
            base_delta       : 0,
            base_delta_neg   : false,
            quote_delta      : 0,
            quote_delta_neg  : false,
        };
        let v2 = CycleResultV3{
            schema              : 3,
            desk_id             : 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::did<T0, T1>(arg0),
            sequence            : arg1,
            source_timestamp_ms : arg2,
            target              : 0,
            direction           : arg3,
            model_score_bps_e4  : arg4,
            book                : v0,
            taker               : v1,
            bid                 : empty_leg(arg7),
            ask                 : empty_leg(arg8),
            rejection           : arg9,
            status              : arg10,
        };
        0x2::event::emit<CycleResultV3>(v2);
    }

    fun empty_leg(arg0: u8) : MakerLegV3 {
        MakerLegV3{
            requested_mode  : arg0,
            actual_mode     : 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::mode_none(),
            requested_price : 0,
            clamped_price   : 0,
            resting_price   : 0,
            quantity        : 0,
            order_id        : 0,
            kept            : false,
            cancelled       : false,
            placed          : false,
            toxic           : false,
            failure         : 0,
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

    fun mx(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * 11400714819323198485 % 18446744073709551616 + (arg1 as u128) * 13787848793156543929 % 18446744073709551616) % 18446744073709551616) as u64)
    }

    fun mx128(arg0: u64, arg1: u64) : u128 {
        (mx(arg0, arg1) as u128) | (mx(arg1, arg0) as u128) << 64
    }

    fun rc<T0, T1>(arg0: &mut 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::D<T0, T1>, arg1: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: bool, arg21: u32, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : (u32, MakerLegV3) {
        let v0 = empty_leg(arg8);
        v0.actual_mode = arg9;
        v0.toxic = arg20;
        if (arg9 == 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::mode_none()) {
            let v1 = if (!arg14) {
                1
            } else {
                4
            };
            v0.failure = v1;
            let v2 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg21, arg22, arg23);
            let v3 = if (arg7) {
                8
            } else {
                64
            };
            v0.cancelled = v2 & v3 != 0;
            return (v2, v0)
        };
        let v4 = if (arg9 == 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::mode_bkf()) {
            0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::px3(arg10, arg15, arg13, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 1), arg7)
        } else if (arg9 == 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::mode_tch()) {
            let (_, v6, _) = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::px2(arg11, arg15, arg7, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 7));
            v6
        } else {
            let (_, v9, _) = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::px1(arg10, arg11, arg15, arg7, (0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 0) as u8));
            v9
        };
        v0.requested_price = v4;
        let v11 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::ec(arg7, v4, arg12, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 19), arg15, arg11);
        v0.clamped_price = v11;
        if (v11 == 0) {
            v0.failure = 2;
            let v12 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg21, arg22, arg23);
            let v13 = if (arg7) {
                8
            } else {
                64
            };
            v0.cancelled = v12 & v13 != 0;
            return (v12, v0)
        };
        let v14 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 6) - 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 6) % arg16;
        v0.quantity = v14;
        if (v14 < arg17) {
            v0.failure = 2;
            let v15 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg21, arg22, arg23);
            let v16 = if (arg7) {
                8
            } else {
                64
            };
            v0.cancelled = v15 & v16 != 0;
            return (v15, v0)
        };
        let v17 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lg<T0, T1>(arg0, arg7);
        if (0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::m0::sx(0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lr(&v17), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lx(&v17), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lq(&v17), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lm(&v17), 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::le(&v17), v11, v14, arg9, arg19, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 5))) {
            v0.kept = true;
            v0.resting_price = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lx(&v17);
            v0.order_id = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lo(&v17);
            let v18 = if (arg7) {
                4
            } else {
                32
            };
            return (arg21 | v18, v0)
        };
        let v19 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg21, arg22, arg23);
        let v20 = if (arg7) {
            8
        } else {
            64
        };
        v0.cancelled = v19 & v20 != 0;
        let v21 = if (arg7) {
            let v22 = 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::fv(v11, v14, true);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= v22 + 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::fa(arg18, v22)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) >= v14 + 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0::fa(arg18, v14)
        };
        if (!v21) {
            v0.failure = 3;
            let v23 = if (arg7) {
                512
            } else {
                1024
            };
            return (v19 | v23, v0)
        };
        let v24 = arg19 + 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::pv<T0, T1>(arg0, 4);
        let v25 = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::cy<T0, T1>(arg0), 3, 1, v11, v14, arg7, v24, arg22, arg23);
        0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::lset<T0, T1>(arg0, arg7, 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::d0::mk(v25, v11, v14, arg19, v24, arg9, arg20));
        v0.placed = true;
        v0.resting_price = v11;
        v0.order_id = v25;
        let v26 = if (arg7) {
            2
        } else {
            16
        };
        (v19 | v26, v0)
    }

    fun tick_px(arg0: u64, arg1: u64, arg2: bool) : u64 {
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

    public fun un_book(arg0: u64, arg1: u64, arg2: u128) : (u64, u64) {
        let v0 = arg2 ^ mx128(arg0, arg1);
        (((v0 & 18446744073709551615) as u64), ((v0 >> 64) as u64))
    }

    public fun un_target(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 ^ mx(arg0, arg1)
    }

    public fun wr_book(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u128 {
        ((arg2 as u128) | (arg3 as u128) << 64) ^ mx128(arg0, arg1)
    }

    public fun wr_control(arg0: u8, arg1: u8, arg2: bool, arg3: u8, arg4: bool) : u64 {
        let v0 = if (arg2) {
            16
        } else {
            0
        };
        let v1 = if (arg4) {
            128
        } else {
            0
        };
        (arg0 as u64) & 3 | ((arg1 as u64) & 3) << 2 | v0 | ((arg3 as u64) & 3) << 5 | v1
    }

    public fun wr_target(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 ^ mx(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

