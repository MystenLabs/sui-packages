module 0x8ebf735f1ca8bbcb16a01adefa4ebc711d328bcf2e3c94c9eefab39ff73e5da2::quoter {
    struct Quoter<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        market: 0x2::object::ID,
        account_id: u64,
        seq: u64,
        bids: vector<u128>,
        asks: vector<u128>,
    }

    struct Created has copy, drop {
        quoter: 0x2::object::ID,
        owner: address,
        market: 0x2::object::ID,
        account_id: u64,
    }

    struct Requoted has copy, drop {
        quoter: 0x2::object::ID,
        market: 0x2::object::ID,
        account_id: u64,
        seq: u64,
        stale: bool,
        change_bid: bool,
        change_ask: bool,
        attempted_cancels: u64,
        successful_cancels: u64,
        bids: vector<u128>,
        asks: vector<u128>,
        clamped: u64,
        dropped: u64,
    }

    fun authorize<T0>(arg0: &Quoter<T0>, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64) : bool {
        assert!(arg0.owner == arg1, 1);
        assert!(arg0.market == arg2, 2);
        assert!(arg0.account_id == arg3, 3);
        arg4 > arg0.seq
    }

    public fun cancel_all<T0, T1>(arg0: &mut Quoter<T0>, arg1: u64, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg5: &0x2::tx_context::TxContext) {
        if (!authorize<T0>(arg0, 0x2::tx_context::sender(arg5), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg2), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg4), arg1)) {
            emit_result<T0>(arg0, arg1, true, true, true, 0, 0, 0, 0);
            return
        };
        arg0.seq = arg1;
        let (v0, v1) = cancel_tracked<T0, T1>(arg0, arg2, arg3, arg4, true, true);
        emit_result<T0>(arg0, arg1, false, true, true, v0, v1, 0, 0);
    }

    fun cancel_tracked<T0, T1>(arg0: &mut Quoter<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: bool, arg5: bool) : (u64, u64) {
        let v0 = vector[];
        if (arg4) {
            0x1::vector::append<u128>(&mut v0, arg0.bids);
            arg0.bids = vector[];
        };
        if (arg5) {
            0x1::vector::append<u128>(&mut v0, arg0.asks);
            arg0.asks = vector[];
        };
        let v1 = 0x1::vector::length<u128>(&v0);
        let v2 = 0;
        if (v1 > 0) {
            let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg1, arg2, arg3, &v0);
            0x1::vector::reverse<bool>(&mut v3);
            let v4 = 0;
            while (v4 < 0x1::vector::length<bool>(&v3)) {
                if (0x1::vector::pop_back<bool>(&mut v3)) {
                    v2 = v2 + 1;
                };
                v4 = v4 + 1;
            };
            0x1::vector::destroy_empty<bool>(v3);
        };
        (v1, v2)
    }

    public fun create<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 1, 3);
        let v0 = Quoter<T0>{
            id         : 0x2::object::new(arg2),
            owner      : 0x2::tx_context::sender(arg2),
            market     : arg0,
            account_id : arg1,
            seq        : 0,
            bids       : vector[],
            asks       : vector[],
        };
        let v1 = Created{
            quoter     : 0x2::object::id<Quoter<T0>>(&v0),
            owner      : v0.owner,
            market     : arg0,
            account_id : arg1,
        };
        0x2::event::emit<Created>(v1);
        0x2::transfer::share_object<Quoter<T0>>(v0);
    }

    fun emit_result<T0>(arg0: &Quoter<T0>, arg1: u64, arg2: bool, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = Requoted{
            quoter             : 0x2::object::id<Quoter<T0>>(arg0),
            market             : arg0.market,
            account_id         : arg0.account_id,
            seq                : arg1,
            stale              : arg2,
            change_bid         : arg3,
            change_ask         : arg4,
            attempted_cancels  : arg5,
            successful_cancels : arg6,
            bids               : arg0.bids,
            asks               : arg0.asks,
            clamped            : arg7,
            dropped            : arg8,
        };
        0x2::event::emit<Requoted>(v0);
    }

    fun fit(arg0: u64, arg1: bool, arg2: &0x1::option::Option<u64>, arg3: u64, arg4: u8) : 0x1::option::Option<u64> {
        assert!(arg4 == 0 || arg4 == 1, 8);
        if (0x1::option::is_none<u64>(arg2)) {
            return 0x1::option::some<u64>(arg0)
        };
        let v0 = *0x1::option::borrow<u64>(arg2);
        let v1 = arg1 && arg0 <= v0 || arg0 >= v0;
        if (!v1) {
            return 0x1::option::some<u64>(arg0)
        };
        if (arg4 == 1) {
            return 0x1::option::none<u64>()
        };
        if (arg1) {
            if (v0 > 9223372036854775807 || arg3 > 9223372036854775807 - v0) {
                return 0x1::option::none<u64>()
            };
            0x1::option::some<u64>(v0 + arg3)
        } else {
            if (v0 <= arg3) {
                return 0x1::option::none<u64>()
            };
            0x1::option::some<u64>(v0 - arg3)
        }
    }

    fun live_expiry(arg0: 0x1::option::Option<u64>, arg1: u64) {
        assert!(0x1::option::is_some<u64>(&arg0), 5);
        let v0 = *0x1::option::borrow<u64>(&arg0);
        assert!(v0 > arg1 && v0 - arg1 <= 120000, 5);
    }

    public fun requote<T0, T1>(arg0: &mut Quoter<T0>, arg1: u64, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: bool, arg9: bool, arg10: vector<u64>, arg11: vector<u64>, arg12: bool, arg13: vector<u64>, arg14: vector<u64>, arg15: bool, arg16: 0x1::option::Option<u64>, arg17: u8, arg18: bool, arg19: 0x1::option::Option<u256>, arg20: u64, arg21: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        if (!authorize<T0>(arg0, 0x2::tx_context::sender(arg21), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(&arg2), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg4), arg1)) {
            emit_result<T0>(arg0, arg1, true, arg8, arg9, 0, 0, 0, 0);
            return arg2
        };
        assert!(arg8 || arg9, 9);
        assert!(arg17 == 0 || arg17 == 1, 8);
        shape(&arg10, &arg11, arg8);
        shape(&arg13, &arg14, arg9);
        let v0 = !0x1::vector::is_empty<u64>(&arg10) || !0x1::vector::is_empty<u64>(&arg13);
        setup_shape(arg18, &arg19, arg20, v0);
        if (v0) {
            live_expiry(arg16, 0x2::clock::timestamp_ms(arg7));
        };
        if (!0x1::vector::is_empty<u64>(&arg10) && !0x1::vector::is_empty<u64>(&arg13)) {
            assert!(*0x1::vector::borrow<u64>(&arg10, 0) < *0x1::vector::borrow<u64>(&arg13, 0), 6);
        };
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg2);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v1);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v1);
        if (!0x1::vector::is_empty<u64>(&arg10)) {
            validate_order(*0x1::vector::borrow<u64>(&arg10, 0), *0x1::vector::borrow<u64>(&arg11, 0), v2, v3);
        };
        if (!0x1::vector::is_empty<u64>(&arg13)) {
            validate_order(*0x1::vector::borrow<u64>(&arg13, 0), *0x1::vector::borrow<u64>(&arg14, 0), v2, v3);
        };
        arg0.seq = arg1;
        if (arg18) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, T1>(&mut arg2, arg3, arg4);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, T1>(&mut arg2, arg3, arg4, 0x1::option::destroy_some<u256>(arg19));
        };
        if (arg20 > 0) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, T1>(&mut arg2, arg3, arg4, arg20);
        };
        let v4 = &mut arg2;
        let (v5, v6) = cancel_tracked<T0, T1>(arg0, v4, arg3, arg4, arg8, arg9);
        let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(&arg2, true);
        let v8 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(&arg2, false);
        let v9 = if (0x1::vector::is_empty<u64>(&arg10)) {
            0x1::option::none<u64>()
        } else {
            fit(*0x1::vector::borrow<u64>(&arg10, 0), false, &v7, v2, arg17)
        };
        let v10 = v9;
        let v11 = if (0x1::vector::is_empty<u64>(&arg13)) {
            0x1::option::none<u64>()
        } else {
            fit(*0x1::vector::borrow<u64>(&arg13, 0), true, &v8, v2, arg17)
        };
        let v12 = v11;
        let v13 = if (0x1::option::is_some<u64>(&v10) && *0x1::option::borrow<u64>(&v10) != *0x1::vector::borrow<u64>(&arg10, 0)) {
            1
        } else {
            0
        };
        let v14 = if (0x1::option::is_some<u64>(&v12) && *0x1::option::borrow<u64>(&v12) != *0x1::vector::borrow<u64>(&arg13, 0)) {
            1
        } else {
            0
        };
        let v15 = if (!0x1::vector::is_empty<u64>(&arg10) && 0x1::option::is_none<u64>(&v10)) {
            1
        } else {
            0
        };
        let v16 = if (!0x1::vector::is_empty<u64>(&arg13) && 0x1::option::is_none<u64>(&v12)) {
            1
        } else {
            0
        };
        let v17 = if (0x1::option::is_none<u64>(&v10) && 0x1::option::is_none<u64>(&v12)) {
            arg2
        } else {
            let v18 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, T1>(arg2, arg3, arg4, arg5, arg6, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg7, arg21);
            if (0x1::option::is_some<u64>(&v10)) {
                let v19 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(&mut v18, false, *0x1::vector::borrow<u64>(&arg11, 0), *0x1::option::borrow<u64>(&v10), 2, 0x1::option::none<u64>(), arg12, arg16);
                if (0x1::option::is_some<u128>(&v19)) {
                    0x1::vector::push_back<u128>(&mut arg0.bids, 0x1::option::destroy_some<u128>(v19));
                };
            };
            if (0x1::option::is_some<u64>(&v12)) {
                let v20 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(&mut v18, true, *0x1::vector::borrow<u64>(&arg14, 0), *0x1::option::borrow<u64>(&v12), 2, 0x1::option::none<u64>(), arg15, arg16);
                if (0x1::option::is_some<u128>(&v20)) {
                    0x1::vector::push_back<u128>(&mut arg0.asks, 0x1::option::destroy_some<u128>(v20));
                };
            };
            let (v21, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, T1>(v18, arg3, arg4, true, false);
            v21
        };
        emit_result<T0>(arg0, arg1, false, arg8, arg9, v5, v6, v13 + v14, v15 + v16);
        v17
    }

    fun setup_shape(arg0: bool, arg1: &0x1::option::Option<u256>, arg2: u64, arg3: bool) {
        assert!(arg0 == 0x1::option::is_some<u256>(arg1), 10);
        if (0x1::option::is_some<u256>(arg1)) {
            assert!(*0x1::option::borrow<u256>(arg1) > 0 && *0x1::option::borrow<u256>(arg1) <= 1000000000000000000, 10);
        };
        assert!(arg3 || !arg0 && arg2 == 0, 10);
    }

    fun shape(arg0: &vector<u64>, arg1: &vector<u64>, arg2: bool) {
        assert!(0x1::vector::length<u64>(arg0) == 0x1::vector::length<u64>(arg1) && 0x1::vector::length<u64>(arg0) <= 1, 4);
        assert!(arg2 || 0x1::vector::is_empty<u64>(arg0), 4);
    }

    fun validate_order(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg2 > 0) {
            if (arg0 > 0) {
                if (arg0 <= 9223372036854775807) {
                    arg0 % arg2 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let v1 = if (arg3 > 0) {
            if (arg1 > 0) {
                arg1 % arg3 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 7);
    }

    // decompiled from Move bytecode v7
}

