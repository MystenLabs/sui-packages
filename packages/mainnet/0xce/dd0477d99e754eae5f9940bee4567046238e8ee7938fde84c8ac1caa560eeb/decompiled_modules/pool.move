module 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pool {
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
        venue: 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::Venue<T1>,
        fee_mode: u8,
        creator_fees: 0x2::balance::Balance<T1>,
        opened_ms: u64,
        snipe_window_ms: u64,
        last_defend_ms: u64,
        last_buyback_ms: u64,
        burned: u64,
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

    fun basket_fee(arg0: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Parts) : u64 {
        let (_, _, _, _, v4, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::parts(arg0);
        v4
    }

    fun basket_value<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::Snapshot) : u64 {
        let (v0, v1, _, _, _, _, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot_parts(arg1);
        0x2::balance::value<T1>(&arg0.cash) + v0 + v1
    }

    public fun venue<T0, T1>(arg0: &Pool<T0, T1>) : &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::Venue<T1> {
        &arg0.venue
    }

    public fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg2: &mut 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::assert_can_buy(arg1);
        let v0 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::params(arg1);
        let v1 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot<T1>(&arg0.venue, arg3, arg4, arg5, arg6, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_oracle_age_ms(v0), arg10);
        let v2 = basket_value<T0, T1>(arg0, &v1);
        let v3 = 0x2::clock::timestamp_ms(arg10);
        let (_, _, v6, v7) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::snipe(v0);
        let v8 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::split(v0);
        let v9 = 0x2::tx_context::sender(arg11);
        let v10 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::bind_referrer<T1>(arg2, v9, arg9);
        let v11 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::buy(v8, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::buy_fee_bps_at(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::trade_fee_bps(v8), v6, arg0.opened_ms, arg0.snipe_window_ms, v3), 0x1::option::is_some<address>(&v10), arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.x - arg0.virtual_shares, v2, 0x2::coin::value<T1>(&arg7));
        let (v12, v13, _, _, v16, v17, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::buy_parts(&v11);
        let v19 = v13;
        assert!(v16 >= arg8, 807);
        if (v3 < arg0.opened_ms + arg0.snipe_window_ms) {
            assert!(v16 <= 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div(1000000000000000, v7, 10000), 808);
        };
        let v20 = take_buy<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T1>(arg7), &v19, v10, v16, v17, arg11);
        let v21 = Traded{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            trader       : v9,
            buy          : true,
            usdc         : v12,
            tokens       : v16,
            fee          : fee_total(&v19),
            referrer     : v10,
            x            : arg0.x,
            y            : 0x2::balance::value<T0>(&arg0.tokens),
            basket_value : v2 + v12 - fee_total(&v19) + basket_fee(&v19),
        };
        0x2::event::emit<Traded>(v21);
        v20
    }

    public fun buyback<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) {
        assert!(0x2::object::id<0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config>(arg1) == arg0.config, 815);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::assert_version(arg1);
        assert!(arg0.fee_mode == 1, 814);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 >= arg0.last_buyback_ms + 60000 && v0 >= arg0.opened_ms + arg0.snipe_window_ms, 813);
        let v1 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::params(arg1);
        let v2 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot<T1>(&arg0.venue, arg2, arg3, arg4, arg5, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_oracle_age_ms(v1), arg6);
        let v3 = basket_value<T0, T1>(arg0, &v2);
        let v4 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div(v3, 100, 10000);
        let v5 = 0x2::balance::value<T1>(&arg0.creator_fees);
        let v6 = if (v5 > v4) {
            v4
        } else {
            v5
        };
        if (v6 == 0) {
            return
        };
        let v7 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::buy(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::split(v1), 0, false, arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.x - arg0.virtual_shares, v3, v6);
        let (_, _, v10, _, v12, v13, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::buy_parts(&v7);
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::balance::split<T1>(&mut arg0.creator_fees, v10));
        arg0.x = v13;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury_cap), 0x2::balance::split<T0>(&mut arg0.tokens, v12));
        arg0.burned = arg0.burned + v12;
        arg0.last_buyback_ms = v0;
        let v15 = BoughtBack{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            usdc          : v6,
            tokens_burned : v12,
        };
        0x2::event::emit<BoughtBack>(v15);
    }

    fun check_platform<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg2: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>) {
        assert!(0x2::object::id<0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config>(arg1) == arg0.config && 0x2::object::id<0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>>(arg2) == arg0.treasury, 815);
    }

    public fun claim_creator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 812);
        assert!(arg0.fee_mode == 0, 814);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees), arg1)
    }

    public fun creator<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.creator
    }

    public fun defend_margin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config>(arg1) == arg0.config, 815);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::assert_version(arg1);
        let v0 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::params(arg1);
        let v1 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot<T1>(&arg0.venue, arg2, arg3, arg5, arg6, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_oracle_age_ms(v0), arg7);
        let (v2, v3, v4, _, _, v7, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot_parts(&v1);
        let (v9, v10, v11) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::defend(v0);
        assert!(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::in_danger(v3, v4, v7, v9), 811);
        let v12 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::defend_amount(v3, v4, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::leverage_bps<T1>(&arg0.venue), 0x2::balance::value<T1>(&arg0.cash) + v2);
        let v13 = if (v12 > v2) {
            v12 - v2
        } else {
            0
        };
        if (v13 > 0) {
            0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::deposit<T1>(&arg0.venue, arg3, arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v13), arg8));
        };
        if (v12 > 0) {
            0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::allocate<T1>(&arg0.venue, arg2, arg3, v12);
        };
        let v14 = 0x2::clock::timestamp_ms(arg7);
        let v15 = if (v14 >= arg0.last_defend_ms + v11 && 0x2::balance::value<T1>(&arg0.cash) >= v10) {
            arg0.last_defend_ms = v14;
            v10
        } else {
            0
        };
        let v16 = Defended{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            caller : 0x2::tx_context::sender(arg8),
            amount : v12,
            reward : v15,
        };
        0x2::event::emit<Defended>(v16);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v15), arg8)
    }

    public fun fee_mode<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.fee_mode
    }

    fun fee_total(arg0: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Parts) : u64 {
        let (v0, _, _, _, _, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::parts(arg0);
        v0
    }

    entry fun launch<T0, T1>(arg0: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg1: &mut 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: 0x2::coin::TreasuryCap<T0>, arg7: &0x2::coin_registry::Currency<T0>, arg8: bool, arg9: u64, arg10: u8, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<T1>, arg13: &0x2::random::Random, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::assert_can_buy(arg0);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::assert_collateral<T1>(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg6) == 0, 800);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg7) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg6)), 801);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg7), 802);
        assert!(0x2::coin_registry::decimals<T0>(arg7) == 6, 803);
        assert!(arg10 == 0 || arg10 == 1, 804);
        let v0 = *0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::params(arg0);
        let v1 = 0x2::tx_context::sender(arg15);
        let v2 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::launch_fee_sui(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg11) >= v2, 805);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::take_launch_fee<T1>(arg1, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg11), v2));
        if (0x2::coin::value<0x2::sui::SUI>(&arg11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg11, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg11);
        };
        let (v3, v4, _, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::snipe(&v0);
        let v7 = 0x2::random::new_generator(arg13, arg15);
        let v8 = 0x2::random::generate_u64_in_range(&mut v7, v3, v4);
        let v9 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::virtual_shares(&v0);
        let v10 = Pool<T0, T1>{
            id              : 0x2::object::new(arg15),
            config          : 0x2::object::id<0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config>(arg0),
            treasury        : 0x2::object::id<0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>>(arg1),
            creator         : v1,
            treasury_cap    : arg6,
            tokens          : 0x2::coin::mint_balance<T0>(&mut arg6, 1000000000000000),
            x               : v9,
            virtual_shares  : v9,
            k               : 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::curve::initial_k(v9, 1000000000000000),
            cash            : 0x2::balance::zero<T1>(),
            venue           : 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::new<T1>(arg2, arg3, arg4, arg5, arg8, arg9, 1000000, arg15),
            fee_mode        : arg10,
            creator_fees    : 0x2::balance::zero<T1>(),
            opened_ms       : 0x2::clock::timestamp_ms(arg14),
            snipe_window_ms : v8,
            last_defend_ms  : 0,
            last_buyback_ms : 0,
            burned          : 0,
        };
        let v11 = Launched{
            pool            : 0x2::object::id<Pool<T0, T1>>(&v10),
            creator         : v1,
            account         : 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::account_id<T1>(&v10.venue),
            market          : 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::market_id<T1>(&v10.venue),
            long            : arg8,
            leverage_bps    : arg9,
            fee_mode        : arg10,
            virtual_shares  : v9,
            snipe_window_ms : v8,
        };
        0x2::event::emit<Launched>(v11);
        if (0x2::coin::value<T1>(&arg12) > 0) {
            let v12 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::buy(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::split(&v0), 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::trade_fee_bps(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::split(&v0)), false, v10.k, v10.x, 0x2::balance::value<T0>(&v10.tokens), 0, 0, 0x2::coin::value<T1>(&arg12));
            let (_, v14, _, _, v17, v18, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::buy_parts(&v12);
            let v20 = v14;
            assert!(v17 <= 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div(1000000000000000, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_dev_buy_bps(&v0), 10000), 806);
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

    public fun rebalance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        assert!(0x2::object::id<0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config>(arg1) == arg0.config, 815);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::assert_version(arg1);
        let v0 = *0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::params(arg1);
        let v1 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_oracle_age_ms(&v0);
        let v2 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_rebalance_notional(&v0);
        let v3 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot<T1>(&arg0.venue, &arg2, arg3, arg5, arg6, v1, arg7);
        let (v4, _, v6, _, _, _, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot_parts(&v3);
        let v11 = basket_value<T0, T1>(arg0, &v3);
        let v12 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::plan(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::band_params(&v0), v11, 0x2::balance::value<T1>(&arg0.cash) + v4, v6, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::leverage_bps<T1>(&arg0.venue));
        let (v13, v14, v15, v16, v17) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::plan_parts(&v12);
        assert!(v13, 810);
        let v18 = arg2;
        if (v14 > 0) {
            let v19 = if (v4 >= v14) {
                0
            } else {
                v14 - v4
            };
            let v20 = if (v19 > 0x2::balance::value<T1>(&arg0.cash)) {
                0x2::balance::value<T1>(&arg0.cash)
            } else {
                v19
            };
            if (v20 > 0) {
                0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::deposit<T1>(&arg0.venue, arg3, arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v20), arg8));
            };
            let v21 = if (v4 + v20 < v14) {
                v4 + v20
            } else {
                v14
            };
            0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::allocate<T1>(&arg0.venue, &mut v18, arg3, v21);
        };
        let v22 = 0;
        let v23 = 0;
        if (v16 >= 1000000 || v17 >= 1000000) {
            let v24 = v16 > 0;
            let v25 = if (v24) {
                v16
            } else {
                v17
            };
            let v26 = if (v25 > v2) {
                v2
            } else {
                v25
            };
            let v27 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::size_for<T1>(&arg0.venue, &v18, arg5, arg6, v26, v1, arg7);
            if (v27 > 0) {
                let (v28, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::trade<T1>(&arg0.venue, v18, arg3, arg5, arg6, v24, v27, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_slippage_bps(&v0), v1, arg7, arg8);
                v18 = v28;
                if (v24) {
                    v23 = v26;
                } else {
                    v22 = v26;
                };
            };
        };
        let v30 = 0;
        if (v15 > 0) {
            let v31 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::deallocate<T1>(&arg0.venue, &mut v18, arg3, arg5, arg6, v15, arg7);
            if (v31 > 0) {
                0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::withdraw<T1>(&arg0.venue, arg3, arg4, v31, arg8)));
                v30 = v31;
            };
        };
        let v32 = Rebalanced{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg0),
            basket_value    : v11,
            moved_to_margin : v14,
            moved_to_cash   : v30,
            grew            : v23,
            shrank          : v22,
        };
        0x2::event::emit<Rebalanced>(v32);
        v18
    }

    public fun sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg2: &mut 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: 0x1::option::Option<address>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::assert_version(arg1);
        let v0 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot<T1>(&arg0.venue, arg3, arg4, arg5, arg6, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_oracle_age_ms(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::params(arg1)), arg10);
        let v1 = basket_value<T0, T1>(arg0, &v0);
        let v2 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::bind_referrer<T1>(arg2, 0x2::tx_context::sender(arg11), arg9);
        settle_sell<T0, T1>(arg0, arg1, arg2, arg7, v1, 0, arg8, v2, arg11)
    }

    public fun sell_through_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg2: &mut 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: 0x2::coin::Coin<T0>, arg9: u64, arg10: 0x1::option::Option<address>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T1>) {
        check_platform<T0, T1>(arg0, arg1, arg2);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::assert_version(arg1);
        let v0 = *0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::params(arg1);
        let v1 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_oracle_age_ms(&v0);
        let v2 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot<T1>(&arg0.venue, &arg3, arg4, arg6, arg7, v1, arg11);
        let v3 = basket_value<T0, T1>(arg0, &v2);
        let v4 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::bind_referrer<T1>(arg2, 0x2::tx_context::sender(arg12), arg10);
        let v5 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::sell(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::split(&v0), 0x1::option::is_some<address>(&v4), arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, v3, 0x2::coin::value<T0>(&arg8));
        let (_, _, _, _, v10, _, _, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::sell_parts(&v5);
        let v14 = arg3;
        if (v10 > 0x2::balance::value<T1>(&arg0.cash)) {
            let v15 = v10 - 0x2::balance::value<T1>(&arg0.cash);
            let v16 = v15;
            let (v17, v18, v19, _, _, _, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot_parts(&v2);
            let v24 = if (v17 < v15) {
                v17
            } else {
                v15
            };
            if (v24 > 0) {
                0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::withdraw<T1>(&arg0.venue, arg4, arg5, v24, arg12)));
                v16 = v15 - v24;
            };
            if (v16 > 0) {
                assert!(v18 > v16, 809);
                let v25 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::size_for<T1>(&arg0.venue, &v14, arg6, arg7, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div_up(v19, v16, v18), v1, arg11);
                if (v25 > 0) {
                    let (v26, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::trade<T1>(&arg0.venue, v14, arg4, arg6, arg7, false, v25, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::max_slippage_bps(&v0), v1, arg11, arg12);
                    v14 = v26;
                };
                let v28 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::deallocate<T1>(&arg0.venue, &mut v14, arg4, arg6, arg7, v16, arg11);
                if (v28 > 0) {
                    0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::withdraw<T1>(&arg0.venue, arg4, arg5, v28, arg12)));
                };
            };
        };
        let v29 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::snapshot<T1>(&arg0.venue, &v14, arg4, arg6, arg7, v1, arg11);
        let v30 = basket_value<T0, T1>(arg0, &v29);
        let v31 = if (v3 > v30) {
            v3 - v30
        } else {
            0
        };
        (v14, settle_sell<T0, T1>(arg0, arg1, arg2, arg8, v3, v31, arg9, v4, arg12))
    }

    public fun settle_funding<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) {
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::venue::settle_funding<T1>(&arg0.venue, arg1, arg2, arg3);
    }

    fun settle_sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Config, arg2: &mut 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::sell(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::split(0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::params(arg1)), 0x1::option::is_some<address>(&arg7), arg0.k, arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, arg4, 0x2::coin::value<T0>(&arg3));
        let (v1, _, _, v4, v5, v6, v7, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::sell_parts(&v0);
        let v9 = v4;
        assert!(v6 > arg5, 807);
        let v10 = v6 - arg5;
        assert!(v10 >= arg6, 807);
        let v11 = v5 - arg5;
        assert!(0x2::balance::value<T1>(&arg0.cash) >= v11, 809);
        let v12 = 0x2::balance::split<T1>(&mut arg0.cash, v11);
        let (_, v14, v15, v16, _, v18) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::parts(&v9);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut v12, v14));
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::credit<T1>(arg2, 0x2::balance::split<T1>(&mut v12, v15), 0x2::balance::split<T1>(&mut v12, v16), 0x2::balance::split<T1>(&mut v12, v18), arg7);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg3));
        arg0.x = v7;
        let v19 = Traded{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            trader       : 0x2::tx_context::sender(arg8),
            buy          : false,
            usdc         : v10,
            tokens       : v1,
            fee          : fee_total(&v9),
            referrer     : arg7,
            x            : arg0.x,
            y            : 0x2::balance::value<T0>(&arg0.tokens),
            basket_value : arg4 - v5 - arg5 + basket_fee(&v9),
        };
        0x2::event::emit<Traded>(v19);
        0x2::coin::from_balance<T1>(v12, arg8)
    }

    public fun snipe_window<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.opened_ms, arg0.snipe_window_ms)
    }

    public fun state<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64, u64, u64) {
        (arg0.x, 0x2::balance::value<T0>(&arg0.tokens), arg0.virtual_shares, 0x2::balance::value<T1>(&arg0.cash), 0x2::balance::value<T1>(&arg0.creator_fees), arg0.burned)
    }

    fun take_buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::Treasury<T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Parts, arg4: 0x1::option::Option<address>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (_, v1, v2, v3, _, v5) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::parts(arg3);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut arg2, v1));
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config::credit<T1>(arg1, 0x2::balance::split<T1>(&mut arg2, v2), 0x2::balance::split<T1>(&mut arg2, v3), 0x2::balance::split<T1>(&mut arg2, v5), arg4);
        0x2::balance::join<T1>(&mut arg0.cash, arg2);
        arg0.x = arg6;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, arg5), arg7)
    }

    fun tokens_value(arg0: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::BuyQuote) : u64 {
        let (v0, _, _, _, _, _, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing::buy_parts(arg0);
        v0
    }

    // decompiled from Move bytecode v7
}

