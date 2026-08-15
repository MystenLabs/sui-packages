module 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::liquidity_kernel {
    struct Leg has store {
        o: 0x1::option::Option<u128>,
        p: u64,
        q: u64,
        e: u64,
        t: u64,
        m: u8,
    }

    struct Kernel<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        o: address,
        m: 0x2::object::ID,
        v: 0x2::object::ID,
        c: vector<u64>,
        f: u64,
        a: Leg,
        b: Leg,
        n: u64,
    }

    struct BookSide has drop {
        raw_bbo: u64,
        external_bbo: u64,
        own_only_top: bool,
        scan_complete: bool,
    }

    struct QuoteTarget has drop {
        mode: u8,
        requested_price: u64,
        price: u64,
        quantity: u64,
        adverse_markout_bps_e4: u64,
        requested_offset_code: u8,
        offset_perfect: bool,
        attainable: bool,
        failure_code: u8,
    }

    struct K0<phantom T0, phantom T1> has copy, drop {
        k: 0x2::object::ID,
        o: address,
        m: 0x2::object::ID,
        v: 0x2::object::ID,
    }

    struct K1<phantom T0, phantom T1> has copy, drop {
        k: 0x2::object::ID,
        n: u64,
        z: u64,
        c0: u64,
        c1: u64,
        x0: u64,
        x1: u64,
        x2: u64,
        x3: u64,
        x4: u128,
        x5: u128,
        x6: u64,
        x7: u64,
        x8: u64,
    }

    public(friend) fun apply<T0, T1>(arg0: &mut Kernel<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : (bool, bool, bool) {
        bind<T0, T1>(arg0, arg1, arg2, arg10);
        assert!(arg5 > 0 && arg7 <= cfg<T0, T1>(arg0, 14), 3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg10);
        let v1 = cancel_untracked<T0, T1>(arg0, arg1, arg2, &v0, arg9, arg10);
        let v2 = scan_external_side<T0, T1>(arg1, arg2, true, cfg<T0, T1>(arg0, 13), 0x2::clock::timestamp_ms(arg9));
        let v3 = scan_external_side<T0, T1>(arg1, arg2, false, cfg<T0, T1>(arg0, 13), 0x2::clock::timestamp_ms(arg9));
        let v4 = if (v2.scan_complete) {
            if (v3.scan_complete) {
                if (v2.external_bbo > 0) {
                    v3.external_bbo > v2.external_bbo
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        update_toxic_latches<T0, T1>(arg0, arg6, arg7);
        let v5 = if (!flag<T0, T1>(arg0, 1)) {
            if (!arg8) {
                if (v4) {
                    if (arg7 >= cfg<T0, T1>(arg0, 7)) {
                        arg6 == 1 && arg5 > v3.external_bbo || arg6 == 2 && arg5 < v2.external_bbo
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
        let v6 = if (flag<T0, T1>(arg0, 2) || v5 && arg6 == 2) {
            arg7
        } else {
            0
        };
        let v7 = if (flag<T0, T1>(arg0, 4) || v5 && arg6 == 1) {
            arg7
        } else {
            0
        };
        let (v8, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let v11 = quote_target(desired_mode(flag<T0, T1>(arg0, 1), flag<T0, T1>(arg0, 2), v5, arg6, true), true, v2.external_bbo, v3.external_bbo, v8, cfg<T0, T1>(arg0, 0), (cfg<T0, T1>(arg0, 9) as u8), cfg<T0, T1>(arg0, 10), v6, cfg<T0, T1>(arg0, 8), v4);
        let v12 = quote_target(desired_mode(flag<T0, T1>(arg0, 1), flag<T0, T1>(arg0, 4), v5, arg6, false), false, v3.external_bbo, v2.external_bbo, v8, cfg<T0, T1>(arg0, 0), (cfg<T0, T1>(arg0, 9) as u8), cfg<T0, T1>(arg0, 10), v7, cfg<T0, T1>(arg0, 8), v4);
        let v13 = &mut v11;
        let v14 = &mut v12;
        resolve_internal_cross(v13, v14, v2.external_bbo, v3.external_bbo, v8, arg6);
        let v15 = 0x2::clock::timestamp_ms(arg9);
        let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, arg2);
        let v17 = side_order_id(&arg0.a);
        let v18 = side_order_id(&arg0.b);
        let v19 = v17 > 0 && 0x2::vec_set::contains<u128>(&v16, &v17);
        let v20 = v18 > 0 && 0x2::vec_set::contains<u128>(&v16, &v18);
        if (!v19) {
            let v21 = &mut arg0.a;
            clear_side(v21);
        };
        if (!v20) {
            let v22 = &mut arg0.b;
            clear_side(v22);
        };
        let v23 = if (v19) {
            remaining_quantity<T0, T1>(arg1, v17)
        } else {
            0
        };
        let v24 = if (v20) {
            remaining_quantity<T0, T1>(arg1, v18)
        } else {
            0
        };
        let v25 = v19 && side_matches(&arg0.a, &v11, v15, cfg<T0, T1>(arg0, 12));
        let v26 = v20 && side_matches(&arg0.b, &v12, v15, cfg<T0, T1>(arg0, 12));
        let v27 = false;
        let v28 = false;
        if (v19 && !v25) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_order<T0, T1>(arg1, arg2, &v0, v17, arg9, arg10);
            let v29 = &mut arg0.a;
            clear_side(v29);
            v27 = true;
        };
        if (v20 && !v26) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_order<T0, T1>(arg1, arg2, &v0, v18, arg9, arg10);
            let v30 = &mut arg0.b;
            clear_side(v30);
            v28 = true;
        };
        let v31 = cfg<T0, T1>(arg0, 11);
        let v32 = false;
        let v33 = false;
        if (arg6 == 2) {
            if (!v26) {
                let v34 = &mut arg0.b;
                v33 = place_target<T0, T1>(v34, &v12, false, arg1, arg2, &v0, arg3, v15, v31, arg9, arg10);
            };
            if (!v25) {
                let v35 = &mut arg0.a;
                v32 = place_target<T0, T1>(v35, &v11, true, arg1, arg2, &v0, arg3, v15, v31, arg9, arg10);
            };
        } else {
            if (!v25) {
                let v36 = &mut arg0.a;
                v32 = place_target<T0, T1>(v36, &v11, true, arg1, arg2, &v0, arg3, v15, v31, arg9, arg10);
            };
            if (!v26) {
                let v37 = &mut arg0.b;
                v33 = place_target<T0, T1>(v37, &v12, false, arg1, arg2, &v0, arg3, v15, v31, arg9, arg10);
            };
        };
        arg0.n = arg0.n + 1;
        let v38 = side_satisfies(&arg0.a, &v11);
        let v39 = side_satisfies(&arg0.b, &v12);
        let (v40, v41, v42, v43, v44) = leg_result(&arg0.a, &v11, v23, v25, v27, v32, v15);
        let (v45, v46, v47, v48, v49) = leg_result(&arg0.b, &v12, v24, v26, v28, v33, v15);
        let v50 = if (v27) {
            true
        } else if (v28) {
            true
        } else if (v32) {
            true
        } else {
            v33
        };
        let v51 = K1<T0, T1>{
            k  : 0x2::object::id<Kernel<T0, T1>>(arg0),
            n  : arg3,
            z  : result_flags(arg8, v5, flag<T0, T1>(arg0, 2), flag<T0, T1>(arg0, 4), v4, v50, v38, v39, v43, v48, v44, v49, v1 > 0),
            c0 : v40,
            c1 : v45,
            x0 : arg0.a.p,
            x1 : arg0.b.p,
            x2 : v41,
            x3 : v46,
            x4 : side_order_id(&arg0.a),
            x5 : side_order_id(&arg0.b),
            x6 : v1,
            x7 : v42,
            x8 : v47,
        };
        0x2::event::emit<K1<T0, T1>>(v51);
        (v50, v38, v39)
    }

    public(friend) fun backoff_price(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : u64 {
        let v0 = backoff_ticks(arg0, arg1, arg3, arg4);
        if (v0 == 0 || v0 > (18446744073709551615 as u64) / arg1) {
            return 0
        };
        let v1 = v0 * arg1;
        if (arg2) {
            if (arg0 > v1) {
                arg0 - v1
            } else {
                0
            }
        } else {
            checked_add(arg0, v1)
        }
    }

    public(friend) fun backoff_ticks(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0x1::u128::max(1, (((arg0 as u128) * ((arg2 as u128) + (arg3 as u128)) + 100000000 - 1) / 100000000 + (arg1 as u128) - 1) / (arg1 as u128));
        if (v0 > 18446744073709551615) {
            0
        } else {
            (v0 as u64)
        }
    }

    public(friend) fun bbo_offset_price(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u8) : (u64, u64, bool) {
        let (v0, v1) = decode_offset(arg4);
        let v2 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            v1 > 16
        };
        if (v2) {
            return (0, 0, false)
        };
        let v3 = v1 * arg2;
        let v4 = if (v0) {
            if (arg3) {
                checked_add(arg0, v3)
            } else if (arg0 > v3) {
                arg0 - v3
            } else {
                0
            }
        } else if (arg3) {
            if (arg0 > v3) {
                arg0 - v3
            } else {
                0
            }
        } else {
            checked_add(arg0, v3)
        };
        if (v4 == 0) {
            return (0, 0, false)
        };
        let v5 = if (arg3) {
            if (arg1 <= arg2) {
                return (v4, 0, false)
            };
            0x1::u64::min(v4, arg1 - arg2)
        } else {
            0x1::u64::max(v4, checked_add(arg1, arg2))
        };
        (v4, v5, v5 == v4)
    }

    public(friend) fun bind<T0, T1>(arg0: &Kernel<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.o == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.v == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) && arg0.m == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 2);
    }

    fun bool_word(arg0: bool, arg1: u64) : u64 {
        if (arg0) {
            arg1
        } else {
            0
        }
    }

    public fun boot<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) == 15, 0);
        validate_configuration<T0, T1>(arg0, cv(&arg2, 0), cv(&arg2, 1), cv(&arg2, 2), cv(&arg2, 3), cv(&arg2, 4), cv(&arg2, 5), cv(&arg2, 6), cv(&arg2, 7), cv(&arg2, 8), (cv(&arg2, 9) as u8), cv(&arg2, 10), cv(&arg2, 11), cv(&arg2, 12), cv(&arg2, 13), cv(&arg2, 14));
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg0, arg1, &v0, arg3, arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Kernel<T0, T1>{
            id : 0x2::object::new(arg4),
            o  : v1,
            m  : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            v  : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            c  : arg2,
            f  : 0,
            a  : empty_side(),
            b  : empty_side(),
            n  : 0,
        };
        let v3 = K0<T0, T1>{
            k : 0x2::object::id<Kernel<T0, T1>>(&v2),
            o : v1,
            m : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            v : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
        };
        0x2::event::emit<K0<T0, T1>>(v3);
        0x2::transfer::share_object<Kernel<T0, T1>>(v2);
    }

    fun cancel_untracked<T0, T1>(arg0: &Kernel<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, arg2));
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&v0)) {
            let v3 = *0x1::vector::borrow<u128>(&v0, v2);
            if (v3 != side_order_id(&arg0.a) && v3 != side_order_id(&arg0.b)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_order<T0, T1>(arg1, arg2, arg3, v3, arg4, arg5);
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun cfg<T0, T1>(arg0: &Kernel<T0, T1>, arg1: u64) : u64 {
        cv(&arg0.c, arg1)
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 > 18446744073709551615) {
            0
        } else {
            (v0 as u64)
        }
    }

    fun clear_side(arg0: &mut Leg) {
        arg0.o = 0x1::option::none<u128>();
        arg0.p = 0;
        arg0.q = 0;
        arg0.e = 0;
        arg0.t = 0;
        arg0.m = 0;
    }

    fun client_order_id(arg0: u64, arg1: bool) : u64 {
        assert!(arg0 < 9223372036854775808, 3);
        if (arg1) {
            arg0
        } else {
            arg0 | 9223372036854775808
        }
    }

    public(friend) fun conviction_clip(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg0 < arg1) {
            true
        } else if (arg2 <= arg1) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg4 > 10000) {
            true
        } else {
            arg5 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = if (arg0 >= arg2) {
            10000
        } else {
            arg4 + ((((10000 - arg4) as u128) * ((arg0 - arg1) as u128) / ((arg2 - arg1) as u128)) as u64)
        };
        (((arg3 as u128) * (v1 as u128) / 10000) as u64) / arg5 * arg5
    }

    fun cv(arg0: &vector<u64>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(arg0, arg1)
    }

    fun decode_offset(arg0: u8) : (bool, u64) {
        if (arg0 >= 128) {
            (true, ((arg0 - 128) as u64))
        } else {
            (false, ((128 - arg0) as u64))
        }
    }

    fun desired_mode(arg0: bool, arg1: bool, arg2: bool, arg3: u8, arg4: bool) : u8 {
        if (arg0) {
            0
        } else if (arg1) {
            3
        } else if (arg2 && (arg4 && arg3 == 1 || !arg4 && arg3 == 2)) {
            2
        } else if (arg2 && (!arg4 && arg3 == 1 || arg4 && arg3 == 2)) {
            3
        } else {
            1
        }
    }

    fun empty_side() : Leg {
        Leg{
            o : 0x1::option::none<u128>(),
            p : 0,
            q : 0,
            e : 0,
            t : 0,
            m : 0,
        }
    }

    fun encode_positive_offset(arg0: u64) : u8 {
        if (arg0 > 127) {
            255
        } else {
            128 + (arg0 as u8)
        }
    }

    fun flag<T0, T1>(arg0: &Kernel<T0, T1>, arg1: u64) : bool {
        arg0.f & arg1 != 0
    }

    fun leg_result(arg0: &Leg, arg1: &QuoteTarget, arg2: u64, arg3: bool, arg4: bool, arg5: bool, arg6: u64) : (u64, u64, u64, bool, bool) {
        let v0 = side_satisfies(arg0, arg1);
        let v1 = if (arg3) {
            arg2
        } else if (side_order_id(arg0) > 0) {
            arg0.q
        } else {
            0
        };
        let v2 = if (v0 || arg1.mode == 0) {
            0
        } else if (arg1.failure_code != 0) {
            arg1.failure_code
        } else {
            3
        };
        let v3 = if (arg1.mode == 1) {
            if (arg1.offset_perfect) {
                v0
            } else {
                false
            }
        } else {
            false
        };
        let v4 = !v0 && v2 == 1;
        let v5 = if (arg0.t > 0 && arg6 >= arg0.t) {
            arg6 - arg0.t
        } else {
            0
        };
        ((arg1.mode as u64) + ((arg0.m as u64) << 2) + bool_word(arg3, 16) + bool_word(arg4, 32) + bool_word(arg5, 64) + bool_word(v0, 128) + bool_word(v3, 256) + bool_word(v4, 512) + ((v2 as u64) << 16) + ((arg1.requested_offset_code as u64) << 24), v1, v5, v3, v4)
    }

    public(friend) fun next_toxic(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg0 && arg1 > arg3 || arg1 >= arg2
    }

    public(friend) fun params<T0, T1>(arg0: &Kernel<T0, T1>) : (u64, u64, u64, u64, u64) {
        (cfg<T0, T1>(arg0, 1), cfg<T0, T1>(arg0, 2), cfg<T0, T1>(arg0, 3), cfg<T0, T1>(arg0, 4), cfg<T0, T1>(arg0, 14))
    }

    public(friend) fun peek<T0, T1>(arg0: &Kernel<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::clock::Clock) : (u64, u64, bool, u64, u64, bool, bool) {
        let v0 = scan_external_side<T0, T1>(arg1, arg2, true, cfg<T0, T1>(arg0, 13), 0x2::clock::timestamp_ms(arg3));
        let v1 = scan_external_side<T0, T1>(arg1, arg2, false, cfg<T0, T1>(arg0, 13), 0x2::clock::timestamp_ms(arg3));
        let v2 = if (v0.scan_complete) {
            if (v1.scan_complete) {
                if (v0.external_bbo > 0) {
                    v1.external_bbo > v0.external_bbo
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        (v0.raw_bbo, v0.external_bbo, v0.own_only_top, v1.raw_bbo, v1.external_bbo, v1.own_only_top, v2)
    }

    fun place_target<T0, T1>(arg0: &mut Leg, arg1: &QuoteTarget, arg2: bool, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : bool {
        let v0 = if (arg1.mode == 0) {
            true
        } else if (!arg1.attainable) {
            true
        } else {
            arg1.price == 0
        };
        if (v0) {
            return false
        };
        let v1 = checked_add(arg7, arg8);
        if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::can_place_limit_order<T0, T1>(arg3, arg4, arg1.price, arg1.quantity, arg2, true, v1, arg9)) {
            return false
        };
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg4, arg5, client_order_id(arg6, arg2), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), arg1.price, arg1.quantity, arg2, true, v1, arg9, arg10);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_inserted(&v2) && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v2) == 0, 4);
        arg0.o = 0x1::option::some<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v2));
        arg0.p = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(&v2);
        arg0.q = arg1.quantity;
        arg0.e = v1;
        arg0.t = arg7;
        arg0.m = arg1.mode;
        true
    }

    fun quote_target(arg0: u8, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: bool) : QuoteTarget {
        if (arg0 == 0) {
            return QuoteTarget{
                mode                   : arg0,
                requested_price        : 0,
                price                  : 0,
                quantity               : 0,
                adverse_markout_bps_e4 : arg8,
                requested_offset_code  : arg6,
                offset_perfect         : true,
                attainable             : true,
                failure_code           : 0,
            }
        };
        let v0 = if (!arg10) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return QuoteTarget{
                mode                   : arg0,
                requested_price        : 0,
                price                  : 0,
                quantity               : arg5,
                adverse_markout_bps_e4 : arg8,
                requested_offset_code  : arg6,
                offset_perfect         : false,
                attainable             : false,
                failure_code           : 1,
            }
        };
        let (v1, v2, v3) = if (arg0 == 1) {
            let (v4, v5, v6) = bbo_offset_price(arg2, arg3, arg4, arg1, arg6);
            (v6, v4, v5)
        } else {
            let (v7, v8, v9) = if (arg0 == 2) {
                touching_price(arg2, arg3, arg4, arg1, arg7)
            } else if (arg0 == 3) {
                let v10 = backoff_price(arg2, arg4, arg1, arg8, arg9);
                (v10, v10, v10 > 0)
            } else {
                (0, 0, false)
            };
            (v9, v7, v8)
        };
        let v11 = if (arg0 == 2) {
            encode_positive_offset(arg7)
        } else {
            arg6
        };
        let v12 = if (v3 > 0) {
            0
        } else {
            2
        };
        QuoteTarget{
            mode                   : arg0,
            requested_price        : v2,
            price                  : v3,
            quantity               : arg5,
            adverse_markout_bps_e4 : arg8,
            requested_offset_code  : v11,
            offset_perfect         : v1,
            attainable             : v3 > 0,
            failure_code           : v12,
        }
    }

    fun remaining_quantity<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u128) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v0) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v0)
    }

    fun resolve_internal_cross(arg0: &mut QuoteTarget, arg1: &mut QuoteTarget, arg2: u64, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = if (arg0.price == 0) {
            true
        } else if (arg1.price == 0) {
            true
        } else {
            arg0.price < arg1.price
        };
        if (v0) {
            return
        };
        if (arg5 == 1) {
            arg1.price = 0x1::u64::max(arg3, checked_add(arg0.price, arg4));
            arg1.offset_perfect = arg1.price == arg1.requested_price;
        } else if (arg5 == 2) {
            let v1 = if (arg1.price > arg4) {
                0x1::u64::min(arg2, arg1.price - arg4)
            } else {
                0
            };
            arg0.price = v1;
            arg0.offset_perfect = arg0.price == arg0.requested_price;
        } else {
            arg0.price = arg2;
            arg1.price = arg3;
            arg0.offset_perfect = arg0.price == arg0.requested_price;
            arg1.offset_perfect = arg1.price == arg1.requested_price;
        };
        arg0.attainable = arg0.price > 0;
        arg1.attainable = arg1.price > arg0.price;
    }

    fun result_flags(arg0: bool, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: bool) : u64 {
        bool_word(arg0, 1) + bool_word(arg1, 2) + bool_word(arg2, 4) + bool_word(arg3, 8) + bool_word(arg4, 16) + bool_word(arg5, 32) + bool_word(arg6, 64) + bool_word(arg7, 128) + bool_word(arg8, 256) + bool_word(arg9, 512) + bool_word(arg10, 1024) + bool_word(arg11, 2048) + bool_word(arg12, 4096)
    }

    fun scan_external_side<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: bool, arg3: u64, arg4: u64) : BookSide {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::some<u64>(arg4), arg3, arg2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = false;
        let v7 = false;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1)) {
            let v9 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v8);
            let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v9);
            if (v2 == 0) {
                v3 = v10;
            };
            if (v10 != v3) {
                v7 = true;
            };
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::balance_manager_id(v9) != 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1)) {
                if (v10 == v3) {
                    v6 = true;
                };
                if (v4 == 0) {
                    v5 = v10;
                };
            };
            v8 = v8 + 1;
        };
        let v11 = v5 > 0 || !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v0);
        let v12 = if (v6) {
            true
        } else if (v7) {
            true
        } else {
            !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v0)
        };
        let v13 = if (v3 > 0) {
            if (v12) {
                !v6
            } else {
                false
            }
        } else {
            false
        };
        BookSide{
            raw_bbo       : v3,
            external_bbo  : v5,
            own_only_top  : v13,
            scan_complete : v11,
        }
    }

    fun set_bit(arg0: &mut u64, arg1: u64, arg2: bool) {
        let v0 = *arg0 & arg1 != 0;
        if (arg2 && !v0) {
            *arg0 = *arg0 + arg1;
        } else if (!arg2 && v0) {
            *arg0 = *arg0 - arg1;
        };
    }

    public fun set_flag<T0, T1>(arg0: &mut Kernel<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.o == 0x2::tx_context::sender(arg2), 1);
        let v0 = &mut arg0.f;
        set_bit(v0, 1, arg1);
    }

    fun side_matches(arg0: &Leg, arg1: &QuoteTarget, arg2: u64, arg3: u64) : bool {
        if (arg1.mode != 0) {
            if (arg1.price > 0) {
                if (arg0.p == arg1.price) {
                    if (arg0.q == arg1.quantity) {
                        if (arg0.m == arg1.mode) {
                            if (arg0.e > arg2) {
                                arg0.e - arg2 > arg3
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
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun side_order_id(arg0: &Leg) : u128 {
        0x1::option::get_with_default<u128>(&arg0.o, 0)
    }

    fun side_satisfies(arg0: &Leg, arg1: &QuoteTarget) : bool {
        if (arg1.mode == 0) {
            0x1::option::is_none<u128>(&arg0.o)
        } else if (0x1::option::is_some<u128>(&arg0.o)) {
            if (arg0.p == arg1.price) {
                if (arg0.q == arg1.quantity) {
                    arg0.m == arg1.mode
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun touching_price(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64) : (u64, u64, bool) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else {
            arg4 > 16
        };
        if (v0) {
            return (0, 0, false)
        };
        let v1 = arg4 * arg2;
        let v2 = if (arg3) {
            if (arg1 > v1) {
                arg1 - v1
            } else {
                0
            }
        } else {
            checked_add(arg1, v1)
        };
        if (v2 == 0) {
            return (0, 0, false)
        };
        let v3 = if (arg3) {
            0x1::u64::min(v2, arg1 - arg2)
        } else {
            0x1::u64::max(v2, checked_add(arg1, arg2))
        };
        (v2, v3, v2 == v3)
    }

    public(friend) fun trim<T0, T1>(arg0: &mut Kernel<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : bool {
        bind<T0, T1>(arg0, arg1, arg2, arg5);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg5);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, arg2);
        let v2 = if (arg3 == 1) {
            side_order_id(&arg0.b)
        } else if (arg3 == 2) {
            side_order_id(&arg0.a)
        } else {
            0
        };
        let v3 = v2;
        if (v3 == 0 || !0x2::vec_set::contains<u128>(&v1, &v3)) {
            return false
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_order<T0, T1>(arg1, arg2, &v0, v3, arg4, arg5);
        if (arg3 == 1) {
            let v4 = &mut arg0.b;
            clear_side(v4);
        } else {
            let v5 = &mut arg0.a;
            clear_side(v5);
        };
        true
    }

    public fun tune<T0, T1>(arg0: &mut Kernel<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.o == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.v == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), 2);
        assert!(0x1::vector::length<u64>(&arg2) == 15, 0);
        validate_configuration<T0, T1>(arg1, cv(&arg2, 0), cv(&arg2, 1), cv(&arg2, 2), cv(&arg2, 3), cv(&arg2, 4), cv(&arg2, 5), cv(&arg2, 6), cv(&arg2, 7), cv(&arg2, 8), (cv(&arg2, 9) as u8), cv(&arg2, 10), cv(&arg2, 11), cv(&arg2, 12), cv(&arg2, 13), cv(&arg2, 14));
        arg0.c = arg2;
    }

    fun update_toxic_latches<T0, T1>(arg0: &mut Kernel<T0, T1>, arg1: u8, arg2: u64) {
        let v0 = if (arg1 == 2) {
            arg2
        } else {
            0
        };
        let v1 = if (arg1 == 1) {
            arg2
        } else {
            0
        };
        let v2 = &mut arg0.f;
        set_bit(v2, 2, next_toxic(flag<T0, T1>(arg0, 2), v0, cfg<T0, T1>(arg0, 5), cfg<T0, T1>(arg0, 6)));
        let v3 = &mut arg0.f;
        set_bit(v3, 4, next_toxic(flag<T0, T1>(arg0, 4), v1, cfg<T0, T1>(arg0, 5), cfg<T0, T1>(arg0, 6)));
    }

    fun validate_configuration<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64) {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (_, v4) = decode_offset(arg10);
        let v5 = if (arg1 >= v2) {
            if (arg1 % v1 == 0) {
                if (arg2 > 0) {
                    if (arg3 > arg2) {
                        if (arg4 > 0) {
                            if (arg4 <= 10000) {
                                if (arg5 > 0) {
                                    if (arg5 % v1 == 0) {
                                        if (arg6 > 0) {
                                            if (arg7 < arg6) {
                                                if (arg6 <= arg2) {
                                                    if (arg8 > 0) {
                                                        if (arg8 <= arg2) {
                                                            if (arg9 > 0) {
                                                                if (v4 <= 16) {
                                                                    if (arg11 > 0) {
                                                                        if (arg11 <= 16) {
                                                                            if (arg12 > arg13) {
                                                                                if (arg12 <= 3600000) {
                                                                                    if (arg14 > 0) {
                                                                                        if (arg14 <= 100) {
                                                                                            if (arg15 >= arg3) {
                                                                                                (arg15 as u128) < 100000000
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
                                                                                }
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
                                                                }
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
                                                }
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
                                }
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
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 0);
    }

    // decompiled from Move bytecode v7
}

