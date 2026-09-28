module 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        treasury: 0x2::object::ID,
        creator: address,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        tokens: 0x2::balance::Balance<T0>,
        x: u64,
        virtual_shares: u64,
        k: u128,
        cash: 0x2::balance::Balance<T1>,
        venue: 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::Venue<T1>,
        fee_mode: u8,
        creator_fees: 0x2::balance::Balance<T1>,
        opened_ms: u64,
        snipe_window_ms: u64,
        last_defend_ms: u64,
        last_buyback_ms: u64,
        last_rebalance_ms: u64,
        burned: u64,
        last_buy_tx: vector<u8>,
        last_sell_tx: vector<u8>,
        wound_down: bool,
    }

    struct Launched has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        account: 0x2::object::ID,
        market: 0x2::object::ID,
        long: bool,
        leverage_bps: u64,
        fee_mode: u8,
        virtual_shares: u64,
        snipe_window_ms: u64,
    }

    struct Traded has copy, drop {
        pool: 0x2::object::ID,
        trader: address,
        buy: bool,
        usdc: u64,
        tokens: u64,
        fee: u64,
        referrer: 0x1::option::Option<address>,
        x: u64,
        y: u64,
        basket_value: u64,
    }

    struct Rebalanced has copy, drop {
        pool: 0x2::object::ID,
        basket_value: u64,
        moved_to_margin: u64,
        moved_to_cash: u64,
        grew: u64,
        shrank: u64,
    }

    struct Defended has copy, drop {
        pool: 0x2::object::ID,
        caller: address,
        amount: u64,
        reward: u64,
    }

    struct BoughtBack has copy, drop {
        pool: 0x2::object::ID,
        usdc: u64,
        tokens_burned: u64,
    }

    struct WoundDown has copy, drop {
        pool: 0x2::object::ID,
        recovered: u64,
        cash: u64,
        first: bool,
    }

    public fun stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::Stake<T0, T1> {
        assert!(0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg1) == arg0.config, 815);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        settle<T0, T1>(arg0, arg3);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::stake<T0, T1>(&mut arg0.id, arg0.fee_mode, 0x2::coin::into_balance<T0>(arg2), 0x2::tx_context::sender(arg4), arg4)
    }

    public fun unstake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = &mut arg2;
        let v1 = claim_rewards<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (0x2::coin::from_balance<T0>(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::unstake<T0, T1>(&mut arg0.id, arg2, 0x2::tx_context::sender(arg4)), arg4), v1)
    }

    public fun add_stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::Stake<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = claim_rewards<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::add<T0, T1>(&mut arg0.id, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::tx_context::sender(arg5));
        v0
    }

    public fun basket<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, bool, u64, bool) {
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, arg1, arg2, arg3, arg4, arg5, arg6);
        let (v1, v2, v3, _, v5, v6, v7) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot_parts(&v0);
        (basket_value<T0, T1>(arg0, &v0), 0x2::balance::value<T1>(&arg0.cash), v1, v2, v3, v5, v6, v7)
    }

    fun basket_fee(arg0: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::Parts) : u64 {
        let (_, _, _, _, v4, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::parts(arg0);
        v4
    }

    fun basket_value<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::Snapshot) : u64 {
        let (v0, v1, _, _, _, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot_parts(arg1);
        0x2::balance::value<T1>(&arg0.cash) + v0 + v1
    }

    public fun venue<T0, T1>(arg0: &Pool<T0, T1>) : &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::Venue<T1> {
        &arg0.venue
    }

    public fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_can_buy(arg1);
        assert!(!arg0.wound_down, 817);
        mark_buy<T0, T1>(arg0, arg11);
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg1);
        let v1 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, arg3, arg4, arg5, arg6, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_oracle_age_ms(v0), arg10);
        let v2 = basket_value<T0, T1>(arg0, &v1);
        let v3 = 0x2::clock::timestamp_ms(arg10);
        let (_, _, v6, v7) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::snipe(v0);
        let v8 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(v0);
        let v9 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::buy_fee_bps_at(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::trade_fee_bps(v8), v6, arg0.opened_ms, arg0.snipe_window_ms, v3);
        let v10 = 0x2::tx_context::sender(arg11);
        let v11 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::bind_referrer<T1>(arg2, v10, arg9);
        let v12 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::buy(v8, v9, leverage_extra<T0, T1>(arg0, v0, v9, &v1), 0x1::option::is_some<address>(&v11), arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.x - arg0.virtual_shares, v2, 0x2::coin::value<T1>(&arg7));
        let (v13, v14, _, _, v17, v18, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::buy_parts(&v12);
        let v20 = v14;
        assert!(v17 >= arg8, 807);
        if (v3 < arg0.opened_ms + arg0.snipe_window_ms) {
            assert!(v17 <= 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::mul_div(1000000000000000, v7, 10000), 808);
        };
        let v21 = take_buy<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T1>(arg7), &v20, v11, v17, v18, arg11);
        let v22 = Traded{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            trader       : v10,
            buy          : true,
            usdc         : v13,
            tokens       : v17,
            fee          : fee_total(&v20),
            referrer     : v11,
            x            : arg0.x,
            y            : 0x2::balance::value<T0>(&arg0.tokens),
            basket_value : v2 + v13 - fee_total(&v20) + basket_fee(&v20),
        };
        0x2::event::emit<Traded>(v22);
        v21
    }

    public fun buyback<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg1) == arg0.config, 815);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 >= arg0.last_buyback_ms + 60000 && v0 >= arg0.opened_ms + arg0.snipe_window_ms, 813);
        mark_buy<T0, T1>(arg0, arg7);
        distribute_fees<T0, T1>(arg0);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::release<T1>(&mut arg0.id, v0);
        let v1 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg1);
        let v2 = if (arg0.wound_down) {
            0x2::balance::value<T1>(&arg0.cash)
        } else {
            let v3 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, arg2, arg3, arg4, arg5, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_oracle_age_ms(v1), arg6);
            basket_value<T0, T1>(arg0, &v3)
        };
        let v4 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::take_buyback<T1>(&mut arg0.id, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::mul_div(v2, 100, 10000));
        let v5 = 0x2::balance::value<T1>(&v4);
        if (v5 == 0) {
            0x2::balance::destroy_zero<T1>(v4);
            return
        };
        let v6 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::buy(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(v1), 0, 0, false, arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.x - arg0.virtual_shares, v2, v5);
        let (_, _, v9, _, v11, v12, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::buy_parts(&v6);
        assert!(v9 == v5, 814);
        0x2::balance::join<T1>(&mut arg0.cash, v4);
        arg0.x = v12;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury_cap), 0x2::balance::split<T0>(&mut arg0.tokens, v11));
        arg0.burned = arg0.burned + v11;
        arg0.last_buyback_ms = v0;
        let v14 = BoughtBack{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            usdc          : v5,
            tokens_burned : v11,
        };
        0x2::event::emit<BoughtBack>(v14);
    }

    fun check_platform<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>) {
        assert!(0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg1) == arg0.config && 0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>>(arg2) == arg0.treasury, 815);
    }

    public fun claim_creator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 812);
        distribute_fees<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::take_claim<T1>(&mut arg0.id, arg0.creator), arg1)
    }

    public fun claim_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg1) == arg0.config, 815);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        settle<T0, T1>(arg0, arg3);
        0x2::coin::from_balance<T1>(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::claim<T0, T1>(&mut arg0.id, arg2, 0x2::tx_context::sender(arg4)), arg4)
    }

    public fun creator<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.creator
    }

    public fun defend_margin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg1) == arg0.config, 815);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        assert!(!arg0.wound_down, 817);
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg1);
        let v1 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, arg2, arg3, arg5, arg6, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_oracle_age_ms(v0), arg7);
        let (v2, v3, v4, _, _, v7, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot_parts(&v1);
        let (v9, v10, v11) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::defend(v0);
        assert!(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::band::in_danger(v3, v4, v7, v9), 811);
        let v12 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::band::defend_amount(v3, v4, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::leverage_bps<T1>(&arg0.venue), v7, v9, 0x2::balance::value<T1>(&arg0.cash) + v2);
        let v13 = if (v12 > v2) {
            v12 - v2
        } else {
            0
        };
        if (v13 > 0) {
            0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::deposit<T1>(&arg0.venue, arg3, arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v13), arg8));
        };
        if (v12 > 0) {
            0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::allocate<T1>(&arg0.venue, arg2, arg3, v12);
        };
        let v14 = 0x2::clock::timestamp_ms(arg7);
        let v15 = if (v12 > 0) {
            if (v14 >= arg0.last_defend_ms + v11) {
                0x2::balance::value<T1>(&arg0.cash) >= v10
            } else {
                false
            }
        } else {
            false
        };
        let v16 = if (v15) {
            arg0.last_defend_ms = v14;
            v10
        } else {
            0
        };
        let v17 = Defended{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            caller : 0x2::tx_context::sender(arg8),
            amount : v12,
            reward : v16,
        };
        0x2::event::emit<Defended>(v17);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v16), arg8)
    }

    fun distribute_fees<T0, T1>(arg0: &mut Pool<T0, T1>) {
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::distribute<T1>(&mut arg0.id, arg0.fee_mode, 0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees));
    }

    fun exposure_bps<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Params, arg2: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::Snapshot) : u64 {
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::band::target_notional(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::band_params(arg1), 10000, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::leverage_bps<T1>(&arg0.venue));
        let v1 = basket_value<T0, T1>(arg0, arg2);
        let (_, _, v4, _, _, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot_parts(arg2);
        let v9 = if (v1 == 0) {
            0
        } else {
            0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::mul_div(v4, 10000, v1)
        };
        if (v9 > v0) {
            v9
        } else {
            v0
        }
    }

    public fun fee_bps<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg1);
        let (_, _, v3, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::snipe(v0);
        let v5 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::trade_fee_bps(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(v0));
        let v6 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::buy_fee_bps_at(v5, v3, arg0.opened_ms, arg0.snipe_window_ms, 0x2::clock::timestamp_ms(arg6));
        if (arg0.wound_down) {
            return (v6, v5)
        };
        let v7 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, arg2, arg3, arg4, arg5, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_oracle_age_ms(v0), arg6);
        (v6 + leverage_extra<T0, T1>(arg0, v0, v6, &v7), v5 + leverage_extra<T0, T1>(arg0, v0, v5, &v7))
    }

    public fun fee_mode<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.fee_mode
    }

    fun fee_total(arg0: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::Parts) : u64 {
        let (v0, _, _, _, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::parts(arg0);
        v0
    }

    public fun is_wound_down<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.wound_down
    }

    entry fun launch<T0, T1>(arg0: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg1: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: 0x2::coin::TreasuryCap<T0>, arg7: &0x2::coin_registry::Currency<T0>, arg8: bool, arg9: u64, arg10: u8, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<T1>, arg13: &0x2::random::Random, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_can_buy(arg0);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_collateral<T1>(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg6) == 0, 800);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg7) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg6)), 801);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg7), 802);
        assert!(0x2::coin_registry::decimals<T0>(arg7) == 6, 803);
        assert!(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::is_mode(arg10), 804);
        let v0 = *0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg0);
        let v1 = 0x2::tx_context::sender(arg15);
        let v2 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::launch_fee_sui(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg11) >= v2, 805);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::take_launch_fee<T1>(arg1, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg11), v2));
        if (0x2::coin::value<0x2::sui::SUI>(&arg11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg11, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg11);
        };
        let (v3, v4, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::snipe(&v0);
        let v7 = 0x2::random::new_generator(arg13, arg15);
        let v8 = 0x2::random::generate_u64_in_range(&mut v7, v3, v4);
        let v9 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::virtual_shares(&v0);
        let v10 = Pool<T0, T1>{
            id                : 0x2::object::new(arg15),
            config            : 0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg0),
            treasury          : 0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>>(arg1),
            creator           : v1,
            treasury_cap      : arg6,
            tokens            : 0x2::coin::mint_balance<T0>(&mut arg6, 1000000000000000),
            x                 : v9,
            virtual_shares    : v9,
            k                 : 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::curve::initial_k(v9, 1000000000000000),
            cash              : 0x2::balance::zero<T1>(),
            venue             : 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::new<T1>(arg2, arg3, arg4, arg5, arg8, arg9, 1000000, arg15),
            fee_mode          : arg10,
            creator_fees      : 0x2::balance::zero<T1>(),
            opened_ms         : 0x2::clock::timestamp_ms(arg14),
            snipe_window_ms   : v8,
            last_defend_ms    : 0,
            last_buyback_ms   : 0,
            last_rebalance_ms : 0,
            burned            : 0,
            last_buy_tx       : *0x2::tx_context::digest(arg15),
            last_sell_tx      : b"",
            wound_down        : false,
        };
        let v11 = Launched{
            pool            : 0x2::object::id<Pool<T0, T1>>(&v10),
            creator         : v1,
            account         : 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::account_id<T1>(&v10.venue),
            market          : 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::market_id<T1>(&v10.venue),
            long            : arg8,
            leverage_bps    : arg9,
            fee_mode        : arg10,
            virtual_shares  : v9,
            snipe_window_ms : v8,
        };
        0x2::event::emit<Launched>(v11);
        if (0x2::coin::value<T1>(&arg12) > 0) {
            let v12 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::buy(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(&v0), 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::trade_fee_bps(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(&v0)), 0, false, v10.k, v10.x, 0x2::balance::value<T0>(&v10.tokens), 0, 0, 0x2::coin::value<T1>(&arg12));
            let (_, v14, _, _, v17, v18, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::buy_parts(&v12);
            let v20 = v14;
            assert!(v17 <= 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::mul_div(1000000000000000, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_dev_buy_bps(&v0), 10000), 806);
            let v21 = &mut v10;
            let v22 = take_buy<T0, T1>(v21, arg1, 0x2::coin::into_balance<T1>(arg12), &v20, 0x1::option::none<address>(), v17, v18, arg15);
            let v23 = Traded{
                pool         : 0x2::object::id<Pool<T0, T1>>(&v10),
                trader       : v1,
                buy          : true,
                usdc         : tokens_value(&v12),
                tokens       : 0x2::coin::value<T0>(&v22),
                fee          : fee_total(&v20),
                referrer     : 0x1::option::none<address>(),
                x            : v10.x,
                y            : 0x2::balance::value<T0>(&v10.tokens),
                basket_value : 0x2::balance::value<T1>(&v10.cash),
            };
            0x2::event::emit<Traded>(v23);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v22, v1);
        } else {
            0x2::coin::destroy_zero<T1>(arg12);
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v10);
    }

    fun leverage_extra<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Params, arg2: u64, arg3: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::Snapshot) : u64 {
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::leverage_extra_bps(arg2, exposure_bps<T0, T1>(arg0, arg1, arg3), 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::arb_move_bps(arg1))
    }

    fun mark_buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = *0x2::tx_context::digest(arg1);
        assert!(v0 != arg0.last_sell_tx, 816);
        arg0.last_buy_tx = v0;
    }

    fun mark_sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = *0x2::tx_context::digest(arg1);
        assert!(v0 != arg0.last_buy_tx, 816);
        arg0.last_sell_tx = v0;
    }

    public fun mode_stats<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::stats<T1>(&arg0.id);
        (0x2::balance::value<T1>(&arg0.creator_fees), v0, v1, v2, v3, v4)
    }

    public fun pending_rewards<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::Stake<T0, T1>) : u64 {
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::pending<T0, T1>(&arg0.id, arg1)
    }

    public fun rebalance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        assert!(0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg1) == arg0.config, 815);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        assert!(!arg0.wound_down, 817);
        assert!(0x2::tx_context::gas_price(arg8) <= 0x2::tx_context::reference_gas_price(arg8), 819);
        let v0 = *0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg1);
        let v1 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_oracle_age_ms(&v0);
        let v2 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_slippage_bps(&v0);
        let v3 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_rebalance_notional(&v0);
        let v4 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, &arg2, arg3, arg5, arg6, v1, arg7);
        let (v5, _, v7, _, _, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot_parts(&v4);
        let v12 = basket_value<T0, T1>(arg0, &v4);
        let v13 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::band::plan(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::band_params(&v0), v12, 0x2::balance::value<T1>(&arg0.cash) + v5, v7, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::leverage_bps<T1>(&arg0.venue));
        let (v14, v15, v16, v17, v18) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::band::plan_parts(&v13);
        assert!(v14, 810);
        let v19 = 0x2::clock::timestamp_ms(arg7);
        assert!(v19 >= arg0.last_rebalance_ms + 30000, 813);
        arg0.last_rebalance_ms = v19;
        let v20 = arg2;
        if (v15 > 0) {
            let v21 = if (v5 >= v15) {
                0
            } else {
                v15 - v5
            };
            let v22 = if (v21 > 0x2::balance::value<T1>(&arg0.cash)) {
                0x2::balance::value<T1>(&arg0.cash)
            } else {
                v21
            };
            if (v22 > 0) {
                0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::deposit<T1>(&arg0.venue, arg3, arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v22), arg8));
            };
            let v23 = if (v5 + v22 < v15) {
                v5 + v22
            } else {
                v15
            };
            0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::allocate<T1>(&arg0.venue, &mut v20, arg3, v23);
        };
        let v24 = 0;
        let v25 = 0;
        if (v17 >= 1000000 || v18 >= 1000000) {
            let v26 = v17 > 0;
            let v27 = if (v26) {
                v17
            } else {
                v18
            };
            let v28 = if (v27 > v3) {
                v3
            } else {
                v27
            };
            if (v26) {
                let v29 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::mul_div_up(v28, v2 + 10, 10000);
                let v30 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, &v20, arg3, arg5, arg6, v1, arg7);
                let (v31, _, _, _, _, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot_parts(&v30);
                let v38 = if (v31 >= v29) {
                    0
                } else {
                    v29 - v31
                };
                let v39 = if (v38 > 0x2::balance::value<T1>(&arg0.cash)) {
                    0x2::balance::value<T1>(&arg0.cash)
                } else {
                    v38
                };
                if (v39 > 0) {
                    0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::deposit<T1>(&arg0.venue, arg3, arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v39), arg8));
                };
            };
            let v40 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::size_for<T1>(&arg0.venue, &v20, arg5, arg6, v28, v1, arg7);
            if (v40 > 0) {
                let (v41, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::trade<T1>(&arg0.venue, v20, arg3, arg5, arg6, v26, v40, v2, v1, arg7, arg8);
                v20 = v41;
                if (v26) {
                    v25 = v28;
                } else {
                    v24 = v28;
                };
            };
        };
        let v43 = 0;
        if (v16 > 0) {
            let v44 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::deallocate<T1>(&arg0.venue, &mut v20, arg3, arg5, arg6, v16, arg7);
            if (v44 > 0) {
                0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::withdraw<T1>(&arg0.venue, arg3, arg4, v44, arg8)));
                v43 = v44;
            };
        };
        let v45 = Rebalanced{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg0),
            basket_value    : v12,
            moved_to_margin : v15,
            moved_to_cash   : v43,
            grew            : v25,
            shrank          : v24,
        };
        0x2::event::emit<Rebalanced>(v45);
        v20
    }

    public fun release_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg1) == arg0.config, 815);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        settle<T0, T1>(arg0, arg2);
    }

    public fun sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        assert!(!arg0.wound_down, 817);
        mark_sell<T0, T1>(arg0, arg11);
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg1);
        let v1 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, arg3, arg4, arg5, arg6, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_oracle_age_ms(v0), arg10);
        let v2 = basket_value<T0, T1>(arg0, &v1);
        let v3 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::bind_referrer<T1>(arg2, 0x2::tx_context::sender(arg11), arg9);
        let v4 = leverage_extra<T0, T1>(arg0, v0, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::trade_fee_bps(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(v0)), &v1);
        settle_sell<T0, T1>(arg0, arg1, arg2, arg7, v2, 0, v4, arg8, v3, arg11)
    }

    public fun sell_through_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: 0x2::coin::Coin<T0>, arg9: u64, arg10: 0x1::option::Option<address>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T1>) {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        assert!(!arg0.wound_down, 817);
        mark_sell<T0, T1>(arg0, arg12);
        let v0 = *0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg1);
        let v1 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_oracle_age_ms(&v0);
        let v2 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, &arg3, arg4, arg6, arg7, v1, arg11);
        let v3 = basket_value<T0, T1>(arg0, &v2);
        let v4 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::bind_referrer<T1>(arg2, 0x2::tx_context::sender(arg12), arg10);
        let v5 = leverage_extra<T0, T1>(arg0, &v0, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::trade_fee_bps(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(&v0)), &v2);
        let v6 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::sell(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(&v0), v5, 0x1::option::is_some<address>(&v4), arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, v3, 0x2::coin::value<T0>(&arg8));
        let (_, _, _, _, v11, _, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::sell_parts(&v6);
        let v15 = arg3;
        if (v11 > 0x2::balance::value<T1>(&arg0.cash)) {
            let v16 = v11 - 0x2::balance::value<T1>(&arg0.cash);
            let v17 = v16;
            let (v18, v19, v20, _, _, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot_parts(&v2);
            let v25 = if (v18 < v16) {
                v18
            } else {
                v16
            };
            if (v25 > 0) {
                0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::withdraw<T1>(&arg0.venue, arg4, arg5, v25, arg12)));
                v17 = v16 - v25;
            };
            if (v17 > 0) {
                assert!(v19 > v17, 809);
                let v26 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::size_for<T1>(&arg0.venue, &v15, arg6, arg7, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::mul_div_up(v20, v17, v19), v1, arg11);
                if (v26 > 0) {
                    let (v27, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::trade<T1>(&arg0.venue, v15, arg4, arg6, arg7, false, v26, 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::max_sell_slippage_bps(&v0), v1, arg11, arg12);
                    v15 = v27;
                };
                let v29 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::deallocate<T1>(&arg0.venue, &mut v15, arg4, arg6, arg7, v17, arg11);
                if (v29 > 0) {
                    0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::withdraw<T1>(&arg0.venue, arg4, arg5, v29, arg12)));
                };
            };
        };
        let v30 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::snapshot<T1>(&arg0.venue, &v15, arg4, arg6, arg7, v1, arg11);
        let v31 = basket_value<T0, T1>(arg0, &v30);
        let v32 = if (v3 > v31) {
            v3 - v31
        } else {
            0
        };
        (v15, settle_sell<T0, T1>(arg0, arg1, arg2, arg8, v3, v32, v5, arg9, v4, arg12))
    }

    public fun sell_wound_down<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        assert!(arg0.wound_down, 818);
        mark_sell<T0, T1>(arg0, arg6);
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::bind_referrer<T1>(arg2, 0x2::tx_context::sender(arg6), arg5);
        let v1 = 0x2::balance::value<T1>(&arg0.cash);
        settle_sell<T0, T1>(arg0, arg1, arg2, arg3, v1, 0, 0, arg4, v0, arg6)
    }

    fun settle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        distribute_fees<T0, T1>(arg0);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::modes::release<T1>(&mut arg0.id, 0x2::clock::timestamp_ms(arg1));
    }

    public fun settle_funding<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) {
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::settle_funding<T1>(&arg0.venue, arg1, arg2, arg3);
    }

    fun settle_sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<address>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::sell(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::split(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::params(arg1)), arg6, 0x1::option::is_some<address>(&arg8), arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, arg4, 0x2::coin::value<T0>(&arg3));
        let (v1, _, _, v4, v5, v6, v7, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::sell_parts(&v0);
        let v9 = v4;
        assert!(v6 > arg5, 807);
        let v10 = v6 - arg5;
        assert!(v10 >= arg7, 807);
        let v11 = v5 - arg5;
        assert!(0x2::balance::value<T1>(&arg0.cash) >= v11, 809);
        let v12 = 0x2::balance::split<T1>(&mut arg0.cash, v11);
        let (_, v14, v15, v16, _, v18) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::parts(&v9);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut v12, v14));
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::credit<T1>(arg2, 0x2::balance::split<T1>(&mut v12, v15), 0x2::balance::split<T1>(&mut v12, v16), 0x2::balance::split<T1>(&mut v12, v18), arg8);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg3));
        arg0.x = v7;
        let v19 = Traded{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            trader       : 0x2::tx_context::sender(arg9),
            buy          : false,
            usdc         : v10,
            tokens       : v1,
            fee          : fee_total(&v9),
            referrer     : arg8,
            x            : arg0.x,
            y            : 0x2::balance::value<T0>(&arg0.tokens),
            basket_value : arg4 - v5 - arg5 + basket_fee(&v9),
        };
        0x2::event::emit<Traded>(v19);
        0x2::coin::from_balance<T1>(v12, arg9)
    }

    public fun snipe_window<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.opened_ms, arg0.snipe_window_ms)
    }

    public fun state<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64, u64, u64) {
        (arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, 0x2::balance::value<T1>(&arg0.cash), 0x2::balance::value<T1>(&arg0.creator_fees), arg0.burned)
    }

    fun take_buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Treasury<T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::Parts, arg4: 0x1::option::Option<address>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (_, v1, v2, v3, _, v5) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::fees::parts(arg3);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut arg2, v1));
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::credit<T1>(arg1, 0x2::balance::split<T1>(&mut arg2, v2), 0x2::balance::split<T1>(&mut arg2, v3), 0x2::balance::split<T1>(&mut arg2, v5), arg4);
        0x2::balance::join<T1>(&mut arg0.cash, arg2);
        arg0.x = arg6;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, arg5), arg7)
    }

    fun tokens_value(arg0: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::BuyQuote) : u64 {
        let (v0, _, _, _, _, _, _) = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::pricing::buy_parts(arg0);
        v0
    }

    public fun wind_down<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::Config>(arg1) == arg0.config, 815);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::config::assert_version(arg1);
        let v0 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::close_at_settlement<T1>(&arg0.venue, arg2, arg3);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::venue::withdraw<T1>(&arg0.venue, arg3, arg4, v0, arg5)));
        };
        arg0.wound_down = true;
        let v1 = WoundDown{
            pool      : 0x2::object::id<Pool<T0, T1>>(arg0),
            recovered : v0,
            cash      : 0x2::balance::value<T1>(&arg0.cash),
            first     : !arg0.wound_down,
        };
        0x2::event::emit<WoundDown>(v1);
    }

    // decompiled from Move bytecode v7
}

