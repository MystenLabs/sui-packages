module 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::a6 {
    struct L has copy, drop, store {
        o: u128,
        p: u64,
        q: u64,
        e: u64,
        f: bool,
    }

    struct A<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        v: 0x2::object::ID,
        d: 0x2::object::ID,
        p: 0x2::object::ID,
        a: 0x2::object::ID,
        c: 0x2::object::ID,
        k: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>,
        n: u64,
        ts: u64,
        hm: u64,
        hi: u64,
        m: u64,
        i: u64,
        sf: u64,
        cost: u64,
        ttl: u64,
        refresh: u64,
        age: u64,
        skew: u64,
        drift: u64,
        off: u64,
        improve: u64,
        tox_in: u64,
        tox_out: u64,
        b: L,
        x: L,
        z: bool,
    }

    struct Cycle has copy, drop {
        desk: 0x2::object::ID,
        sequence: u64,
        source_ts_ms: u64,
        reason: u8,
        status: u64,
        source_anchor: u64,
        live_bid: u64,
        live_ask: u64,
        drift_bps: u64,
        target: u64,
        bid_price: u64,
        bid_size: u64,
        bid_order: u128,
        bid_cancel_found: bool,
        ask_price: u64,
        ask_size: u64,
        ask_order: u128,
        ask_cancel_found: bool,
        position_size: u64,
        position_long: bool,
    }

    fun emit<T0, T1>(arg0: &A<T0, T1>, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: u64, arg13: bool) {
        let v0 = Cycle{
            desk             : 0x2::object::uid_to_inner(&arg0.id),
            sequence         : arg1,
            source_ts_ms     : arg2,
            reason           : arg3,
            status           : arg4,
            source_anchor    : arg5,
            live_bid         : arg6,
            live_ask         : arg7,
            drift_bps        : arg8,
            target           : arg9,
            bid_price        : arg0.b.p,
            bid_size         : arg0.b.q,
            bid_order        : arg0.b.o,
            bid_cancel_found : arg10,
            ask_price        : arg0.x.p,
            ask_size         : arg0.x.q,
            ask_order        : arg0.x.o,
            ask_cancel_found : arg11,
            position_size    : arg12,
            position_long    : arg13,
        };
        0x2::event::emit<Cycle>(v0);
    }

    public fun ap<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg6), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg5), 1);
        assert!(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::account_vault_id<T0, T1>(arg2) == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1), 1);
        assert!(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::clearing_house_id<T0, T1>(arg2) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg5), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg6);
        assert!(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::account_num<T0, T1>(arg2) == v0, 1);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg16));
        if (arg9 <= arg0.n || arg10 <= arg0.ts) {
            emit<T0, T1>(arg0, arg9, arg10, 1, 0, arg11, 0, 0, 0, 0, false, false, 0, true);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg5);
            return 0
        };
        arg0.n = arg9;
        arg0.ts = arg10;
        let v1 = 0x2::clock::timestamp_ms(arg15);
        let v2 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), true));
        let v3 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), false));
        let v4 = v3 > 0 && v2 > v3;
        let v5 = if (v4) {
            ((((v3 as u128) + (v2 as u128)) / 2) as u64)
        } else {
            0
        };
        let (v6, v7) = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::ad(arg11, v5, arg0.drift);
        let v8 = valid_time<T0, T1>(arg0, arg10, v1);
        let v9 = if (0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::version(arg3) == arg4) {
            if (0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::status(arg3) == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::status_normal()) {
                if (!0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::is_paused<T1>(arg1)) {
                    if (0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::is_dex_allowed(arg3, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_aftermath_perp())) {
                        if (0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::is_dex_allowed<T1>(arg1, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_aftermath_perp())) {
                            !arg0.z
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
        let v10 = 0;
        let v11 = v10;
        let v12 = arg0.x.o != 0;
        let v13 = present<T1>(&arg5, arg0.x.o);
        if (arg0.b.o != 0 && !present<T1>(&arg5, arg0.b.o)) {
            clear<T0, T1>(arg0, true);
            v11 = v10 | 64;
        };
        if (v12 && !v13) {
            clear<T0, T1>(arg0, false);
            v11 = v11 | 128;
        };
        let (v14, v15) = base_size<T1>(&arg5, v0);
        let v16 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg5);
        let v17 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v16);
        let v18 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v16);
        let v19 = room(v14, v15, arg0.i, true);
        let v20 = room(v14, v15, arg0.i, false);
        let v21 = quote_size(arg0.m, arg0.sf, arg14, v18, v19);
        let v22 = quote_size(arg0.m, arg0.sf, arg14, v18, v20);
        let v23 = arg13 / 10;
        let v24 = if (arg12 == 2) {
            v23
        } else {
            0
        };
        let v25 = if (arg12 == 1) {
            v23
        } else {
            0
        };
        arg0.b.f = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m0::lx(arg0.b.f, v24, arg0.tox_in, arg0.tox_out);
        arg0.x.f = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m0::lx(arg0.x.f, v25, arg0.tox_in, arg0.tox_out);
        if (arg0.b.f) {
            v11 = v11 | 256;
        };
        if (arg0.x.f) {
            v11 = v11 | 512;
        };
        let v26 = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::tg(arg11, arg12, arg13, false);
        let v27 = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::tg(arg11, arg12, arg13, true);
        let v28 = if (v26 > 0) {
            v26
        } else {
            v27
        };
        let v29 = if (v9) {
            if (v8) {
                if (v4) {
                    if (v6) {
                        if (v28 > 0) {
                            if (v17 > 0) {
                                v18 > 0
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
        let v30 = if (v29) {
            if (!arg0.b.f) {
                v21 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v31 = if (v30) {
            let (v32, _) = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::mkp(true, v26, arg0.cost, v3, v2, arg0.off, v17);
            v32
        } else {
            0
        };
        let v34 = if (v29) {
            if (!arg0.x.f) {
                v22 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v35 = if (v34) {
            let (v36, _) = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::mkp(false, v27, arg0.cost, v3, v2, arg0.off, v17);
            v36
        } else {
            0
        };
        let (v38, v39) = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m0::cx(v31, v35, v3, v2, v17, arg12);
        let v40 = v39;
        let v41 = v38;
        let v42 = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::rqd(arg0.b.o != 0, arg0.b.p, v38, true, econ_bound(v26, arg0.cost, true), arg0.improve, v17, arg0.b.e, v1, arg0.refresh);
        let v43 = 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::rqd(arg0.x.o != 0, arg0.x.p, v39, false, econ_bound(v27, arg0.cost, false), arg0.improve, v17, arg0.x.e, v1, arg0.refresh);
        if (arg0.b.o != 0 && arg0.b.q > v19) {
            let v44 = if (v38 > 0 && v21 > 0) {
                0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_replace()
            } else {
                0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_cancel()
            };
            v42 = v44;
        };
        if (arg0.x.o != 0 && arg0.x.q > v20) {
            let v45 = if (v39 > 0 && v22 > 0) {
                0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_replace()
            } else {
                0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_cancel()
            };
            v43 = v45;
        };
        let v46 = if (v42 == 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_replace()) {
            if (v38 > 0) {
                v21 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v47 = if (v43 == 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_replace()) {
            if (v39 > 0) {
                v22 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v46 || v47) {
            let v48 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T1>(&arg5, arg7, arg15);
            let v49 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v16);
            if (v46 && !order_value_ok(v21, v48, v49)) {
                v41 = 0;
                v11 = v11 | 1024;
                let v50 = if (arg0.b.o != 0) {
                    0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_cancel()
                } else {
                    0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_keep()
                };
                v42 = v50;
            };
            if (v47 && !order_value_ok(v22, v48, v49)) {
                v40 = 0;
                v11 = v11 | 2048;
                let v51 = if (arg0.x.o != 0) {
                    0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_cancel()
                } else {
                    0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_keep()
                };
                v43 = v51;
            };
        };
        let v52 = false;
        let v53 = false;
        if (v42 != 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_keep() && arg0.b.o != 0) {
            let v54 = &mut arg5;
            let (v55, v56) = cancel_one<T0, T1>(arg0, v54, arg6, true);
            if (v55) {
                v11 = v11 | 2;
            };
            v52 = v56;
        } else if (v42 == 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_keep() && arg0.b.o != 0) {
            v11 = v11 | 1;
        };
        if (v43 != 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_keep() && arg0.x.o != 0) {
            let v57 = &mut arg5;
            let (v58, v59) = cancel_one<T0, T1>(arg0, v57, arg6, false);
            if (v58) {
                v11 = v11 | 16;
            };
            v53 = v59;
        } else if (v43 == 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_keep() && arg0.x.o != 0) {
            v11 = v11 | 8;
        };
        let v60 = if (v42 == 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_replace()) {
            if (v41 > 0) {
                v21 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v61 = if (v43 == 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::m1::act_replace()) {
            if (v40 > 0) {
                v22 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v60 || v61) {
            let v62 = v1 + arg0.ttl;
            let v63 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg5, &arg0.k, arg6, arg7, arg8, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg15, arg16);
            if (v60) {
                let v64 = option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T1>(&mut v63, false, v21, v41, 2, 0x1::option::some<u64>(client_id(arg9, false)), false, 0x1::option::some<u64>(v62)));
                if (v64 != 0) {
                    let v65 = L{
                        o : v64,
                        p : v41,
                        q : v21,
                        e : v62,
                        f : arg0.b.f,
                    };
                    arg0.b = v65;
                    v11 = v11 | 4;
                };
            };
            if (v61) {
                let v66 = option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T1>(&mut v63, true, v22, v40, 2, 0x1::option::some<u64>(client_id(arg9, true)), false, 0x1::option::some<u64>(v62)));
                if (v66 != 0) {
                    let v67 = L{
                        o : v66,
                        p : v40,
                        q : v22,
                        e : v62,
                        f : arg0.x.f,
                    };
                    arg0.x = v67;
                    v11 = v11 | 32;
                };
            };
            let (v68, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v63, &arg0.k, arg6, false, false);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v68);
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg5);
        };
        let v70 = if (!v8) {
            2
        } else if (!v9) {
            3
        } else if (!v4) {
            4
        } else if (!v6) {
            5
        } else if (v21 == 0 && v22 == 0) {
            6
        } else {
            let v71 = if (v11 & (1024 | 2048) != 0) {
                if (v41 == 0) {
                    v40 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v71) {
                7
            } else {
                0
            }
        };
        emit<T0, T1>(arg0, arg9, arg10, v70, v11, arg11, v3, v2, v7, v28, v52, v53, v14, v15);
        v11
    }

    fun base_size<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64) : (u64, bool) {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, arg1)) {
            return (0, true)
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, arg1);
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::abs_net_base(v0), 1000000000), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v0))
    }

    public fun c0<T0, T1>(arg0: &0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::D<T0, T1>, arg1: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultAdminCap<T1>, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg4: u64, arg5: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::PerpAccount<T0, T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : A<T0, T1> {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::assert_active(arg3, arg4);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_active_vault<T1>(arg1, arg3, arg4);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_admin<T1>(arg1, arg2);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::dex_adapter::assert_dex_allowed<T1>(arg1, arg3, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_aftermath_perp());
        assert!(0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::vid<T0, T1>(arg0) == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1), 1);
        assert!(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::account_vault_id<T0, T1>(arg5) == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1), 1);
        assert!(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::clearing_house_id<T0, T1>(arg5) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg6), 1);
        assert!(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::account_num<T0, T1>(arg5) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg7), 1);
        validate(arg9, arg10, arg11);
        assert!(arg9 <= 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 6), 2);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg6, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg7))) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg6, &arg8, arg7);
        };
        let v0 = if (0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 9) < 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 21)) {
            0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 9)
        } else {
            0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 21)
        };
        assert!(v0 > 0 && 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 4) > 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 5), 2);
        assert!(0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 3) < 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 2), 2);
        A<T0, T1>{
            id      : 0x2::object::new(arg12),
            v       : 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1),
            d       : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::did<T0, T1>(arg0),
            p       : 0x2::object::id<0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg5),
            a       : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg7),
            c       : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg6),
            k       : arg8,
            n       : 0,
            ts      : 0,
            hm      : arg9,
            hi      : arg10,
            m       : arg9,
            i       : arg10,
            sf      : arg11,
            cost    : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 19),
            ttl     : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 4),
            refresh : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 5),
            age     : v0,
            skew    : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 8),
            drift   : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 20),
            off     : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 22),
            improve : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 26),
            tox_in  : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 2),
            tox_out : 0x341a7e94adfe3925fe232c7505146ff1e519e40b43f605a0bb9ba865a1596600::d0::pv<T0, T1>(arg0, 3),
            b       : empty_leg(),
            x       : empty_leg(),
            z       : false,
        }
    }

    public fun ca<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg4), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg3), 1);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg6));
        let v0 = &mut arg3;
        let (v1, v2) = cancel_one<T0, T1>(arg0, v0, arg4, true);
        let v3 = &mut arg3;
        let (v4, v5) = cancel_one<T0, T1>(arg0, v3, arg4, false);
        let v6 = 0;
        let v7 = v6;
        if (v1) {
            v7 = v6 | 2;
        };
        if (v4) {
            v7 = v7 | 16;
        };
        emit<T0, T1>(arg0, arg0.n, 0x2::clock::timestamp_ms(arg5), 3, v7, 0, 0, 0, 0, 0, v2, v5, 0, true);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg3);
        v7
    }

    fun cancel_one<T0, T1>(arg0: &mut A<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: bool) : (bool, bool) {
        let v0 = if (arg3) {
            arg0.b.o
        } else {
            arg0.x.o
        };
        if (v0 == 0) {
            return (false, false)
        };
        let v1 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v1, v0);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, &arg0.k, arg2, &v1);
        let v3 = 0x1::vector::length<bool>(&v2) == 1 && *0x1::vector::borrow<bool>(&v2, 0);
        clear<T0, T1>(arg0, arg3);
        (true, v3)
    }

    fun clear<T0, T1>(arg0: &mut A<T0, T1>, arg1: bool) {
        let v0 = arg1 && arg0.b.f || arg0.x.f;
        let v1 = L{
            o : 0,
            p : 0,
            q : 0,
            e : 0,
            f : v0,
        };
        if (arg1) {
            arg0.b = v1;
        } else {
            arg0.x = v1;
        };
    }

    fun client_id(arg0: u64, arg1: bool) : u64 {
        let v0 = if (arg1) {
            1
        } else {
            0
        };
        (arg0 & 9223372036854775807) * 2 + v0
    }

    fun econ_bound(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg2) {
            (((arg0 as u128) * 10000 / (10000 + (arg1 as u128))) as u64)
        } else {
            ((((arg0 as u128) * (10000 + (arg1 as u128)) + 10000 - 1) / 10000) as u64)
        }
    }

    fun empty_leg() : L {
        L{
            o : 0,
            p : 0,
            q : 0,
            e : 0,
            f : false,
        }
    }

    fun option_u128(arg0: 0x1::option::Option<u128>) : u128 {
        if (0x1::option::is_some<u128>(&arg0)) {
            0x1::option::destroy_some<u128>(arg0)
        } else {
            0x1::option::destroy_none<u128>(arg0);
            0
        }
    }

    fun option_u64(arg0: 0x1::option::Option<u64>) : u64 {
        if (0x1::option::is_some<u64>(&arg0)) {
            0x1::option::destroy_some<u64>(arg0)
        } else {
            0x1::option::destroy_none<u64>(arg0);
            0
        }
    }

    fun order_value_ok(arg0: u64, arg1: u256, arg2: u256) : bool {
        arg0 > 0 && (arg0 as u256) * arg1 / 1000000000 >= arg2
    }

    fun present<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u128) : bool {
        if (arg1 == 0) {
            return false
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::get_order(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(arg0), arg1);
        0x1::option::is_some<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v0)
    }

    fun quote_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 < arg3
        };
        if (v0) {
            return 0
        };
        let v1 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        let v2 = if ((arg2 as u128) > 1000000) {
            1000000
        } else {
            (arg2 as u128)
        };
        let v3 = (((arg0 as u128) * v2 / 1000000) as u64);
        let v4 = if (v3 > v1) {
            v3
        } else {
            v1
        };
        let v5 = v4;
        if (v4 > arg0) {
            v5 = arg0;
        };
        if (v5 > arg4) {
            v5 = arg4;
        };
        v5 - v5 % arg3
    }

    fun room(arg0: u64, arg1: bool, arg2: u64, arg3: bool) : u64 {
        if (arg1 == arg3) {
            if (arg0 >= arg2) {
                0
            } else {
                arg2 - arg0
            }
        } else if (arg0 > 18446744073709551615 - arg2) {
            18446744073709551615
        } else {
            arg2 + arg0
        }
    }

    public fun s0<T0, T1>(arg0: A<T0, T1>) {
        0x2::transfer::share_object<A<T0, T1>>(arg0);
    }

    public fun u0<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultAdminCap<T1>, arg3: u64, arg4: u64, arg5: u64) {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1), 1);
        validate(arg3, arg4, arg5);
        assert!(arg3 <= arg0.hm && arg4 <= arg0.hi, 2);
        arg0.m = arg3;
        arg0.i = arg4;
        arg0.sf = arg5;
    }

    fun valid_time<T0, T1>(arg0: &A<T0, T1>, arg1: u64, arg2: u64) : bool {
        if (arg2 > arg1 && arg2 - arg1 > arg0.age) {
            return false
        };
        if (arg1 > arg2 && arg1 - arg2 > arg0.skew) {
            return false
        };
        true
    }

    fun validate(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0 && arg1 >= arg0, 2);
        assert!(arg2 > 0 && arg2 <= 10000, 2);
    }

    public fun z0<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultAdminCap<T1>, arg3: bool) {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1), 1);
        arg0.z = arg3;
    }

    // decompiled from Move bytecode v7
}

