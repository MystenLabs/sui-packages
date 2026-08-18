module 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::r1 {
    struct MakerLegV2 has copy, drop {
        mode: u8,
        requested_price: u64,
        safe_price: u64,
        resting_price: u64,
        quantity: u64,
        order_id: u128,
        kept: bool,
        cancelled: bool,
        placed: bool,
        quote_satisfied: bool,
        perfect_bbo: bool,
        retry_recommended: bool,
        failure: u8,
    }

    struct CycleResultV2 has copy, drop {
        schema: u8,
        desk_id: 0x2::object::ID,
        sequence: u64,
        source_timestamp_ms: u64,
        target: u64,
        direction: u8,
        markout_bps_e4: u64,
        clip: u64,
        venue: u8,
        taker_attempted: bool,
        taker_executed: bool,
        base_delta: u64,
        base_delta_neg: bool,
        quote_delta: u64,
        quote_delta_neg: bool,
        est_fee: u64,
        surplus: u64,
        noop_reason: u8,
        ext_bid: u64,
        ext_ask: u64,
        bid: MakerLegV2,
        ask: MakerLegV2,
        status: u32,
    }

    struct VenueQuoteV2 has copy, drop {
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

    public fun ap<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &mut 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u32 {
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::vid<T0, T1>(arg0) == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg1), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::aid<T0, T1>(arg0) == 0x2::object::id<0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::DeepBookAccount<T0, T1>>(arg2), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::poid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg6), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::mid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg5), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pcid<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg10), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pbid<T0, T1>(arg0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg13), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pmid<T0, T1>(arg0) == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg7), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::xg<T0, T1>(arg0, 1) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg11), 1);
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::assert_executor<T1>(arg1, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::did<T0, T1>(arg0), 0x2::tx_context::sender(arg18));
        let v0 = 0x2::clock::timestamp_ms(arg17);
        let (v1, _) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::ta<T0, T1>(arg0, arg14, arg16, v0);
        if (!v1) {
            let v3 = 16384 | 32768;
            let v4 = CycleResultV2{
                schema              : 2,
                desk_id             : 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::did<T0, T1>(arg0),
                sequence            : arg14,
                source_timestamp_ms : arg16,
                target              : 0,
                direction           : 0,
                markout_bps_e4      : 0,
                clip                : 0,
                venue               : 0,
                taker_attempted     : false,
                taker_executed      : false,
                base_delta          : 0,
                base_delta_neg      : false,
                quote_delta         : 0,
                quote_delta_neg     : false,
                est_fee             : 0,
                surplus             : 0,
                noop_reason         : 1,
                ext_bid             : 0,
                ext_ask             : 0,
                bid                 : empty_leg(),
                ask                 : empty_leg(),
                status              : v3,
            };
            0x2::event::emit<CycleResultV2>(v4);
            return v3
        };
        let v5 = un(arg14, arg16, arg15);
        assert!(v5 > 0, 5);
        let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg6);
        let v9 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 18);
        let v10 = 0;
        let v11 = v10;
        let v12 = 0;
        if (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::zp<T0, T1>(arg0)) {
            v12 = 2;
        };
        let v13 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, true);
        let v14 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, false);
        let v15 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5));
        let v16 = 0;
        let v17 = 0;
        let v18 = false;
        let v19 = false;
        let v20 = 0;
        while (v20 < 0x1::vector::length<u128>(&v15)) {
            let v21 = *0x1::vector::borrow<u128>(&v15, v20);
            let v22 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v13) && v21 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lo(&v13);
            let v23 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v14) && v21 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lo(&v14);
            if (v22) {
                v18 = true;
            };
            if (v23) {
                v19 = true;
                let v24 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg6, v21);
                v16 = v16 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v24) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v24);
            };
            if (!v22 && !v23) {
                0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::cancel_order<T0, T1>(arg1, arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, v21, arg17, arg18);
                v17 = v17 + 1;
            };
            v20 = v20 + 1;
        };
        if (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v13) && !v18) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lclr<T0, T1>(arg0, true);
        };
        if (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v14) && !v19) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lclr<T0, T1>(arg0, false);
        };
        if (v17 > 0) {
            v11 = v10 | 2048;
        };
        let v25 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::r0::ex<T0, T1>(arg6, arg5, true, v6, v9, arg17);
        let v26 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::r0::ex<T0, T1>(arg6, arg5, false, v6, v9, arg17);
        let v27 = if (v25 > 0) {
            if (v26 > 0) {
                v26 > v25
            } else {
                false
            }
        } else {
            false
        };
        if (!v27) {
            v11 = v11 | 8192;
        };
        let v28 = 0;
        let v29 = 0;
        if (v27) {
            let v30 = v25 + (v26 - v25) / 2;
            if (v5 > v30 && v5 > v25) {
                v28 = 1;
                v29 = ((((v5 - v25) as u128) * 100000000 / (v25 as u128)) as u64);
            } else if (v5 < v30 && v5 < v26) {
                v28 = 2;
                v29 = ((((v26 - v5) as u128) * 100000000 / (v26 as u128)) as u64);
            };
        } else if (v12 == 0) {
            v12 = 4;
        };
        if (v28 == 0 && v12 == 0) {
            v12 = 3;
        };
        let v31 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let v32 = if (v28 != 0 && v12 == 0) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::cc(v29, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 11), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 12), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 13), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 14), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 15))
        } else {
            0
        };
        let v33 = v32 - v32 % v7;
        let v34 = 0;
        let v35 = 0;
        let v36 = v35;
        let v37 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::none();
        let v38 = 0;
        if (v33 >= v8 && v12 == 0) {
            let (v39, v40) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::bnd(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::fv(v5, v33, false), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 10));
            let v41 = v28 == 1;
            let v42 = if (v41) {
                0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::side_buy()
            } else {
                0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::side_sell()
            };
            let v43 = 0x1::vector::empty<u8>();
            let v44 = &mut v43;
            0x1::vector::push_back<u8>(v44, 1);
            0x1::vector::push_back<u8>(v44, 5);
            0x1::vector::push_back<u8>(v44, 2);
            0x1::vector::push_back<u8>(v44, 3);
            0x1::vector::push_back<u8>(v44, 4);
            while (!0x1::vector::is_empty<u8>(&v43)) {
                let v45 = 0x1::vector::pop_back<u8>(&mut v43);
                let v46 = 0;
                let v47 = v46;
                let v48 = if (v45 == 1) {
                    if (v41) {
                        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qd_buy<T0, T1>(arg6, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_deepbook(), v39, v33, arg17)
                    } else {
                        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qd<T0, T1>(arg6, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_deepbook(), v33, arg17)
                    }
                } else if (v45 == 2) {
                    0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qc<T0, T1>(arg10, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_cetus(), v42, v33, climit(v41))
                } else if (v45 == 3) {
                    0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qc<T0, T1>(arg11, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_cetus(), v42, v33, climit(v41))
                } else if (v45 == 4) {
                    0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qb<T0, T1>(arg13, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_bluefin(), v42, v33, blimit(v41))
                } else {
                    0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qm<T0, T1>(arg7, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_momentum(), v42, v33, blimit(v41))
                };
                let v49 = v48;
                let v50 = 0;
                if (v46 == 0) {
                    let (v51, v52) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::ed(&v49, v33, v39, v40);
                    let v53 = if (v45 == 1) {
                        if (v41) {
                            let v54 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::fv(tick_px(v5, v6, true), v33, true);
                            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= v54 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::df<T0, T1>(arg6, v54)
                        } else {
                            v31 >= v33 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::df<T0, T1>(arg6, v33)
                        }
                    } else {
                        v41 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(&v49) || v31 >= 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(&v49)
                    };
                    if (!v51) {
                        let v55 = if (!0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tc_(&v49)) {
                            1
                        } else {
                            2
                        };
                        v47 = v55;
                    } else if (!0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::iv(&v49, v31 + v16, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 16), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 17))) {
                        v47 = 3;
                    } else if (!v53) {
                        v47 = 5;
                    } else {
                        v50 = v52;
                    };
                };
                let v56 = VenueQuoteV2{
                    desk_id    : 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::did<T0, T1>(arg0),
                    sequence   : arg14,
                    venue      : v45,
                    direction  : v28,
                    amount_in  : 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tai(&v49),
                    amount_out : 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tao(&v49),
                    fee        : 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tf(&v49),
                    limit      : 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tl(&v49),
                    surplus    : v50,
                    reject     : v47,
                };
                0x2::event::emit<VenueQuoteV2>(v56);
                if (v47 == 0 && v50 > v35) {
                    v36 = v50;
                    v34 = v45;
                    v37 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::mk_s(v49, v50);
                };
            };
            if (v34 == 0 && v12 == 0) {
                v12 = 5;
            };
        } else if (v28 != 0 && v12 == 0) {
            v12 = 5;
        };
        let v57 = v34 != 0;
        if (v57 && v34 == 1) {
            let v58 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, v28 != 1);
            if (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v58)) {
                if (v28 == 1 && 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v58) <= tick_px(v5, v6, v28 == 1) || 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v58) >= tick_px(v5, v6, v28 == 1)) {
                    v11 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v28 != 1, v11, arg17, arg18);
                };
            };
        };
        let v59 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let v60 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5);
        let v61 = false;
        if (v57) {
            let v62 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::st(&v37);
            v38 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tf(v62);
            let v63 = v28 == 1;
            let v64 = if (v63) {
                v33
            } else {
                let (_, v66) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::bnd(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::fv(v5, v33, false), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 10));
                v66
            };
            if (v34 == 1) {
                let v67 = tick_px(v5, v6, v63);
                if (v67 > 0) {
                    0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cy<T0, T1>(arg0), 1, 1, v67, v33, v63, v0 + 1000, arg17, arg18);
                    v61 = true;
                };
            } else if (v34 == 2 || v34 == 3) {
                let v68 = if (v34 == 2) {
                    arg10
                } else {
                    arg11
                };
                let (_, _) = 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::swap_via_manager_cetus<T0, T1>(arg1, arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg9, v68, !v63, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(v62), v64, climit(v63), arg17, arg18);
                v61 = true;
            } else if (v34 == 4) {
                let (_, _) = 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::swap_via_manager_bluefin<T0, T1>(arg1, arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg12, arg13, !v63, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(v62), v64, blimit(v63), arg17, arg18);
                v61 = true;
            } else {
                let (_, _) = 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::swap_via_manager_momentum<T0, T1>(arg1, arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg7, arg8, !v63, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(v62), v64, blimit(v63), arg17, arg18);
                v61 = true;
            };
            if (v61) {
                v11 = v11 | 1;
            } else {
                v11 = v11 | 4096;
            };
        };
        let v75 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5);
        let v76 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5);
        let (v77, v78) = if (v75 >= v59) {
            (v75 - v59, false)
        } else {
            (v59 - v75, true)
        };
        let (v79, v80) = if (v76 >= v60) {
            (v76 - v60, false)
        } else {
            (v60 - v76, true)
        };
        if (v78) {
            v11 = v11 | 65536;
        };
        if (v80) {
            v11 = v11 | 131072;
        };
        let v81 = v61 && (v28 == 1 && v77 > 0 && !v78 || v79 > 0 && !v80);
        let v82 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::zp<T0, T1>(arg0);
        let v83 = !v82 && v27;
        let v84 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, true);
        let v85 = if (v28 == 2) {
            v29
        } else {
            0
        };
        let v86 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::lx(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lf(&v84), v85, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 2), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 3));
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lflag<T0, T1>(arg0, true, v86);
        if (v86) {
            v11 = v11 | 128;
        };
        let v87 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, false);
        let v88 = if (v28 == 1) {
            v29
        } else {
            0
        };
        let v89 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::lx(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lf(&v87), v88, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 2), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 3));
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lflag<T0, T1>(arg0, false, v89);
        if (v89) {
            v11 = v11 | 256;
        };
        let v90 = if (v27) {
            if (!v81) {
                if (v28 != 0) {
                    v29 >= 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 11)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v91 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mo(v82, v86, v90, v28, true);
        let v92 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mo(v82, v89, v90, v28, false);
        let (v93, v94, v95) = leg_px<T0, T1>(arg0, v91, v25, v26, v29, true, v6);
        let (v96, v97, v98) = leg_px<T0, T1>(arg0, v92, v26, v25, v29, false, v6);
        let (v99, v100) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::cx(v94, v97, v25, v26, v6, v28);
        let v101 = v100;
        let v102 = if (v100 > 0) {
            if (v99 > 0) {
                v100 <= v99
            } else {
                false
            }
        } else {
            false
        };
        if (v102) {
            v101 = 0;
        };
        empty_leg();
        empty_leg();
        let (v103, v104) = if (v28 == 2) {
            let v105 = v98 && v101 == v97;
            let (v106, v107) = rc2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, v96, v101, v105, v92, v83, v27, v6, v7, v8, v0, v11, arg17, arg18);
            let v108 = v95 && v99 == v94;
            let (v109, v110) = rc2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v93, v99, v108, v91, v83, v27, v6, v7, v8, v0, v106, arg17, arg18);
            v11 = v109;
            (v107, v110)
        } else {
            let v111 = v95 && v99 == v94;
            let (v112, v113) = rc2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v93, v99, v111, v91, v83, v27, v6, v7, v8, v0, v11, arg17, arg18);
            let v114 = v98 && v101 == v97;
            let (v115, v116) = rc2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, v96, v101, v114, v92, v83, v27, v6, v7, v8, v0, v112, arg17, arg18);
            v11 = v115;
            (v116, v113)
        };
        if (v12 != 0) {
            v11 = v11 | 32768;
        };
        let v117 = CycleResultV2{
            schema              : 2,
            desk_id             : 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::did<T0, T1>(arg0),
            sequence            : arg14,
            source_timestamp_ms : arg16,
            target              : v5,
            direction           : v28,
            markout_bps_e4      : v29,
            clip                : v33,
            venue               : v34,
            taker_attempted     : v57,
            taker_executed      : v81,
            base_delta          : v77,
            base_delta_neg      : v78,
            quote_delta         : v79,
            quote_delta_neg     : v80,
            est_fee             : v38,
            surplus             : v36,
            noop_reason         : v12,
            ext_bid             : v25,
            ext_ask             : v26,
            bid                 : v104,
            ask                 : v103,
            status              : v11,
        };
        0x2::event::emit<CycleResultV2>(v117);
        v11
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

    fun cxl<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, arg7);
        if (!0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v0)) {
            return arg8
        };
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5);
        let v2 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lo(&v0);
        if (0x2::vec_set::contains<u128>(&v1, &v2)) {
            0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::cancel_order<T0, T1>(arg1, arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lo(&v0), arg9, arg10);
            let v3 = if (arg7) {
                8
            } else {
                64
            };
            arg8 = arg8 | v3;
        };
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lclr<T0, T1>(arg0, arg7);
        arg8
    }

    fun empty_leg() : MakerLegV2 {
        MakerLegV2{
            mode              : 0,
            requested_price   : 0,
            safe_price        : 0,
            resting_price     : 0,
            quantity          : 0,
            order_id          : 0,
            kept              : false,
            cancelled         : false,
            placed            : false,
            quote_satisfied   : false,
            perfect_bbo       : false,
            retry_recommended : false,
            failure           : 0,
        }
    }

    fun leg_px<T0, T1>(arg0: &0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64) : (u64, u64, bool) {
        if (arg1 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_bkf()) {
            let v3 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::px3(arg2, arg6, arg4, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 1), arg5);
            (v3, v3, v3 > 0)
        } else if (arg1 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_tch()) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::px2(arg3, arg6, arg5, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 7))
        } else if (arg1 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_off()) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::px1(arg2, arg3, arg6, arg5, (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 0) as u8))
        } else {
            (0, 0, false)
        }
    }

    fun rc2<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &mut 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u64, arg9: u64, arg10: bool, arg11: u8, arg12: bool, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u32, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (u32, MakerLegV2) {
        let v0 = empty_leg();
        v0.mode = arg11;
        v0.requested_price = arg8;
        v0.safe_price = arg9;
        let v1 = arg11 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_off() && arg10;
        v0.perfect_bbo = v1;
        let v2 = if (!arg12) {
            true
        } else if (arg11 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_none()) {
            true
        } else if (arg9 == 0) {
            true
        } else {
            arg9 % arg14 != 0
        };
        if (v2) {
            let v3 = if (!arg13) {
                1
            } else {
                2
            };
            v0.failure = v3;
            v0.retry_recommended = !arg13;
            let v4 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg18, arg19, arg20);
            let v5 = if (arg7) {
                8
            } else {
                64
            };
            v0.cancelled = v4 & v5 != 0;
            return (v4, v0)
        };
        let v6 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 6) - 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 6) % arg15;
        v0.quantity = v6;
        if (v6 < arg16) {
            v0.failure = 2;
            let v7 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg18, arg19, arg20);
            let v8 = if (arg7) {
                8
            } else {
                64
            };
            v0.cancelled = v7 & v8 != 0;
            return (v7, v0)
        };
        let v9 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, arg7);
        if (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::sx(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v9), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v9), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lq(&v9), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lm(&v9), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::le(&v9), arg9, v6, arg11, arg17, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 5))) {
            let v10 = if (arg7) {
                4
            } else {
                32
            };
            v0.kept = true;
            v0.quote_satisfied = true;
            v0.resting_price = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v9);
            v0.order_id = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lo(&v9);
            return (arg18 | v10, v0)
        };
        let v11 = cxl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg18, arg19, arg20);
        let v12 = if (arg7) {
            8
        } else {
            64
        };
        v0.cancelled = v11 & v12 != 0;
        let v13 = if (arg7) {
            let v14 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::fv(arg9, v6, true);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= v14 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::df<T0, T1>(arg6, v14)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) >= v6 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::df<T0, T1>(arg6, v6)
        };
        if (!v13) {
            v0.failure = 3;
            let v15 = if (arg7) {
                512
            } else {
                1024
            };
            return (v11 | v15, v0)
        };
        let v16 = arg17 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 4);
        let v17 = 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cy<T0, T1>(arg0), 3, 1, arg9, v6, arg7, v16, arg19, arg20);
        let v18 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, arg7);
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lset<T0, T1>(arg0, arg7, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::mk(v17, arg9, v6, arg17, v16, arg11, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lf(&v18)));
        v0.placed = true;
        v0.quote_satisfied = true;
        v0.resting_price = arg9;
        v0.order_id = v17;
        let v19 = if (arg7) {
            2
        } else {
            16
        };
        (v11 | v19, v0)
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

    public fun un(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 ^ 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::r0::mx(arg0, arg1)
    }

    public fun wr(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 ^ 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::r0::mx(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

