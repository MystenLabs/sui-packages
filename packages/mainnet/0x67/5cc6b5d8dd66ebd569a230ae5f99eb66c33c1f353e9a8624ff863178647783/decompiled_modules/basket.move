module 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::basket {
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
        cash: 0x2::balance::Balance<T1>,
        desk: 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::Desk<T1>,
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
        assert!(0x1::vector::length<Leg>(&v0.legs) < 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::weights::max_legs(), 1126);
        let v1 = 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Leg>(&v0.legs)) {
            assert!(0x1::vector::borrow<Leg>(&v0.legs, v2).market != v1, 1125);
            v2 = v2 + 1;
        };
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::open_leg<T1>(&v0.desk, &arg0.acct, arg1, arg2, arg3, arg5);
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

    public fun add_stake<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::Stake<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = claim_rewards<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::add<T0, T1>(&mut arg0.id, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::tx_context::sender(arg5));
        v0
    }

    fun basket_fee(arg0: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::Parts) : u64 {
        let (_, _, _, _, v4, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::parts(arg0);
        v4
    }

    public fun buy<T0, T1>(arg0: Valuation, arg1: &mut BasketPool<T0, T1>, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg3: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>, arg4: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = finished<T0, T1>(arg0, arg1);
        check_platform<T0, T1>(arg1, arg2, arg3);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_can_buy(arg2);
        mark_buy<T0, T1>(arg1, arg9);
        let v1 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg2);
        let v2 = value_full<T0, T1>(arg1, &v0);
        let v3 = 0x2::clock::timestamp_ms(arg8);
        let (_, _, v6, v7) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::snipe(v1);
        let v8 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::split(v1);
        let v9 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::buy_fee_bps_at(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::trade_fee_bps(v8), v6, arg1.opened_ms, arg1.snipe_window_ms, v3);
        let v10 = 0x2::tx_context::sender(arg9);
        let v11 = 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::bind_sender(arg4, arg7, arg9);
        drop_value(v0);
        let v12 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::buy(v8, v9, leverage_extra<T0, T1>(arg1, v1, v9, &v0, v2), 0x1::option::is_some<address>(&v11), arg1.k, arg1.x, 0x2::balance::value<T0>(&arg1.tokens), arg1.x - arg1.virtual_shares, v2, 0x2::coin::value<T1>(&arg5));
        let (v13, v14, _, _, v17, v18, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::buy_parts(&v12);
        let v20 = v14;
        assert!(v17 >= arg6, 1107);
        if (v3 < arg1.opened_ms + arg1.snipe_window_ms) {
            assert!(v17 <= 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div(1000000000000000, v7, 10000), 1108);
        };
        let v21 = take_buy<T0, T1>(arg1, arg3, arg4, 0x2::coin::into_balance<T1>(arg5), &v20, v11, v17, v18, arg9);
        let v22 = Traded{
            pool         : 0x2::object::id<BasketPool<T0, T1>>(arg1),
            trader       : v10,
            buy          : true,
            usdc         : v13,
            tokens       : v17,
            fee          : fee_total(&v20),
            referrer     : v11,
            x            : arg1.x,
            y            : 0x2::balance::value<T0>(&arg1.tokens),
            basket_value : v2 + v13 - fee_total(&v20) + basket_fee(&v20),
        };
        0x2::event::emit<Traded>(v22);
        v21
    }

    public fun buyback<T0, T1>(arg0: 0x1::option::Option<Valuation>, arg1: &mut BasketPool<T0, T1>, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg2) == arg1.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_can_buy(arg2);
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
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::release<T1>(&mut arg1.id, v2);
        let v3 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg2);
        let v4 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::take_buyback<T1>(&mut arg1.id, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div(v0, 100, 10000));
        let v5 = 0x2::balance::value<T1>(&v4);
        if (v5 == 0) {
            0x2::balance::destroy_zero<T1>(v4);
            return
        };
        let v6 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::buy(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::split(v3), 0, 0, false, arg1.k, arg1.x, 0x2::balance::value<T0>(&arg1.tokens), arg1.x - arg1.virtual_shares, v0, v5);
        let (_, _, v9, _, v11, v12, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::buy_parts(&v6);
        assert!(v9 == v5, 1114);
        0x2::balance::join<T1>(&mut arg1.cash, v4);
        arg1.x = v12;
        arg1.nonce = arg1.nonce + 1;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg1.treasury_cap), 0x2::balance::split<T0>(&mut arg1.tokens, v11));
        arg1.burned = arg1.burned + v11;
        arg1.last_buyback_ms = v2;
        let v14 = BoughtBack{
            pool          : 0x2::object::id<BasketPool<T0, T1>>(arg1),
            usdc          : v5,
            tokens_burned : v11,
        };
        0x2::event::emit<BoughtBack>(v14);
    }

    fun check_platform<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>) {
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg1) == arg0.config && 0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>>(arg2) == arg0.treasury, 1115);
    }

    public fun claim_creator<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg1) == arg0.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1112);
        distribute_fees<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::take_claim<T1>(&mut arg0.id, arg0.creator), arg2)
    }

    public fun claim_rewards<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg1) == arg0.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg1);
        settle<T0, T1>(arg0, arg3);
        0x2::coin::from_balance<T1>(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::claim<T0, T1>(&mut arg0.id, arg2, 0x2::tx_context::sender(arg4)), arg4)
    }

    public fun creator<T0, T1>(arg0: &BasketPool<T0, T1>) : address {
        arg0.creator
    }

    public fun defend_leg<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: u64, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg1) == arg0.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg1);
        assert!(!arg0.wound_down, 1117);
        let v0 = *0x1::vector::borrow<Leg>(&arg0.legs, arg2);
        assert!(!v0.retired, 1127);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == v0.market && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg6) == v0.base_oracle, 1122);
        let v1 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg1);
        let v2 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_snapshot<T1>(&arg0.desk, arg3, arg4, arg6, arg7, v0.long, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::max_oracle_age_ms(v1), arg8);
        let (v3, v4, v5, _, _, v8, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::snapshot_parts(&v2);
        let (v10, v11, v12) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::defend(v1);
        let v13 = if (!0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::is_underwater(&v2)) {
            if (v4 > 0) {
                0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::band::in_danger(v4, v5, v8, v10)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v13, 1111);
        let v14 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::band::defend_amount(v4, v5, v0.leverage_bps, v8, v10, 0x2::balance::value<T1>(&arg0.cash) + v3);
        let v15 = if (v14 > v3) {
            v14 - v3
        } else {
            0
        };
        if (v15 > 0) {
            0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_deposit<T1>(&arg0.desk, arg4, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v15), arg9));
        };
        if (v14 > 0) {
            0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_allocate<T1>(&arg0.desk, arg3, arg4, v14);
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

    public fun desk<T0, T1>(arg0: &BasketPool<T0, T1>) : &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::Desk<T1> {
        &arg0.desk
    }

    fun distribute_fees<T0, T1>(arg0: &mut BasketPool<T0, T1>) {
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::distribute<T1>(&mut arg0.id, arg0.fee_mode, 0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees));
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

    fun fee_total(arg0: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::Parts) : u64 {
        let (v0, _, _, _, _, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::parts(arg0);
        v0
    }

    entry fun finish_launch<T0, T1>(arg0: Launch<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>, arg3: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: vector<u8>, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let Launch {
            pool   : v0,
            acct   : v1,
            policy : v2,
        } = arg0;
        let v3 = v0;
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg1) == v3.config && 0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>>(arg2) == v3.treasury, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_can_buy(arg1);
        let v4 = leg_weights<T0, T1>(&v3);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::weights::check(&v4);
        assert!(0x1::vector::length<u8>(&arg6) <= 64, 1128);
        assert!(arg5 == 0 || 0x2::coin::value<T1>(&arg4) > 0, 1120);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::share_desk_account<T1>(v1, v2);
        let v5 = *0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg1);
        let v6 = v3.creator;
        let (v7, v8, _, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::snipe(&v5);
        let v11 = 0x2::random::new_generator(arg7, arg9);
        v3.snipe_window_ms = 0x2::random::generate_u64_in_range(&mut v11, v7, v8);
        v3.opened_ms = 0x2::clock::timestamp_ms(arg8);
        let v12 = Launched{
            pool            : 0x2::object::id<BasketPool<T0, T1>>(&v3),
            creator         : v6,
            account         : 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_account_id<T1>(&v3.desk),
            legs            : v3.legs,
            fee_mode        : v3.fee_mode,
            virtual_shares  : v3.virtual_shares,
            snipe_window_ms : v3.snipe_window_ms,
            preset          : arg6,
        };
        0x2::event::emit<Launched>(v12);
        if (0x2::coin::value<T1>(&arg4) > 0) {
            let v13 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::buy(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::split(&v5), 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::trade_fee_bps(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::split(&v5)), 0, false, v3.k, v3.x, 0x2::balance::value<T0>(&v3.tokens), 0, 0, 0x2::coin::value<T1>(&arg4));
            let (v14, v15, _, _, v18, v19, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::buy_parts(&v13);
            let v21 = v15;
            assert!(v18 <= 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div(1000000000000000, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::max_dev_buy_bps(&v5), 10000), 1106);
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
                    lock   : 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::vesting::lock_for_sender<T0>(v23, arg5, arg8, arg9),
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

    public fun finish_sell<T0, T1>(arg0: SellThrough, arg1: &mut BasketPool<T0, T1>, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg3: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>, arg4: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: 0x1::option::Option<address>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
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
        let v12 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_free<T1>(&arg1.desk, arg5);
        let v13 = if (v4 > v12) {
            v4 - v12
        } else {
            0
        };
        let v14 = 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::bind_sender(arg4, arg8, arg9);
        settle_sell<T0, T1>(arg1, arg2, arg3, arg4, arg6, v3, v8 + v13, v9, arg7, v14, arg9)
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

    fun leverage_extra<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Params, arg2: u64, arg3: &Valuation, arg4: u64) : u64 {
        let v0 = leg_live<T0, T1>(arg0);
        let v1 = leg_weights<T0, T1>(arg0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Leg>(&arg0.legs)) {
            if (*0x1::vector::borrow<bool>(&v0, v4)) {
                v2 = v2 + 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div(0x1::vector::borrow<Leg>(&arg0.legs, v4).weight_bps, 0x1::vector::borrow<Leg>(&arg0.legs, v4).leverage_bps, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::weights::live_weight(&v1, &v0));
            };
            v3 = v3 + *0x1::vector::borrow<u64>(&arg3.notionals, v4);
            v4 = v4 + 1;
        };
        let v5 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::band::target_notional(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::band_params(arg1), 10000, v2);
        let v6 = if (arg4 == 0) {
            0
        } else {
            0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div(v3, 10000, arg4)
        };
        let v7 = if (v6 > v5) {
            v6
        } else {
            v5
        };
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::leverage_extra_bps(arg2, v7, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::arb_move_bps(arg1))
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
        let (v0, v1, v2, v3, v4, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::stats<T1>(&arg0.id);
        (0x2::balance::value<T1>(&arg0.creator_fees), v0, v1, v2, v3, v4)
    }

    public fun pending_rewards<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::Stake<T0, T1>) : u64 {
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::pending<T0, T1>(&arg0.id, arg1)
    }

    public fun rebalance<T0, T1>(arg0: Valuation, arg1: &mut BasketPool<T0, T1>, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        let v0 = finished<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg2) == arg1.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg2);
        assert!(0x2::tx_context::gas_price(arg9) <= 0x2::tx_context::reference_gas_price(arg9), 1119);
        let v1 = *0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg2);
        let v2 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::max_oracle_age_ms(&v1);
        let v3 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::max_slippage_bps(&v1);
        let v4 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::max_rebalance_notional(&v1);
        let v5 = value_full<T0, T1>(arg1, &v0);
        let v6 = leg_weights<T0, T1>(arg1);
        let v7 = leg_leverages<T0, T1>(arg1);
        let v8 = leg_live<T0, T1>(arg1);
        let v9 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::weights::next_leg(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::band_params(&v1), 500, v5, 0x2::balance::value<T1>(&arg1.cash) + v0.free, &v0.equities, &v0.notionals, &v6, &v7, &v8, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::is_sell_only(arg2));
        let (v10, v11, v12, v13, v14, v15) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::weights::leg_plan_parts(&v9);
        let v16 = v0.free;
        let v17 = if (v10) {
            *0x1::vector::borrow<u64>(&v0.equities, v11)
        } else {
            0
        };
        let v18 = if (v10) {
            *0x1::vector::borrow<u64>(&v0.notionals, v11)
        } else {
            0
        };
        let v19 = v10 && *0x1::vector::borrow<bool>(&v0.danger, v11) && v17 == 0;
        drop_value(v0);
        let (v20, v21) = if (0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::is_sell_only(arg2)) {
            (0, 0)
        } else {
            (v12, v14)
        };
        let v22 = if (v10) {
            if (v20 > 0) {
                true
            } else if (v13 > 0) {
                true
            } else if (v21 >= 1000000) {
                true
            } else {
                v15 >= 1000000
            }
        } else {
            false
        };
        assert!(v22, 1110);
        assert!(!v19 && (v18 == 0 || v17 > 0), 1111);
        let v23 = *0x1::vector::borrow<Leg>(&arg1.legs, v11);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg3) == v23.market && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg6) == v23.base_oracle, 1122);
        let v24 = 0x2::clock::timestamp_ms(arg8);
        assert!(v24 >= arg1.last_rebalance_ms + 30000, 1113);
        arg1.last_rebalance_ms = v24;
        arg1.nonce = arg1.nonce + 1;
        let v25 = arg3;
        if (v20 > 0) {
            let v26 = if (v16 >= v20) {
                0
            } else {
                v20 - v16
            };
            let v27 = if (v26 > 0x2::balance::value<T1>(&arg1.cash)) {
                0x2::balance::value<T1>(&arg1.cash)
            } else {
                v26
            };
            if (v27 > 0) {
                0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_deposit<T1>(&arg1.desk, arg4, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.cash, v27), arg9));
            };
            let v28 = if (v16 + v27 < v20) {
                v16 + v27
            } else {
                v20
            };
            0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_allocate<T1>(&arg1.desk, &mut v25, arg4, v28);
        };
        let v29 = 0;
        let v30 = 0;
        if (v21 >= 1000000 || v15 >= 1000000) {
            let v31 = v21 > 0;
            let v32 = if (v31) {
                v21
            } else {
                v15
            };
            let v33 = if (v32 > v4) {
                v4
            } else {
                v32
            };
            if (v31) {
                let v34 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div_up(v33, v3 + 10, 10000);
                let v35 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_free<T1>(&arg1.desk, arg4);
                let v36 = if (v35 >= v34) {
                    0
                } else {
                    v34 - v35
                };
                let v37 = if (v36 > 0x2::balance::value<T1>(&arg1.cash)) {
                    0x2::balance::value<T1>(&arg1.cash)
                } else {
                    v36
                };
                if (v37 > 0) {
                    0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_deposit<T1>(&arg1.desk, arg4, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.cash, v37), arg9));
                };
            };
            let v38 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_size_for<T1>(&arg1.desk, &v25, arg6, arg7, v33, v2, arg8);
            if (v38 > 0) {
                let (v39, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_trade<T1>(&arg1.desk, v25, arg4, arg6, arg7, v23.long, v31, v38, v3, v2, arg8, arg9);
                v25 = v39;
                if (v31) {
                    v30 = v33;
                } else {
                    v29 = v33;
                };
            };
        };
        let v41 = 0;
        if (v13 > 0) {
            let v42 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_deallocate<T1>(&arg1.desk, &mut v25, arg4, arg6, arg7, v13, arg8);
            if (v42 > 0) {
                0x2::balance::join<T1>(&mut arg1.cash, 0x2::coin::into_balance<T1>(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_withdraw<T1>(&arg1.desk, arg4, arg5, v42, arg9)));
                v41 = v42;
            };
        };
        let v43 = Rebalanced{
            pool            : 0x2::object::id<BasketPool<T0, T1>>(arg1),
            leg             : v11,
            basket_value    : v5,
            moved_to_margin : v20,
            moved_to_cash   : v41,
            grew            : v30,
            shrank          : v29,
        };
        0x2::event::emit<Rebalanced>(v43);
        v25
    }

    public fun release_rewards<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg1) == arg0.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg1);
        settle<T0, T1>(arg0, arg2);
    }

    public fun retire_leg<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: u64, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg1) == arg0.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg1);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == 0x1::vector::borrow<Leg>(&arg0.legs, arg2).market, 1122);
        let v0 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_close_at_settlement<T1>(&arg0.desk, arg3, arg4);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_withdraw<T1>(&arg0.desk, arg4, arg5, v0, arg6)));
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

    public fun sell<T0, T1>(arg0: Valuation, arg1: &mut BasketPool<T0, T1>, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg3: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>, arg4: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = finished<T0, T1>(arg0, arg1);
        check_platform<T0, T1>(arg1, arg2, arg3);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg2);
        mark_sell<T0, T1>(arg1, arg8);
        let v1 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg2);
        let v2 = value_for_sell<T0, T1>(arg1, &v0);
        let v3 = leverage_extra<T0, T1>(arg1, v1, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::trade_fee_bps(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::split(v1)), &v0, value_full<T0, T1>(arg1, &v0));
        drop_value(v0);
        let v4 = 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::bind_sender(arg4, arg7, arg8);
        settle_sell<T0, T1>(arg1, arg2, arg3, arg4, arg5, v2, 0, v3, arg6, v4, arg8)
    }

    public fun sell_wound_down<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>, arg3: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg1);
        assert!(arg0.wound_down, 1118);
        mark_sell<T0, T1>(arg0, arg7);
        let v0 = 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::bind_sender(arg3, arg6, arg7);
        let v1 = 0x2::balance::value<T1>(&arg0.cash);
        settle_sell<T0, T1>(arg0, arg1, arg2, arg3, arg4, v1, 0, 0, arg5, v0, arg7)
    }

    fun settle<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x2::clock::Clock) {
        distribute_fees<T0, T1>(arg0);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::release<T1>(&mut arg0.id, 0x2::clock::timestamp_ms(arg1));
    }

    public fun settle_funding<T0, T1>(arg0: &BasketPool<T0, T1>, arg1: u64, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2) == 0x1::vector::borrow<Leg>(&arg0.legs, arg1).market, 1122);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_settle_funding<T1>(&arg0.desk, arg2, arg3, arg4);
    }

    fun settle_sell<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>, arg3: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::sell(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::split(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg1)), arg7, 0x1::option::is_some<address>(&arg9), arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, arg5, 0x2::coin::value<T0>(&arg4));
        let (v1, _, _, v4, v5, v6, v7, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::sell_parts(&v0);
        let v9 = v4;
        assert!(v6 > arg6, 1107);
        let v10 = v6 - arg6;
        assert!(v10 >= arg8, 1107);
        let v11 = v5 - arg6;
        assert!(0x2::balance::value<T1>(&arg0.cash) >= v11, 1109);
        let v12 = 0x2::balance::split<T1>(&mut arg0.cash, v11);
        let (_, v14, v15, v16, _, v18) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::parts(&v9);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut v12, v14));
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::credit<T1>(arg2, arg3, 0x2::balance::split<T1>(&mut v12, v15), 0x2::balance::split<T1>(&mut v12, v16), 0x2::balance::split<T1>(&mut v12, v18), arg9);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg4));
        arg0.x = v7;
        arg0.nonce = arg0.nonce + 1;
        let v19 = Traded{
            pool         : 0x2::object::id<BasketPool<T0, T1>>(arg0),
            trader       : 0x2::tx_context::sender(arg10),
            buy          : false,
            usdc         : v10,
            tokens       : v1,
            fee          : fee_total(&v9),
            referrer     : arg9,
            x            : arg0.x,
            y            : 0x2::balance::value<T0>(&arg0.tokens),
            basket_value : 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::basket_after_sell(arg5, v5),
        };
        0x2::event::emit<Traded>(v19);
        0x2::coin::from_balance<T1>(v12, arg10)
    }

    public fun shrink_leg<T0, T1>(arg0: &mut SellThrough, arg1: &mut BasketPool<T0, T1>, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg3: u64, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        assert!(arg0.pool == 0x2::object::id<BasketPool<T0, T1>>(arg1) && arg0.nonce == arg1.nonce, 1124);
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg2) == arg1.config, 1115);
        let v0 = *0x1::vector::borrow<u64>(&arg0.cut_margin, arg3);
        assert!(v0 > 0, 1122);
        let v1 = *0x1::vector::borrow<Leg>(&arg1.legs, arg3);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(&arg4) == v1.market && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg7) == v1.base_oracle, 1122);
        let v2 = *0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg2);
        let v3 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::max_oracle_age_ms(&v2);
        let v4 = arg4;
        let v5 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_size_for<T1>(&arg1.desk, &v4, arg7, arg8, *0x1::vector::borrow<u64>(&arg0.cut_notional, arg3), v3, arg9);
        let v6 = v0;
        if (v5 > 0) {
            let (v7, v8) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_trade<T1>(&arg1.desk, v4, arg5, arg7, arg8, v1.long, false, v5, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::max_sell_slippage_bps(&v2), v3, arg9, arg10);
            v4 = v7;
            let v9 = if (v8 > v5) {
                v5
            } else {
                v8
            };
            v6 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div(v0, v9, v5);
        };
        let v10 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_deallocate<T1>(&arg1.desk, &mut v4, arg5, arg7, arg8, v6, arg9);
        if (v10 > 0) {
            0x2::balance::join<T1>(&mut arg1.cash, 0x2::coin::into_balance<T1>(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_withdraw<T1>(&arg1.desk, arg5, arg6, v10, arg10)));
        };
        let v11 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_snapshot<T1>(&arg1.desk, &v4, arg5, arg7, arg8, v1.long, v3, arg9);
        let (_, v13, _, _, _, _, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::snapshot_parts(&v11);
        let v19 = *0x1::vector::borrow<u64>(&arg0.equities, arg3);
        let v20 = v13 + v10;
        if (v19 > v20) {
            arg0.loss = arg0.loss + v19 - v20;
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

    public fun snipe_window<T0, T1>(arg0: &BasketPool<T0, T1>) : (u64, u64) {
        (arg0.opened_ms, arg0.snipe_window_ms)
    }

    public fun stake<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::Stake<T0, T1> {
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg1) == arg0.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg1);
        settle<T0, T1>(arg0, arg3);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::stake<T0, T1>(&mut arg0.id, arg0.fee_mode, 0x2::coin::into_balance<T0>(arg2), 0x2::tx_context::sender(arg4), arg4)
    }

    public fun start_launch<T0, T1>(arg0: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg1: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: 0x2::coin::TreasuryCap<T0>, arg5: &0x2::coin_registry::Currency<T0>, arg6: u8, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Launch<T0, T1> {
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_can_buy(arg0);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_collateral<T1>(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg4) == 0, 1100);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg5) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg4)), 1101);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg5), 1102);
        assert!(0x2::coin_registry::decimals<T0>(arg5) == 6, 1103);
        assert!(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::is_mode(arg6), 1104);
        let v0 = *0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg0);
        let v1 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::launch_fee_sui(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg7) >= v1, 1105);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::take_launch_fee<T1>(arg1, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg7), v1));
        let (v2, v3, v4) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::new_desk<T1>(arg2, arg3, 1000000, arg9);
        let v5 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::virtual_shares(&v0);
        let v6 = BasketPool<T0, T1>{
            id                : 0x2::object::new(arg9),
            config            : 0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg0),
            treasury          : 0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>>(arg1),
            creator           : 0x2::tx_context::sender(arg9),
            treasury_cap      : arg4,
            tokens            : 0x2::coin::mint_balance<T0>(&mut arg4, 1000000000000000),
            x                 : v5,
            virtual_shares    : v5,
            k                 : 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::curve::initial_k(v5, 1000000000000000),
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
            wound_down        : false,
            nonce             : 0,
        };
        Launch<T0, T1>{
            pool   : v6,
            acct   : v3,
            policy : v4,
        }
    }

    public fun start_sell_through<T0, T1>(arg0: Valuation, arg1: &mut BasketPool<T0, T1>, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : SellThrough {
        let v0 = finished<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg2) == arg1.config, 1115);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::assert_version(arg2);
        mark_sell<T0, T1>(arg1, arg6);
        let v1 = *0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg2);
        let v2 = value_for_sell<T0, T1>(arg1, &v0);
        let v3 = leverage_extra<T0, T1>(arg1, &v1, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::trade_fee_bps(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::split(&v1)), &v0, value_full<T0, T1>(arg1, &v0));
        let v4 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::sell(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::split(&v1), v3, false, arg1.k, arg1.x, 0x2::balance::value<T0>(&arg1.tokens), arg1.virtual_shares, v2, arg5);
        let (_, _, _, _, v9, _, _, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::pricing::sell_parts(&v4);
        let v13 = 0x1::vector::length<Leg>(&arg1.legs);
        let v14 = vector[];
        let v15 = 0;
        while (v15 < v13) {
            0x1::vector::push_back<u64>(&mut v14, 0);
            v15 = v15 + 1;
        };
        let v16 = vector[];
        let v17 = 0;
        while (v17 < v13) {
            0x1::vector::push_back<u64>(&mut v16, 0);
            v17 = v17 + 1;
        };
        let v18 = 0x2::balance::value<T1>(&arg1.cash);
        if (v9 > v18) {
            let v19 = v9 - v18;
            let v20 = v19;
            let v21 = if (v0.free < v19) {
                v0.free
            } else {
                v19
            };
            if (v21 > 0) {
                0x2::balance::join<T1>(&mut arg1.cash, 0x2::coin::into_balance<T1>(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_withdraw<T1>(&arg1.desk, arg3, arg4, v21, arg6)));
                v20 = v19 - v21;
            };
            if (v20 > 0) {
                let v22 = vector[];
                let v23 = 0;
                let v24 = 0;
                while (v24 < v13) {
                    let v25 = if (0x1::vector::borrow<Leg>(&arg1.legs, v24).retired) {
                        true
                    } else if (*0x1::vector::borrow<bool>(&v0.paused, v24)) {
                        true
                    } else {
                        *0x1::vector::borrow<bool>(&v0.danger, v24)
                    };
                    let v26 = if (v25) {
                        0
                    } else {
                        *0x1::vector::borrow<u64>(&v0.equities, v24)
                    };
                    0x1::vector::push_back<u64>(&mut v22, v26);
                    v23 = v23 + v26;
                    v24 = v24 + 1;
                };
                assert!(v23 > v20, 1109);
                let v27 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::weights::shrink(&v22, v20, v23);
                v24 = 0;
                while (v24 < v13) {
                    let v28 = *0x1::vector::borrow<u64>(&v27, v24);
                    if (v28 > 0) {
                        *0x1::vector::borrow_mut<u64>(&mut v14, v24) = v28;
                        *0x1::vector::borrow_mut<u64>(&mut v16, v24) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div_up(*0x1::vector::borrow<u64>(&v0.notionals, v24), v28, *0x1::vector::borrow<u64>(&v0.equities, v24));
                    };
                    v24 = v24 + 1;
                };
            };
        };
        arg1.nonce = arg1.nonce + 1;
        drop_value(v0);
        SellThrough{
            pool         : 0x2::object::id<BasketPool<T0, T1>>(arg1),
            nonce        : arg1.nonce,
            tokens_in    : arg5,
            before       : v2,
            free_left    : 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::desk_free<T1>(&arg1.desk, arg3),
            equities     : v0.equities,
            cut_margin   : v14,
            cut_notional : v16,
            loss         : 0,
            extra        : v3,
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

    fun take_buy<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &mut 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Treasury<T1>, arg2: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg3: 0x2::balance::Balance<T1>, arg4: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::Parts, arg5: 0x1::option::Option<address>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (_, v1, v2, v3, _, v5) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::fees::parts(arg4);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut arg3, v1));
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::credit<T1>(arg1, arg2, 0x2::balance::split<T1>(&mut arg3, v2), 0x2::balance::split<T1>(&mut arg3, v3), 0x2::balance::split<T1>(&mut arg3, v5), arg5);
        0x2::balance::join<T1>(&mut arg0.cash, arg3);
        arg0.x = arg7;
        arg0.nonce = arg0.nonce + 1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, arg6), arg8)
    }

    public fun unstake<T0, T1>(arg0: &mut BasketPool<T0, T1>, arg1: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg2: 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = &mut arg2;
        let v1 = claim_rewards<T0, T1>(arg0, arg1, v0, arg3, arg4);
        (0x2::coin::from_balance<T0>(0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::modes::unstake<T0, T1>(&mut arg0.id, arg2, 0x2::tx_context::sender(arg4)), arg4), v1)
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

    public fun value_leg<T0, T1>(arg0: &mut Valuation, arg1: &BasketPool<T0, T1>, arg2: &0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) {
        assert!(arg0.pool == 0x2::object::id<BasketPool<T0, T1>>(arg1) && arg0.nonce == arg1.nonce, 1124);
        assert!(0x2::object::id<0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::Config>(arg2) == arg1.config, 1115);
        skip_retired<T0, T1>(arg0, arg1);
        let v0 = arg0.next;
        assert!(v0 < 0x1::vector::length<Leg>(&arg1.legs), 1122);
        let v1 = 0x1::vector::borrow<Leg>(&arg1.legs, v0);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == v1.market && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg5) == v1.base_oracle, 1122);
        let v2 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::params(arg2);
        let v3 = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::leg_snapshot<T1>(&arg1.desk, arg3, arg4, arg5, arg6, v1.long, 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::max_oracle_age_ms(v2), arg7);
        let (v4, v5, v6, _, _, v9, v10) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::snapshot_parts(&v3);
        let (v11, _, _) = 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::config::defend(v2);
        arg0.free = v4;
        0x1::vector::push_back<u64>(&mut arg0.equities, v5);
        0x1::vector::push_back<u64>(&mut arg0.notionals, v6);
        0x1::vector::push_back<u64>(&mut arg0.mmrs, v9);
        0x1::vector::push_back<bool>(&mut arg0.paused, v10);
        let v14 = if (0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::venue::is_underwater(&v3)) {
            true
        } else if (v6 > 0 && v5 == 0) {
            true
        } else {
            0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::band::in_danger(v5, v6, v9, v11)
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

