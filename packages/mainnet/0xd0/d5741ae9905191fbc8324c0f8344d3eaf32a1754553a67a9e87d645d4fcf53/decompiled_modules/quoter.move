module 0xd0d5741ae9905191fbc8324c0f8344d3eaf32a1754553a67a9e87d645d4fcf53::quoter {
    struct Quoter<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        market: 0x2::object::ID,
        account_id: u64,
        seq: u64,
        bids: vector<u128>,
        asks: vector<u128>,
    }

    struct QuoterCreated has copy, drop {
        quoter: 0x2::object::ID,
        market: 0x2::object::ID,
        account_id: u64,
        owner: address,
    }

    struct Requoted has copy, drop {
        quoter: 0x2::object::ID,
        market: 0x2::object::ID,
        seq: u64,
        stale: bool,
        cancelled: u64,
        bids: u64,
        asks: u64,
        clamped: u64,
        dropped: u64,
    }

    public fun account_id<T0>(arg0: &Quoter<T0>) : u64 {
        arg0.account_id
    }

    public fun market<T0>(arg0: &Quoter<T0>) : 0x2::object::ID {
        arg0.market
    }

    public fun asks<T0>(arg0: &Quoter<T0>) : vector<u128> {
        arg0.asks
    }

    public fun bids<T0>(arg0: &Quoter<T0>) : vector<u128> {
        arg0.bids
    }

    public fun cancel_all<T0, T1>(arg0: &mut Quoter<T0>, arg1: u64, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg2) == arg0.market, 2);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg4) == arg0.account_id, 3);
        if (arg1 <= arg0.seq) {
            0x2::event::emit<Requoted>(stale_event(0x2::object::id<Quoter<T0>>(arg0), arg0.market, arg1));
            return
        };
        arg0.seq = arg1;
        let v0 = arg0.bids;
        0x1::vector::append<u128>(&mut v0, arg0.asks);
        arg0.bids = vector[];
        arg0.asks = vector[];
        let v1 = 0x1::vector::length<u128>(&v0);
        if (v1 > 0) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg2, arg3, arg4, &v0);
        };
        let v2 = Requoted{
            quoter    : 0x2::object::id<Quoter<T0>>(arg0),
            market    : arg0.market,
            seq       : arg1,
            stale     : false,
            cancelled : v1,
            bids      : 0,
            asks      : 0,
            clamped   : 0,
            dropped   : 0,
        };
        0x2::event::emit<Requoted>(v2);
    }

    public fun create<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Quoter<T0>{
            id         : 0x2::object::new(arg2),
            owner      : 0x2::tx_context::sender(arg2),
            market     : arg0,
            account_id : arg1,
            seq        : 0,
            bids       : vector[],
            asks       : vector[],
        };
        let v1 = QuoterCreated{
            quoter     : 0x2::object::id<Quoter<T0>>(&v0),
            market     : arg0,
            account_id : arg1,
            owner      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<QuoterCreated>(v1);
        0x2::transfer::share_object<Quoter<T0>>(v0);
    }

    public fun cross_clamp() : u8 {
        0
    }

    public fun cross_skip() : u8 {
        1
    }

    fun fit(arg0: u64, arg1: bool, arg2: &0x1::option::Option<u64>, arg3: u64, arg4: u8) : (bool, u64, bool) {
        if (0x1::option::is_none<u64>(arg2)) {
            return (arg0 > 0, arg0, false)
        };
        let v0 = *0x1::option::borrow<u64>(arg2);
        let v1 = arg1 && arg0 <= v0 || arg0 >= v0;
        if (!v1) {
            return (arg0 > 0, arg0, false)
        };
        if (arg4 != 0) {
            return (false, arg0, false)
        };
        if (arg1) {
            if (v0 > 18446744073709551615 - arg3) {
                return (false, arg0, false)
            };
            (true, v0 + arg3, true)
        } else {
            if (v0 <= arg3) {
                return (false, arg0, false)
            };
            (true, v0 - arg3, true)
        }
    }

    public fun owner<T0>(arg0: &Quoter<T0>) : address {
        arg0.owner
    }

    public fun requote<T0, T1>(arg0: &mut Quoter<T0>, arg1: u64, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: bool, arg9: bool, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: u64, arg15: 0x1::option::Option<u64>, arg16: u8, arg17: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg17) == arg0.owner, 1);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(&arg2) == arg0.market, 2);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg4) == arg0.account_id, 3);
        assert!(0x1::vector::length<u64>(&arg10) == 0x1::vector::length<u64>(&arg11), 4);
        assert!(0x1::vector::length<u64>(&arg12) == 0x1::vector::length<u64>(&arg13), 4);
        if (arg1 <= arg0.seq) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg2);
            0x2::event::emit<Requoted>(stale_event(0x2::object::id<Quoter<T0>>(arg0), arg0.market, arg1));
            return
        };
        arg0.seq = arg1;
        let v0 = vector[];
        if (arg8) {
            0x1::vector::append<u128>(&mut v0, arg0.bids);
            arg0.bids = vector[];
        };
        if (arg9) {
            0x1::vector::append<u128>(&mut v0, arg0.asks);
            arg0.asks = vector[];
        };
        let v1 = 0x1::vector::length<u128>(&v0);
        if (v1 > 0) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(&mut arg2, arg3, arg4, &v0);
        };
        let v2 = if (arg8) {
            0x1::vector::length<u64>(&arg10)
        } else {
            0
        };
        let v3 = if (arg9) {
            0x1::vector::length<u64>(&arg12)
        } else {
            0
        };
        if (v2 + v3 == 0) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg2);
            let v4 = Requoted{
                quoter    : 0x2::object::id<Quoter<T0>>(arg0),
                market    : arg0.market,
                seq       : arg1,
                stale     : false,
                cancelled : v1,
                bids      : 0,
                asks      : 0,
                clamped   : 0,
                dropped   : 0,
            };
            0x2::event::emit<Requoted>(v4);
            return
        };
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg2));
        let v6 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(&arg2, true);
        let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(&arg2, false);
        let v8 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, T1>(arg2, arg3, arg4, arg5, arg6, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg7, arg17);
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        let v13 = 0;
        while (v13 < v2) {
            let (v14, v15, v16) = fit(*0x1::vector::borrow<u64>(&arg10, v13), false, &v6, v5, arg16);
            if (v16) {
                v11 = v11 + 1;
            };
            if (v14) {
                let v17 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(&mut v8, false, *0x1::vector::borrow<u64>(&arg11, v13), v15, arg14, 0x1::option::none<u64>(), false, arg15);
                if (0x1::option::is_some<u128>(&v17)) {
                    0x1::vector::push_back<u128>(&mut arg0.bids, 0x1::option::destroy_some<u128>(v17));
                    v9 = v9 + 1;
                };
                if (0x1::option::is_none<u64>(&v7) || v15 > *0x1::option::borrow<u64>(&v7)) {
                    v7 = 0x1::option::some<u64>(v15);
                };
            } else {
                v12 = v12 + 1;
            };
            v13 = v13 + 1;
        };
        let v18 = 0;
        while (v18 < v3) {
            let (v19, v20, v21) = fit(*0x1::vector::borrow<u64>(&arg12, v18), true, &v7, v5, arg16);
            if (v21) {
                v11 = v11 + 1;
            };
            if (v19) {
                let v22 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(&mut v8, true, *0x1::vector::borrow<u64>(&arg13, v18), v20, arg14, 0x1::option::none<u64>(), false, arg15);
                if (0x1::option::is_some<u128>(&v22)) {
                    0x1::vector::push_back<u128>(&mut arg0.asks, 0x1::option::destroy_some<u128>(v22));
                    v10 = v10 + 1;
                };
            } else {
                v12 = v12 + 1;
            };
            v18 = v18 + 1;
        };
        let (v23, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, T1>(v8, arg3, arg4, true, false);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(v23);
        let v25 = Requoted{
            quoter    : 0x2::object::id<Quoter<T0>>(arg0),
            market    : arg0.market,
            seq       : arg1,
            stale     : false,
            cancelled : v1,
            bids      : v9,
            asks      : v10,
            clamped   : v11,
            dropped   : v12,
        };
        0x2::event::emit<Requoted>(v25);
    }

    public fun seq<T0>(arg0: &Quoter<T0>) : u64 {
        arg0.seq
    }

    fun stale_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) : Requoted {
        Requoted{
            quoter    : arg0,
            market    : arg1,
            seq       : arg2,
            stale     : true,
            cancelled : 0,
            bids      : 0,
            asks      : 0,
            clamped   : 0,
            dropped   : 0,
        }
    }

    // decompiled from Move bytecode v7
}

