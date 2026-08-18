module 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::r0 {
    public fun ap<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::S1, arg2: &mut 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::DeepBookAccount<T0, T1>, arg4: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg5: u64, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u32 {
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cks<T0, T1>(arg0, arg1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::vid<T0, T1>(arg0) == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg2), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::poid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg7), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::mid<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg6), 1);
        let v0 = 0x2::clock::timestamp_ms(arg15);
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::adm<T0, T1>(arg0, arg8, arg9, v0);
        let (v1, v2, v3, v4, v5) = un(arg8, arg14);
        let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg7);
        let v9 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 18);
        let v10 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::zp<T0, T1>(arg0);
        let v11 = 0;
        let v12 = v11;
        let v13 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, true);
        let v14 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, false);
        let v15 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg7, arg6));
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
                let v24 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg7, v21);
                v16 = v16 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v24) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v24);
            };
            if (!v22 && !v23) {
                0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::cancel_order<T0, T1>(arg2, arg3, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg4, arg5, arg6, arg7, v21, arg15, arg16);
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
            v12 = v11 | 2048;
        };
        let v25 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg6);
        let v26 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg6);
        let v27 = if (!v10) {
            if (v5) {
                arg10 != 0
            } else {
                false
            }
        } else {
            false
        };
        if (v27) {
            let v28 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 13);
            let v29 = if (arg13 < v28) {
                arg13
            } else {
                v28
            };
            let v30 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::cc(arg12, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 11), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 12), v29, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 14), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 15));
            let v31 = v30 - v30 % v7;
            let v32 = false;
            let v33 = if (v31 >= v8) {
                if (arg11 > 0) {
                    arg11 % v6 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v33) {
                let (v34, v35) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::bnd(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::fv(arg11, v31, false), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 10));
                let v36 = if (arg10 == 1) {
                    0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qd_buy<T0, T1>(arg7, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_deepbook(), v34, v31, arg15)
                } else {
                    0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qd<T0, T1>(arg7, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_deepbook(), v31, arg15)
                };
                let v37 = v36;
                let (v38, _) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::ed(&v37, v31, v34, v35);
                let v40 = if (arg10 == 1) {
                    let v41 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::fv(arg11, v31, true);
                    v26 >= v41 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::df<T0, T1>(arg7, v41)
                } else {
                    v25 >= v31 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::df<T0, T1>(arg7, v31)
                };
                let v42 = if (v38) {
                    if (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::iv(&v37, v25 + v16, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 16), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 17))) {
                        v40
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v42) {
                    let v43 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, arg10 != 1);
                    if (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v43)) {
                        if (arg10 == 1 && 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v43) <= arg11 || 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v43) >= arg11) {
                            v12 = cl<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg10 != 1, v12, arg15, arg16);
                        };
                    };
                    0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::place_limit_order<T0, T1>(arg2, arg3, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg4, arg5, arg6, arg7, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cy<T0, T1>(arg0), 1, 1, arg11, v31, arg10 == 1, v0 + 1000, arg15, arg16);
                    v12 = v12 | 1;
                    v32 = true;
                };
            };
            if (!v32) {
                v12 = v12 | 4096;
            };
        };
        let v44 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg6);
        let v45 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg6);
        let v46 = if (v44 >= v25) {
            v44 - v25
        } else {
            v12 = v12 | 65536;
            v25 - v44
        };
        let v47 = if (v45 >= v26) {
            v45 - v26
        } else {
            v12 = v12 | 131072;
            v26 - v45
        };
        let v48 = ex<T0, T1>(arg7, arg6, true, v6, v9, arg15);
        let v49 = ex<T0, T1>(arg7, arg6, false, v6, v9, arg15);
        let v50 = if (v48 > 0) {
            if (v49 > 0) {
                v49 > v48
            } else {
                false
            }
        } else {
            false
        };
        if (!v50) {
            v12 = v12 | 8192;
        };
        let v51 = !v10 && v50;
        let v52 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, true);
        let v53 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::lx(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lf(&v52), v1, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 2), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 3));
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lflag<T0, T1>(arg0, true, v53);
        if (v53) {
            v12 = v12 | 128;
        };
        let v54 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, false);
        let v55 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::lx(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lf(&v54), v2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 2), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 3));
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lflag<T0, T1>(arg0, false, v55);
        if (v55) {
            v12 = v12 | 256;
        };
        let v56 = v12 & 1 != 0;
        let v57 = v3 && !v56;
        let v58 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mo(false, v53, v57, arg10, true);
        let v59 = v4 && !v56;
        let v60 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mo(false, v55, v59, arg10, false);
        let (v61, v62) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::cx(tp<T0, T1>(arg0, v58, v48, v49, v6, v1, true), tp<T0, T1>(arg0, v60, v49, v48, v6, v2, false), v48, v49, v6, arg10);
        let v63 = v62;
        let v64 = if (v62 > 0) {
            if (v61 > 0) {
                v62 <= v61
            } else {
                false
            }
        } else {
            false
        };
        if (v64) {
            v63 = 0;
        };
        if (arg10 == 2) {
            let v65 = rc<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, false, v63, v60, v51, v6, v7, v8, v0, v12, arg15, arg16);
            v12 = rc<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, true, v61, v58, v51, v6, v7, v8, v0, v65, arg15, arg16);
        } else {
            let v66 = rc<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, true, v61, v58, v51, v6, v7, v8, v0, v12, arg15, arg16);
            v12 = rc<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, false, v63, v60, v51, v6, v7, v8, v0, v66, arg15, arg16);
        };
        let v67 = if (v17 > 65535) {
            65535
        } else {
            v17
        };
        let v68 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, true);
        let v69 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, false);
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::emit_cycle(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::did<T0, T1>(arg0), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cy<T0, T1>(arg0), (v12 as u64) | v67 << 32, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v68), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v69), v46, v47);
        v12
    }

    fun cl<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u32 {
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

    public(friend) fun ex<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg5);
        if (v0 == 0) {
            return 0
        };
        let v1 = arg3 * 64;
        let (v2, v3) = if (arg2) {
            let v4 = if (v0 > v1) {
                v0 - v1
            } else {
                1
            };
            (v4, v0)
        } else {
            (v0, v0 + v1)
        };
        let (v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, v2, v3, arg2, arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg0, arg1));
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&v8) && v10 < arg4) {
            let v11 = *0x1::vector::borrow<u64>(&v8, v10);
            let v12 = 0;
            let v13 = 0;
            while (v13 < 0x1::vector::length<u128>(&v9)) {
                let v14 = *0x1::vector::borrow<u128>(&v9, v13);
                let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg0, v14);
                if (v14 >> 127 == 0 == arg2 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(&v15) == v11) {
                    v12 = v12 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v15) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v15);
                };
                v13 = v13 + 1;
            };
            if (*0x1::vector::borrow<u64>(&v7, v10) > v12) {
                return v11
            };
            v10 = v10 + 1;
        };
        0
    }

    fun g1<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::S1, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (u64, u64, u64) {
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cks<T0, T1>(arg0, arg1);
        assert!(!0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::zp<T0, T1>(arg0), 6);
        assert!(arg4 == 1 || arg4 == 2, 6);
        assert!(arg5 > 0, 6);
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::adm<T0, T1>(arg0, arg2, arg3, arg8);
        let v0 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 13);
        let v1 = if (arg7 < v0) {
            arg7
        } else {
            v0
        };
        let v2 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::cc(arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 11), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 12), v1, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 14), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 15));
        assert!(v2 > 0, 6);
        let (v3, v4) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::bnd(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::fv(arg5, v2, false), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 10));
        (v2, v3, v4)
    }

    public(friend) fun mx(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * 11400714819323198485 % 18446744073709551616 + (arg1 as u128) * 13787848793156543929 % 18446744073709551616) % 18446744073709551616) as u64)
    }

    fun rc<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &mut 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg2: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::DeepBookAccount<T0, T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: bool, arg8: u64, arg9: u8, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u32, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, arg7);
        let v1 = if (!arg10) {
            true
        } else if (arg9 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_none()) {
            true
        } else if (arg8 == 0) {
            true
        } else {
            arg8 % arg11 != 0
        };
        if (v1) {
            return cl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg15, arg16, arg17)
        };
        let v2 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 6) - 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 6) % arg12;
        if (v2 < arg13) {
            return cl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg15, arg16, arg17)
        };
        if (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::sx(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lr(&v0), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lx(&v0), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lq(&v0), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lm(&v0), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::le(&v0), arg8, v2, arg9, arg14, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 5))) {
            let v3 = if (arg7) {
                4
            } else {
                32
            };
            return arg15 | v3
        };
        let v4 = cl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg15, arg16, arg17);
        let v5 = if (arg7) {
            let v6 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::fv(arg8, v2, true);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg5) >= v6 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::df<T0, T1>(arg6, v6)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg5) >= v2 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::df<T0, T1>(arg6, v2)
        };
        if (!v5) {
            let v7 = if (arg7) {
                512
            } else {
                1024
            };
            return v4 | v7
        };
        let v8 = arg14 + 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 4);
        let v9 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lg<T0, T1>(arg0, arg7);
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lset<T0, T1>(arg0, arg7, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::mk(0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::deepbook_adapter::place_limit_order<T0, T1>(arg1, arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cy<T0, T1>(arg0), 3, 1, arg8, v2, arg7, v8, arg16, arg17), arg8, v2, arg14, v8, arg9, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::lf(&v9)));
        let v10 = if (arg7) {
            2
        } else {
            16
        };
        v4 | v10
    }

    public fun tc<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::S1, arg2: &mut 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock) : u64 {
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::vid<T0, T1>(arg0) == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg2), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pcid<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg6), 1);
        let (v0, v1, v2) = g1<T0, T1>(arg0, arg1, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::clock::timestamp_ms(arg14));
        let v3 = if (arg9 == 1) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::side_buy()
        } else {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::side_sell()
        };
        let v4 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qc<T0, T1>(arg6, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_cetus(), v3, v0, arg13);
        let v5 = w1(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 16), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 17), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::aux_balance<T1, T0>(arg2), &v4, v0, v1, v2);
        if (arg9 == 1) {
            0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::cetus_adapter::buy_base_qb<T0, T1>(arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(&v4), v0, arg13, arg14);
        } else {
            0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::cetus_adapter::sell_base_qb<T0, T1>(arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, v0, v2, arg13, arg14);
        };
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::emit_take(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::did<T0, T1>(arg0), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cy<T0, T1>(arg0), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_cetus(), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(&v4), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tao(&v4), v5);
        v5
    }

    public fun tf<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::S1, arg2: &mut 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg4: u64, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock) : u64 {
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::vid<T0, T1>(arg0) == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg2), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pbid<T0, T1>(arg0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6), 1);
        let (v0, v1, v2) = g1<T0, T1>(arg0, arg1, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::clock::timestamp_ms(arg14));
        let v3 = if (arg9 == 1) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::side_buy()
        } else {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::side_sell()
        };
        let v4 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qb<T0, T1>(arg6, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_bluefin(), v3, v0, arg13);
        let v5 = w1(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 16), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 17), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::aux_balance<T1, T0>(arg2), &v4, v0, v1, v2);
        if (arg9 == 1) {
            0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::bluefin_adapter::buy_base_bq<T0, T1>(arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(&v4), v0, arg13, arg14);
        } else {
            0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::bluefin_adapter::sell_base_bq<T0, T1>(arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, v0, v2, arg13, arg14);
        };
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::emit_take(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::did<T0, T1>(arg0), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cy<T0, T1>(arg0), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_bluefin(), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(&v4), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tao(&v4), v5);
        v5
    }

    public fun tm<T0, T1>(arg0: &mut 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: &0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::S1, arg2: &mut 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::Vault<T1>, arg3: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg4: u64, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::vid<T0, T1>(arg0) == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::id<T1>(arg2), 1);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pmid<T0, T1>(arg0) == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg5), 1);
        let (v0, v1, v2) = g1<T0, T1>(arg0, arg1, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::clock::timestamp_ms(arg14));
        let v3 = if (arg9 == 1) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::side_buy()
        } else {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::side_sell()
        };
        let v4 = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::qm<T0, T1>(arg5, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_momentum(), v3, v0, arg13);
        let v5 = w1(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 16), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 17), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::vault::aux_balance<T1, T0>(arg2), &v4, v0, v1, v2);
        if (arg9 == 1) {
            0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::momentum_adapter::buy_base_bq<T0, T1>(arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(&v4), v0, arg13, arg14, arg15);
        } else {
            0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::momentum_adapter::sell_base_bq<T0, T1>(arg2, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::kb<T0, T1>(arg0), arg3, arg4, arg5, arg6, v0, v2, arg13, arg14, arg15);
        };
        0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::emit_take(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::did<T0, T1>(arg0), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::cy<T0, T1>(arg0), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::dex_momentum(), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::eco_in(&v4), 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::tao(&v4), v5);
        v5
    }

    fun tp<T0, T1>(arg0: &0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::D<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : u64 {
        if (arg1 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_bkf()) {
            0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::px3(arg2, arg4, arg5, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 1), arg6)
        } else if (arg1 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_tch()) {
            let (_, v2, _) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::px2(arg3, arg4, arg6, 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 7));
            v2
        } else if (arg1 == 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::mode_off()) {
            let (_, v5, _) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0::px1(arg2, arg3, arg4, arg6, (0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::d0::pv<T0, T1>(arg0, 0) as u8));
            v5
        } else {
            0
        }
    }

    public fun un(arg0: u64, arg1: u64) : (u64, u64, bool, bool, bool) {
        let v0 = arg1 ^ mx(arg0, arg0);
        let v1 = v0 >> 40 & 15;
        (v0 & 1048575, v0 >> 20 & 1048575, v1 & 1 != 0, v1 & 2 != 0, v1 & 4 != 0)
    }

    fun w1(arg0: u64, arg1: u64, arg2: u64, arg3: &0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::T, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let (v0, v1) = 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::ed(arg3, arg4, arg5, arg6);
        assert!(v0, 6);
        assert!(0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::q0::iv(arg3, arg2, arg0, arg1), 7);
        v1
    }

    public fun wr(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: bool) : u64 {
        assert!(arg1 < 1048576 && arg2 < 1048576, 0);
        let v0 = if (arg3) {
            1
        } else {
            0
        };
        let v1 = if (arg4) {
            2
        } else {
            0
        };
        let v2 = if (arg5) {
            4
        } else {
            0
        };
        (arg1 | arg2 << 20 | (v0 | v1 | v2) << 40) ^ mx(arg0, arg0)
    }

    // decompiled from Move bytecode v7
}

