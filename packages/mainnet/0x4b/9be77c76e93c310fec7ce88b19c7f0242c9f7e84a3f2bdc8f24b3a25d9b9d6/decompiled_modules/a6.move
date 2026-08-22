module 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::a6 {
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

    struct DepthBbo has copy, drop {
        desk: 0x2::object::ID,
        sequence: u64,
        requested_size: u64,
        raw_bid: u64,
        raw_ask: u64,
        depth_bid: u64,
        depth_ask: u64,
        bid_accumulated: u64,
        ask_accumulated: u64,
        bid_complete: bool,
        ask_complete: bool,
    }

    struct RebalanceSizing has copy, drop {
        desk: 0x2::object::ID,
        sequence: u64,
        position_size: u64,
        position_long: bool,
        target_side: u8,
        target_size: u64,
        position_limit: u64,
        error_bps: u64,
        inventory_above_target: bool,
        pressure_bps: u64,
        neutral_size: u64,
        bid_factor_bps: u64,
        ask_factor_bps: u64,
        bid_size: u64,
        ask_size: u64,
    }

    struct Unwind has copy, drop {
        desk: 0x2::object::ID,
        size_before: u64,
        was_long: bool,
        size_after: u64,
        bid_cancel_found: bool,
        ask_cancel_found: bool,
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

    public fun ap<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, arg15, arg16)
    }

    public fun apd<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, arg16, arg17)
    }

    public fun apdr<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: u8, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : u64 {
        validate_rebalance<T0, T1>(arg0, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, true, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26)
    }

    fun apply<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: u8, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg6), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg5), 1);
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::account_vault_id<T0, T1>(arg2) == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::clearing_house_id<T0, T1>(arg2) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg5), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg6);
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::account_num<T0, T1>(arg2) == v0, 1);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg27));
        if (arg9 <= arg0.n || arg10 <= arg0.ts) {
            emit<T0, T1>(arg0, arg9, arg10, 1, 0, arg11, 0, 0, 0, 0, false, false, 0, true);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg5);
            return 0
        };
        arg0.n = arg9;
        arg0.ts = arg10;
        let v1 = 0x2::clock::timestamp_ms(arg26);
        let v2 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), true));
        let v3 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), false));
        let v4 = v3 > 0 && v2 > v3;
        let v5 = if (v4) {
            ((((v3 as u128) + (v2 as u128)) / 2) as u64)
        } else {
            0
        };
        let (v6, v7, v8) = depth_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), false, v3, arg15);
        let (v9, v10, v11) = depth_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), true, v2, arg15);
        let v12 = if (v8) {
            if (v11) {
                if (v6 > 0) {
                    v9 > v6
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let (v13, v14) = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::ad(arg11, v5, arg0.drift);
        let v15 = valid_time<T0, T1>(arg0, arg10, v1);
        let v16 = if (0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::version(arg3) == arg4) {
            if (0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::status(arg3) == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::status_normal()) {
                if (!0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::is_paused<T1>(arg1)) {
                    if (0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::is_dex_allowed(arg3, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_aftermath_perp())) {
                        if (0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::is_dex_allowed<T1>(arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_aftermath_perp())) {
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
        let v17 = 0;
        let v18 = v17;
        if (v8) {
            v18 = v17 | 4096;
        };
        if (v11) {
            v18 = v18 | 8192;
        };
        let v19 = arg0.x.o != 0;
        let v20 = present<T1>(&arg5, arg0.x.o);
        if (arg0.b.o != 0 && !present<T1>(&arg5, arg0.b.o)) {
            clear<T0, T1>(arg0, true);
            v18 = v18 | 64;
        };
        if (v19 && !v20) {
            clear<T0, T1>(arg0, false);
            v18 = v18 | 128;
        };
        let (v21, v22) = base_size<T1>(&arg5, v0);
        let v23 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg5);
        let v24 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v23);
        let v25 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v23);
        let v26 = room(v21, v22, arg0.i, true);
        let v27 = room(v21, v22, arg0.i, false);
        let (v28, v29, v30, v31, v32) = if (arg16) {
            let (v33, v34, v35, v36, v37) = rebalance_factors(v21, v22, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
            (v35, v36, v37, v33, v34)
        } else {
            (0, 10000, 10000, 0, false)
        };
        let v38 = if (arg16) {
            scaled_quote_size(arg0.m, arg0.sf, arg14, v29, arg0.hm, v25, v26)
        } else {
            quote_size(arg0.m, arg0.sf, arg14, v25, v26)
        };
        let v39 = if (arg16) {
            scaled_quote_size(arg0.m, arg0.sf, arg14, v30, arg0.hm, v25, v27)
        } else {
            quote_size(arg0.m, arg0.sf, arg14, v25, v27)
        };
        if (arg16) {
            arg0.b.f = false;
            arg0.x.f = false;
        } else {
            let v40 = arg13 / 10;
            let v41 = if (arg12 == 2) {
                v40
            } else {
                0
            };
            let v42 = if (arg12 == 1) {
                v40
            } else {
                0
            };
            arg0.b.f = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m0::lx(arg0.b.f, v41, arg0.tox_in, arg0.tox_out);
            arg0.x.f = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m0::lx(arg0.x.f, v42, arg0.tox_in, arg0.tox_out);
        };
        if (arg0.b.f) {
            v18 = v18 | 256;
        };
        if (arg0.x.f) {
            v18 = v18 | 512;
        };
        let v43 = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::tg(arg11, arg12, arg13, false);
        let v44 = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::tg(arg11, arg12, arg13, true);
        let v45 = if (v43 > 0) {
            v43
        } else {
            v44
        };
        let v46 = if (v16) {
            if (v15) {
                if (v4) {
                    if (v12) {
                        if (v13) {
                            if (v45 > 0) {
                                if (v24 > 0) {
                                    v25 > 0
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
        let v47 = if (v46) {
            if (!arg0.b.f) {
                v38 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v48 = if (v47) {
            let (v49, _) = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::mkpd(true, v43, arg0.cost, v6, v9, v3, v2, arg0.off, v24);
            v49
        } else {
            0
        };
        let v51 = if (v46) {
            if (!arg0.x.f) {
                v39 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v52 = if (v51) {
            let (v53, _) = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::mkpd(false, v44, arg0.cost, v6, v9, v3, v2, arg0.off, v24);
            v53
        } else {
            0
        };
        let (v55, v56) = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m0::cx(v48, v52, v3, v2, v24, arg12);
        let v57 = v56;
        let v58 = v55;
        let v59 = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::rqd(arg0.b.o != 0, arg0.b.p, v55, true, econ_bound(v43, arg0.cost, true), arg0.improve, v24, arg0.b.e, v1, arg0.refresh);
        let v60 = 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::rqd(arg0.x.o != 0, arg0.x.p, v56, false, econ_bound(v44, arg0.cost, false), arg0.improve, v24, arg0.x.e, v1, arg0.refresh);
        if (arg0.b.o != 0 && (arg0.b.q > v26 || arg16 && arg0.b.q != v38)) {
            let v61 = if (v55 > 0 && v38 > 0) {
                0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_replace()
            } else {
                0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_cancel()
            };
            v59 = v61;
        };
        if (arg0.x.o != 0 && (arg0.x.q > v27 || arg16 && arg0.x.q != v39)) {
            let v62 = if (v56 > 0 && v39 > 0) {
                0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_replace()
            } else {
                0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_cancel()
            };
            v60 = v62;
        };
        let v63 = if (v59 == 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_replace()) {
            if (v55 > 0) {
                v38 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v64 = if (v60 == 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_replace()) {
            if (v56 > 0) {
                v39 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v63 || v64) {
            let v65 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T1>(&arg5, arg7, arg26);
            let v66 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v23);
            if (v63 && !order_value_ok(v38, v65, v66)) {
                v58 = 0;
                v18 = v18 | 1024;
                let v67 = if (arg0.b.o != 0) {
                    0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_cancel()
                } else {
                    0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_keep()
                };
                v59 = v67;
            };
            if (v64 && !order_value_ok(v39, v65, v66)) {
                v57 = 0;
                v18 = v18 | 2048;
                let v68 = if (arg0.x.o != 0) {
                    0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_cancel()
                } else {
                    0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_keep()
                };
                v60 = v68;
            };
        };
        let v69 = false;
        let v70 = false;
        if (v59 != 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_keep() && arg0.b.o != 0) {
            let v71 = &mut arg5;
            let (v72, v73) = cancel_one<T0, T1>(arg0, v71, arg6, true);
            if (v72) {
                v18 = v18 | 2;
            };
            v69 = v73;
        } else if (v59 == 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_keep() && arg0.b.o != 0) {
            v18 = v18 | 1;
        };
        if (v60 != 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_keep() && arg0.x.o != 0) {
            let v74 = &mut arg5;
            let (v75, v76) = cancel_one<T0, T1>(arg0, v74, arg6, false);
            if (v75) {
                v18 = v18 | 16;
            };
            v70 = v76;
        } else if (v60 == 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_keep() && arg0.x.o != 0) {
            v18 = v18 | 8;
        };
        let v77 = if (v59 == 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_replace()) {
            if (v58 > 0) {
                v38 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v78 = if (v60 == 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::m1::act_replace()) {
            if (v57 > 0) {
                v39 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v77 || v78) {
            let v79 = v1 + arg0.ttl;
            let v80 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg5, &arg0.k, arg6, arg7, arg8, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg26, arg27);
            if (v77) {
                let v81 = option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T1>(&mut v80, false, v38, v58, 2, 0x1::option::some<u64>(client_id(arg9, false)), false, 0x1::option::some<u64>(v79)));
                if (v81 != 0) {
                    let v82 = L{
                        o : v81,
                        p : v58,
                        q : v38,
                        e : v79,
                        f : arg0.b.f,
                    };
                    arg0.b = v82;
                    v18 = v18 | 4;
                };
            };
            if (v78) {
                let v83 = option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T1>(&mut v80, true, v39, v57, 2, 0x1::option::some<u64>(client_id(arg9, true)), false, 0x1::option::some<u64>(v79)));
                if (v83 != 0) {
                    let v84 = L{
                        o : v83,
                        p : v57,
                        q : v39,
                        e : v79,
                        f : arg0.x.f,
                    };
                    arg0.x = v84;
                    v18 = v18 | 32;
                };
            };
            let (v85, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v80, &arg0.k, arg6, false, false);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v85);
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg5);
        };
        let v87 = if (!v15) {
            2
        } else if (!v16) {
            3
        } else if (!v4) {
            4
        } else if (!v12) {
            8
        } else if (!v13) {
            5
        } else if (v38 == 0 && v39 == 0) {
            6
        } else {
            let v88 = if (v18 & (1024 | 2048) != 0) {
                if (v58 == 0) {
                    v57 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v88) {
                7
            } else {
                0
            }
        };
        let v89 = DepthBbo{
            desk            : 0x2::object::uid_to_inner(&arg0.id),
            sequence        : arg9,
            requested_size  : arg15,
            raw_bid         : v3,
            raw_ask         : v2,
            depth_bid       : v6,
            depth_ask       : v9,
            bid_accumulated : v7,
            ask_accumulated : v10,
            bid_complete    : v8,
            ask_complete    : v11,
        };
        0x2::event::emit<DepthBbo>(v89);
        if (arg16) {
            let v90 = RebalanceSizing{
                desk                   : 0x2::object::uid_to_inner(&arg0.id),
                sequence               : arg9,
                position_size          : v21,
                position_long          : v22,
                target_side            : arg17,
                target_size            : arg18,
                position_limit         : arg19,
                error_bps              : v31,
                inventory_above_target : v32,
                pressure_bps           : v28,
                neutral_size           : arg0.m,
                bid_factor_bps         : v29,
                ask_factor_bps         : v30,
                bid_size               : v38,
                ask_size               : v39,
            };
            0x2::event::emit<RebalanceSizing>(v90);
        };
        emit<T0, T1>(arg0, arg9, arg10, v87, v18, arg11, v3, v2, v14, v45, v69, v70, v21, v22);
        v18
    }

    fun base_size<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64) : (u64, bool) {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, arg1)) {
            return (0, true)
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, arg1);
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::abs_net_base(v0), 1000000000), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v0))
    }

    public fun c0<T0, T1>(arg0: &0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::D<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultAdminCap<T1>, arg3: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg4: u64, arg5: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : A<T0, T1> {
        create<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun c1<T0, T1, T2>(arg0: &0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::D<T2, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultAdminCap<T1>, arg3: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg4: u64, arg5: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : A<T0, T1> {
        create<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun ca<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg4), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg3), 1);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg6));
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

    fun clamp_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        }
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

    fun create<T0, T1, T2>(arg0: &0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::D<T2, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultAdminCap<T1>, arg3: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg4: u64, arg5: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : A<T0, T1> {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::assert_active(arg3, arg4);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_active_vault<T1>(arg1, arg3, arg4);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_admin<T1>(arg1, arg2);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::dex_adapter::assert_dex_allowed<T1>(arg1, arg3, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::dex_aftermath_perp());
        assert!(0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::vid<T2, T1>(arg0) == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::account_vault_id<T0, T1>(arg5) == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::clearing_house_id<T0, T1>(arg5) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg6), 1);
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::account_num<T0, T1>(arg5) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg7), 1);
        validate(arg9, arg10, arg11);
        assert!(arg9 <= 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 6), 2);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg6, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg7))) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg6, &arg8, arg7);
        };
        let v0 = if (0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 9) < 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 21)) {
            0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 9)
        } else {
            0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 21)
        };
        assert!(v0 > 0 && 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 4) > 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 5), 2);
        assert!(0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 3) < 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 2), 2);
        A<T0, T1>{
            id      : 0x2::object::new(arg12),
            v       : 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1),
            d       : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::did<T2, T1>(arg0),
            p       : 0x2::object::id<0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg5),
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
            cost    : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 19),
            ttl     : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 4),
            refresh : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 5),
            age     : v0,
            skew    : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 8),
            drift   : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 20),
            off     : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 22),
            improve : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 26),
            tox_in  : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 2),
            tox_out : 0x24f8b13c74bfc9fb5401777608e8b811224437623124723ee78a6e52400f9085::d0::pv<T2, T1>(arg0, 3),
            b       : empty_leg(),
            x       : empty_leg(),
            z       : false,
        }
    }

    fun cumulative_depth_price(arg0: &vector<u128>, arg1: &vector<u64>, arg2: bool, arg3: u64) : (u64, u64, bool) {
        if (arg3 == 0 || 0x1::vector::length<u128>(arg0) != 0x1::vector::length<u64>(arg1)) {
            return (0, 0, false)
        };
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u128>(arg0)) {
            let v2 = v1 + (*0x1::vector::borrow<u64>(arg1, v0) as u128);
            v1 = v2;
            if (v2 >= (arg3 as u128)) {
                let v3 = if (v2 > 18446744073709551615) {
                    18446744073709551615
                } else {
                    (v2 as u64)
                };
                return (order_price(*0x1::vector::borrow<u128>(arg0, v0), arg2), v3, true)
            };
            v0 = v0 + 1;
        };
        let v4 = if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        };
        (0, v4, false)
    }

    fun depth_price(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Orderbook, arg1: bool, arg2: u64, arg3: u64) : (u64, u64, bool) {
        if (arg3 == 0) {
            return (arg2, 0, arg2 > 0)
        };
        if (arg2 == 0) {
            return (0, 0, false)
        };
        let v0 = if (arg1) {
            18446744073709551615
        } else {
            0
        };
        let (v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::inspect_orders(arg0, arg1, arg2, v0, 50);
        let v3 = v2;
        let v4 = v1;
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v3)) {
            let (_, v8, _, _, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::as_parts(0x1::vector::borrow<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v3, v6));
            0x1::vector::push_back<u64>(&mut v5, v8);
            v6 = v6 + 1;
        };
        cumulative_depth_price(&v4, &v5, arg1, arg3)
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

    fun inventory_error(arg0: u64, arg1: bool, arg2: u8, arg3: u64) : (u128, bool) {
        if (arg2 == 0) {
            if (arg0 == 0) {
                return (0, false)
            };
            return ((arg0 as u128), arg1)
        };
        let v0 = arg2 == 1;
        if (arg0 == 0) {
            return ((arg3 as u128), !v0)
        };
        if (arg1 == v0) {
            if (arg0 == arg3) {
                return (0, false)
            };
            if (v0) {
                if (arg0 > arg3) {
                    (((arg0 - arg3) as u128), true)
                } else {
                    (((arg3 - arg0) as u128), false)
                }
            } else if (arg0 < arg3) {
                (((arg3 - arg0) as u128), true)
            } else {
                (((arg0 - arg3) as u128), false)
            }
        } else {
            ((arg0 as u128) + (arg3 as u128), arg1)
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

    fun order_price(arg0: u128, arg1: bool) : u64 {
        if (arg1) {
            ((arg0 >> 64) as u64)
        } else {
            18446744073709551615 - ((arg0 >> 64) as u64)
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

    fun rebalance_factors(arg0: u64, arg1: bool, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : (u64, bool, u64, u64, u64) {
        let (v0, v1) = inventory_error(arg0, arg1, arg2, arg3);
        let (v2, v3) = rebalance_pressure(v0, arg4, arg5, arg6, arg7);
        if (v3 == 0) {
            return (v2, v1, 0, 10000, 10000)
        };
        let v4 = (((arg8 as u128) * (v3 as u128) / 10000) as u64);
        let v5 = if (v4 > 18446744073709541615) {
            18446744073709551615
        } else {
            10000 + v4
        };
        let v6 = if (v4 >= 10000) {
            0
        } else {
            10000 - v4
        };
        let (v7, v8) = if (v1) {
            (clamp_factor(v5, arg9, arg10), clamp_factor(v6, arg9, arg10))
        } else {
            (clamp_factor(v6, arg9, arg10), clamp_factor(v5, arg9, arg10))
        };
        (v2, v1, v3, v8, v7)
    }

    fun rebalance_pressure(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let v0 = arg0 * 10000 / (arg1 as u128);
        let v1 = v0;
        if (v0 > 10000) {
            v1 = 10000;
        };
        let v2 = (v1 as u64);
        if (v2 <= arg2) {
            return (v2, 0)
        };
        let v3 = ((v2 - arg2) as u128) * 10000 / ((arg3 - arg2) as u128);
        let v4 = v3;
        if (v3 > 10000) {
            v4 = 10000;
        };
        if (v4 == 0) {
            return (v2, 0)
        };
        let v5 = (arg4 as u128);
        let v6 = (v4 + v5 - 1) / v5 * v5;
        let v7 = v6;
        if (v6 > 10000) {
            v7 = 10000;
        };
        (v2, (v7 as u64))
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

    fun scaled_quote_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = quote_size(arg0, arg1, arg2, arg5, 18446744073709551615);
        if (v0 == 0 || arg6 < arg5) {
            return 0
        };
        let v1 = (v0 as u128) * (arg3 as u128) / 10000;
        let v2 = if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        };
        let v3 = v2;
        if (v2 > arg4) {
            v3 = arg4;
        };
        if (v3 > arg6) {
            v3 = arg6;
        };
        v3 - v3 % arg5
    }

    public fun u0<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultAdminCap<T1>, arg3: u64, arg4: u64, arg5: u64) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        validate(arg3, arg4, arg5);
        assert!(arg3 <= arg0.hm && arg4 <= arg0.hi, 2);
        arg0.m = arg3;
        arg0.i = arg4;
        arg0.sf = arg5;
    }

    public fun u1<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultAdminCap<T1>, arg3: u64, arg4: u64, arg5: u64) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        validate(arg3, arg4, arg5);
        assert!(arg3 <= arg0.hm, 2);
        assert!((arg4 as u128) <= (arg0.hm as u128) * 2, 2);
        arg0.hi = arg4;
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

    fun validate_rebalance<T0, T1>(arg0: &A<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg1 <= 2, 2);
        assert!(arg1 == 0 == arg2 == 0, 2);
        assert!(arg3 > 0 && arg3 == arg0.i, 2);
        assert!(arg2 <= arg3, 2);
        assert!(arg4 < arg5 && arg5 <= 10000, 2);
        assert!(arg6 > 0 && arg6 <= 10000, 2);
        assert!(arg7 <= 10000, 2);
        assert!(arg8 > 0 && arg8 <= 10000, 2);
        assert!(arg9 >= 10000, 2);
        assert!(arg9 <= 20000, 2);
        assert!(((arg0.m as u128) * (arg9 as u128) + 10000 - 1) / 10000 <= (arg0.hm as u128), 2);
    }

    public fun xu<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg4), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg3), 1);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg8));
        let v0 = &mut arg3;
        let (_, v2) = cancel_one<T0, T1>(arg0, v0, arg4, true);
        let v3 = &mut arg3;
        let (_, v5) = cancel_one<T0, T1>(arg0, v3, arg4, false);
        let v6 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg4);
        let (v7, v8) = base_size<T1>(&arg3, v6);
        let v9 = if (v7 > 0) {
            let v10 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg3, &arg0.k, arg4, arg5, arg6, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg7, arg8);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_market_order<T1>(&mut v10, v8, v7, true);
            let (v11, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v10, &arg0.k, arg4, false, false);
            let v13 = v11;
            let (v14, _) = base_size<T1>(&v13, v6);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v13);
            v14
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg3);
            0
        };
        assert!(v9 == 0, 2);
        arg0.z = true;
        let v16 = Unwind{
            desk             : 0x2::object::id<A<T0, T1>>(arg0),
            size_before      : v7,
            was_long         : v8,
            size_after       : v9,
            bid_cancel_found : v2,
            ask_cancel_found : v5,
        };
        0x2::event::emit<Unwind>(v16);
        v7
    }

    public fun z0<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::Vault<T1>, arg2: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::VaultAdminCap<T1>, arg3: bool) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::vault::id<T1>(arg1), 1);
        arg0.z = arg3;
    }

    // decompiled from Move bytecode v7
}

