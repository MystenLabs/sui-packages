module 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::tide_v2 {
    struct Layer has copy, drop {
        price: u128,
        depth: u64,
        filled: u64,
    }

    struct TimePoint has copy, drop {
        offset_ms: u32,
        slippage_bps: u16,
    }

    struct FillPoint has copy, drop {
        amount_base: u64,
        start_ms: u32,
        slippage_bps: u16,
    }

    struct Curve has copy, drop {
        time_points: vector<TimePoint>,
        fill_points: vector<FillPoint>,
        max_total_slippage_bps: u16,
    }

    struct Entry has copy, drop {
        quote_hash: vector<u8>,
        layers: vector<Layer>,
        slippage: Curve,
        signed_at_ms: u64,
        sig_expiry_ms: u64,
        fill_or_kill: bool,
        min_fill: u64,
        signer_policy_version: u64,
        inventory_version: u64,
        cumulative_filled_in: u64,
        total_depth: u64,
        cancelled: bool,
    }

    struct Context has copy, drop {
        a2b: bool,
        now_ms: u64,
        max_slippage_bps: u64,
        signer_policy_version: u64,
        inventory_version: u64,
    }

    fun active_bps(arg0: &FillPoint, arg1: u64) : u64 {
        if (arg1 >= (arg0.start_ms as u64)) {
            (arg0.slippage_bps as u64)
        } else {
            0
        }
    }

    fun applied_bps(arg0: &Curve, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg1 as u256) + (arg2 as u256);
        let v1 = v0;
        if (v0 > (arg0.max_total_slippage_bps as u256)) {
            v1 = (arg0.max_total_slippage_bps as u256);
        };
        if (v1 > (arg3 as u256)) {
            v1 = (arg3 as u256);
        };
        (v1 as u64)
    }

    public fun check<T0, T1>(arg0: &mut 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::Probe, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: &0x2::clock::Clock) {
        if (!0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::checking(arg0)) {
            return
        };
        let (v0, v1) = quote<T0, T1>(arg1, arg2, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::check_amount(arg0), arg4, arg5, arg6);
        0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::check_step(arg0, v0, v1, arg3);
    }

    fun chunk_amount(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg0 >= arg1) {
            arg1
        } else {
            arg0
        }
    }

    fun decode_entry(arg0: vector<u8>) : Entry {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x1::vector::empty<Layer>();
        let v2 = 0;
        while (v2 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v3 = Layer{
                price  : 0x2::bcs::peel_u128(&mut v0),
                depth  : 0x2::bcs::peel_u64(&mut v0),
                filled : 0x2::bcs::peel_u64(&mut v0),
            };
            0x1::vector::push_back<Layer>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = 0x1::vector::empty<TimePoint>();
        v2 = 0;
        while (v2 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v5 = TimePoint{
                offset_ms    : 0x2::bcs::peel_u32(&mut v0),
                slippage_bps : 0x2::bcs::peel_u16(&mut v0),
            };
            0x1::vector::push_back<TimePoint>(&mut v4, v5);
            v2 = v2 + 1;
        };
        let v6 = 0x1::vector::empty<FillPoint>();
        v2 = 0;
        while (v2 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v7 = FillPoint{
                amount_base  : 0x2::bcs::peel_u64(&mut v0),
                start_ms     : 0x2::bcs::peel_u32(&mut v0),
                slippage_bps : 0x2::bcs::peel_u16(&mut v0),
            };
            0x1::vector::push_back<FillPoint>(&mut v6, v7);
            v2 = v2 + 1;
        };
        let v8 = Curve{
            time_points            : v4,
            fill_points            : v6,
            max_total_slippage_bps : 0x2::bcs::peel_u16(&mut v0),
        };
        Entry{
            quote_hash            : 0x2::bcs::peel_vec_u8(&mut v0),
            layers                : v1,
            slippage              : v8,
            signed_at_ms          : 0x2::bcs::peel_u64(&mut v0),
            sig_expiry_ms         : 0x2::bcs::peel_u64(&mut v0),
            fill_or_kill          : 0x2::bcs::peel_bool(&mut v0),
            min_fill              : 0x2::bcs::peel_u64(&mut v0),
            signer_policy_version : 0x2::bcs::peel_u64(&mut v0),
            inventory_version     : 0x2::bcs::peel_u64(&mut v0),
            cumulative_filled_in  : 0x2::bcs::peel_u64(&mut v0),
            total_depth           : 0x2::bcs::peel_u64(&mut v0),
            cancelled             : 0x2::bcs::peel_bool(&mut v0),
        }
    }

    fun default_chunk(arg0: &Entry, arg1: &Context) : u64 {
        if (arg0.cancelled || arg0.cumulative_filled_in >= arg0.total_depth) {
            return 0
        };
        let v0 = &arg0.slippage.fill_points;
        let v1 = if (arg0.fill_or_kill) {
            true
        } else if (arg0.min_fill > 0) {
            true
        } else {
            0x1::vector::length<FillPoint>(v0) < 2
        };
        if (v1) {
            return 0
        };
        let v2 = elapsed(arg0, arg1.now_ms);
        let v3 = time_bps(&arg0.slippage, v2);
        if (v3 > 18446744073709551615) {
            return 0
        };
        let v4 = applied_bps(&arg0.slippage, (v3 as u64), active_bps(0x1::vector::borrow<FillPoint>(v0, 0), v2), arg1.max_slippage_bps);
        let v5 = false;
        let v6 = 1;
        while (v6 < 0x1::vector::length<FillPoint>(v0)) {
            if (applied_bps(&arg0.slippage, (v3 as u64), active_bps(0x1::vector::borrow<FillPoint>(v0, v6), v2), arg1.max_slippage_bps) > v4) {
                v5 = true;
                break
            };
            v6 = v6 + 1;
        };
        if (!v5) {
            return 0
        };
        if (arg1.a2b) {
            return 0x1::vector::borrow<FillPoint>(v0, 0).amount_base
        };
        v6 = 0;
        while (v6 < 0x1::vector::length<Layer>(&arg0.layers)) {
            let v7 = 0x1::vector::borrow<Layer>(&arg0.layers, v6);
            if (v7.filled < v7.depth) {
                let v8 = (0x1::vector::borrow<FillPoint>(v0, 0).amount_base as u256) * (effective_price(v7.price, false, v4) as u256) / 1000000000000000000;
                let v9 = if (v8 > 18446744073709551615) {
                    18446744073709551615
                } else {
                    v8
                };
                return (v9 as u64)
            };
            v6 = v6 + 1;
        };
        0
    }

    fun effective_price(arg0: u128, arg1: bool, arg2: u64) : u128 {
        if (arg1 && (arg2 as u256) > 10000) {
            return 0
        };
        let v0 = if (arg1) {
            10000 - (arg2 as u256)
        } else {
            10000 + (arg2 as u256)
        };
        let v1 = (arg0 as u256) * v0;
        if (v1 > 340282366920938463463374607431768211455) {
            return 0
        };
        ((v1 / 10000) as u128)
    }

    fun elapsed(arg0: &Entry, arg1: u64) : u64 {
        if (arg1 >= arg0.signed_at_ms) {
            arg1 - arg0.signed_at_ms
        } else {
            0
        }
    }

    fun fee_bound<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker) : u16 {
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_fee_override<T0, T1>(arg0);
        if (0x1::option::is_some<u16>(v0)) {
            return *0x1::option::borrow<u16>(v0)
        };
        let v1 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::fee_override(arg1);
        if (0x1::option::is_some<u16>(v1)) {
            return *0x1::option::borrow<u16>(v1)
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::fee::hard_max_fee_bps()
    }

    fun fill_band(arg0: &Curve, arg1: u64, arg2: u64) : (u64, bool, u64) {
        let v0 = 0x1::vector::length<FillPoint>(&arg0.fill_points);
        if (v0 == 0) {
            return (0, false, 0)
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<FillPoint>(&arg0.fill_points, v1);
            if (arg2 < v2.amount_base) {
                return (active_bps(v2, arg1), true, v2.amount_base - arg2)
            };
            v1 = v1 + 1;
        };
        (active_bps(0x1::vector::borrow<FillPoint>(&arg0.fill_points, v0 - 1), arg1), false, 0)
    }

    public fun fold_live<T0, T1>(arg0: &mut 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::Probe, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg2: bool, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &0x2::clock::Clock) {
        let (v0, v1) = quote_live<T0, T1>(arg1, arg2, 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::reference_input(arg0), arg3, arg4, arg5, true);
        if (v0 == 0 || v1 == 0) {
            0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::fold_closed(arg0);
            return
        };
        0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
    }

    fun live_chunk<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg1: bool, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0x2::clock::Clock) : u64 {
        let v0 = if (arg1) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_bid<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_ask<T0, T1>(arg0)
        };
        if (0x1::option::is_none<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(v0)) {
            return 0
        };
        let v1 = decode_entry(0x2::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(v0)));
        let v2 = Context{
            a2b                   : arg1,
            now_ms                : 0x2::clock::timestamp_ms(arg3),
            max_slippage_bps      : max_slippage(arg2),
            signer_policy_version : v1.signer_policy_version,
            inventory_version     : v1.inventory_version,
        };
        default_chunk(&v1, &v2)
    }

    fun max_slippage(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig) : u64 {
        let v0 = 0x2::bcs::new(0x2::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::OrderBookV2Params>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::params(arg0)));
        (0x2::bcs::peel_u16(&mut v0) as u64)
    }

    public fun quote<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &0x2::clock::Clock) : (u64, u64) {
        quote_live<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, false)
    }

    fun quote_chunks(arg0: Entry, arg1: &Context, arg2: u64, arg3: u64, arg4: u16, arg5: u64) : (bool, u64, u64) {
        let v0 = 0;
        let v1 = arg2;
        while (v1 > 0) {
            let v2 = &mut arg0;
            let (v3, v4, v5) = walk_one(v2, arg1, chunk_amount(arg5, v1));
            if (!v3 || v5 > arg3) {
                return (false, 0, 0)
            };
            arg3 = arg3 - v5;
            let v6 = v5 - (((v5 as u256) * (arg4 as u256) / 10000) as u64);
            if ((v0 as u256) + (v6 as u256) > 18446744073709551615) {
                return (false, 0, 0)
            };
            v0 = v0 + v6;
            v1 = v1 - v4;
            if (v4 == 0) {
                break
            };
        };
        (true, arg2 - v1, v0)
    }

    fun quote_live<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &0x2::clock::Clock, arg6: bool) : (u64, u64) {
        let v0 = if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_paused<T0, T1>(arg0)) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::paused(arg3)) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::paused(arg4)) {
            true
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_rebalance_pending<T0, T1>(arg0)
        };
        if (v0) {
            return (0, 0)
        };
        let v1 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_mm_id<T0, T1>(arg0);
        if (v1 != 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg4)) {
            return (0, 0)
        };
        let v2 = if (arg1) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_bid<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_ask<T0, T1>(arg0)
        };
        if (0x1::option::is_none<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(v2)) {
            return (0, 0)
        };
        let v3 = decode_entry(0x2::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(v2)));
        let v4 = Context{
            a2b                   : arg1,
            now_ms                : 0x2::clock::timestamp_ms(arg5),
            max_slippage_bps      : max_slippage(arg3),
            signer_policy_version : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::signer_policy_version(arg3, v1),
            inventory_version     : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_inventory_version<T0, T1>(arg0),
        };
        let v5 = if (arg1) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_quote_value<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_base_value<T0, T1>(arg0)
        };
        let (v6, v7, v8) = if (arg6) {
            quote_reference(v3, &v4, arg2, v5, fee_bound<T0, T1>(arg0, arg4), default_chunk(&v3, &v4))
        } else {
            quote_chunks(v3, &v4, arg2, v5, fee_bound<T0, T1>(arg0, arg4), default_chunk(&v3, &v4))
        };
        if (v6) {
            (v7, v8)
        } else {
            (0, 0)
        }
    }

    fun quote_reference(arg0: Entry, arg1: &Context, arg2: u64, arg3: u64, arg4: u16, arg5: u64) : (bool, u64, u64) {
        while (arg2 > 0) {
            let (v0, v1, v2) = quote_chunks(arg0, arg1, arg2, arg3, arg4, arg5);
            if (v0) {
                return (v0, v1, v2)
            };
            if (arg0.fill_or_kill || arg2 <= arg0.min_fill) {
                break
            };
            arg2 = arg2 / 2;
            if (arg2 < arg0.min_fill) {
                arg2 = arg0.min_fill;
            };
        };
        (false, 0, 0)
    }

    public fun swap_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg4) == 0) {
            return (0x2::coin::zero<T1>(arg6), arg4)
        };
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::balance::zero<T1>();
        while (0x2::balance::value<T0>(&v0) > 0) {
            let v2 = chunk_amount(live_chunk<T0, T1>(arg3, true, arg1, arg5), 0x2::balance::value<T0>(&v0));
            let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", v2), 0x2::balance::split<T0>(&mut v0, v2), arg5, arg6);
            let v5 = v4;
            0x2::balance::join<T1>(&mut v1, v3);
            0x2::balance::join<T0>(&mut v0, v5);
            if (0x2::balance::value<T0>(&v5) == v2) {
                break
            };
        };
        (0x2::coin::from_balance<T1>(v1, arg6), 0x2::coin::from_balance<T0>(v0, arg6))
    }

    public fun swap_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T1>(&arg4) == 0) {
            return (0x2::coin::zero<T0>(arg6), arg4)
        };
        let v0 = 0x2::coin::into_balance<T1>(arg4);
        let v1 = 0x2::balance::zero<T0>();
        while (0x2::balance::value<T1>(&v0) > 0) {
            let v2 = chunk_amount(live_chunk<T0, T1>(arg3, false, arg1, arg5), 0x2::balance::value<T1>(&v0));
            let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", v2), 0x2::balance::split<T1>(&mut v0, v2), arg5, arg6);
            let v5 = v4;
            0x2::balance::join<T0>(&mut v1, v3);
            0x2::balance::join<T1>(&mut v0, v5);
            if (0x2::balance::value<T1>(&v5) == v2) {
                break
            };
        };
        (0x2::coin::from_balance<T0>(v1, arg6), 0x2::coin::from_balance<T1>(v0, arg6))
    }

    fun time_bps(arg0: &Curve, arg1: u64) : u256 {
        if (arg1 == 0 || 0x1::vector::is_empty<TimePoint>(&arg0.time_points)) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<TimePoint>(&arg0.time_points)) {
            let v5 = 0x1::vector::borrow<TimePoint>(&arg0.time_points, v4);
            let v6 = (v5.offset_ms as u64);
            if (arg1 <= v6) {
                return (v1 as u256) + ((arg1 - v0) as u256) * (((v5.slippage_bps as u64) - v1) as u256) / ((v6 - v0) as u256)
            };
            v2 = (v5.slippage_bps as u64);
            v3 = v6;
            v4 = v4 + 1;
        };
        (v2 as u256) + ((arg1 - v3) as u256) * ((v2 - 0) as u256) / ((v3 - 0) as u256)
    }

    fun walk_one(arg0: &mut Entry, arg1: &Context, arg2: u64) : (bool, u64, u64) {
        if (arg0.cancelled || arg0.cumulative_filled_in >= arg0.total_depth) {
            return (true, 0, 0)
        };
        let v0 = if (arg0.sig_expiry_ms <= arg1.now_ms) {
            true
        } else if (arg0.signer_policy_version != arg1.signer_policy_version) {
            true
        } else {
            arg0.inventory_version != arg1.inventory_version
        };
        if (v0) {
            return (false, 0, 0)
        };
        let v1 = elapsed(arg0, arg1.now_ms);
        let v2 = time_bps(&arg0.slippage, v1);
        if (v2 > 18446744073709551615) {
            return (false, 0, 0)
        };
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Layer>(&arg0.layers) && arg2 > 0) {
            let v6 = 0x1::vector::borrow<Layer>(&arg0.layers, v5);
            let v7 = v6.depth - v6.filled;
            if (v7 == 0) {
                v5 = v5 + 1;
                continue
            };
            let (v8, v9, v10) = fill_band(&arg0.slippage, v1, v4);
            let v11 = if (v9 && v10 < v7) {
                v10
            } else {
                v7
            };
            let v12 = effective_price(v6.price, arg1.a2b, applied_bps(&arg0.slippage, (v2 as u64), v8, arg1.max_slippage_bps));
            if (v12 == 0) {
                return (false, 0, 0)
            };
            let (v13, v14) = if (arg1.a2b) {
                let v15 = if (arg2 < v11) {
                    arg2
                } else {
                    v11
                };
                (v15, (v15 as u256) * (v12 as u256) / 1000000000000000000)
            } else {
                let v16 = (arg2 as u256) * 1000000000000000000 / (v12 as u256);
                let v17 = if (v16 > 18446744073709551615) {
                    18446744073709551615
                } else {
                    v16
                };
                let v18 = (v17 as u64);
                if (v18 < v11) {
                    (v18, (arg2 as u256))
                } else {
                    (v11, (v11 as u256) * (v12 as u256) / 1000000000000000000)
                }
            };
            if (v14 > 18446744073709551615 || (v3 as u256) + v14 > 18446744073709551615) {
                return (false, 0, 0)
            };
            if (v13 == 0) {
                break
            };
            let v19 = 0x1::vector::borrow_mut<Layer>(&mut arg0.layers, v5);
            v19.filled = v19.filled + v13;
            v4 = v4 + v13;
            v3 = v3 + (v14 as u64);
            let v20 = if (arg1.a2b) {
                v13
            } else {
                (v14 as u64)
            };
            arg2 = arg2 - v20;
            if (v19.filled >= v19.depth) {
                v5 = v5 + 1;
            };
        };
        if ((arg0.cumulative_filled_in as u256) + (v4 as u256) > 18446744073709551615) {
            return (false, 0, 0)
        };
        arg0.cumulative_filled_in = arg0.cumulative_filled_in + v4;
        let (v21, v22) = if (arg1.a2b) {
            (v4, v3)
        } else {
            (v3, v4)
        };
        if (v21 < arg0.min_fill || arg0.fill_or_kill && v4 != arg0.total_depth) {
            return (false, 0, 0)
        };
        (true, v21, v22)
    }

    // decompiled from Move bytecode v7
}

