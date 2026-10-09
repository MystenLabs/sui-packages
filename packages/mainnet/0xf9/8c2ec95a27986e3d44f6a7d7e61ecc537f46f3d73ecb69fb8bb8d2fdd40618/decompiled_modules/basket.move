module 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::basket {
    struct Leg has copy, drop, store {
        market: 0x2::object::ID,
        base_oracle: 0x2::object::ID,
        long: bool,
        leverage_bps: u64,
        weight_bps: u64,
        retired: bool,
        last_defend_ms: u64,
    }

    struct BasketPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        treasury: 0x2::object::ID,
        creator: address,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        tokens: 0x2::balance::Balance<T0>,
        x: u64,
        virtual_shares: u64,
        k: u128,
        terms: 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::Terms,
        cash: 0x2::balance::Balance<T1>,
        desk: 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::Desk<T1>,
        legs: vector<Leg>,
        fee_mode: u8,
        creator_fees: 0x2::balance::Balance<T1>,
        opened_ms: u64,
        snipe_window_ms: u64,
        last_buyback_ms: u64,
        last_rebalance_ms: u64,
        burned: u64,
        last_buy_tx: vector<u8>,
        last_sell_tx: vector<u8>,
        snipe_tx: vector<u8>,
        snipe_bought: u64,
        wound_down: bool,
        nonce: u64,
    }

    struct Launch<phantom T0, phantom T1> {
        pool: BasketPool<T0, T1>,
        acct: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>,
        policy: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::AccountSharePolicy,
    }

    struct Valuation {
        pool: 0x2::object::ID,
        nonce: u64,
        next: u64,
        free: u64,
        equities: vector<u64>,
        notionals: vector<u64>,
        mmrs: vector<u64>,
        paused: vector<bool>,
        danger: vector<bool>,
    }

    struct SellThrough {
        pool: 0x2::object::ID,
        nonce: u64,
        tokens_in: u64,
        before: u64,
        free_left: u64,
        equities: vector<u64>,
        cut_margin: vector<u64>,
        cut_notional: vector<u64>,
        loss: u64,
        extra: u64,
    }

    struct Launched has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        account: 0x2::object::ID,
        legs: vector<Leg>,
        fee_mode: u8,
        virtual_shares: u64,
        snipe_window_ms: u64,
        preset: vector<u8>,
        terms: 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::Terms,
        coin: 0x1::string::String,
        collateral: 0x1::string::String,
    }

    struct DevBuyLocked has copy, drop {
        pool: 0x2::object::ID,
        lock: 0x2::object::ID,
        days: u64,
        tokens: u64,
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
        leg: u64,
        basket_value: u64,
        moved_to_margin: u64,
        moved_to_cash: u64,
        grew: u64,
        shrank: u64,
    }

    struct Defended has copy, drop {
        pool: 0x2::object::ID,
        leg: u64,
        caller: address,
        amount: u64,
        reward: u64,
    }

    struct LegRetired has copy, drop {
        pool: 0x2::object::ID,
        leg: u64,
        recovered: u64,
        cash: u64,
        wound_down: bool,
    }

    struct BoughtBack has copy, drop {
        pool: 0x2::object::ID,
        usdc: u64,
        tokens_burned: u64,
    }

    public fun add_leg<T0, T1>(arg0: &mut Launch<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: bool, arg5: u64, arg6: u64) {
        let v0 = &mut arg0.pool;
        assert!(0x1::vector::length<Leg>(&v0.legs) < 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::weights::max_legs(), 1126);
        let v1 = 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Leg>(&v0.legs)) {
            assert!(0x1::vector::borrow<Leg>(&v0.legs, v2).market != v1, 1125);
            v2 = v2 + 1;
        };
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::open_leg<T1>(&v0.desk, &arg0.acct, arg1, arg2, arg3, arg5);
        let v3 = Leg{
            market         : v1,
            base_oracle    : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg2),
            long           : arg4,
            leverage_bps   : arg5,
            weight_bps     : arg6,
            retired        : false,
            last_defend_ms : 0,
        };
        0x1::vector::push_back<Leg>(&mut v0.legs, v3);
    }

    public fun add_stake<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::Stake<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg1);
        let v0 = claim_rewards<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::add<T0, T1>(&mut arg0.id, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::tx_context::sender(arg5));
        v0
    }

    fun basket_fee(arg0: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::Parts) : u64 {
        let (_, _, _, _, v4, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::parts(arg0);
        v4
    }

    public fun buy<T0, T1>(arg0: Valuation, arg1: &mut BasketPool<T0, T1>, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg3: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>, arg4: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = finished<T0, T1>(arg0, arg1);
        check_platform<T0, T1>(arg1, arg2, arg3);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_can_buy(arg2);
        mark_buy<T0, T1>(arg1, arg9);
        let v1 = value_full<T0, T1>(arg1, &v0);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        let (_, _, v5, v6) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::snipe(&arg1.terms);
        let v7 = *0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::split(&arg1.terms);
        let v8 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::buy_fee_bps_at(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::trade_fee_bps(&v7), v5, arg1.opened_ms, arg1.snipe_window_ms, v2);
        let v9 = 0x2::tx_context::sender(arg9);
        let v10 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::legacy::bind_sender(arg4, arg7, arg9);
        drop_value(v0);
        let v11 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::buy(&v7, v8, leverage_extra<T0, T1>(arg1, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::risk(arg2), v8, &v0, v1), 0x1::option::is_some<address>(&v10), arg1.k, arg1.x, 0x2::balance::value<T0>(&arg1.tokens), arg1.x - arg1.virtual_shares, v1, 0x2::coin::value<T1>(&arg5));
        let (v12, v13, _, _, v16, v17, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::buy_parts(&v11);
        let v19 = v13;
        assert!(v16 >= arg6, 1107);
        if (v2 < arg1.opened_ms + arg1.snipe_window_ms) {
            let v20 = snipe_tx_bought<T0, T1>(arg1, v16, arg9);
            assert!(v20 <= 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(1000000000000000, v6, 10000), 1108);
        };
        let v21 = take_buy<T0, T1>(arg1, arg3, arg4, 0x2::coin::into_balance<T1>(arg5), &v19, v10, v16, v17, arg9);
        let v22 = Traded{
            pool         : 0x2::object::id<BasketPool<T0, T1>>(arg1),
            trader       : v9,
            buy          : true,
            usdc         : v12,
            tokens       : v16,
            fee          : fee_total(&v19),
            referrer     : v10,
            x            : arg1.x,
            y            : 0x2::balance::value<T0>(&arg1.tokens),
            basket_value : v1 + v12 - fee_total(&v19) + basket_fee(&v19),
        };
        0x2::event::emit<Traded>(v22);
        v21
    }

    public fun buyback<T0, T1>(arg0: 0x1::option::Option<Valuation>, arg1: &mut BasketPool<T0, T1>, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg2) == arg1.config, 1115);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_can_buy(arg2);
        let v0 = if (arg1.wound_down) {
            assert!(0x1::option::is_none<Valuation>(&arg0), 1117);
            0x1::option::destroy_none<Valuation>(arg0);
            0x2::balance::value<T1>(&arg1.cash)
        } else {
            let v1 = finished<T0, T1>(0x1::option::destroy_some<Valuation>(arg0), arg1);
            drop_value(v1);
            value_full<T0, T1>(arg1, &v1)
        };
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= arg1.last_buyback_ms + 60000 && v2 >= arg1.opened_ms + arg1.snipe_window_ms, 1113);
        mark_buy<T0, T1>(arg1, arg4);
        distribute_fees<T0, T1>(arg1);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::release<T1>(&mut arg1.id, v2);
        let v3 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::take_buyback<T1>(&mut arg1.id, 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(v0, 100, 10000));
        let v4 = 0x2::balance::value<T1>(&v3);
        if (v4 == 0) {
            0x2::balance::destroy_zero<T1>(v3);
            return
        };
        let v5 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::buy(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::split(&arg1.terms), 0, 0, false, arg1.k, arg1.x, 0x2::balance::value<T0>(&arg1.tokens), arg1.x - arg1.virtual_shares, v0, v4);
        let (_, _, v8, _, v10, v11, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::buy_parts(&v5);
        assert!(v8 == v4, 1114);
        0x2::balance::join<T1>(&mut arg1.cash, v3);
        arg1.x = v11;
        arg1.nonce = arg1.nonce + 1;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg1.treasury_cap), 0x2::balance::split<T0>(&mut arg1.tokens, v10));
        arg1.burned = arg1.burned + v10;
        arg1.last_buyback_ms = v2;
        let v13 = BoughtBack{
            pool          : 0x2::object::id<BasketPool<T0, T1>>(arg1),
            usdc          : v4,
            tokens_burned : v10,
        };
        0x2::event::emit<BoughtBack>(v13);
    }

    fun check_platform<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>) {
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg1) == arg0.config && 0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>>(arg2) == arg0.treasury, 1115);
    }

    public fun claim_creator<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg1) == arg0.config, 1115);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1112);
        distribute_fees<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::take_claim<T1>(&mut arg0.id, arg0.creator), arg2)
    }

    public fun claim_rewards<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg1) == arg0.config, 1115);
        settle<T0, T1>(arg0, arg3);
        0x2::coin::from_balance<T1>(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::claim<T0, T1>(&mut arg0.id, arg2, 0x2::tx_context::sender(arg4)), arg4)
    }

    public fun creator<T0, T1>(arg0: &BasketPool<T0, T1>) : address {
        arg0.creator
    }

    public fun defend_leg<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: u64, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg1) == arg0.config, 1115);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg1);
        assert!(!arg0.wound_down, 1117);
        let v0 = *0x1::vector::borrow<Leg>(&arg0.legs, arg2);
        assert!(!v0.retired, 1127);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == v0.market && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg6) == v0.base_oracle, 1122);
        let v1 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::risk(arg1);
        let v2 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_snapshot<T1>(&arg0.desk, arg3, arg4, arg6, arg7, v0.long, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::max_oracle_age_ms(v1), arg8);
        let (v3, v4, v5, _, _, v8, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::snapshot_parts(&v2);
        let (v10, v11, v12) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::defend(v1);
        let v13 = if (!0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::is_underwater(&v2)) {
            if (v4 > 0) {
                0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::band::in_danger(v4, v5, v8, v10)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v13, 1111);
        let v14 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::band::defend_amount(v4, v5, v0.leverage_bps, v8, v10, 0x2::balance::value<T1>(&arg0.cash) + v3);
        let v15 = if (v14 > v3) {
            v14 - v3
        } else {
            0
        };
        if (v15 > 0) {
            0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_deposit<T1>(&arg0.desk, arg4, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v15), arg9));
        };
        if (v14 > 0) {
            0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_allocate<T1>(&arg0.desk, arg3, arg4, v14);
        };
        arg0.nonce = arg0.nonce + 1;
        let v16 = 0x2::clock::timestamp_ms(arg8);
        let v17 = if (v14 > 0) {
            if (v16 >= v0.last_defend_ms + v12) {
                0x2::balance::value<T1>(&arg0.cash) >= v11
            } else {
                false
            }
        } else {
            false
        };
        let v18 = if (v17) {
            0x1::vector::borrow_mut<Leg>(&mut arg0.legs, arg2).last_defend_ms = v16;
            v11
        } else {
            0
        };
        let v19 = Defended{
            pool   : 0x2::object::id<BasketPool<T0, T1>>(arg0),
            leg    : arg2,
            caller : 0x2::tx_context::sender(arg9),
            amount : v14,
            reward : v18,
        };
        0x2::event::emit<Defended>(v19);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v18), arg9)
    }

    public fun desk<T0, T1>(arg0: &BasketPool<T0, T1>) : &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::Desk<T1> {
        &arg0.desk
    }

    fun distribute_fees<T0, T1>(arg0: &mut BasketPool<T0, T1>) {
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::distribute<T1>(&mut arg0.id, arg0.fee_mode, 0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees));
    }

    fun drop_value(arg0: Valuation) {
        let Valuation {
            pool      : _,
            nonce     : _,
            next      : _,
            free      : _,
            equities  : _,
            notionals : _,
            mmrs      : _,
            paused    : _,
            danger    : _,
        } = arg0;
    }

    public fun fee_mode<T0, T1>(arg0: &BasketPool<T0, T1>) : u8 {
        arg0.fee_mode
    }

    fun fee_total(arg0: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::Parts) : u64 {
        let (v0, _, _, _, _, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::parts(arg0);
        v0
    }

    entry fun finish_launch<T0, T1>(arg0: Launch<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>, arg3: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: vector<u8>, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let Launch {
            pool   : v0,
            acct   : v1,
            policy : v2,
        } = arg0;
        let v3 = v0;
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg1) == v3.config && 0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>>(arg2) == v3.treasury, 1115);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_can_buy(arg1);
        let v4 = leg_weights<T0, T1>(&v3);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::weights::check(&v4);
        assert!(0x1::vector::length<u8>(&arg6) <= 64, 1128);
        assert!(arg5 == 0 || 0x2::coin::value<T1>(&arg4) > 0, 1120);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::share_desk_account<T1>(v1, v2);
        let v5 = v3.terms;
        let v6 = v3.creator;
        let (v7, v8, _, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::snipe(&v5);
        let v11 = 0x2::random::new_generator(arg7, arg9);
        v3.snipe_window_ms = 0x2::random::generate_u64_in_range(&mut v11, v7, v8);
        v3.opened_ms = 0x2::clock::timestamp_ms(arg8);
        let v12 = Launched{
            pool            : 0x2::object::id<BasketPool<T0, T1>>(&v3),
            creator         : v6,
            account         : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_account_id<T1>(&v3.desk),
            legs            : v3.legs,
            fee_mode        : v3.fee_mode,
            virtual_shares  : v3.virtual_shares,
            snipe_window_ms : v3.snipe_window_ms,
            preset          : arg6,
            terms           : v5,
            coin            : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())),
            collateral      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())),
        };
        0x2::event::emit<Launched>(v12);
        if (0x2::coin::value<T1>(&arg4) > 0) {
            let v13 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::buy(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::split(&v5), 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::trade_fee_bps(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::split(&v5)), 0, false, v3.k, v3.x, 0x2::balance::value<T0>(&v3.tokens), 0, 0, 0x2::coin::value<T1>(&arg4));
            let (v14, v15, _, _, v18, v19, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::buy_parts(&v13);
            let v21 = v15;
            assert!(v18 <= 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(1000000000000000, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::max_dev_buy_bps(&v5), 10000), 1106);
            let v22 = &mut v3;
            let v23 = take_buy<T0, T1>(v22, arg2, arg3, 0x2::coin::into_balance<T1>(arg4), &v21, 0x1::option::none<address>(), v18, v19, arg9);
            let v24 = Traded{
                pool         : 0x2::object::id<BasketPool<T0, T1>>(&v3),
                trader       : v6,
                buy          : true,
                usdc         : v14,
                tokens       : 0x2::coin::value<T0>(&v23),
                fee          : fee_total(&v21),
                referrer     : 0x1::option::none<address>(),
                x            : v3.x,
                y            : 0x2::balance::value<T0>(&v3.tokens),
                basket_value : 0x2::balance::value<T1>(&v3.cash),
            };
            0x2::event::emit<Traded>(v24);
            if (arg5 > 0) {
                let v25 = DevBuyLocked{
                    pool   : 0x2::object::id<BasketPool<T0, T1>>(&v3),
                    lock   : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::legacy::lock_for_sender<T0>(v23, arg5, arg8, arg9),
                    days   : arg5,
                    tokens : 0x2::coin::value<T0>(&v23),
                };
                0x2::event::emit<DevBuyLocked>(v25);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v23, v6);
            };
        } else {
            0x2::coin::destroy_zero<T1>(arg4);
        };
        0x2::transfer::share_object<BasketPool<T0, T1>>(v3);
    }

    public fun finish_sell<T0, T1>(arg0: SellThrough, arg1: &mut BasketPool<T0, T1>, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg3: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>, arg4: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: 0x1::option::Option<address>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let SellThrough {
            pool         : v0,
            nonce        : v1,
            tokens_in    : v2,
            before       : v3,
            free_left    : v4,
            equities     : _,
            cut_margin   : v6,
            cut_notional : _,
            loss         : v8,
            extra        : v9,
        } = arg0;
        let v10 = v6;
        assert!(v0 == 0x2::object::id<BasketPool<T0, T1>>(arg1) && v1 == arg1.nonce, 1124);
        check_platform<T0, T1>(arg1, arg2, arg3);
        assert!(0x2::coin::value<T0>(&arg6) == v2, 1129);
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v10)) {
            assert!(*0x1::vector::borrow<u64>(&v10, v11) == 0, 1123);
            v11 = v11 + 1;
        };
        let v12 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_free<T1>(&arg1.desk, arg5);
        let v13 = if (v4 > v12) {
            v4 - v12
        } else {
            0
        };
        let v14 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::legacy::bind_sender(arg4, arg8, arg9);
        settle_sell<T0, T1>(arg1, arg3, arg4, arg6, v3, v8 + v13, v9, arg7, v14, arg9)
    }

    fun finished<T0, T1>(arg0: Valuation, arg1: &BasketPool<T0, T1>) : Valuation {
        assert!(arg0.pool == 0x2::object::id<BasketPool<T0, T1>>(arg1), 1121);
        assert!(arg0.nonce == arg1.nonce, 1124);
        let v0 = &mut arg0;
        skip_retired<T0, T1>(v0, arg1);
        assert!(arg0.next == 0x1::vector::length<Leg>(&arg1.legs) && 0x1::vector::length<u64>(&arg0.equities) == 0x1::vector::length<Leg>(&arg1.legs), 1123);
        arg0
    }

    public fun is_wound_down<T0, T1>(arg0: &BasketPool<T0, T1>) : bool {
        arg0.wound_down
    }

    fun leg_blocked(arg0: &Valuation) : vector<bool> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.equities)) {
            0x1::vector::push_back<bool>(&mut v0, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::weights::blocked(*0x1::vector::borrow<bool>(&arg0.paused, v1), *0x1::vector::borrow<bool>(&arg0.danger, v1), *0x1::vector::borrow<u64>(&arg0.equities, v1), *0x1::vector::borrow<u64>(&arg0.notionals, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun leg_leverages<T0, T1>(arg0: &BasketPool<T0, T1>) : vector<u64> {
        let v0 = &arg0.legs;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Leg>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<Leg>(v0, v2).leverage_bps);
            v2 = v2 + 1;
        };
        v1
    }

    fun leg_live<T0, T1>(arg0: &BasketPool<T0, T1>) : vector<bool> {
        let v0 = &arg0.legs;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Leg>(v0)) {
            0x1::vector::push_back<bool>(&mut v1, !0x1::vector::borrow<Leg>(v0, v2).retired);
            v2 = v2 + 1;
        };
        v1
    }

    public fun leg_parts(arg0: &Leg) : (0x2::object::ID, 0x2::object::ID, bool, u64, u64, bool) {
        (arg0.market, arg0.base_oracle, arg0.long, arg0.leverage_bps, arg0.weight_bps, arg0.retired)
    }

    fun leg_weights<T0, T1>(arg0: &BasketPool<T0, T1>) : vector<u64> {
        let v0 = &arg0.legs;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Leg>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<Leg>(v0, v2).weight_bps);
            v2 = v2 + 1;
        };
        v1
    }

    public fun legs<T0, T1>(arg0: &BasketPool<T0, T1>) : &vector<Leg> {
        &arg0.legs
    }

    fun leverage_extra<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Risk, arg2: u64, arg3: &Valuation, arg4: u64) : u64 {
        let v0 = leg_live<T0, T1>(arg0);
        let v1 = leg_weights<T0, T1>(arg0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Leg>(&arg0.legs)) {
            if (*0x1::vector::borrow<bool>(&v0, v4)) {
                v2 = v2 + 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(0x1::vector::borrow<Leg>(&arg0.legs, v4).weight_bps, 0x1::vector::borrow<Leg>(&arg0.legs, v4).leverage_bps, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::weights::live_weight(&v1, &v0));
            };
            v3 = v3 + *0x1::vector::borrow<u64>(&arg3.notionals, v4);
            v4 = v4 + 1;
        };
        let v5 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::band_for(arg1, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::margin_bps(&arg0.terms));
        let v6 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::band::target_notional(&v5, 10000, v2);
        let v7 = if (arg4 == 0) {
            0
        } else {
            0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(v3, 10000, arg4)
        };
        let v8 = if (v7 > v6) {
            v7
        } else {
            v6
        };
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::leverage_extra_bps(arg2, v8, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::arb_move_bps(&arg0.terms))
    }

    fun mark_buy<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = *0x2::tx_context::digest(arg1);
        assert!(v0 != arg0.last_sell_tx, 1116);
        arg0.last_buy_tx = v0;
    }

    fun mark_sell<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = *0x2::tx_context::digest(arg1);
        assert!(v0 != arg0.last_buy_tx, 1116);
        arg0.last_sell_tx = v0;
    }

    public fun mode_stats<T0, T1>(arg0: &BasketPool<T0, T1>) : (u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::stats<T1>(&arg0.id);
        (0x2::balance::value<T1>(&arg0.creator_fees), v0, v1, v2, v3, v4)
    }

    public fun pending_rewards<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::Stake<T0, T1>) : u64 {
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::pending<T0, T1>(&arg0.id, arg1)
    }

    public fun rebalance<T0, T1>(arg0: Valuation, arg1: &mut BasketPool<T0, T1>, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        let v0 = finished<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg2) == arg1.config, 1115);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg2);
        assert!(0x2::tx_context::gas_price(arg9) <= 0x2::tx_context::reference_gas_price(arg9), 1119);
        let v1 = *0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::risk(arg2);
        let v2 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::max_oracle_age_ms(&v1);
        let v3 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::max_slippage_bps(&v1);
        let v4 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::max_rebalance_notional(&v1);
        let v5 = value_full<T0, T1>(arg1, &v0);
        let v6 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::band_for(&v1, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::margin_bps(&arg1.terms));
        let v7 = leg_weights<T0, T1>(arg1);
        let v8 = leg_leverages<T0, T1>(arg1);
        let v9 = leg_live<T0, T1>(arg1);
        let v10 = leg_blocked(&v0);
        let v11 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::weights::next_leg(&v6, 500, v5, 0x2::balance::value<T1>(&arg1.cash) + v0.free, &v0.equities, &v0.notionals, &v7, &v8, &v9, &v10, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::is_sell_only(arg2));
        let (v12, v13, v14, v15, v16, v17) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::weights::leg_plan_parts(&v11);
        let v18 = v0.free;
        let v19 = if (v12) {
            *0x1::vector::borrow<u64>(&v0.equities, v13)
        } else {
            0
        };
        let v20 = if (v12) {
            *0x1::vector::borrow<u64>(&v0.notionals, v13)
        } else {
            0
        };
        let v21 = v12 && *0x1::vector::borrow<bool>(&v0.danger, v13) && v19 == 0;
        drop_value(v0);
        let (v22, v23) = if (0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::is_sell_only(arg2)) {
            (0, 0)
        } else {
            (v14, v16)
        };
        let v24 = if (v12) {
            if (v22 > 0) {
                true
            } else if (v15 > 0) {
                true
            } else if (v23 >= 1000000) {
                true
            } else {
                v17 >= 1000000
            }
        } else {
            false
        };
        assert!(v24, 1110);
        assert!(!v21 && (v20 == 0 || v19 > 0), 1111);
        let v25 = *0x1::vector::borrow<Leg>(&arg1.legs, v13);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg3) == v25.market && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg6) == v25.base_oracle, 1122);
        let v26 = 0x2::clock::timestamp_ms(arg8);
        assert!(v26 >= arg1.last_rebalance_ms + 30000, 1113);
        arg1.last_rebalance_ms = v26;
        arg1.nonce = arg1.nonce + 1;
        let v27 = arg3;
        if (v22 > 0) {
            let v28 = if (v18 >= v22) {
                0
            } else {
                v22 - v18
            };
            let v29 = if (v28 > 0x2::balance::value<T1>(&arg1.cash)) {
                0x2::balance::value<T1>(&arg1.cash)
            } else {
                v28
            };
            if (v29 > 0) {
                0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_deposit<T1>(&arg1.desk, arg4, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.cash, v29), arg9));
            };
            let v30 = if (v18 + v29 < v22) {
                v18 + v29
            } else {
                v22
            };
            0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_allocate<T1>(&arg1.desk, &mut v27, arg4, v30);
        };
        let v31 = 0;
        let v32 = 0;
        if (v23 >= 1000000 || v17 >= 1000000) {
            let v33 = v23 > 0;
            let v34 = if (v33) {
                v23
            } else {
                v17
            };
            let v35 = if (v34 > v4) {
                v4
            } else {
                v34
            };
            if (v33) {
                let v36 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div_up(v35, v3 + 10, 10000);
                let v37 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_free<T1>(&arg1.desk, arg4);
                let v38 = if (v37 >= v36) {
                    0
                } else {
                    v36 - v37
                };
                let v39 = if (v38 > 0x2::balance::value<T1>(&arg1.cash)) {
                    0x2::balance::value<T1>(&arg1.cash)
                } else {
                    v38
                };
                if (v39 > 0) {
                    0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_deposit<T1>(&arg1.desk, arg4, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.cash, v39), arg9));
                };
            };
            let v40 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_size_for<T1>(&arg1.desk, &v27, arg6, arg7, v35, v2, arg8);
            if (v40 > 0) {
                let (v41, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_trade<T1>(&arg1.desk, v27, arg4, arg6, arg7, v25.long, v33, v40, v3, v2, arg8, arg9);
                v27 = v41;
                if (v33) {
                    v32 = v35;
                } else {
                    v31 = v35;
                };
            };
        };
        let v43 = 0;
        if (v15 > 0) {
            let v44 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_deallocate<T1>(&arg1.desk, &mut v27, arg4, arg6, arg7, v15, arg8);
            if (v44 > 0) {
                0x2::balance::join<T1>(&mut arg1.cash, 0x2::coin::into_balance<T1>(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_withdraw<T1>(&arg1.desk, arg4, arg5, v44, arg9)));
                v43 = v44;
            };
        };
        let v45 = Rebalanced{
            pool            : 0x2::object::id<BasketPool<T0, T1>>(arg1),
            leg             : v13,
            basket_value    : v5,
            moved_to_margin : v22,
            moved_to_cash   : v43,
            grew            : v32,
            shrank          : v31,
        };
        0x2::event::emit<Rebalanced>(v45);
        v27
    }

    public fun release_rewards<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg1) == arg0.config, 1115);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg1);
        settle<T0, T1>(arg0, arg2);
    }

    public fun retire_leg<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: u64, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg1) == arg0.config, 1115);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg1);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == 0x1::vector::borrow<Leg>(&arg0.legs, arg2).market, 1122);
        let v0 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_close_at_settlement<T1>(&arg0.desk, arg3, arg4);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_withdraw<T1>(&arg0.desk, arg4, arg5, v0, arg6)));
        };
        0x1::vector::borrow_mut<Leg>(&mut arg0.legs, arg2).retired = true;
        arg0.nonce = arg0.nonce + 1;
        let v1 = leg_live<T0, T1>(arg0);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<bool>(&v1)) {
            if (*0x1::vector::borrow<bool>(&v1, v3)) {
                v2 = true;
            };
            v3 = v3 + 1;
        };
        arg0.wound_down = !v2;
        let v4 = LegRetired{
            pool       : 0x2::object::id<BasketPool<T0, T1>>(arg0),
            leg        : arg2,
            recovered  : v0,
            cash       : 0x2::balance::value<T1>(&arg0.cash),
            wound_down : arg0.wound_down,
        };
        0x2::event::emit<LegRetired>(v4);
    }

    public fun sell<T0, T1>(arg0: Valuation, arg1: &mut BasketPool<T0, T1>, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg3: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>, arg4: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = finished<T0, T1>(arg0, arg1);
        check_platform<T0, T1>(arg1, arg2, arg3);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg2);
        mark_sell<T0, T1>(arg1, arg8);
        let v1 = value_for_sell<T0, T1>(arg1, &v0);
        let v2 = leverage_extra<T0, T1>(arg1, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::risk(arg2), 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::trade_fee_bps(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::split(&arg1.terms)), &v0, value_full<T0, T1>(arg1, &v0));
        drop_value(v0);
        let v3 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::legacy::bind_sender(arg4, arg7, arg8);
        settle_sell<T0, T1>(arg1, arg3, arg4, arg5, v1, 0, v2, arg6, v3, arg8)
    }

    public fun sell_wound_down<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>, arg3: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg1);
        assert!(arg0.wound_down, 1118);
        mark_sell<T0, T1>(arg0, arg7);
        let v0 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::legacy::bind_sender(arg3, arg6, arg7);
        let v1 = 0x2::balance::value<T1>(&arg0.cash);
        settle_sell<T0, T1>(arg0, arg2, arg3, arg4, v1, 0, 0, arg5, v0, arg7)
    }

    fun settle<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x2::clock::Clock) {
        distribute_fees<T0, T1>(arg0);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::release<T1>(&mut arg0.id, 0x2::clock::timestamp_ms(arg1));
    }

    public fun settle_funding<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: u64, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2) == 0x1::vector::borrow<Leg>(&arg0.legs, arg1).market, 1122);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_settle_funding<T1>(&arg0.desk, arg2, arg3, arg4);
    }

    fun settle_sell<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>, arg2: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<address>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::sell(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::split(&arg0.terms), arg6, 0x1::option::is_some<address>(&arg8), arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, arg4, 0x2::coin::value<T0>(&arg3));
        let (v1, _, _, v4, v5, v6, v7, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::sell_parts(&v0);
        let v9 = v4;
        assert!(v6 > arg5, 1107);
        let v10 = v6 - arg5;
        assert!(v10 >= arg7, 1107);
        let v11 = v5 - arg5;
        assert!(0x2::balance::value<T1>(&arg0.cash) >= v11, 1109);
        let v12 = 0x2::balance::split<T1>(&mut arg0.cash, v11);
        let (_, v14, v15, v16, _, v18) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::parts(&v9);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut v12, v14));
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::credit<T1>(arg1, arg2, 0x2::balance::split<T1>(&mut v12, v15), 0x2::balance::split<T1>(&mut v12, v16), 0x2::balance::split<T1>(&mut v12, v18), arg8);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg3));
        arg0.x = v7;
        arg0.nonce = arg0.nonce + 1;
        let v19 = Traded{
            pool         : 0x2::object::id<BasketPool<T0, T1>>(arg0),
            trader       : 0x2::tx_context::sender(arg9),
            buy          : false,
            usdc         : v10,
            tokens       : v1,
            fee          : fee_total(&v9),
            referrer     : arg8,
            x            : arg0.x,
            y            : 0x2::balance::value<T0>(&arg0.tokens),
            basket_value : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::basket_after_sell(arg4, v5),
        };
        0x2::event::emit<Traded>(v19);
        0x2::coin::from_balance<T1>(v12, arg9)
    }

    public fun shrink_leg<T0, T1>(arg0: &mut SellThrough, arg1: &mut BasketPool<T0, T1>, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg3: u64, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        assert!(arg0.pool == 0x2::object::id<BasketPool<T0, T1>>(arg1) && arg0.nonce == arg1.nonce, 1124);
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg2) == arg1.config, 1115);
        let v0 = *0x1::vector::borrow<u64>(&arg0.cut_margin, arg3);
        assert!(v0 > 0, 1122);
        let v1 = *0x1::vector::borrow<Leg>(&arg1.legs, arg3);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg4) == v1.market && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg7) == v1.base_oracle, 1122);
        let v2 = *0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::risk(arg2);
        let v3 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::max_oracle_age_ms(&v2);
        let v4 = arg4;
        let v5 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_snapshot<T1>(&arg1.desk, &v4, arg5, arg7, arg8, v1.long, v3, arg9);
        let (_, _, _, v9, _, _, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::snapshot_parts(&v5);
        let v13 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_close_size_for<T1>(&arg1.desk, &v4, arg7, arg8, *0x1::vector::borrow<u64>(&arg0.cut_notional, arg3), v9, v3, arg9);
        let v14 = v0;
        if (v13 > 0) {
            let (v15, v16) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_trade<T1>(&arg1.desk, v4, arg5, arg7, arg8, v1.long, false, v13, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::max_sell_slippage_bps(&v2), v3, arg9, arg10);
            v4 = v15;
            let v17 = if (v16 > v13) {
                v13
            } else {
                v16
            };
            v14 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(v0, v17, v13);
        };
        let v18 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_deallocate<T1>(&arg1.desk, &mut v4, arg5, arg7, arg8, v14, arg9);
        if (v18 > 0) {
            0x2::balance::join<T1>(&mut arg1.cash, 0x2::coin::into_balance<T1>(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_withdraw<T1>(&arg1.desk, arg5, arg6, v18, arg10)));
        };
        let v19 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_snapshot<T1>(&arg1.desk, &v4, arg5, arg7, arg8, v1.long, v3, arg9);
        let (_, v21, _, _, _, _, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::snapshot_parts(&v19);
        let v27 = *0x1::vector::borrow<u64>(&arg0.equities, arg3);
        let v28 = v21 + v18;
        if (v27 > v28) {
            arg0.loss = arg0.loss + v27 - v28;
        };
        *0x1::vector::borrow_mut<u64>(&mut arg0.cut_margin, arg3) = 0;
        v4
    }

    fun skip_retired<T0, T1>(arg0: &mut Valuation, arg1: &BasketPool<T0, T1>) {
        while (arg0.next < 0x1::vector::length<Leg>(&arg1.legs) && 0x1::vector::borrow<Leg>(&arg1.legs, arg0.next).retired) {
            0x1::vector::push_back<u64>(&mut arg0.equities, 0);
            0x1::vector::push_back<u64>(&mut arg0.notionals, 0);
            0x1::vector::push_back<u64>(&mut arg0.mmrs, 0);
            0x1::vector::push_back<bool>(&mut arg0.paused, false);
            0x1::vector::push_back<bool>(&mut arg0.danger, false);
            arg0.next = arg0.next + 1;
        };
    }

    fun snipe_tx_bought<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = *0x2::tx_context::digest(arg2);
        if (v0 != arg0.snipe_tx) {
            arg0.snipe_tx = v0;
            arg0.snipe_bought = 0;
        };
        arg0.snipe_bought = arg0.snipe_bought + arg1;
        arg0.snipe_bought
    }

    public fun snipe_window<T0, T1>(arg0: &BasketPool<T0, T1>) : (u64, u64) {
        (arg0.opened_ms, arg0.snipe_window_ms)
    }

    public fun stake<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::Stake<T0, T1> {
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg1) == arg0.config, 1115);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg1);
        settle<T0, T1>(arg0, arg3);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::stake<T0, T1>(&mut arg0.id, arg0.fee_mode, 0x2::coin::into_balance<T0>(arg2), 0x2::tx_context::sender(arg4), arg4)
    }

    public fun start_launch<T0, T1>(arg0: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg1: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: 0x2::coin::TreasuryCap<T0>, arg5: &0x2::coin_registry::Currency<T0>, arg6: u8, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Launch<T0, T1> {
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_can_buy(arg0);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_sealed(arg0);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_collateral<T1>(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg4) == 0, 1100);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg5) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg4)), 1101);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg5), 1102);
        assert!(0x2::coin_registry::decimals<T0>(arg5) == 6, 1103);
        assert!(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::is_mode(arg6), 1104);
        let v0 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::launch_terms(arg0);
        let v1 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::launch_fee_sui(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg7) >= v1, 1105);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::take_launch_fee<T1>(arg1, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg7), v1));
        let (v2, v3, v4) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::new_desk<T1>(arg2, arg3, 1000000, arg9);
        let v5 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::virtual_shares(&v0);
        let v6 = BasketPool<T0, T1>{
            id                : 0x2::object::new(arg9),
            config            : 0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg0),
            treasury          : 0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>>(arg1),
            creator           : 0x2::tx_context::sender(arg9),
            treasury_cap      : arg4,
            tokens            : 0x2::coin::mint_balance<T0>(&mut arg4, 1000000000000000),
            x                 : v5,
            virtual_shares    : v5,
            k                 : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::curve::initial_k(v5, 1000000000000000),
            terms             : v0,
            cash              : 0x2::balance::zero<T1>(),
            desk              : v2,
            legs              : 0x1::vector::empty<Leg>(),
            fee_mode          : arg6,
            creator_fees      : 0x2::balance::zero<T1>(),
            opened_ms         : 0x2::clock::timestamp_ms(arg8),
            snipe_window_ms   : 0,
            last_buyback_ms   : 0,
            last_rebalance_ms : 0,
            burned            : 0,
            last_buy_tx       : *0x2::tx_context::digest(arg9),
            last_sell_tx      : b"",
            snipe_tx          : b"",
            snipe_bought      : 0,
            wound_down        : false,
            nonce             : 0,
        };
        Launch<T0, T1>{
            pool   : v6,
            acct   : v3,
            policy : v4,
        }
    }

    public fun start_sell_through<T0, T1>(arg0: Valuation, arg1: &mut BasketPool<T0, T1>, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : SellThrough {
        let v0 = finished<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg2) == arg1.config, 1115);
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::assert_version(arg2);
        mark_sell<T0, T1>(arg1, arg6);
        let v1 = value_for_sell<T0, T1>(arg1, &v0);
        let v2 = leverage_extra<T0, T1>(arg1, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::risk(arg2), 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::trade_fee_bps(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::split(&arg1.terms)), &v0, value_full<T0, T1>(arg1, &v0));
        let v3 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::sell(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::split(&arg1.terms), v2, false, arg1.k, arg1.x, 0x2::balance::value<T0>(&arg1.tokens), arg1.virtual_shares, v1, arg5);
        let (_, _, _, _, v8, _, _, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::pricing::sell_parts(&v3);
        let v12 = 0x1::vector::length<Leg>(&arg1.legs);
        let v13 = vector[];
        let v14 = 0;
        while (v14 < v12) {
            0x1::vector::push_back<u64>(&mut v13, 0);
            v14 = v14 + 1;
        };
        let v15 = vector[];
        let v16 = 0;
        while (v16 < v12) {
            0x1::vector::push_back<u64>(&mut v15, 0);
            v16 = v16 + 1;
        };
        let v17 = 0x2::balance::value<T1>(&arg1.cash);
        if (v8 > v17) {
            let v18 = v8 - v17;
            let v19 = v18;
            let v20 = if (v0.free < v18) {
                v0.free
            } else {
                v18
            };
            if (v20 > 0) {
                0x2::balance::join<T1>(&mut arg1.cash, 0x2::coin::into_balance<T1>(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_withdraw<T1>(&arg1.desk, arg3, arg4, v20, arg6)));
                v19 = v18 - v20;
            };
            if (v19 > 0) {
                let v21 = vector[];
                let v22 = 0;
                let v23 = 0;
                while (v23 < v12) {
                    let v24 = if (0x1::vector::borrow<Leg>(&arg1.legs, v23).retired) {
                        true
                    } else if (*0x1::vector::borrow<bool>(&v0.paused, v23)) {
                        true
                    } else {
                        *0x1::vector::borrow<bool>(&v0.danger, v23)
                    };
                    let v25 = if (v24) {
                        0
                    } else {
                        *0x1::vector::borrow<u64>(&v0.equities, v23)
                    };
                    0x1::vector::push_back<u64>(&mut v21, v25);
                    v22 = v22 + v25;
                    v23 = v23 + 1;
                };
                assert!(v22 > v19, 1109);
                let v26 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::weights::shrink(&v21, v19, v22);
                v23 = 0;
                while (v23 < v12) {
                    let v27 = *0x1::vector::borrow<u64>(&v26, v23);
                    if (v27 > 0) {
                        *0x1::vector::borrow_mut<u64>(&mut v13, v23) = v27;
                        *0x1::vector::borrow_mut<u64>(&mut v15, v23) = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div_up(*0x1::vector::borrow<u64>(&v0.notionals, v23), v27, *0x1::vector::borrow<u64>(&v0.equities, v23));
                    };
                    v23 = v23 + 1;
                };
            };
        };
        arg1.nonce = arg1.nonce + 1;
        drop_value(v0);
        SellThrough{
            pool         : 0x2::object::id<BasketPool<T0, T1>>(arg1),
            nonce        : arg1.nonce,
            tokens_in    : arg5,
            before       : v1,
            free_left    : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::desk_free<T1>(&arg1.desk, arg3),
            equities     : v0.equities,
            cut_margin   : v13,
            cut_notional : v15,
            loss         : 0,
            extra        : v2,
        }
    }

    public fun start_value<T0, T1>(arg0: &BasketPool<T0, T1>) : Valuation {
        assert!(!arg0.wound_down, 1117);
        Valuation{
            pool      : 0x2::object::id<BasketPool<T0, T1>>(arg0),
            nonce     : arg0.nonce,
            next      : 0,
            free      : 0,
            equities  : vector[],
            notionals : vector[],
            mmrs      : vector[],
            paused    : vector[],
            danger    : vector[],
        }
    }

    public fun state<T0, T1>(arg0: &BasketPool<T0, T1>) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, 0x2::balance::value<T1>(&arg0.cash), 0x2::balance::value<T1>(&arg0.creator_fees), arg0.burned, arg0.nonce)
    }

    fun take_buy<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &mut 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Treasury<T1>, arg2: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg3: 0x2::balance::Balance<T1>, arg4: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::Parts, arg5: 0x1::option::Option<address>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (_, v1, v2, v3, _, v5) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::parts(arg4);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut arg3, v1));
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::credit<T1>(arg1, arg2, 0x2::balance::split<T1>(&mut arg3, v2), 0x2::balance::split<T1>(&mut arg3, v3), 0x2::balance::split<T1>(&mut arg3, v5), arg5);
        0x2::balance::join<T1>(&mut arg0.cash, arg3);
        arg0.x = arg7;
        arg0.nonce = arg0.nonce + 1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, arg6), arg8)
    }

    public fun terms<T0, T1>(arg0: &BasketPool<T0, T1>) : &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms::Terms {
        &arg0.terms
    }

    public fun unstake<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg2: 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = &mut arg2;
        let v1 = claim_rewards<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (0x2::coin::from_balance<T0>(0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::modes::unstake<T0, T1>(&mut arg0.id, arg2, 0x2::tx_context::sender(arg4)), arg4), v1)
    }

    fun value_for_sell<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: &Valuation) : u64 {
        let v0 = 0x2::balance::value<T1>(&arg0.cash) + arg1.free;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1.equities)) {
            if (!*0x1::vector::borrow<bool>(&arg1.danger, v1)) {
                v0 = v0 + *0x1::vector::borrow<u64>(&arg1.equities, v1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun value_full<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: &Valuation) : u64 {
        let v0 = 0x2::balance::value<T1>(&arg0.cash) + arg1.free;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1.equities)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1.equities, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun value_leg<T0, T1>(arg0: &mut Valuation, arg1: &BasketPool<T0, T1>, arg2: &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) {
        assert!(arg0.pool == 0x2::object::id<BasketPool<T0, T1>>(arg1) && arg0.nonce == arg1.nonce, 1124);
        assert!(0x2::object::id<0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::Config>(arg2) == arg1.config, 1115);
        skip_retired<T0, T1>(arg0, arg1);
        let v0 = arg0.next;
        assert!(v0 < 0x1::vector::length<Leg>(&arg1.legs), 1122);
        let v1 = 0x1::vector::borrow<Leg>(&arg1.legs, v0);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == v1.market && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg5) == v1.base_oracle, 1122);
        let v2 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::risk(arg2);
        let v3 = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::leg_snapshot<T1>(&arg1.desk, arg3, arg4, arg5, arg6, v1.long, 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::max_oracle_age_ms(v2), arg7);
        let (v4, v5, v6, _, _, v9, v10) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::snapshot_parts(&v3);
        let (v11, _, _) = 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::config::defend(v2);
        arg0.free = v4;
        0x1::vector::push_back<u64>(&mut arg0.equities, v5);
        0x1::vector::push_back<u64>(&mut arg0.notionals, v6);
        0x1::vector::push_back<u64>(&mut arg0.mmrs, v9);
        0x1::vector::push_back<bool>(&mut arg0.paused, v10);
        let v14 = if (0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::venue::is_underwater(&v3)) {
            true
        } else if (v6 > 0 && v5 == 0) {
            true
        } else {
            0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::band::in_danger(v5, v6, v9, v11)
        };
        0x1::vector::push_back<bool>(&mut arg0.danger, v14);
        arg0.next = v0 + 1;
    }

    public fun view<T0, T1>(arg0: Valuation, arg1: &BasketPool<T0, T1>) : (u64, u64, u64, u64, vector<u64>, vector<u64>, vector<bool>, vector<bool>) {
        let v0 = finished<T0, T1>(arg0, arg1);
        let Valuation {
            pool      : _,
            nonce     : _,
            next      : _,
            free      : v4,
            equities  : v5,
            notionals : v6,
            mmrs      : _,
            paused    : v8,
            danger    : v9,
        } = v0;
        (value_full<T0, T1>(arg1, &v0), value_for_sell<T0, T1>(arg1, &v0), 0x2::balance::value<T1>(&arg1.cash), v4, v5, v6, v8, v9)
    }

    // decompiled from Move bytecode v7
}

