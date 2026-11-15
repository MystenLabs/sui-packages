module 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::token {
    struct LevToken<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        state: u8,
        treasury: 0x2::coin::TreasuryCap<T0>,
        fees: 0x2::balance::Balance<T0>,
        vault: 0x2::object::ID,
        registry: 0x2::object::ID,
        market: 0x2::object::ID,
        base_oracle: 0x2::object::ID,
        collateral_oracle: 0x2::object::ID,
        custody_cap: 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::OwnerCap,
        long: bool,
        target_bps: u64,
        min_bps: u64,
        max_bps: u64,
        ratio_max_bps: u64,
        max_notional: u64,
        fee_index: u128,
        referrers: 0x2::table::Table<address, address>,
        winddown_after_ms: u64,
        pending_limits: 0x1::option::Option<PendingLimits>,
        pending_margin: 0x1::option::Option<PendingMargin>,
    }

    struct PendingLimits has copy, drop, store {
        min_bps: u64,
        max_bps: u64,
        max_notional: u64,
        after_ms: u64,
    }

    struct PendingMargin has copy, drop, store {
        ratio_max_bps: u64,
        after_ms: u64,
    }

    struct Created has copy, drop {
        token: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        vault: 0x2::object::ID,
        account: 0x2::object::ID,
        market: 0x2::object::ID,
        long: bool,
        target_bps: u64,
        min_bps: u64,
        max_bps: u64,
        max_notional: u64,
        base_oracle: 0x2::object::ID,
        collateral_oracle: 0x2::object::ID,
    }

    struct Minted has copy, drop {
        token: 0x2::object::ID,
        buyer: address,
        deposit: u64,
        fee: u64,
        referrer: address,
        tokens: u64,
        nav: u64,
        supply: u64,
        price: u64,
        oracle: u256,
    }

    struct Redeemed has copy, drop {
        token: 0x2::object::ID,
        seller: address,
        tokens: u64,
        payout: u64,
        fee: u64,
        referrer: address,
        nav: u64,
        supply: u64,
        price: u64,
        oracle: u256,
    }

    struct Rebalanced has copy, drop {
        token: 0x2::object::ID,
        increase: bool,
        size: u64,
        leverage_before: u64,
        leverage_after: u64,
        nav: u64,
        oracle: u256,
    }

    struct MarginRestored has copy, drop {
        token: 0x2::object::ID,
        amount: u64,
    }

    struct MarginReleased has copy, drop {
        token: 0x2::object::ID,
        amount: u64,
    }

    struct FeesAccrued has copy, drop {
        token: 0x2::object::ID,
        tokens: u64,
        supply: u64,
    }

    struct Unwound has copy, drop {
        token: 0x2::object::ID,
        size: u64,
        nav: u64,
        oracle: u256,
    }

    struct FeesCollected has copy, drop {
        token: 0x2::object::ID,
        tokens: u64,
        payout: u64,
    }

    struct StateChanged has copy, drop {
        token: 0x2::object::ID,
        state: u8,
    }

    struct LimitsChanged has copy, drop {
        token: 0x2::object::ID,
        min_bps: u64,
        max_bps: u64,
        max_notional: u64,
    }

    struct Rebound has copy, drop {
        token: 0x2::object::ID,
        base_oracle: 0x2::object::ID,
        collateral_oracle: 0x2::object::ID,
    }

    struct MarginChanged has copy, drop {
        token: 0x2::object::ID,
        ratio_max_bps: u64,
    }

    struct Scheduled has copy, drop {
        token: 0x2::object::ID,
        what: u8,
        after_ms: u64,
    }

    struct Status has copy, drop {
        token: 0x2::object::ID,
        state: u8,
        long: bool,
        target_bps: u64,
        min_bps: u64,
        max_bps: u64,
        nav: u64,
        nav_usd: u64,
        supply: u64,
        price: u64,
        notional_usd: u64,
        leverage_bps: u64,
        max_notional: u64,
        oracle: u256,
        needs_rebalance: bool,
        fees_pending: u64,
        margin_shortfall: u64,
        timestamp_ms: u64,
        schema: u64,
        package_version: u64,
        ratio_max_bps: u64,
        lot: u64,
        free_cash: u64,
        position_collateral: u64,
        winddown_after_ms: u64,
        base_oracle: 0x2::object::ID,
        collateral_oracle: 0x2::object::ID,
        pending: StatusPending,
    }

    struct StatusPending has copy, drop {
        min_bps: u64,
        max_bps: u64,
        max_notional: u64,
        limits_after_ms: u64,
        ratio_max_bps: u64,
        margin_after_ms: u64,
    }

    public fun mint<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: address, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T0>) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_minting(arg0);
        let v0 = if (arg10 == 0) {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::entry_slippage_bps(arg0)
        } else {
            arg10
        };
        assert!(v0 <= 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::emergency_slippage_bps(arg0), 12);
        assert!(arg1.state == 1, 7);
        check<T0, T1>(arg1, arg2, arg3, &arg4, arg5);
        timely(arg13, arg12);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::settle<T1>(arg2, arg3, &mut arg4, arg6, arg7, arg13);
        let v1 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(&arg4, arg6, arg7, arg13);
        accrue<T0, T1>(arg1, arg0, arg13);
        let v2 = referrer_of<T0, T1>(arg1, 0x2::tx_context::sender(arg14), arg11);
        let v3 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::portion(0x2::coin::value<T1>(&arg8), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::mint_fee_bps(arg0));
        if (v3 > 0) {
            let v4 = 0x2::coin::split<T1>(&mut arg8, v3, arg14);
            pay_fee<T1>(arg0, v4, v2, arg14);
        };
        let v5 = 0x2::coin::value<T1>(&arg8);
        assert!(v5 > 0, 3);
        let v6 = 0x2::coin::total_supply<T0>(&arg1.treasury) == 0x2::balance::value<T0>(&arg1.fees);
        if (v6 && 0x2::balance::value<T0>(&arg1.fees) > 0) {
            let v7 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::redeem_assets(0x2::balance::value<T0>(&arg1.fees), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg2, arg3), 0x2::coin::total_supply<T0>(&arg1.treasury), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v1));
            if (v7 > 0) {
                let v8 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::withdraw<T1>(arg2, &arg1.custody_cap, arg3, arg5, v7, arg14);
                pay_fee<T1>(arg0, v8, @0x0, arg14);
            };
            let v9 = 0x2::balance::withdraw_all<T0>(&mut arg1.fees);
            0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg1.treasury), v9);
            let v10 = FeesCollected{
                token  : 0x2::object::id<LevToken<T0, T1>>(arg1),
                tokens : 0x2::balance::value<T0>(&v9),
                payout : v7,
            };
            0x2::event::emit<FeesCollected>(v10);
        };
        let v11 = nav<T1>(arg2, arg3, &arg4, &v1);
        assert!(v6 || v11 > 0, 3);
        let v12 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4));
        let v13 = base<T1>(&arg4, arg3, arg1.long);
        assert!(!v6 || ((v13 / 1000000000) as u64) < v12, 2);
        let (_, v15, v16) = exposure<T1>(arg2, arg3, &arg4, &v1, arg1.long);
        let v17 = if (v6 || v15 == 0) {
            arg1.target_bps
        } else {
            v16
        };
        assert!(v17 <= arg1.max_bps, 13);
        let v18 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v1);
        let v19 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::order_size(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::target_notional(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::collateral_usd_e6(v5, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_price(&v1), v18, false), v17), oracle(&v1), v12);
        assert!(v19 > 0 && !below_min_order<T1>(&arg4, v19, oracle(&v1)), 11);
        let v20 = v13 + (v19 as u256) * 1000000000;
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::assert_notional_limit(v20, oracle(&v1), arg1.max_notional);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::deposit<T1>(arg2, arg3, arg5, arg8);
        let (v21, _) = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::trade_limit<T1>(arg2, &arg1.custody_cap, arg3, arg4, arg6, arg7, opening_side(arg1.long), v19, order_limit<T1>(&arg4, &v1, v0, arg1.long), false, arg13, arg14);
        arg4 = v21;
        assert!(base<T1>(&arg4, arg3, arg1.long) == v20, 5);
        let v23 = nav<T1>(arg2, arg3, &arg4, &v1);
        let (_, _, v26) = exposure<T1>(arg2, arg3, &arg4, &v1, arg1.long);
        assert!(v26 <= arg1.ratio_max_bps, 13);
        let v27 = if (v6) {
            0
        } else {
            v11
        };
        let v28 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::mint_shares(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::contribution(v11, v23, v5), v27, 0x2::coin::total_supply<T0>(&arg1.treasury), v18);
        assert!(v28 >= arg9, 11);
        let v29 = 0x2::coin::total_supply<T0>(&arg1.treasury);
        let v30 = Minted{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg1),
            buyer    : 0x2::tx_context::sender(arg14),
            deposit  : v5,
            fee      : v3,
            referrer : v2,
            tokens   : v28,
            nav      : v23,
            supply   : v29,
            price    : 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::token_price(v23, v29, v18),
            oracle   : oracle(&v1),
        };
        0x2::event::emit<Minted>(v30);
        (arg4, 0x2::coin::mint<T0>(&mut arg1.treasury, v28, arg14))
    }

    fun accrue<T0, T1>(arg0: &mut LevToken<T0, T1>, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = fee_shares<T0, T1>(arg1, arg0, v0);
        arg0.fee_index = 0x1::u128::max(arg0.fee_index, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::streaming_fee_index(arg1, v0));
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.fees, 0x2::coin::mint_balance<T0>(&mut arg0.treasury, v1));
            let v2 = FeesAccrued{
                token  : 0x2::object::id<LevToken<T0, T1>>(arg0),
                tokens : v1,
                supply : 0x2::coin::total_supply<T0>(&arg0.treasury),
            };
            0x2::event::emit<FeesAccrued>(v2);
        };
    }

    public fun activate<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>, arg3: &mut 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        let v0 = if (arg2.state == 0) {
            if (0x2::object::id<0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>>(arg3) == arg2.vault) {
                0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg5) == arg2.market
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::configure_margin<T1>(arg3, &arg2.custody_cap, arg4, arg5, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::position_ratio_bps(arg2.ratio_max_bps));
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::set_paused<T1>(arg3, &arg2.custody_cap, false);
        set_state_internal<T0, T1>(arg2, 1);
    }

    public fun apply_limits<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        assert!(arg1.state != 4 && 0x1::option::is_some<PendingLimits>(&arg1.pending_limits), 7);
        let PendingLimits {
            min_bps      : v0,
            max_bps      : v1,
            max_notional : v2,
            after_ms     : v3,
        } = *0x1::option::borrow<PendingLimits>(&arg1.pending_limits);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_window(v3, arg2);
        assert!(emergency_bps(arg1.target_bps, v1) <= arg1.ratio_max_bps, 2);
        arg1.pending_limits = 0x1::option::none<PendingLimits>();
        arg1.min_bps = v0;
        arg1.max_bps = v1;
        arg1.max_notional = v2;
        let v4 = LimitsChanged{
            token        : 0x2::object::id<LevToken<T0, T1>>(arg1),
            min_bps      : v0,
            max_bps      : v1,
            max_notional : v2,
        };
        0x2::event::emit<LimitsChanged>(v4);
    }

    public fun apply_margin<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        assert!(0x1::option::is_some<PendingMargin>(&arg1.pending_margin) && arg1.state != 4, 7);
        check<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let PendingMargin {
            ratio_max_bps : v0,
            after_ms      : v1,
        } = *0x1::option::borrow<PendingMargin>(&arg1.pending_margin);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_window(v1, arg8);
        assert!(emergency_bps(arg1.target_bps, arg1.max_bps) <= v0, 2);
        assert_venue_margin<T1>(arg4, v0);
        arg1.pending_margin = 0x1::option::none<PendingMargin>();
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg3))) {
            let v2 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::prices<T1>(arg4, arg6, arg7, arg8);
            let v3 = 0x1::u64::min(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::margin_shortfall<T1>(arg3, arg4, &v2, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::position_ratio_bps(v0)), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg2, arg3));
            if (v3 > 0) {
                0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::allocate_margin<T1>(arg2, &arg1.custody_cap, arg3, arg4, v3);
                let v4 = MarginRestored{
                    token  : 0x2::object::id<LevToken<T0, T1>>(arg1),
                    amount : v3,
                };
                0x2::event::emit<MarginRestored>(v4);
            };
        };
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::configure_margin<T1>(arg2, &arg1.custody_cap, arg3, arg4, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::position_ratio_bps(v0));
        arg1.ratio_max_bps = v0;
        let v5 = MarginChanged{
            token         : 0x2::object::id<LevToken<T0, T1>>(arg1),
            ratio_max_bps : v0,
        };
        0x2::event::emit<MarginChanged>(v5);
    }

    fun assert_band(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= 10000 && arg0 <= 100000, 2);
        assert!(arg1 < arg0 && arg2 > arg0, 2);
        assert!(arg1 * 2 >= arg0 && arg2 * 2 <= arg0 * 3, 2);
    }

    fun assert_execution(arg0: u64, arg1: u64, arg2: u256, arg3: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::Prices, arg4: u64) {
        if (arg1 >= arg0) {
            return
        };
        assert!((0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::collateral_usd_e6(arg0 - arg1, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_price(arg3), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(arg3), true) as u128) * 10000 <= (0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::notional_usd_e6(arg2, oracle(arg3)) as u128) * (arg4 as u128), 12);
    }

    fun assert_venue_margin<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul((0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::position_ratio_bps(arg1) as u256) * 100000000000000, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::one(), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(v0))) >= 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(v0) + 20000000000000000, 2);
    }

    public fun band<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>) : (u64, u64) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        (arg1.min_bps, arg1.max_bps)
    }

    fun base<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: bool) : u256 {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1))) {
            return 0
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let (v1, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v0);
        if (arg2) {
            assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v0), 2);
            v1
        } else {
            assert!(v1 == 0 || 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v1), 2);
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v1)
        }
    }

    public fun begin_winddown<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>, arg3: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(arg2.state == 2 && arg2.winddown_after_ms > 0, 7);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_window(arg2.winddown_after_ms, arg3);
        accrue<T0, T1>(arg2, arg1, arg3);
        arg2.winddown_after_ms = 0;
        set_state_internal<T0, T1>(arg2, 3);
    }

    fun below_min_order<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: u256) : bool {
        (arg1 as u256) * 1000000000 * arg2 / 1000000000000000000 < 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0))
    }

    public fun cancel_limits<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(0x1::option::is_some<PendingLimits>(&arg2.pending_limits), 7);
        arg2.pending_limits = 0x1::option::none<PendingLimits>();
        let v0 = Scheduled{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg2),
            what     : 1,
            after_ms : 0,
        };
        0x2::event::emit<Scheduled>(v0);
    }

    public fun cancel_margin<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(0x1::option::is_some<PendingMargin>(&arg2.pending_margin), 7);
        arg2.pending_margin = 0x1::option::none<PendingMargin>();
        let v0 = Scheduled{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg2),
            what     : 3,
            after_ms : 0,
        };
        0x2::event::emit<Scheduled>(v0);
    }

    public fun cancel_winddown<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(arg2.state == 1 || arg2.state == 2, 7);
        assert!(arg2.winddown_after_ms > 0, 7);
        arg2.winddown_after_ms = 0;
        let v0 = Scheduled{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg2),
            what     : 0,
            after_ms : 0,
        };
        0x2::event::emit<Scheduled>(v0);
    }

    fun check<T0, T1>(arg0: &LevToken<T0, T1>, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry) {
        let v0 = if (0x2::object::id<0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>>(arg1) == arg0.vault) {
            if (0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::account_id<T1>(arg1) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg2)) {
                if (0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == arg0.market) {
                    0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg4) == arg0.registry
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    fun chunk_size<T0>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::Prices) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1));
        0x1::u64::max(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::order_size(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::unwind_chunk(arg0), oracle(arg2), v0), v0)
    }

    fun close_share<T0, T1>(arg0: &LevToken<T0, T1>, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::Prices, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T1>) {
        assert!(arg8 > 0 && arg8 <= arg9, 3);
        let v0 = nav<T1>(arg1, arg2, &arg3, arg7);
        let v1 = base<T1>(&arg3, arg2, arg0.long);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg3));
        let v3 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::closing_size(((v1 / 1000000000) as u64), arg8, arg9, v2);
        if (v3 > 0) {
            let (v4, _) = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::trade<T1>(arg1, &arg0.custody_cap, arg2, arg3, arg5, arg6, closing_side(arg0.long), v3, true, arg10, arg11);
            arg3 = v4;
            assert!(base<T1>(&arg3, arg2, arg0.long) + (v3 as u256) * 1000000000 == v1, 5);
        };
        if (arg8 == arg9) {
            assert!(((base<T1>(&arg3, arg2, arg0.long) / 1000000000) as u64) < v2, 5);
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::release_margin<T1>(arg1, &arg0.custody_cap, arg2, &mut arg3, arg5, arg6, arg10);
        };
        let v6 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::share_payout(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::redeem_assets(arg8, v0, arg9, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(arg7)), v0, nav<T1>(arg1, arg2, &arg3, arg7), share_of(v1, arg8, arg9), (v3 as u256) * 1000000000);
        let v7 = v6;
        if (v6 > 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg1, arg2) && arg8 < arg9) {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::configure_margin<T1>(arg1, &arg0.custody_cap, arg2, &mut arg3, venue_floor_bps<T1>(&arg3));
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::release_margin<T1>(arg1, &arg0.custody_cap, arg2, &mut arg3, arg5, arg6, arg10);
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::configure_margin<T1>(arg1, &arg0.custody_cap, arg2, &mut arg3, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::position_ratio_bps(arg0.ratio_max_bps));
        };
        if (arg8 == arg9) {
            v7 = 0x1::u64::min(v6, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg1, arg2));
        };
        assert!(v7 > 0 && v7 <= 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg1, arg2), 6);
        (arg3, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::withdraw<T1>(arg1, &arg0.custody_cap, arg2, arg4, v7, arg11))
    }

    fun closing_side(arg0: bool) : bool {
        arg0
    }

    public fun collect_fees<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::KeeperCap, arg2: &mut LevToken<T0, T1>, arg3: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_keeper(arg0, arg1);
        assert!(arg2.state != 0, 7);
        check<T0, T1>(arg2, arg3, arg4, &arg5, arg6);
        timely(arg10, arg9);
        let v0 = if (arg2.state == 4) {
            let v1 = 0x2::balance::value<T0>(&arg2.fees);
            assert!(v1 > 0, 3);
            pay_settled<T0, T1>(arg2, arg3, arg4, &arg5, arg6, v1, 0x2::coin::total_supply<T0>(&arg2.treasury), arg11)
        } else {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::settle<T1>(arg3, arg4, &mut arg5, arg7, arg8, arg10);
            let v2 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(&arg5, arg7, arg8, arg10);
            accrue<T0, T1>(arg2, arg0, arg10);
            let v3 = 0x2::balance::value<T0>(&arg2.fees);
            assert!(v3 > 0, 3);
            let v4 = 0x2::coin::total_supply<T0>(&arg2.treasury);
            let v5 = nav<T1>(arg3, arg4, &arg5, &v2);
            let v6 = base<T1>(&arg5, arg4, arg2.long);
            let v7 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::closing_size(((v6 / 1000000000) as u64), v3, v4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg5)));
            if (v7 > 0) {
                let v8 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::rebalance_slippage_bps(arg0);
                let (v9, _) = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::trade_limit<T1>(arg3, &arg2.custody_cap, arg4, arg5, arg7, arg8, closing_side(arg2.long), v7, order_limit<T1>(&arg5, &v2, v8, !arg2.long), true, arg10, arg11);
                arg5 = v9;
                let v11 = v6 - base<T1>(&arg5, arg4, arg2.long);
                assert!(v11 == (v7 as u256) * 1000000000, 14);
                assert_execution(v5, nav<T1>(arg3, arg4, &arg5, &v2), v11, &v2, v8);
            };
            let v12 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::share_payout(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::redeem_assets(v3, v5, v4, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v2)), v5, nav<T1>(arg3, arg4, &arg5, &v2), share_of(v6, v3, v4), v6 - base<T1>(&arg5, arg4, arg2.long));
            assert!(v12 > 0 && v12 <= 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg3, arg4), 6);
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::withdraw<T1>(arg3, &arg2.custody_cap, arg4, arg6, v12, arg11)
        };
        let v13 = v0;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg2.treasury), 0x2::balance::withdraw_all<T0>(&mut arg2.fees));
        pay_fee<T1>(arg0, v13, @0x0, arg11);
        let v14 = FeesCollected{
            token  : 0x2::object::id<LevToken<T0, T1>>(arg2),
            tokens : 0x2::balance::value<T0>(&arg2.fees),
            payout : 0x2::coin::value<T1>(&v13),
        };
        0x2::event::emit<FeesCollected>(v14);
        arg5
    }

    public fun create<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 2);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg3) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg2)) && !0x2::coin_registry::is_regulated<T0>(arg3), 2);
        assert_band(arg9, arg10, arg11);
        assert!(arg12 > 0, 2);
        let v0 = emergency_bps(arg9, arg11);
        assert_venue_margin<T1>(arg5, v0);
        let v1 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(arg5, arg6, arg7, arg13);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::assert_collateral_scaling(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v1));
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg5));
        assert!(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::limit_price(oracle(&v1), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::rebalance_slippage_bps(arg1) / 2, true, v2) > 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::limit_price(oracle(&v1), 0, true, v2), 2);
        let (v3, v4) = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::new<T1>(arg4, 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg5), 18446744073709551615, arg14);
        let v5 = v3;
        let v6 = LevToken<T0, T1>{
            id                : 0x2::object::new(arg14),
            state             : 0,
            treasury          : arg2,
            fees              : 0x2::balance::zero<T0>(),
            vault             : 0x2::object::id<0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>>(&v5),
            registry          : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg4),
            market            : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg5),
            base_oracle       : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg6),
            collateral_oracle : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg7),
            custody_cap       : v4,
            long              : arg8,
            target_bps        : arg9,
            min_bps           : arg10,
            max_bps           : arg11,
            ratio_max_bps     : v0,
            max_notional      : arg12,
            fee_index         : 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::streaming_fee_index(arg1, 0x2::clock::timestamp_ms(arg13)),
            referrers         : 0x2::table::new<address, address>(arg14),
            winddown_after_ms : 0,
            pending_limits    : 0x1::option::none<PendingLimits>(),
            pending_margin    : 0x1::option::none<PendingMargin>(),
        };
        let v7 = Created{
            token             : 0x2::object::id<LevToken<T0, T1>>(&v6),
            coin_type         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            vault             : 0x2::object::id<0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>>(&v5),
            account           : 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::account_id<T1>(&v5),
            market            : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg5),
            long              : arg8,
            target_bps        : arg9,
            min_bps           : arg10,
            max_bps           : arg11,
            max_notional      : arg12,
            base_oracle       : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg6),
            collateral_oracle : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg7),
        };
        0x2::event::emit<Created>(v7);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::share<T1>(v5);
        0x2::transfer::share_object<LevToken<T0, T1>>(v6);
    }

    fun emergency_bps(arg0: u64, arg1: u64) : u64 {
        arg1 + arg1 - arg0
    }

    fun exposure<T0>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::Prices, arg4: bool) : (u64, u64, u64) {
        let v0 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::collateral_usd_e6(nav<T0>(arg0, arg1, arg2, arg3), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_price(arg3), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(arg3), false);
        let v1 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::notional_usd_e6(base<T0>(arg2, arg1, arg4), oracle(arg3));
        (v0, v1, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::leverage_bps(v1, v0))
    }

    fun fee_shares<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>, arg2: u64) : u64 {
        if (arg1.state != 1 && arg1.state != 2) {
            return 0
        };
        let v0 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::streaming_fee_index(arg0, arg2);
        if (v0 <= arg1.fee_index) {
            return 0
        };
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::streaming_fee_shares(0x2::coin::total_supply<T0>(&arg1.treasury) - 0x2::balance::value<T0>(&arg1.fees), v0 - arg1.fee_index)
    }

    public fun long<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>) : bool {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        arg1.long
    }

    public fun lower_cap<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>, arg3: u64) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(arg3 > 0 && arg3 < arg2.max_notional, 2);
        arg2.max_notional = arg3;
        if (0x1::option::is_some<PendingLimits>(&arg2.pending_limits)) {
            arg2.pending_limits = 0x1::option::none<PendingLimits>();
            let v0 = Scheduled{
                token    : 0x2::object::id<LevToken<T0, T1>>(arg2),
                what     : 1,
                after_ms : 0,
            };
            0x2::event::emit<Scheduled>(v0);
        };
        let v1 = LimitsChanged{
            token        : 0x2::object::id<LevToken<T0, T1>>(arg2),
            min_bps      : arg2.min_bps,
            max_bps      : arg2.max_bps,
            max_notional : arg3,
        };
        0x2::event::emit<LimitsChanged>(v1);
    }

    public fun market_id<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>) : 0x2::object::ID {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        arg1.market
    }

    public fun max_notional<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>) : u64 {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        arg1.max_notional
    }

    fun nav<T0>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::Prices) : u64 {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::total<T0>(arg0, arg1, arg2, arg3, 0)
    }

    fun opening_side(arg0: bool) : bool {
        !arg0
    }

    fun oracle(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::Prices) : u256 {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::mark(arg0)
    }

    fun order_limit<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::Prices, arg2: u64, arg3: bool) : u64 {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::limit_price(oracle(arg1), arg2, arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0)))
    }

    fun pay_fee<T0>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 != @0x0) {
            let v0 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::portion(0x2::coin::value<T0>(&arg1), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::referral_bps(arg0));
            if (v0 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0, arg3), arg2);
            };
        };
        let v1 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::portion(0x2::coin::value<T0>(&arg1), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::ppx_bps(arg0));
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg3), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::ppx_recipient(arg0));
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::treasury(arg0));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    fun pay_settled<T0, T1>(arg0: &LevToken<T0, T1>, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == arg0.market && 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::account_id<T1>(arg1) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg2), 1);
        let v0 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::redeem_assets(arg5, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg1, arg2), arg6, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg3)));
        assert!(v0 > 0, 3);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::withdraw<T1>(arg1, &arg0.custody_cap, arg2, arg4, v0, arg7)
    }

    fun pending_of<T0, T1>(arg0: &LevToken<T0, T1>) : StatusPending {
        let (v0, v1, v2, v3) = if (0x1::option::is_some<PendingLimits>(&arg0.pending_limits)) {
            let v4 = 0x1::option::borrow<PendingLimits>(&arg0.pending_limits);
            (v4.min_bps, v4.max_bps, v4.max_notional, v4.after_ms)
        } else {
            (0, 0, 0, 0)
        };
        let (v5, v6) = if (0x1::option::is_some<PendingMargin>(&arg0.pending_margin)) {
            let v7 = 0x1::option::borrow<PendingMargin>(&arg0.pending_margin);
            (v7.ratio_max_bps, v7.after_ms)
        } else {
            (0, 0)
        };
        StatusPending{
            min_bps         : v0,
            max_bps         : v1,
            max_notional    : v2,
            limits_after_ms : v3,
            ratio_max_bps   : v5,
            margin_after_ms : v6,
        }
    }

    fun position_collateral<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: u256) : u64 {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1))) {
            return 0
        };
        let v0 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1)));
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0)) {
            0
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v0, arg2)
        }
    }

    public fun propose_limits<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(arg2.state != 4, 7);
        assert_band(arg2.target_bps, arg3, arg4);
        assert!(emergency_bps(arg2.target_bps, arg4) <= arg2.ratio_max_bps && arg5 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg6) + 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::notice_ms();
        let v1 = PendingLimits{
            min_bps      : arg3,
            max_bps      : arg4,
            max_notional : arg5,
            after_ms     : v0,
        };
        arg2.pending_limits = 0x1::option::some<PendingLimits>(v1);
        let v2 = Scheduled{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg2),
            what     : 1,
            after_ms : v0,
        };
        0x2::event::emit<Scheduled>(v2);
    }

    public fun propose_margin<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: u64, arg5: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        let v0 = if (arg2.state != 0) {
            if (arg2.state != 4) {
                0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == arg2.market
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        assert!(emergency_bps(arg2.target_bps, arg2.max_bps) <= arg4, 2);
        assert_venue_margin<T1>(arg3, arg4);
        let v1 = 0x2::clock::timestamp_ms(arg5) + 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::notice_ms();
        let v2 = PendingMargin{
            ratio_max_bps : arg4,
            after_ms      : v1,
        };
        arg2.pending_margin = 0x1::option::some<PendingMargin>(v2);
        let v3 = Scheduled{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg2),
            what     : 3,
            after_ms : v1,
        };
        0x2::event::emit<Scheduled>(v3);
    }

    public fun rebalance<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        rebalance_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, false, arg8, arg9, arg10)
    }

    public fun rebalance_down<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::KeeperCap, arg2: &mut LevToken<T0, T1>, arg3: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_keeper(arg0, arg1);
        rebalance_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, false, true, arg9, arg10, arg11)
    }

    fun rebalance_internal<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        let v0 = if (arg1.state == 1) {
            true
        } else if (arg1.state == 2) {
            true
        } else {
            arg1.state == 3
        };
        assert!(v0, 7);
        check<T0, T1>(arg1, arg2, arg3, &arg4, arg5);
        timely(arg11, arg10);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::settle<T1>(arg2, arg3, &mut arg4, arg6, arg7, arg11);
        let v1 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(&arg4, arg6, arg7, arg11);
        accrue<T0, T1>(arg1, arg0, arg11);
        assert!(0x2::coin::total_supply<T0>(&arg1.treasury) > 0x2::balance::value<T0>(&arg1.fees), 7);
        let (_, _, v4) = exposure<T1>(arg2, arg3, &arg4, &v1, arg1.long);
        assert!(arg8 && v4 < arg1.min_bps || arg9 && v4 > arg1.max_bps || v4 > arg1.ratio_max_bps, 9);
        let (v5, v6) = rebalance_order<T0, T1>(arg1, arg2, arg3, &arg4, &v1);
        let v7 = v6;
        let v8 = if (v6 > 0) {
            if (v5 == arg8) {
                !v5 || arg1.state != 3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 3);
        if (!arg9) {
            v7 = 0x1::u64::min(v6, chunk_size<T1>(arg0, &arg4, &v1));
        };
        let v9 = base<T1>(&arg4, arg3, arg1.long);
        let v10 = nav<T1>(arg2, arg3, &arg4, &v1);
        let v11 = if (arg9 && v4 > arg1.ratio_max_bps) {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::emergency_slippage_bps(arg0)
        } else {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::rebalance_slippage_bps(arg0)
        };
        let v12 = v5 && opening_side(arg1.long) || closing_side(arg1.long);
        let (v13, _) = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::trade_limit<T1>(arg2, &arg1.custody_cap, arg3, arg4, arg6, arg7, v12, v7, order_limit<T1>(&arg4, &v1, v11, v5 == arg1.long), !v5, arg11, arg12);
        arg4 = v13;
        let v15 = if (v5) {
            base<T1>(&arg4, arg3, arg1.long) - v9
        } else {
            v9 - base<T1>(&arg4, arg3, arg1.long)
        };
        assert!(v15 > 0 && v15 <= (v7 as u256) * 1000000000, 14);
        let (_, _, v18) = exposure<T1>(arg2, arg3, &arg4, &v1, arg1.long);
        assert!(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::distance(v18, arg1.target_bps) < 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::distance(v4, arg1.target_bps), 10);
        assert_execution(v10, nav<T1>(arg2, arg3, &arg4, &v1), v15, &v1, v11);
        let v19 = Rebalanced{
            token           : 0x2::object::id<LevToken<T0, T1>>(arg1),
            increase        : v5,
            size            : ((v15 / 1000000000) as u64),
            leverage_before : v4,
            leverage_after  : v18,
            nav             : nav<T1>(arg2, arg3, &arg4, &v1),
            oracle          : oracle(&v1),
        };
        0x2::event::emit<Rebalanced>(v19);
        arg4
    }

    fun rebalance_order<T0, T1>(arg0: &LevToken<T0, T1>, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::Prices) : (bool, u64) {
        let (v0, v1, _) = exposure<T1>(arg1, arg2, arg3, arg4, arg0.long);
        let v3 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::target_notional(v0, arg0.target_bps);
        let v4 = v3 > v1;
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg3));
        let v6 = oracle(arg4);
        let v7 = base<T1>(arg3, arg2, arg0.long);
        let v8 = if (v4) {
            let v9 = (arg0.max_notional as u256) * 1000000000000000000000000000000 / v6;
            let v10 = if (v9 > v7) {
                (v9 - v7) / 1000000000
            } else {
                0
            };
            let v11 = (0x1::u256::min((0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::order_size(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::distance(v3, v1), v6, v5) as u256), v10 / (v5 as u256) * (v5 as u256)) as u64);
            let v8 = v11;
            if (v11 > 0 && below_min_order<T1>(arg3, v11, v6)) {
                v8 = 0;
            };
            v8
        } else {
            0x1::u64::min(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::order_size(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::distance(v3, v1), v6, v5), ((v7 / 1000000000) as u64) / v5 * v5)
        };
        (v4, v8)
    }

    public fun rebalance_up<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::KeeperCap, arg2: &mut LevToken<T0, T1>, arg3: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_keeper(arg0, arg1);
        rebalance_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, true, true, arg9, arg10, arg11)
    }

    public fun redeem<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: 0x2::coin::Coin<T0>, arg9: u64, arg10: address, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T1>) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        assert!(arg1.state != 0, 7);
        check<T0, T1>(arg1, arg2, arg3, &arg4, arg5);
        timely(arg12, arg11);
        let v0 = referrer_of<T0, T1>(arg1, 0x2::tx_context::sender(arg13), arg10);
        let v1 = 0x2::coin::value<T0>(&arg8);
        let (v2, v3, v4, v5) = if (arg1.state == 4) {
            let v6 = 0x2::coin::total_supply<T0>(&arg1.treasury);
            let v7 = v1 == v6 - 0x2::balance::value<T0>(&arg1.fees);
            let v8 = if (v7) {
                v6
            } else {
                v1
            };
            let v9 = pay_settled<T0, T1>(arg1, arg2, arg3, &arg4, arg5, v8, v6, arg13);
            0x2::coin::burn<T0>(&mut arg1.treasury, arg8);
            let v10 = if (v7) {
                settle_fee_tokens<T0, T1>(arg1, arg0, v9, v6, arg13)
            } else {
                v9
            };
            let v11 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg2, arg3);
            (v10, v11, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::token_price(v11, 0x2::coin::total_supply<T0>(&arg1.treasury), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4))), 0)
        } else {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::settle<T1>(arg2, arg3, &mut arg4, arg6, arg7, arg12);
            let v12 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(&arg4, arg6, arg7, arg12);
            accrue<T0, T1>(arg1, arg0, arg12);
            let v13 = 0x2::coin::total_supply<T0>(&arg1.treasury);
            let v14 = v1 == v13 - 0x2::balance::value<T0>(&arg1.fees);
            let v15 = if (v14) {
                v13
            } else {
                v1
            };
            let (v16, v17) = close_share<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v12, v15, v13, arg12, arg13);
            arg4 = v16;
            0x2::coin::burn<T0>(&mut arg1.treasury, arg8);
            let v18 = if (v14) {
                settle_fee_tokens<T0, T1>(arg1, arg0, v17, v13, arg13)
            } else {
                v17
            };
            let v19 = nav<T1>(arg2, arg3, &arg4, &v12);
            (v18, v19, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::token_price(v19, 0x2::coin::total_supply<T0>(&arg1.treasury), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v12)), oracle(&v12))
        };
        let v20 = v2;
        let v21 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::portion(0x2::coin::value<T1>(&v20), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::redeem_fee_bps(arg0));
        if (v21 > 0) {
            let v22 = 0x2::coin::split<T1>(&mut v20, v21, arg13);
            pay_fee<T1>(arg0, v22, v0, arg13);
        };
        assert!(0x2::coin::value<T1>(&v20) >= arg9, 11);
        let v23 = Redeemed{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg1),
            seller   : 0x2::tx_context::sender(arg13),
            tokens   : v1,
            payout   : 0x2::coin::value<T1>(&v20),
            fee      : v21,
            referrer : v0,
            nav      : v3,
            supply   : 0x2::coin::total_supply<T0>(&arg1.treasury),
            price    : v4,
            oracle   : v5,
        };
        0x2::event::emit<Redeemed>(v23);
        (arg4, v20)
    }

    public fun redeem_partial<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: 0x2::coin::Coin<T0>, arg9: u64, arg10: u64, arg11: address, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        assert!(arg1.state != 0 && arg1.state != 4, 7);
        check<T0, T1>(arg1, arg2, arg3, &arg4, arg5);
        timely(arg13, arg12);
        let v0 = if (arg9 == 0) {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::rebalance_slippage_bps(arg0)
        } else {
            arg9
        };
        assert!(v0 <= 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::emergency_slippage_bps(arg0), 12);
        let v1 = referrer_of<T0, T1>(arg1, 0x2::tx_context::sender(arg14), arg11);
        let v2 = 0x2::coin::value<T0>(&arg8);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::settle<T1>(arg2, arg3, &mut arg4, arg6, arg7, arg13);
        let v3 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(&arg4, arg6, arg7, arg13);
        accrue<T0, T1>(arg1, arg0, arg13);
        let v4 = 0x2::coin::total_supply<T0>(&arg1.treasury);
        let v5 = v2 == v4 - 0x2::balance::value<T0>(&arg1.fees);
        let v6 = if (v5) {
            v4
        } else {
            v2
        };
        assert!(v6 > 0 && v6 <= v4, 3);
        let v7 = nav<T1>(arg2, arg3, &arg4, &v3);
        let v8 = base<T1>(&arg4, arg3, arg1.long);
        let v9 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4));
        let v10 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::closing_size(((v8 / 1000000000) as u64), v6, v4, v9);
        if (v10 > 0) {
            let (v11, _) = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::trade_limit<T1>(arg2, &arg1.custody_cap, arg3, arg4, arg6, arg7, closing_side(arg1.long), v10, order_limit<T1>(&arg4, &v3, v0, !arg1.long), true, arg13, arg14);
            arg4 = v11;
        };
        let v13 = v8 - base<T1>(&arg4, arg3, arg1.long);
        let v14 = v13 == (v10 as u256) * 1000000000;
        let v15 = if (v14) {
            v6
        } else {
            assert!(v13 > 0, 14);
            (0x1::u256::min(v13 * (v4 as u256) / v8, (v2 as u256)) as u64)
        };
        assert!(v15 > 0, 14);
        let v16 = v14 && v5;
        if (v16) {
            assert!(((base<T1>(&arg4, arg3, arg1.long) / 1000000000) as u64) < v9, 5);
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::release_margin<T1>(arg2, &arg1.custody_cap, arg3, &mut arg4, arg6, arg7, arg13);
        };
        let v17 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::share_payout(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::redeem_assets(v15, v7, v4, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v3)), v7, nav<T1>(arg2, arg3, &arg4, &v3), share_of(v8, v15, v4), v13);
        let v18 = v17;
        if (v17 > 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg2, arg3) && !v16) {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::configure_margin<T1>(arg2, &arg1.custody_cap, arg3, &mut arg4, venue_floor_bps<T1>(&arg4));
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::release_margin<T1>(arg2, &arg1.custody_cap, arg3, &mut arg4, arg6, arg7, arg13);
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::configure_margin<T1>(arg2, &arg1.custody_cap, arg3, &mut arg4, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::position_ratio_bps(arg1.ratio_max_bps));
        };
        if (v16) {
            v18 = 0x1::u64::min(v17, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg2, arg3));
        };
        assert!(v18 > 0 && v18 <= 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg2, arg3), 6);
        let v19 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::withdraw<T1>(arg2, &arg1.custody_cap, arg3, arg5, v18, arg14);
        let v20 = if (v16) {
            v2
        } else {
            v15
        };
        0x2::coin::burn<T0>(&mut arg1.treasury, 0x2::coin::split<T0>(&mut arg8, v20, arg14));
        if (v16) {
            let v21 = v19;
            v19 = settle_fee_tokens<T0, T1>(arg1, arg0, v21, v4, arg14);
        };
        let v22 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::portion(0x2::coin::value<T1>(&v19), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::redeem_fee_bps(arg0));
        if (v22 > 0) {
            let v23 = 0x2::coin::split<T1>(&mut v19, v22, arg14);
            pay_fee<T1>(arg0, v23, v1, arg14);
        };
        assert!((0x2::coin::value<T1>(&v19) as u128) * (v2 as u128) >= (arg10 as u128) * (v20 as u128), 11);
        let v24 = nav<T1>(arg2, arg3, &arg4, &v3);
        let v25 = Redeemed{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg1),
            seller   : 0x2::tx_context::sender(arg14),
            tokens   : v20,
            payout   : 0x2::coin::value<T1>(&v19),
            fee      : v22,
            referrer : v1,
            nav      : v24,
            supply   : 0x2::coin::total_supply<T0>(&arg1.treasury),
            price    : 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::token_price(v24, 0x2::coin::total_supply<T0>(&arg1.treasury), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v3)),
            oracle   : oracle(&v3),
        };
        0x2::event::emit<Redeemed>(v25);
        (arg4, v19, arg8)
    }

    fun referrer_of<T0, T1>(arg0: &mut LevToken<T0, T1>, arg1: address, arg2: address) : address {
        if (0x2::table::contains<address, address>(&arg0.referrers, arg1)) {
            return *0x2::table::borrow<address, address>(&arg0.referrers, arg1)
        };
        if (arg2 == @0x0 || arg2 == arg1) {
            return @0x0
        };
        0x2::table::add<address, address>(&mut arg0.referrers, arg1, arg2);
        arg2
    }

    public fun release_settled_margin<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        let (v0, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settlement_valuation_prices<T1>(arg4);
        assert!(arg1.state == 4 || v0, 7);
        check<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v3 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::release_margin<T1>(arg2, &arg1.custody_cap, arg3, arg4, arg6, arg7, arg8);
        assert!(v3 > 0, 3);
        let v4 = MarginReleased{
            token  : 0x2::object::id<LevToken<T0, T1>>(arg1),
            amount : v3,
        };
        0x2::event::emit<MarginReleased>(v4);
    }

    public fun restore_margin<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        let v0 = if (arg1.state == 1) {
            true
        } else if (arg1.state == 2) {
            true
        } else {
            arg1.state == 3
        };
        assert!(v0, 7);
        check<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::settle<T1>(arg2, arg3, arg4, arg6, arg7, arg8);
        let v1 = shortfall<T0, T1>(arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        assert!(v1 > 0, 3);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::allocate_margin<T1>(arg2, &arg1.custody_cap, arg3, arg4, v1);
        let v2 = MarginRestored{
            token  : 0x2::object::id<LevToken<T0, T1>>(arg1),
            amount : v1,
        };
        0x2::event::emit<MarginRestored>(v2);
    }

    public fun schedule_winddown<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>, arg3: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(arg2.state == 1 || arg2.state == 2, 7);
        arg2.winddown_after_ms = 0x2::clock::timestamp_ms(arg3) + 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::notice_ms();
        if (arg2.state == 1) {
            set_state_internal<T0, T1>(arg2, 2);
        };
        let v0 = Scheduled{
            token    : 0x2::object::id<LevToken<T0, T1>>(arg2),
            what     : 0,
            after_ms : arg2.winddown_after_ms,
        };
        0x2::event::emit<Scheduled>(v0);
    }

    public fun set_minting<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::AdminCap, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: &mut LevToken<T0, T1>, arg3: bool) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg1);
        assert!(arg2.state == 1 || arg2.state == 2, 7);
        assert!(!arg3 || arg2.winddown_after_ms == 0, 7);
        let v0 = if (arg3) {
            1
        } else {
            2
        };
        set_state_internal<T0, T1>(arg2, v0);
    }

    fun set_state_internal<T0, T1>(arg0: &mut LevToken<T0, T1>, arg1: u8) {
        arg0.state = arg1;
        let v0 = StateChanged{
            token : 0x2::object::id<LevToken<T0, T1>>(arg0),
            state : arg1,
        };
        0x2::event::emit<StateChanged>(v0);
    }

    fun settle_fee_tokens<T0, T1>(arg0: &mut LevToken<T0, T1>, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::balance::value<T0>(&arg0.fees);
        if (v0 == 0) {
            return arg2
        };
        let v1 = (((0x2::coin::value<T1>(&arg2) as u128) * (v0 as u128) / (arg3 as u128)) as u64);
        if (v1 > 0) {
            let v2 = 0x2::coin::split<T1>(&mut arg2, v1, arg4);
            pay_fee<T1>(arg1, v2, @0x0, arg4);
        };
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury), 0x2::balance::withdraw_all<T0>(&mut arg0.fees));
        let v3 = FeesCollected{
            token  : 0x2::object::id<LevToken<T0, T1>>(arg0),
            tokens : v0,
            payout : v1,
        };
        0x2::event::emit<FeesCollected>(v3);
        arg2
    }

    public fun settle_if_flat<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        let (v0, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settlement_valuation_prices<T1>(arg4);
        assert!(arg1.state == 3 || v0 && (arg1.state == 1 || arg1.state == 2), 7);
        let v3 = if (0x2::object::id<0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>>(arg2) == arg1.vault) {
            if (0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg4) == arg1.market) {
                0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::account_id<T1>(arg2) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 1);
        assert!(((base<T1>(arg4, arg3, arg1.long) / 1000000000) as u64) < 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg4)), 2);
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg3))) {
            assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T1>(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg3))) == 0, 2);
        };
        accrue<T0, T1>(arg1, arg0, arg5);
        set_state_internal<T0, T1>(arg1, 4);
    }

    fun share_of(arg0: u256, arg1: u64, arg2: u64) : u256 {
        arg0 * (arg1 as u256) / (arg2 as u256)
    }

    fun shortfall<T0, T1>(arg0: &LevToken<T0, T1>, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : u64 {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg2))) {
            return 0
        };
        let v0 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::prices<T1>(arg3, arg4, arg5, arg6);
        0x1::u64::min(0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::margin_shortfall<T1>(arg2, arg3, &v0, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::position_ratio_bps(arg0.ratio_max_bps)), 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg1, arg2))
    }

    public fun state<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>) : u8 {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        arg1.state
    }

    public fun status<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock) : Status {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        check<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        if (arg1.state == 4) {
            let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg4));
            let v1 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg2, arg3);
            let v2 = 0x2::coin::total_supply<T0>(&arg1.treasury);
            let v3 = if (v2 == 0) {
                0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::token_price(0, 0, v0)
            } else {
                0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::token_price(v1, v2, v0)
            };
            return Status{
                token               : 0x2::object::id<LevToken<T0, T1>>(arg1),
                state               : arg1.state,
                long                : arg1.long,
                target_bps          : arg1.target_bps,
                min_bps             : arg1.min_bps,
                max_bps             : arg1.max_bps,
                nav                 : v1,
                nav_usd             : 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::collateral_usd_e6(v1, 1000000000000000000, v0, false),
                supply              : v2,
                price               : v3,
                notional_usd        : 0,
                leverage_bps        : 0,
                max_notional        : arg1.max_notional,
                oracle              : 0,
                needs_rebalance     : false,
                fees_pending        : 0x2::balance::value<T0>(&arg1.fees),
                margin_shortfall    : 0,
                timestamp_ms        : 0x2::clock::timestamp_ms(arg8),
                schema              : 1,
                package_version     : 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::version(),
                ratio_max_bps       : arg1.ratio_max_bps,
                lot                 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg4)),
                free_cash           : v1,
                position_collateral : position_collateral<T1>(arg4, arg3, v0),
                winddown_after_ms   : arg1.winddown_after_ms,
                base_oracle         : arg1.base_oracle,
                collateral_oracle   : arg1.collateral_oracle,
                pending             : pending_of<T0, T1>(arg1),
            }
        };
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T1>(arg4) == 0 && !0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T1>(arg4)) {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::settle<T1>(arg2, arg3, arg4, arg6, arg7, arg8);
        };
        let v4 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(arg4, arg6, arg7, arg8);
        let v5 = nav<T1>(arg2, arg3, arg4, &v4);
        let (v6, v7, v8) = exposure<T1>(arg2, arg3, arg4, &v4, arg1.long);
        let v9 = arg1.state == 1 || arg1.state == 2;
        let v10 = fee_shares<T0, T1>(arg0, arg1, 0x2::clock::timestamp_ms(arg8));
        let v11 = 0x2::coin::total_supply<T0>(&arg1.treasury) + v10;
        let v12 = v11 == 0x2::balance::value<T0>(&arg1.fees) + v10;
        let v13 = if (!v12 && (v8 < arg1.min_bps || v8 > arg1.max_bps)) {
            if (v9 || arg1.state == 3 && v8 > arg1.max_bps) {
                let (_, v15) = rebalance_order<T0, T1>(arg1, arg2, arg3, arg4, &v4);
                v15 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v16 = if (arg1.state == 0 || arg1.state == 4) {
            0
        } else {
            shortfall<T0, T1>(arg1, arg2, arg3, arg4, arg6, arg7, arg8)
        };
        let v17 = if (v12) {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::token_price(0, 0, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v4))
        } else {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::lev_math::token_price(v5, v11, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v4))
        };
        Status{
            token               : 0x2::object::id<LevToken<T0, T1>>(arg1),
            state               : arg1.state,
            long                : arg1.long,
            target_bps          : arg1.target_bps,
            min_bps             : arg1.min_bps,
            max_bps             : arg1.max_bps,
            nav                 : v5,
            nav_usd             : v6,
            supply              : v11,
            price               : v17,
            notional_usd        : v7,
            leverage_bps        : v8,
            max_notional        : arg1.max_notional,
            oracle              : oracle(&v4),
            needs_rebalance     : v13,
            fees_pending        : 0x2::balance::value<T0>(&arg1.fees) + v10,
            margin_shortfall    : v16,
            timestamp_ms        : 0x2::clock::timestamp_ms(arg8),
            schema              : 1,
            package_version     : 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::version(),
            ratio_max_bps       : arg1.ratio_max_bps,
            lot                 : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg4)),
            free_cash           : 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::balance<T1>(arg2, arg3),
            position_collateral : position_collateral<T1>(arg4, arg3, 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::collateral_scaling(&v4)),
            winddown_after_ms   : arg1.winddown_after_ms,
            base_oracle         : arg1.base_oracle,
            collateral_oracle   : arg1.collateral_oracle,
            pending             : pending_of<T0, T1>(arg1),
        }
    }

    public fun supply<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>) : u64 {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        0x2::coin::total_supply<T0>(&arg1.treasury)
    }

    public fun sync_feeds<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2) == arg1.market, 1);
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(arg2, arg3, arg4, arg5);
        arg1.base_oracle = 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg3);
        arg1.collateral_oracle = 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg4);
        let v0 = Rebound{
            token             : 0x2::object::id<LevToken<T0, T1>>(arg1),
            base_oracle       : arg1.base_oracle,
            collateral_oracle : arg1.collateral_oracle,
        };
        0x2::event::emit<Rebound>(v0);
    }

    public fun target_bps<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>) : u64 {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        arg1.target_bps
    }

    fun timely(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1 && arg1 - v0 <= 120000, 4);
    }

    public fun unwind<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        unwind_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, arg8, arg9, arg10)
    }

    fun unwind_internal<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &mut LevToken<T0, T1>, arg2: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        assert!(arg1.state == 3, 7);
        check<T0, T1>(arg1, arg2, arg3, &arg4, arg5);
        timely(arg10, arg9);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4));
        let v1 = ((base<T1>(&arg4, arg3, arg1.long) / 1000000000) as u64);
        if (v1 >= v0) {
            0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::settle<T1>(arg2, arg3, &mut arg4, arg6, arg7, arg10);
            let v2 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::valuation::oracle_prices<T1>(&arg4, arg6, arg7, arg10);
            let (_, _, v5) = exposure<T1>(arg2, arg3, &arg4, &v2, arg1.long);
            let v6 = if (arg8 && v5 > arg1.ratio_max_bps) {
                0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::emergency_slippage_bps(arg0)
            } else {
                0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::rebalance_slippage_bps(arg0)
            };
            let v7 = base<T1>(&arg4, arg3, arg1.long);
            let v8 = nav<T1>(arg2, arg3, &arg4, &v2);
            let (v9, _) = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::trade_limit<T1>(arg2, &arg1.custody_cap, arg3, arg4, arg6, arg7, closing_side(arg1.long), 0x1::u64::min(v1 / v0 * v0, chunk_size<T1>(arg0, &arg4, &v2)), order_limit<T1>(&arg4, &v2, v6, !arg1.long), true, arg10, arg11);
            arg4 = v9;
            let v11 = v7 - base<T1>(&arg4, arg3, arg1.long);
            assert!(v11 > 0, 14);
            assert_execution(v8, nav<T1>(arg2, arg3, &arg4, &v2), v11, &v2, v6);
            let v12 = Unwound{
                token  : 0x2::object::id<LevToken<T0, T1>>(arg1),
                size   : ((v11 / 1000000000) as u64),
                nav    : nav<T1>(arg2, arg3, &arg4, &v2),
                oracle : oracle(&v2),
            };
            0x2::event::emit<Unwound>(v12);
        };
        if (((base<T1>(&arg4, arg3, arg1.long) / 1000000000) as u64) < v0) {
            let v13 = 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::release_margin<T1>(arg2, &arg1.custody_cap, arg3, &mut arg4, arg6, arg7, arg10);
            if (v13 > 0) {
                let v14 = MarginReleased{
                    token  : 0x2::object::id<LevToken<T0, T1>>(arg1),
                    amount : v13,
                };
                0x2::event::emit<MarginReleased>(v14);
            };
            set_state_internal<T0, T1>(arg1, 4);
        };
        arg4
    }

    public fun unwind_keeper<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::KeeperCap, arg2: &mut LevToken<T0, T1>, arg3: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::custody::Vault<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_keeper(arg0, arg1);
        unwind_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, true, arg9, arg10, arg11)
    }

    public fun vault_id<T0, T1>(arg0: &0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::Config, arg1: &LevToken<T0, T1>) : 0x2::object::ID {
        0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config::assert_version(arg0);
        arg1.vault
    }

    fun venue_floor_bps<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) : u64 {
        (((0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0)) + 99999999999999) / 100000000000000) as u64)
    }

    // decompiled from Move bytecode v7
}

