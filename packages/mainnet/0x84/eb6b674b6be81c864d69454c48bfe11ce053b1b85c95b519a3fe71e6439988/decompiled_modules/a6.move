module 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::a6 {
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

    struct InventoryRiskState has copy, drop {
        desk: 0x2::object::ID,
        sequence: u64,
        filled_position_size: u64,
        filled_position_long: bool,
        pending_risk_size: u64,
        pending_risk_long: bool,
        error_bps: u64,
        tier: u8,
        recovery_cross_capped: bool,
        cross_allowance: u64,
        bid_room: u64,
        ask_room: u64,
        adverse_offset_ticks: u64,
    }

    struct NotionalRiskRetuned has copy, drop {
        desk: 0x2::object::ID,
        hard_max_order: u64,
        hard_position_limit: u64,
        reference_price: u64,
        market_equity_quote: u64,
        maximum_leverage_bps: u64,
    }

    struct PositionLeverageSet has copy, drop {
        desk: 0x2::object::ID,
        account_num: u64,
        leverage: u64,
        initial_margin_ratio: u256,
    }

    struct TakerCycle has copy, drop {
        desk: 0x2::object::ID,
        sequence: u64,
        source_ts_ms: u64,
        reason: u8,
        source_anchor: u64,
        live_bid: u64,
        live_ask: u64,
        drift_bps: u64,
        absolute_target: u64,
        side_is_ask: bool,
        quantity: u64,
        limit_price: u64,
        required_edge_bps_e4: u64,
        position_limit: u64,
        position_size_before: u64,
        position_long_before: bool,
        position_size_after: u64,
        position_long_after: bool,
        executed_size: u64,
        bid_cancel_found: bool,
        ask_cancel_found: bool,
    }

    struct Unwind has copy, drop {
        desk: 0x2::object::ID,
        size_before: u64,
        was_long: bool,
        size_after: u64,
        bid_cancel_found: bool,
        ask_cancel_found: bool,
    }

    struct PortfolioMigrated has copy, drop {
        child_desk: 0x2::object::ID,
        authority_desk: 0x2::object::ID,
        old_account: 0x2::object::ID,
        portfolio_account: 0x2::object::ID,
        old_perp_account: 0x2::object::ID,
        portfolio_perp_account: 0x2::object::ID,
        allocated_quote: u64,
        account_num: u64,
    }

    struct PortfolioMarginAdjusted has copy, drop {
        child_desk: 0x2::object::ID,
        authority_desk: 0x2::object::ID,
        portfolio_account: 0x2::object::ID,
        clearing_house: 0x2::object::ID,
        amount_quote: u64,
        allocated: bool,
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

    fun adverse_offset_ticks(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg0 <= arg1) {
            0
        } else if (arg0 < arg2) {
            arg3
        } else {
            arg4
        }
    }

    public fun ap<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0, false, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2500, 1000, 1, 2, 0, 0, arg15, arg16)
    }

    public fun apd<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, false, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2500, 1000, 1, 2, 0, 0, arg16, arg17)
    }

    public fun apdr<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: u8, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : u64 {
        validate_rebalance<T0, T1>(arg0, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, true, false, arg16, arg17, arg18, 0, 0, arg19, arg20, arg21, arg22, arg23, arg24, 2500, 1000, 1, 2, 0, 0, arg25, arg26)
    }

    public fun apdrn<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: u8, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: &0x2::clock::Clock, arg28: &mut 0x2::tx_context::TxContext) : u64 {
        validate_notional_rebalance<T0, T1>(arg0, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, true, true, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, 2500, 1000, 1, 2, 0, 0, arg27, arg28)
    }

    public fun apdrna<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: u8, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: &0x2::clock::Clock, arg29: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg12 > 0, 2);
        validate_notional_rebalance<T0, T1>(arg0, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27);
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14, arg15, arg16, true, true, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, 2500, 1000, 1, 2, arg12, 0, arg28, arg29)
    }

    public fun apdrnai<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: u8, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: &0x2::clock::Clock, arg33: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg12 > 0, 2);
        validate_notional_rebalance<T0, T1>(arg0, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg25, arg26, arg27, arg28);
        validate_inventory_cycle_policy(arg22, arg23, arg24, arg29, arg30, arg31);
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14, arg15, arg16, true, true, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg25, arg26, arg27, arg28, arg24, arg29, arg30, arg31, arg12, 0, arg32, arg33)
    }

    public fun apdrnaj<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: u8, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: u64, arg33: &0x2::clock::Clock, arg34: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg12 > 0 && arg32 <= 5000, 2);
        validate_notional_rebalance<T0, T1>(arg0, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg25, arg26, arg27, arg28);
        validate_inventory_cycle_policy(arg22, arg23, arg24, arg29, arg30, arg31);
        apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14, arg15, arg16, true, true, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg25, arg26, arg27, arg28, arg24, arg29, arg30, arg31, arg12, arg32, arg33, arg34)
    }

    public fun apdrnap<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg5: u64, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: u64, arg17: u64, arg18: u8, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg13 > 0, 2);
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == arg1.v && arg0.d == arg1.d, 1);
        assert!(arg0.p == arg1.p && arg0.a == arg1.a, 1);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg3), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg7), 1);
        validate_notional_rebalance<T0, T2>(arg0, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28);
        apply_portfolio<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15, arg16, arg17, true, true, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, 2500, 1000, 1, 2, arg13, 0, arg1, arg29, arg30)
    }

    public fun apdrnapi<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg5: u64, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: u64, arg17: u64, arg18: u8, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: u64, arg33: &0x2::clock::Clock, arg34: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg13 > 0, 2);
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == arg1.v && arg0.d == arg1.d, 1);
        assert!(arg0.p == arg1.p && arg0.a == arg1.a, 1);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg3), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg7), 1);
        validate_notional_rebalance<T0, T2>(arg0, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg26, arg27, arg28, arg29);
        validate_inventory_cycle_policy(arg23, arg24, arg25, arg30, arg31, arg32);
        apply_portfolio<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15, arg16, arg17, true, true, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg26, arg27, arg28, arg29, arg25, arg30, arg31, arg32, arg13, 0, arg1, arg33, arg34)
    }

    public fun apdrnapj<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg5: u64, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: u64, arg17: u64, arg18: u8, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: u64, arg33: u64, arg34: &0x2::clock::Clock, arg35: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg13 > 0 && arg33 <= 5000, 2);
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == arg1.v && arg0.d == arg1.d, 1);
        assert!(arg0.p == arg1.p && arg0.a == arg1.a, 1);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg3), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg7), 1);
        validate_notional_rebalance<T0, T2>(arg0, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg26, arg27, arg28, arg29);
        validate_inventory_cycle_policy(arg23, arg24, arg25, arg30, arg31, arg32);
        apply_portfolio<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15, arg16, arg17, true, true, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg26, arg27, arg28, arg29, arg25, arg30, arg31, arg32, arg13, arg33, arg1, arg34, arg35)
    }

    fun apply<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: bool, arg18: u8, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: &0x2::clock::Clock, arg36: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg6), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg5), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T0, T1>(arg2) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::clearing_house_id<T0, T1>(arg2) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg5), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg6);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T0, T1>(arg2) == v0, 1);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg36));
        if (arg9 <= arg0.n || arg10 <= arg0.ts) {
            emit<T0, T1>(arg0, arg9, arg10, 1, 0, arg11, 0, 0, 0, 0, false, false, 0, true);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg5);
            return 0
        };
        arg0.n = arg9;
        arg0.ts = arg10;
        let v1 = 0x2::clock::timestamp_ms(arg35);
        let v2 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), true));
        let v3 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), false));
        let v4 = v3 > 0 && v2 > v3;
        let v5 = if (v4) {
            ((((v3 as u128) + (v2 as u128)) / 2) as u64)
        } else {
            0
        };
        let (v6, v7, v8) = depth_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), false, v3, arg15, arg0.b.o);
        let (v9, v10, v11) = depth_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), true, v2, arg15, arg0.x.o);
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
        let (v13, v14) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::ad(arg11, v5, arg0.drift);
        let v15 = valid_time<T0, T1>(arg0, arg10, v1);
        let v16 = if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::version(arg3) == arg4) {
            if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::status(arg3) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::status_normal()) {
                if (!0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_paused<T1>(arg1)) {
                    if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::is_dex_allowed(arg3, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::dex_aftermath_perp())) {
                        if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_dex_allowed<T1>(arg1, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::dex_aftermath_perp())) {
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
        let (v23, v24) = risk_base_size<T1>(&arg5, v0);
        let v25 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg5);
        let v26 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v25);
        let v27 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v25);
        let v28 = if (arg17) {
            arg20
        } else {
            arg0.i
        };
        let v29 = if (arg17) {
            arg21
        } else {
            arg0.m
        };
        let v30 = if (arg17) {
            arg22
        } else {
            arg0.hm
        };
        let (v31, v32, v33, v34, v35) = if (arg16) {
            rebalance_factors(v21, v22, arg18, arg19, arg20, arg23, arg24, arg29, arg25, arg26, arg27, arg28)
        } else {
            (0, false, 0, 10000, 10000)
        };
        let v36 = (((v29 as u128) * (arg30 as u128) / 10000) as u64);
        let v37 = arg16 && v31 > arg23;
        let v38 = inventory_room(v21, v22, v23, v24, v28, true, v36, v37);
        let v39 = inventory_room(v21, v22, v23, v24, v28, false, v36, v37);
        let v40 = if (arg16) {
            scaled_quote_size(v29, arg0.sf, arg14, v34, v30, v27, v38)
        } else {
            quote_size(arg0.m, arg0.sf, arg14, v27, v38)
        };
        let v41 = if (arg16) {
            scaled_quote_size(v29, arg0.sf, arg14, v35, v30, v27, v39)
        } else {
            quote_size(arg0.m, arg0.sf, arg14, v27, v39)
        };
        let v42 = if (arg16) {
            inventory_tier(v31, arg23, arg24, arg29)
        } else {
            0
        };
        let v43 = if (arg33 == 0 && arg16) {
            adverse_offset_ticks(v31, arg23, arg24, arg31, arg32)
        } else {
            0
        };
        if (arg33 > 0) {
            arg0.b.f = arg12 == 2;
            arg0.x.f = arg12 == 1;
        } else if (arg16) {
            arg0.b.f = false;
            arg0.x.f = false;
        } else {
            let v44 = arg13 / 10;
            let v45 = if (arg12 == 2) {
                v44
            } else {
                0
            };
            let v46 = if (arg12 == 1) {
                v44
            } else {
                0
            };
            arg0.b.f = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m0::lx(arg0.b.f, v45, arg0.tox_in, arg0.tox_out);
            arg0.x.f = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m0::lx(arg0.x.f, v46, arg0.tox_in, arg0.tox_out);
        };
        if (arg0.b.f) {
            v18 = v18 | 256;
        };
        if (arg0.x.f) {
            v18 = v18 | 512;
        };
        assert!(arg34 <= 5000, 2);
        let v47 = if (arg33 > 0) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::fb(arg33, arg34, true)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::tg(arg11, arg12, arg13, false)
        };
        let v48 = if (arg33 > 0) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::fb(arg33, arg34, false)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::tg(arg11, arg12, arg13, true)
        };
        let v49 = if (arg33 > 0) {
            arg33
        } else if (v47 > 0) {
            v47
        } else {
            v48
        };
        let v50 = if (v16) {
            if (v15) {
                if (v4) {
                    if (v12) {
                        if (v13) {
                            if (v49 > 0) {
                                if (v26 > 0) {
                                    v27 > 0
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
        let v51 = if (v50) {
            if (!arg0.b.f) {
                v40 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v52 = if (v51) {
            if (arg33 > 0) {
                let (v53, _) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::mkpdb(true, arg33, arg34, v6, v9, v3, v2, arg0.off, v26);
                v53
            } else {
                let (v55, _) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::mkpd(true, v47, arg0.cost, v6, v9, v3, v2, arg0.off, v26);
                v55
            }
        } else {
            0
        };
        let v57 = v52;
        let v58 = if (v50) {
            if (!arg0.x.f) {
                v41 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v59 = if (v58) {
            if (arg33 > 0) {
                let (v60, _) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::mkpdb(false, arg33, arg34, v6, v9, v3, v2, arg0.off, v26);
                v60
            } else {
                let (v62, _) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::mkpd(false, v48, arg0.cost, v6, v9, v3, v2, arg0.off, v26);
                v62
            }
        } else {
            0
        };
        let v64 = v59;
        if (arg33 == 0) {
            let (v65, v66) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m0::cx(v52, v59, v3, v2, v26, arg12);
            v64 = v66;
            v57 = v65;
        };
        let v67 = if (arg33 == 0) {
            if (arg16) {
                v43 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v67) {
            if (v32) {
                v57 = move_adverse_price_outward(v57, true, v43, v26);
            } else {
                v64 = move_adverse_price_outward(v64, false, v43, v26);
            };
        };
        let v68 = if (arg33 > 0) {
            0
        } else {
            arg0.cost
        };
        let v69 = if (arg33 > 0) {
            0
        } else {
            arg0.cost
        };
        let v70 = if (arg33 > 0) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::rqd(arg0.b.o != 0, arg0.b.p, v57, true, econ_bound(v47, v68, true), arg0.improve, v26, arg0.b.e, v1, arg0.refresh)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::rqd(arg0.b.o != 0, arg0.b.p, v57, true, econ_bound(v47, v68, true), arg0.improve, v26, arg0.b.e, v1, arg0.refresh)
        };
        let v71 = v70;
        let v72 = if (arg33 > 0) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::rqd(arg0.x.o != 0, arg0.x.p, v64, false, econ_bound(v48, v69, false), arg0.improve, v26, arg0.x.e, v1, arg0.refresh)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::rqd(arg0.x.o != 0, arg0.x.p, v64, false, econ_bound(v48, v69, false), arg0.improve, v26, arg0.x.e, v1, arg0.refresh)
        };
        let v73 = v72;
        if (arg0.b.o != 0 && (arg0.b.q > v38 || arg16 && (arg17 && material_size_change(arg0.b.q, v40) || arg0.b.q != v40))) {
            let v74 = if (v57 > 0 && v40 > 0) {
                0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()
            } else {
                0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_cancel()
            };
            v71 = v74;
        };
        if (arg0.x.o != 0 && (arg0.x.q > v39 || arg16 && (arg17 && material_size_change(arg0.x.q, v41) || arg0.x.q != v41))) {
            let v75 = if (v64 > 0 && v41 > 0) {
                0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()
            } else {
                0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_cancel()
            };
            v73 = v75;
        };
        let v76 = if (v71 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()) {
            if (v57 > 0) {
                v40 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v77 = if (v73 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()) {
            if (v64 > 0) {
                v41 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v76 || v77) {
            let v78 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T1>(&arg5, arg7, arg35);
            let v79 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v25);
            if (v76 && !order_value_ok(v40, v78, v79)) {
                v57 = 0;
                v18 = v18 | 1024;
                let v80 = if (arg0.b.o != 0) {
                    0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_cancel()
                } else {
                    0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep()
                };
                v71 = v80;
            };
            if (v77 && !order_value_ok(v41, v78, v79)) {
                v64 = 0;
                v18 = v18 | 2048;
                let v81 = if (arg0.x.o != 0) {
                    0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_cancel()
                } else {
                    0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep()
                };
                v73 = v81;
            };
        };
        let v82 = false;
        let v83 = false;
        if (v71 != 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep() && arg0.b.o != 0) {
            let v84 = &mut arg5;
            let (v85, v86) = cancel_one<T0, T1>(arg0, v84, arg6, true);
            if (v85) {
                v18 = v18 | 2;
            };
            v82 = v86;
        } else if (v71 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep() && arg0.b.o != 0) {
            v18 = v18 | 1;
        };
        if (v73 != 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep() && arg0.x.o != 0) {
            let v87 = &mut arg5;
            let (v88, v89) = cancel_one<T0, T1>(arg0, v87, arg6, false);
            if (v88) {
                v18 = v18 | 16;
            };
            v83 = v89;
        } else if (v73 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep() && arg0.x.o != 0) {
            v18 = v18 | 8;
        };
        let v90 = if (v71 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()) {
            if (v57 > 0) {
                v40 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v91 = if (v73 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()) {
            if (v64 > 0) {
                v41 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v90 || v91) {
            let v92 = v1 + arg0.ttl;
            let v93 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg5, &arg0.k, arg6, arg7, arg8, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg35, arg36);
            if (v90) {
                let v94 = option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T1>(&mut v93, false, v40, v57, 2, 0x1::option::some<u64>(client_id(arg9, false)), false, 0x1::option::some<u64>(v92)));
                if (v94 != 0) {
                    let v95 = L{
                        o : v94,
                        p : v57,
                        q : v40,
                        e : v92,
                        f : arg0.b.f,
                    };
                    arg0.b = v95;
                    v18 = v18 | 4;
                };
            };
            if (v91) {
                let v96 = option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T1>(&mut v93, true, v41, v64, 2, 0x1::option::some<u64>(client_id(arg9, true)), false, 0x1::option::some<u64>(v92)));
                if (v96 != 0) {
                    let v97 = L{
                        o : v96,
                        p : v64,
                        q : v41,
                        e : v92,
                        f : arg0.x.f,
                    };
                    arg0.x = v97;
                    v18 = v18 | 32;
                };
            };
            let (v98, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v93, &arg0.k, arg6, false, false);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v98);
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg5);
        };
        let v100 = if (!v15) {
            2
        } else if (!v16) {
            3
        } else if (!v4) {
            4
        } else if (!v12) {
            8
        } else if (!v13) {
            5
        } else if (v40 == 0 && v41 == 0) {
            6
        } else {
            let v101 = if (v18 & (1024 | 2048) != 0) {
                if (v57 == 0) {
                    v64 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v101) {
                7
            } else {
                0
            }
        };
        let v102 = DepthBbo{
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
        0x2::event::emit<DepthBbo>(v102);
        if (arg16) {
            let v103 = RebalanceSizing{
                desk                   : 0x2::object::uid_to_inner(&arg0.id),
                sequence               : arg9,
                position_size          : v21,
                position_long          : v22,
                target_side            : arg18,
                target_size            : arg19,
                position_limit         : arg20,
                error_bps              : v31,
                inventory_above_target : v32,
                pressure_bps           : v33,
                neutral_size           : v29,
                bid_factor_bps         : v34,
                ask_factor_bps         : v35,
                bid_size               : v40,
                ask_size               : v41,
            };
            0x2::event::emit<RebalanceSizing>(v103);
            let v104 = InventoryRiskState{
                desk                  : 0x2::object::uid_to_inner(&arg0.id),
                sequence              : arg9,
                filled_position_size  : v21,
                filled_position_long  : v22,
                pending_risk_size     : v23,
                pending_risk_long     : v24,
                error_bps             : v31,
                tier                  : v42,
                recovery_cross_capped : v37,
                cross_allowance       : v36,
                bid_room              : v38,
                ask_room              : v39,
                adverse_offset_ticks  : v43,
            };
            0x2::event::emit<InventoryRiskState>(v104);
        };
        emit<T0, T1>(arg0, arg9, arg10, v100, v18, arg11, v3, v2, v14, v49, v82, v83, v21, v22);
        v18
    }

    fun apply_portfolio<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: bool, arg18: u8, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: &A<T1, T2>, arg36: &0x2::clock::Clock, arg37: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg6), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(&arg5), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T1, T2>(arg2) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg1), 1);
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg35), 1);
        assert!(arg35.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg1) && arg35.d == arg0.d, 1);
        assert!(arg35.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg2) && arg35.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg6), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg6);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T1, T2>(arg2) == v0, 1);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_executor<T2>(arg1, arg0.d, 0x2::tx_context::sender(arg37));
        if (arg9 <= arg0.n || arg10 <= arg0.ts) {
            emit<T0, T2>(arg0, arg9, arg10, 1, 0, arg11, 0, 0, 0, 0, false, false, 0, true);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(arg5);
            return 0
        };
        arg0.n = arg9;
        arg0.ts = arg10;
        let v1 = 0x2::clock::timestamp_ms(arg36);
        let v2 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T2>(&arg5), true));
        let v3 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T2>(&arg5), false));
        let v4 = v3 > 0 && v2 > v3;
        let v5 = if (v4) {
            ((((v3 as u128) + (v2 as u128)) / 2) as u64)
        } else {
            0
        };
        let (v6, v7, v8) = depth_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T2>(&arg5), false, v3, arg15, arg0.b.o);
        let (v9, v10, v11) = depth_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T2>(&arg5), true, v2, arg15, arg0.x.o);
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
        let (v13, v14) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::ad(arg11, v5, arg0.drift);
        let v15 = valid_time<T0, T2>(arg0, arg10, v1);
        let v16 = if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::version(arg3) == arg4) {
            if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::status(arg3) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::status_normal()) {
                if (!0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_paused<T2>(arg1)) {
                    if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::is_dex_allowed(arg3, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::dex_aftermath_perp())) {
                        if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_dex_allowed<T2>(arg1, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::dex_aftermath_perp())) {
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
        let v20 = present<T2>(&arg5, arg0.x.o);
        if (arg0.b.o != 0 && !present<T2>(&arg5, arg0.b.o)) {
            clear<T0, T2>(arg0, true);
            v18 = v18 | 64;
        };
        if (v19 && !v20) {
            clear<T0, T2>(arg0, false);
            v18 = v18 | 128;
        };
        let (v21, v22) = base_size<T2>(&arg5, v0);
        let (v23, v24) = risk_base_size<T2>(&arg5, v0);
        let v25 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T2>(&arg5);
        let v26 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v25);
        let v27 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v25);
        let v28 = if (arg17) {
            arg20
        } else {
            arg0.i
        };
        let v29 = if (arg17) {
            arg21
        } else {
            arg0.m
        };
        let v30 = if (arg17) {
            arg22
        } else {
            arg0.hm
        };
        let (v31, v32, v33, v34, v35) = if (arg16) {
            rebalance_factors(v21, v22, arg18, arg19, arg20, arg23, arg24, arg29, arg25, arg26, arg27, arg28)
        } else {
            (0, false, 0, 10000, 10000)
        };
        let v36 = (((v29 as u128) * (arg30 as u128) / 10000) as u64);
        let v37 = arg16 && v31 > arg23;
        let v38 = inventory_room(v21, v22, v23, v24, v28, true, v36, v37);
        let v39 = inventory_room(v21, v22, v23, v24, v28, false, v36, v37);
        let v40 = if (arg16) {
            scaled_quote_size(v29, arg0.sf, arg14, v34, v30, v27, v38)
        } else {
            quote_size(arg0.m, arg0.sf, arg14, v27, v38)
        };
        let v41 = if (arg16) {
            scaled_quote_size(v29, arg0.sf, arg14, v35, v30, v27, v39)
        } else {
            quote_size(arg0.m, arg0.sf, arg14, v27, v39)
        };
        let v42 = if (arg16) {
            inventory_tier(v31, arg23, arg24, arg29)
        } else {
            0
        };
        let v43 = if (arg33 == 0 && arg16) {
            adverse_offset_ticks(v31, arg23, arg24, arg31, arg32)
        } else {
            0
        };
        if (arg33 > 0) {
            arg0.b.f = arg12 == 2;
            arg0.x.f = arg12 == 1;
        } else if (arg16) {
            arg0.b.f = false;
            arg0.x.f = false;
        } else {
            let v44 = arg13 / 10;
            let v45 = if (arg12 == 2) {
                v44
            } else {
                0
            };
            let v46 = if (arg12 == 1) {
                v44
            } else {
                0
            };
            arg0.b.f = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m0::lx(arg0.b.f, v45, arg0.tox_in, arg0.tox_out);
            arg0.x.f = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m0::lx(arg0.x.f, v46, arg0.tox_in, arg0.tox_out);
        };
        if (arg0.b.f) {
            v18 = v18 | 256;
        };
        if (arg0.x.f) {
            v18 = v18 | 512;
        };
        assert!(arg34 <= 5000, 2);
        let v47 = if (arg33 > 0) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::fb(arg33, arg34, true)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::tg(arg11, arg12, arg13, false)
        };
        let v48 = if (arg33 > 0) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::fb(arg33, arg34, false)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::tg(arg11, arg12, arg13, true)
        };
        let v49 = if (arg33 > 0) {
            arg33
        } else if (v47 > 0) {
            v47
        } else {
            v48
        };
        let v50 = if (v16) {
            if (v15) {
                if (v4) {
                    if (v12) {
                        if (v13) {
                            if (v49 > 0) {
                                if (v26 > 0) {
                                    v27 > 0
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
        let v51 = if (v50) {
            if (!arg0.b.f) {
                v40 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v52 = if (v51) {
            if (arg33 > 0) {
                let (v53, _) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::mkpdb(true, arg33, arg34, v6, v9, v3, v2, arg0.off, v26);
                v53
            } else {
                let (v55, _) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::mkpd(true, v47, arg0.cost, v6, v9, v3, v2, arg0.off, v26);
                v55
            }
        } else {
            0
        };
        let v57 = v52;
        let v58 = if (v50) {
            if (!arg0.x.f) {
                v41 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v59 = if (v58) {
            if (arg33 > 0) {
                let (v60, _) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::mkpdb(false, arg33, arg34, v6, v9, v3, v2, arg0.off, v26);
                v60
            } else {
                let (v62, _) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::mkpd(false, v48, arg0.cost, v6, v9, v3, v2, arg0.off, v26);
                v62
            }
        } else {
            0
        };
        let v64 = v59;
        if (arg33 == 0) {
            let (v65, v66) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m0::cx(v52, v59, v3, v2, v26, arg12);
            v64 = v66;
            v57 = v65;
        };
        let v67 = if (arg33 == 0) {
            if (arg16) {
                v43 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v67) {
            if (v32) {
                v57 = move_adverse_price_outward(v57, true, v43, v26);
            } else {
                v64 = move_adverse_price_outward(v64, false, v43, v26);
            };
        };
        let v68 = if (arg33 > 0) {
            0
        } else {
            arg0.cost
        };
        let v69 = if (arg33 > 0) {
            0
        } else {
            arg0.cost
        };
        let v70 = if (arg33 > 0) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::rqd(arg0.b.o != 0, arg0.b.p, v57, true, econ_bound(v47, v68, true), arg0.improve, v26, arg0.b.e, v1, arg0.refresh)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::rqd(arg0.b.o != 0, arg0.b.p, v57, true, econ_bound(v47, v68, true), arg0.improve, v26, arg0.b.e, v1, arg0.refresh)
        };
        let v71 = v70;
        let v72 = if (arg33 > 0) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::rqd(arg0.x.o != 0, arg0.x.p, v64, false, econ_bound(v48, v69, false), arg0.improve, v26, arg0.x.e, v1, arg0.refresh)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::rqd(arg0.x.o != 0, arg0.x.p, v64, false, econ_bound(v48, v69, false), arg0.improve, v26, arg0.x.e, v1, arg0.refresh)
        };
        let v73 = v72;
        if (arg0.b.o != 0 && (arg0.b.q > v38 || arg16 && (arg17 && material_size_change(arg0.b.q, v40) || arg0.b.q != v40))) {
            let v74 = if (v57 > 0 && v40 > 0) {
                0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()
            } else {
                0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_cancel()
            };
            v71 = v74;
        };
        if (arg0.x.o != 0 && (arg0.x.q > v39 || arg16 && (arg17 && material_size_change(arg0.x.q, v41) || arg0.x.q != v41))) {
            let v75 = if (v64 > 0 && v41 > 0) {
                0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()
            } else {
                0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_cancel()
            };
            v73 = v75;
        };
        let v76 = if (v71 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()) {
            if (v57 > 0) {
                v40 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v77 = if (v73 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()) {
            if (v64 > 0) {
                v41 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v76 || v77) {
            let v78 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T2>(&arg5, arg7, arg36);
            let v79 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v25);
            if (v76 && !order_value_ok(v40, v78, v79)) {
                v57 = 0;
                v18 = v18 | 1024;
                let v80 = if (arg0.b.o != 0) {
                    0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_cancel()
                } else {
                    0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep()
                };
                v71 = v80;
            };
            if (v77 && !order_value_ok(v41, v78, v79)) {
                v64 = 0;
                v18 = v18 | 2048;
                let v81 = if (arg0.x.o != 0) {
                    0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_cancel()
                } else {
                    0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep()
                };
                v73 = v81;
            };
        };
        let v82 = false;
        let v83 = false;
        if (v71 != 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep() && arg0.b.o != 0) {
            let v84 = &mut arg5;
            let (v85, v86) = cancel_one_with_cap<T0, T2>(arg0, v84, arg6, &arg35.k, true);
            if (v85) {
                v18 = v18 | 2;
            };
            v82 = v86;
        } else if (v71 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep() && arg0.b.o != 0) {
            v18 = v18 | 1;
        };
        if (v73 != 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep() && arg0.x.o != 0) {
            let v87 = &mut arg5;
            let (v88, v89) = cancel_one_with_cap<T0, T2>(arg0, v87, arg6, &arg35.k, false);
            if (v88) {
                v18 = v18 | 16;
            };
            v83 = v89;
        } else if (v73 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_keep() && arg0.x.o != 0) {
            v18 = v18 | 8;
        };
        let v90 = if (v71 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()) {
            if (v57 > 0) {
                v40 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v91 = if (v73 == 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::act_replace()) {
            if (v64 > 0) {
                v41 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v90 || v91) {
            let v92 = v1 + arg0.ttl;
            let v93 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg5, &arg35.k, arg6, arg7, arg8, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg36, arg37);
            if (v90) {
                let v94 = option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T2>(&mut v93, false, v40, v57, 2, 0x1::option::some<u64>(client_id(arg9, false)), false, 0x1::option::some<u64>(v92)));
                if (v94 != 0) {
                    let v95 = L{
                        o : v94,
                        p : v57,
                        q : v40,
                        e : v92,
                        f : arg0.b.f,
                    };
                    arg0.b = v95;
                    v18 = v18 | 4;
                };
            };
            if (v91) {
                let v96 = option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T2>(&mut v93, true, v41, v64, 2, 0x1::option::some<u64>(client_id(arg9, true)), false, 0x1::option::some<u64>(v92)));
                if (v96 != 0) {
                    let v97 = L{
                        o : v96,
                        p : v64,
                        q : v41,
                        e : v92,
                        f : arg0.x.f,
                    };
                    arg0.x = v97;
                    v18 = v18 | 32;
                };
            };
            let (v98, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v93, &arg35.k, arg6, false, false);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(v98);
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(arg5);
        };
        let v100 = if (!v15) {
            2
        } else if (!v16) {
            3
        } else if (!v4) {
            4
        } else if (!v12) {
            8
        } else if (!v13) {
            5
        } else if (v40 == 0 && v41 == 0) {
            6
        } else {
            let v101 = if (v18 & (1024 | 2048) != 0) {
                if (v57 == 0) {
                    v64 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v101) {
                7
            } else {
                0
            }
        };
        let v102 = DepthBbo{
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
        0x2::event::emit<DepthBbo>(v102);
        if (arg16) {
            let v103 = RebalanceSizing{
                desk                   : 0x2::object::uid_to_inner(&arg0.id),
                sequence               : arg9,
                position_size          : v21,
                position_long          : v22,
                target_side            : arg18,
                target_size            : arg19,
                position_limit         : arg20,
                error_bps              : v31,
                inventory_above_target : v32,
                pressure_bps           : v33,
                neutral_size           : v29,
                bid_factor_bps         : v34,
                ask_factor_bps         : v35,
                bid_size               : v40,
                ask_size               : v41,
            };
            0x2::event::emit<RebalanceSizing>(v103);
            let v104 = InventoryRiskState{
                desk                  : 0x2::object::uid_to_inner(&arg0.id),
                sequence              : arg9,
                filled_position_size  : v21,
                filled_position_long  : v22,
                pending_risk_size     : v23,
                pending_risk_long     : v24,
                error_bps             : v31,
                tier                  : v42,
                recovery_cross_capped : v37,
                cross_allowance       : v36,
                bid_room              : v38,
                ask_room              : v39,
                adverse_offset_ticks  : v43,
            };
            0x2::event::emit<InventoryRiskState>(v104);
        };
        emit<T0, T2>(arg0, arg9, arg10, v100, v18, arg11, v3, v2, v14, v49, v82, v83, v21, v22);
        v18
    }

    fun assert_portfolio_market<T0, T1, T2>(arg0: &A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>) : u64 {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_admin<T2>(arg2, arg3);
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2) && arg1.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        assert!(arg0.d == arg1.d, 1);
        assert!(arg0.p == arg1.p && arg0.a == arg1.a, 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg5), 1);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg4), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg6), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T1, T2>(arg4) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg6);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T1, T2>(arg4) == v0, 1);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T2>(arg5, v0), 1);
        assert!(arg0.b.o == 0 && arg0.x.o == 0, 2);
        v0
    }

    fun base_size<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64) : (u64, bool) {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, arg1)) {
            return (0, true)
        };
        let (v0, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, arg1));
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v0), 1000000000), !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0))
    }

    public fun c0<T0, T1>(arg0: &0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::D<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : A<T0, T1> {
        create<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun c1<T0, T1, T2>(arg0: &0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::D<T2, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : A<T0, T1> {
        create<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun ca<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg4), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg3), 1);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg6));
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

    fun cancel_one_with_cap<T0, T1>(arg0: &mut A<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg4: bool) : (bool, bool) {
        let v0 = if (arg4) {
            arg0.b.o
        } else {
            arg0.x.o
        };
        if (v0 == 0) {
            return (false, false)
        };
        let v1 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v1, v0);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, arg3, arg2, &v1);
        let v3 = 0x1::vector::length<bool>(&v2) == 1 && *0x1::vector::borrow<bool>(&v2, 0);
        clear<T0, T1>(arg0, arg4);
        (true, v3)
    }

    public fun cap<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2) && arg1.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        let v0 = if (arg0.d == arg1.d) {
            if (arg0.p == arg1.p) {
                arg0.a == arg1.a
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(&arg4), 1);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg3), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg5), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T1, T2>(arg3) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T1, T2>(arg3) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg5), 1);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_executor<T2>(arg2, arg0.d, 0x2::tx_context::sender(arg7));
        let v1 = &mut arg4;
        let (v2, v3) = cancel_one_with_cap<T0, T2>(arg0, v1, arg5, &arg1.k, true);
        let v4 = &mut arg4;
        let (v5, v6) = cancel_one_with_cap<T0, T2>(arg0, v4, arg5, &arg1.k, false);
        let v7 = 0;
        let v8 = v7;
        if (v2) {
            v8 = v7 | 2;
        };
        if (v5) {
            v8 = v8 | 16;
        };
        emit<T0, T2>(arg0, arg0.n, 0x2::clock::timestamp_ms(arg6), 3, v8, 0, 0, 0, 0, 0, v3, v6, 0, true);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(arg4);
        v8
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

    fun create<T0, T1, T2>(arg0: &0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::D<T2, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : A<T0, T1> {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::assert_active(arg3, arg4);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_active_vault<T1>(arg1, arg3, arg4);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_admin<T1>(arg1, arg2);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::dex_adapter::assert_dex_allowed<T1>(arg1, arg3, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::dex_aftermath_perp());
        assert!(0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::vid<T2, T1>(arg0) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T0, T1>(arg5) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::clearing_house_id<T0, T1>(arg5) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg6), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T0, T1>(arg5) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg7), 1);
        validate(arg9, arg10, arg11);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg6, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg7))) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg6, &arg8, arg7);
        };
        let v0 = if (0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 9) < 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 21)) {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 9)
        } else {
            0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 21)
        };
        assert!(v0 > 0 && 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 4) > 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 5), 2);
        assert!(0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 3) < 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 2), 2);
        A<T0, T1>{
            id      : 0x2::object::new(arg12),
            v       : 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1),
            d       : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::did<T2, T1>(arg0),
            p       : 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg5),
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
            cost    : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 19),
            ttl     : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 4),
            refresh : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 5),
            age     : v0,
            skew    : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 8),
            drift   : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 20),
            off     : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 22),
            improve : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 26),
            tox_in  : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 2),
            tox_out : 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::d0::pv<T2, T1>(arg0, 3),
            b       : empty_leg(),
            x       : empty_leg(),
            z       : false,
        }
    }

    fun cumulative_depth_price(arg0: &vector<u128>, arg1: &vector<u64>, arg2: bool, arg3: u64, arg4: u128) : (u64, u64, bool) {
        if (arg3 == 0 || 0x1::vector::length<u128>(arg0) != 0x1::vector::length<u64>(arg1)) {
            return (0, 0, false)
        };
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u128>(arg0)) {
            if (*0x1::vector::borrow<u128>(arg0, v0) == arg4 && arg4 != 0) {
                v0 = v0 + 1;
                continue
            };
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

    fun depth_price(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Orderbook, arg1: bool, arg2: u64, arg3: u64, arg4: u128) : (u64, u64, bool) {
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
        cumulative_depth_price(&v4, &v5, arg1, arg3, arg4)
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

    fun executed_in_direction(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: bool) : u64 {
        if (arg4) {
            if (arg1) {
                if (!arg3 || arg2 < arg0) {
                    0
                } else {
                    arg2 - arg0
                }
            } else if (!arg3) {
                if (arg2 > arg0) {
                    0
                } else {
                    arg0 - arg2
                }
            } else if (arg0 > 18446744073709551615 - arg2) {
                18446744073709551615
            } else {
                arg0 + arg2
            }
        } else if (!arg1) {
            if (arg3 || arg2 < arg0) {
                0
            } else {
                arg2 - arg0
            }
        } else if (arg3) {
            if (arg2 > arg0) {
                0
            } else {
                arg0 - arg2
            }
        } else if (arg0 > 18446744073709551615 - arg2) {
            18446744073709551615
        } else {
            arg0 + arg2
        }
    }

    fun interpolate_factor(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0 || arg0 == arg1) {
            return arg0
        };
        if (arg2 >= arg3) {
            return arg1
        };
        if (arg1 > arg0) {
            arg0 + ((((arg1 - arg0) as u128) * (arg2 as u128) / (arg3 as u128)) as u64)
        } else {
            arg0 - ((((arg0 - arg1) as u128) * (arg2 as u128) / (arg3 as u128)) as u64)
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

    fun inventory_room(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: u64, arg7: bool) : u64 {
        let v0 = room(arg2, arg3, arg4, arg5);
        let v1 = if (!arg7) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg1 == arg5
        };
        if (v1) {
            return v0
        };
        let v2 = if (arg0 > 18446744073709551615 - arg6) {
            18446744073709551615
        } else {
            arg0 + arg6
        };
        if (v0 < v2) {
            v0
        } else {
            v2
        }
    }

    fun inventory_tier(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u8 {
        if (arg0 <= arg1) {
            0
        } else if (arg0 <= arg2) {
            1
        } else if (arg0 <= arg3) {
            2
        } else {
            3
        }
    }

    public fun l3<T0, T1>(arg0: &A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>) {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg4), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg3), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg4);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(&arg3, v0), 1);
        let v1 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::one() / 3;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg3, &arg0.k, arg4, v1);
        let v2 = PositionLeverageSet{
            desk                 : 0x2::object::id<A<T0, T1>>(arg0),
            account_num          : v0,
            leverage             : 3,
            initial_margin_ratio : v1,
        };
        0x2::event::emit<PositionLeverageSet>(v2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg3);
    }

    fun market_equity<T0, T1>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg1: u64, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) : u64 {
        market_equity_scaled<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0, 0)
    }

    fun market_equity_scaled<T0, T1>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg1: u64, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: u8, arg7: u8) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T1>(arg0, arg4, arg5);
        let v1 = oracle_price_e9(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::fresh_price<T0, T1>(arg2, arg3, arg5), arg6, arg7);
        let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(1000000000)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::one());
        let (v3, v4) = if (v2 > v1) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        assert!(((v4 - v3) as u128) * 10000 <= (v3 as u128) * (100 as u128), 2);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg0, arg1)) {
            return 0
        };
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T1>(arg0, arg1);
        let (v6, v7) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T1>(arg0));
        let v8 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v5), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v5, v0)), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::calculate_position_funding_internal(v5, v6, v7));
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v8)) {
            0
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v8, (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::decimal_scalar_from_decimals(6) as u256))
        }
    }

    fun material_size_change(arg0: u64, arg1: u64) : bool {
        if (arg0 == arg1) {
            return false
        };
        let (v0, v1) = if (arg0 > arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        if (v1 == 0) {
            return true
        };
        ((v0 - v1) as u128) * 10000 >= (v1 as u128) * 1000
    }

    public fun me<T0, T1, T2>(arg0: &A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T2>, arg6: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock) : u64 {
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == arg1.v && arg0.d == arg1.d, 1);
        assert!(arg0.p == arg1.p && arg0.a == arg1.a, 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg3), 1);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg2), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg4), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T1, T2>(arg2) == arg0.v, 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg4);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T1, T2>(arg2) == v0, 1);
        market_equity<T0, T2>(arg3, v0, arg5, arg6, arg7, arg8)
    }

    public fun me2<T0, T1, T2>(arg0: &A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T2>, arg6: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock, arg9: u8, arg10: u8) : u64 {
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == arg1.v && arg0.d == arg1.d, 1);
        assert!(arg0.p == arg1.p && arg0.a == arg1.a, 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg3), 1);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg2), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg4), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T1, T2>(arg2) == arg0.v, 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg4);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T1, T2>(arg2) == v0, 1);
        market_equity_scaled<T0, T2>(arg3, v0, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun move_adverse_price_outward(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return arg0
        };
        if (arg2 > 18446744073709551615 / arg3) {
            return 0
        };
        let v1 = arg2 * arg3;
        if (arg1) {
            if (arg0 > v1) {
                arg0 - v1
            } else {
                0
            }
        } else if (arg0 > 18446744073709551615 - v1) {
            0
        } else {
            arg0 + v1
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

    fun oracle_price_e9(arg0: u64, arg1: u8, arg2: u8) : u64 {
        assert!(arg1 <= 18 && arg2 <= 18, 2);
        let v0 = (arg0 as u256);
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        let v2 = 1;
        v1 = 0;
        while (v1 < arg2) {
            v2 = v2 * 10;
            v1 = v1 + 1;
        };
        let v3 = v0 / v2;
        assert!(v3 > 0 && v3 <= 18446744073709551615, 2);
        (v3 as u64)
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

    public fun pm<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T2>, arg5: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg8: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg9: u64, arg10: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T2>, arg11: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x2::clock::Clock) : u64 {
        pm_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0, 0)
    }

    public fun pm2<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T2>, arg5: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg8: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg9: u64, arg10: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T2>, arg11: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x2::clock::Clock, arg14: u8, arg15: u8) : u64 {
        pm_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    fun pm_impl<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T2>, arg5: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg8: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg9: u64, arg10: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::oracle::PriceOracle<T0, T2>, arg11: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x2::clock::Clock, arg14: u8, arg15: u8) : u64 {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_admin<T2>(arg2, arg3);
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2) && arg1.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        assert!(arg0.d == arg1.d, 1);
        assert!(arg0.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T2>>(arg4), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg7), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(&arg6), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T0, T2>(arg4) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::clearing_house_id<T0, T2>(arg4) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(&arg6), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg7);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T0, T2>(arg4) == v0, 1);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T2>(arg7) == 0, 2);
        let (v1, _) = base_size<T2>(&arg6, v0);
        assert!(v1 == 0, 2);
        let v3 = if (arg0.z) {
            if (arg0.b.o == 0) {
                arg0.x.o == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 2);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg5), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg8), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T1, T2>(arg5) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg8);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T1, T2>(arg5) == v4, 1);
        assert!(arg9 > 0, 2);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T2>(&arg6, v4)) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg6, &arg1.k, arg8);
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg6, &arg1.k, arg8, arg9);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg6, &arg1.k, arg8, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::one() / 3);
        arg0.a = arg1.a;
        arg0.p = arg1.p;
        arg0.z = true;
        let v5 = PortfolioMigrated{
            child_desk             : 0x2::object::id<A<T0, T2>>(arg0),
            authority_desk         : 0x2::object::id<A<T1, T2>>(arg1),
            old_account            : arg0.a,
            portfolio_account      : arg1.a,
            old_perp_account       : arg0.p,
            portfolio_perp_account : arg1.p,
            allocated_quote        : arg9,
            account_num            : v4,
        };
        0x2::event::emit<PortfolioMigrated>(v5);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(arg6);
        market_equity_scaled<T0, T2>(&arg6, v4, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public fun pma<T0, T1, T2>(arg0: &A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg7: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg8: u64, arg9: u64) {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::assert_active(arg7, arg8);
        assert!(arg9 > 0, 2);
        assert_portfolio_market<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg5, &arg1.k, arg6, arg9);
        let v0 = PortfolioMarginAdjusted{
            child_desk        : 0x2::object::id<A<T0, T2>>(arg0),
            authority_desk    : 0x2::object::id<A<T1, T2>>(arg1),
            portfolio_account : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg6),
            clearing_house    : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg5),
            amount_quote      : arg9,
            allocated         : true,
        };
        0x2::event::emit<PortfolioMarginAdjusted>(v0);
    }

    public fun pmd<T0, T1, T2>(arg0: &A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T2>, arg4: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: &0x2::clock::Clock) : u64 {
        assert!(arg9 > 0, 2);
        assert_portfolio_market<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_collateral<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg5, &arg1.k, arg6, arg7, arg8, arg9, arg10);
        assert!(v0 == arg9, 2);
        let v1 = PortfolioMarginAdjusted{
            child_desk        : 0x2::object::id<A<T0, T2>>(arg0),
            authority_desk    : 0x2::object::id<A<T1, T2>>(arg1),
            portfolio_account : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg6),
            clearing_house    : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg5),
            amount_quote      : v0,
            allocated         : false,
        };
        0x2::event::emit<PortfolioMarginAdjusted>(v1);
        v0
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

    fun rebalance_factors(arg0: u64, arg1: bool, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : (u64, bool, u64, u64, u64) {
        let (v0, v1) = inventory_error(arg0, arg1, arg2, arg3);
        let (v2, v3) = rebalance_pressure(v0, arg4, arg5, arg6, arg8);
        if (v3 == 0) {
            return (v2, v1, 0, 10000, 10000)
        };
        let (v4, v5) = if (v2 <= arg6) {
            let v6 = v2 - arg5;
            let v7 = arg6 - arg5;
            (interpolate_factor(7500, 2500, v6, v7), interpolate_factor(12500, 15000, v6, v7))
        } else if (v2 <= arg7) {
            let v8 = v2 - arg6;
            let v9 = arg7 - arg6;
            (interpolate_factor(2000, arg10, v8, v9), interpolate_factor(15000, arg11, v8, v9))
        } else {
            (arg10, arg11)
        };
        let (v10, v11) = if (v1) {
            (clamp_factor(strength_blend_factor(v4, arg9), arg10, arg11), clamp_factor(strength_blend_factor(v5, arg9), arg10, arg11))
        } else {
            (clamp_factor(strength_blend_factor(v5, arg9), arg10, arg11), clamp_factor(strength_blend_factor(v4, arg9), arg10, arg11))
        };
        (v2, v1, v3, v10, v11)
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

    fun risk_base_size<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64) : (u64, bool) {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, arg1)) {
            return (0, true)
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, arg1);
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::abs_net_base(v0), 1000000000), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v0))
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

    fun strength_blend_factor(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= 10000) {
            10000 + ((((arg0 - 10000) as u128) * (arg1 as u128) / 10000) as u64)
        } else {
            10000 - ((((10000 - arg0) as u128) * (arg1 as u128) / 10000) as u64)
        }
    }

    fun taker_edge_ok(arg0: u64, arg1: u64, arg2: bool, arg3: u64) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return false
        };
        arg2 && arg1 > arg0 && ((arg1 - arg0) as u256) * 100000000 >= (arg0 as u256) * (arg3 as u256) || arg0 > arg1 && ((arg0 - arg1) as u256) * 100000000 >= (arg1 as u256) * (arg3 as u256)
    }

    fun taker_inventory_ok(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: u64) : bool {
        if (arg0 == 0) {
            return true
        };
        if (!((arg0 as u128) * 10000 > (arg2 as u128) * 200)) {
            return true
        };
        arg1 != arg3 && arg4 <= arg0
    }

    public fun tk<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::LotusConfig, arg4: u64, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg6), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg5), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T0, T1>(arg2) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::clearing_house_id<T0, T1>(arg2) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg5), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg6);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T0, T1>(arg2) == v0, 1);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg19));
        let v1 = if (arg9 > 0) {
            if (arg9 <= 9223372036854775807) {
                if (arg10 > 0) {
                    if (arg11 > 0) {
                        if (arg12 > 0) {
                            if (arg14 > 0) {
                                arg15 > 0
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
        assert!(v1, 2);
        assert!(arg16 >= 65000, 2);
        let v2 = if (arg17 > 0) {
            if (arg17 <= arg0.i) {
                if (arg14 <= arg0.hm) {
                    arg14 <= arg17
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
        if (arg9 <= arg0.n || arg10 <= arg0.ts) {
            let v3 = TakerCycle{
                desk                 : 0x2::object::id<A<T0, T1>>(arg0),
                sequence             : arg9,
                source_ts_ms         : arg10,
                reason               : 1,
                source_anchor        : arg11,
                live_bid             : 0,
                live_ask             : 0,
                drift_bps            : 0,
                absolute_target      : arg12,
                side_is_ask          : arg13,
                quantity             : arg14,
                limit_price          : arg15,
                required_edge_bps_e4 : arg16,
                position_limit       : arg17,
                position_size_before : 0,
                position_long_before : true,
                position_size_after  : 0,
                position_long_after  : true,
                executed_size        : 0,
                bid_cancel_found     : false,
                ask_cancel_found     : false,
            };
            0x2::event::emit<TakerCycle>(v3);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg5);
            return 0
        };
        arg0.n = arg9;
        arg0.ts = arg10;
        let v4 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), true));
        let v5 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T1>(&arg5), false));
        let v6 = v5 > 0 && v4 > v5;
        let v7 = if (v6) {
            ((((v5 as u128) + (v4 as u128)) / 2) as u64)
        } else {
            0
        };
        let (v8, v9) = 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1::ad(arg11, v7, arg0.drift);
        let v10 = valid_time<T0, T1>(arg0, arg10, 0x2::clock::timestamp_ms(arg18));
        let v11 = if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::version(arg3) == arg4) {
            if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::status(arg3) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::status_normal()) {
                if (!0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_paused<T1>(arg1)) {
                    if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::is_dex_allowed(arg3, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::dex_aftermath_perp())) {
                        if (0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::is_dex_allowed<T1>(arg1, 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::config::dex_aftermath_perp())) {
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
        let v12 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg5);
        let v13 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v12);
        let v14 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v12);
        let v15 = if (v13 > 0) {
            if (v14 > 0) {
                if (arg15 % v13 == 0) {
                    arg14 % v14 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v15, 2);
        let (v16, v17) = base_size<T1>(&arg5, v0);
        let v18 = arg14 <= room(v16, v17, arg17, !arg13);
        let v19 = taker_inventory_ok(v16, v17, arg17, !arg13, arg14);
        let v20 = taker_edge_ok(arg12, arg15, arg13, arg16);
        let v21 = v6 && (arg13 && arg15 <= v5 || arg15 >= v4);
        let v22 = if (v11) {
            if (v10) {
                if (v6) {
                    if (v8) {
                        if (v18) {
                            if (v19) {
                                if (v20) {
                                    v21
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
        let v23 = v22 && order_value_ok(arg14, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T1>(&arg5, arg7, arg18), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v12));
        let v24 = &mut arg5;
        let (_, v26) = cancel_one<T0, T1>(arg0, v24, arg6, true);
        let v27 = &mut arg5;
        let (_, v29) = cancel_one<T0, T1>(arg0, v27, arg6, false);
        let v30 = if (v11) {
            if (v10) {
                if (v6) {
                    if (v8) {
                        if (v18) {
                            if (v19) {
                                if (v20) {
                                    if (v21) {
                                        v23
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
        let (v31, v32, v33) = if (v30) {
            let v34 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg5, &arg0.k, arg6, arg7, arg8, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg18, arg19);
            option_u128(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T1>(&mut v34, arg13, arg14, arg15, 3, 0x1::option::some<u64>(client_id(arg9, arg13)), false, 0x1::option::none<u64>()));
            let (v35, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v34, &arg0.k, arg6, false, false);
            let v37 = v35;
            let (v38, v39) = base_size<T1>(&v37, v0);
            let v40 = executed_in_direction(v16, v17, v38, v39, !arg13);
            assert!(v40 <= arg14, 2);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v37);
            (v38, v39, v40)
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg5);
            (v16, v17, 0)
        };
        let v41 = if (!v10) {
            2
        } else if (!v11) {
            3
        } else if (!v6) {
            4
        } else if (!v8) {
            5
        } else if (!v20) {
            9
        } else if (!v21) {
            10
        } else if (!v18) {
            11
        } else if (!v19) {
            12
        } else if (!v23) {
            7
        } else {
            0
        };
        let v42 = TakerCycle{
            desk                 : 0x2::object::id<A<T0, T1>>(arg0),
            sequence             : arg9,
            source_ts_ms         : arg10,
            reason               : v41,
            source_anchor        : arg11,
            live_bid             : v5,
            live_ask             : v4,
            drift_bps            : v9,
            absolute_target      : arg12,
            side_is_ask          : arg13,
            quantity             : arg14,
            limit_price          : arg15,
            required_edge_bps_e4 : arg16,
            position_limit       : arg17,
            position_size_before : v16,
            position_long_before : v17,
            position_size_after  : v31,
            position_long_after  : v32,
            executed_size        : v33,
            bid_cancel_found     : v26,
            ask_cancel_found     : v29,
        };
        0x2::event::emit<TakerCycle>(v42);
        v33
    }

    public fun u0<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T1>, arg3: u64, arg4: u64, arg5: u64) {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        validate(arg3, arg4, arg5);
        assert!(arg3 <= arg0.hm && arg4 <= arg0.hi, 2);
        arg0.m = arg3;
        arg0.i = arg4;
        arg0.sf = arg5;
    }

    public fun u1<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T1>, arg3: u64, arg4: u64, arg5: u64) {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        validate(arg3, arg4, arg5);
        assert!(arg3 <= arg0.hm, 2);
        assert!((arg4 as u128) <= (arg0.hm as u128) * 2, 2);
        arg0.hi = arg4;
        arg0.m = arg3;
        arg0.i = arg4;
        arg0.sf = arg5;
    }

    public fun u2<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        validate(arg3, arg4, arg5);
        assert!(arg6 > 0 && arg7 > 0, 2);
        assert!(arg8 > 0 && arg8 <= 30000, 2);
        assert!((arg4 as u128) <= (arg3 as u128) * 2 + 1, 2);
        assert!((arg4 as u256) * (arg6 as u256) / 1000000000000 <= (arg7 as u256) * (arg8 as u256) / (10000 as u256), 2);
        arg0.hm = arg3;
        arg0.hi = arg4;
        arg0.m = 0;
        arg0.i = arg4;
        arg0.sf = arg5;
        let v0 = NotionalRiskRetuned{
            desk                 : 0x2::object::id<A<T0, T1>>(arg0),
            hard_max_order       : arg3,
            hard_position_limit  : arg4,
            reference_price      : arg6,
            market_equity_quote  : arg7,
            maximum_leverage_bps : arg8,
        };
        0x2::event::emit<NotionalRiskRetuned>(v0);
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

    fun validate_inventory_cycle_policy(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg0 < arg1) {
            if (arg1 < arg2) {
                arg2 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg3 <= 2000, 2);
        assert!(arg4 <= arg5 && arg5 <= 10, 2);
    }

    fun validate_notional_rebalance<T0, T1>(arg0: &A<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        assert!(arg1 <= 2, 2);
        assert!(arg1 == 0 == arg2 == 0, 2);
        assert!(arg3 > 0 && arg3 <= arg0.i, 2);
        assert!(arg2 <= arg3, 2);
        let v0 = if (arg4 > 0) {
            if (arg4 <= arg5) {
                if (arg5 <= arg0.hm) {
                    arg5 <= arg3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg6 < arg7 && arg7 <= 10000, 2);
        assert!(arg8 > 0 && arg8 <= 10000, 2);
        assert!(arg9 <= 10000, 2);
        assert!(arg10 > 0 && arg10 <= 10000, 2);
        assert!(arg11 >= 10000, 2);
        assert!(arg11 <= 20000, 2);
        assert!(((arg4 as u128) * (arg11 as u128) + 10000 - 1) / 10000 <= (arg5 as u128), 2);
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

    public fun xu<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        assert!(arg0.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T0, T1>>(arg2), 1);
        assert!(arg0.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg4), 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg3), 1);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_executor<T1>(arg1, arg0.d, 0x2::tx_context::sender(arg8));
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

    public fun xup<T0, T1, T2>(arg0: &mut A<T0, T2>, arg1: &A<T1, T2>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T2>, arg3: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::object::id<A<T0, T2>>(arg0) != 0x2::object::id<A<T1, T2>>(arg1), 1);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2) && arg1.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        let v0 = if (arg0.d == arg1.d) {
            if (arg0.p == arg1.p) {
                arg0.a == arg1.a
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg0.c == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(&arg4), 1);
        assert!(arg1.p == 0x2::object::id<0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::PerpAccount<T1, T2>>(arg3), 1);
        assert!(arg1.a == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>>(arg5), 1);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_vault_id<T1, T2>(arg3) == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T2>(arg2), 1);
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg5);
        assert!(0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::aftermath_perp_adapter::account_num<T1, T2>(arg3) == v1, 1);
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_executor<T2>(arg2, arg0.d, 0x2::tx_context::sender(arg9));
        let v2 = &mut arg4;
        let (_, v4) = cancel_one_with_cap<T0, T2>(arg0, v2, arg5, &arg1.k, true);
        let v5 = &mut arg4;
        let (_, v7) = cancel_one_with_cap<T0, T2>(arg0, v5, arg5, &arg1.k, false);
        let (v8, v9) = base_size<T2>(&arg4, v1);
        let v10 = if (v8 > 0) {
            let v11 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg4, &arg1.k, arg5, arg6, arg7, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg8, arg9);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_market_order<T2>(&mut v11, v9, v8, true);
            let (v12, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T2, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v11, &arg1.k, arg5, false, false);
            let v14 = v12;
            let (v15, _) = base_size<T2>(&v14, v1);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(v14);
            v15
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(arg4);
            0
        };
        assert!(v10 == 0, 2);
        arg0.z = true;
        let v17 = Unwind{
            desk             : 0x2::object::id<A<T0, T2>>(arg0),
            size_before      : v8,
            was_long         : v9,
            size_after       : v10,
            bid_cancel_found : v4,
            ask_cancel_found : v7,
        };
        0x2::event::emit<Unwind>(v17);
        v8
    }

    public fun z0<T0, T1>(arg0: &mut A<T0, T1>, arg1: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::Vault<T1>, arg2: &0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::VaultAdminCap<T1>, arg3: bool) {
        0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0xa876c373a5270907acb358d298f6b01d8b8ae991274993b789d94eaae8139264::vault::id<T1>(arg1), 1);
        arg0.z = arg3;
    }

    // decompiled from Move bytecode v7
}

