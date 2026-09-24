module 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool {
    struct NotionalLimitKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExposureCapped has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        to_engine: u64,
        to_cash: u64,
    }

    struct CreatorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CreatorFees<phantom T0> has store {
        creator: address,
        funds: 0x2::balance::Balance<T0>,
    }

    struct CreatorPaid has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct CompositePool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::Basket<T1, T2>,
        pending_seed: 0x2::balance::Balance<T2>,
        treasury: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::Treasury<T2>,
        dividends: 0x2::balance::Balance<T2>,
        platform: 0x2::balance::Balance<T2>,
        rollover: u64,
        settings: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::Settings,
        state: u8,
        created_ms: u64,
        last_trade_ms: u64,
        epoch_ms: u64,
        lp_supply: u64,
        records: 0x2::table::Table<0x2::object::ID, Record>,
        ledger: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::Ledger,
        reinvest_bps: u64,
    }

    struct Reinvested has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        amount: u64,
        added_nav: u64,
    }

    struct Record has store {
        lots: vector<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Lot>,
        amount: u64,
        lock: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::Lock,
        account: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::Account,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct LpPosition has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        shares: u64,
    }

    struct Prepared has copy, drop {
        pool: 0x2::object::ID,
        engine: 0x2::object::ID,
        engine_vault: 0x2::object::ID,
        engine_sleeve: 0x2::object::ID,
        engine_account: 0x2::object::ID,
        pool_sleeve: 0x2::object::ID,
        reserve: 0x2::object::ID,
        reserve_account: 0x2::object::ID,
        creator: address,
    }

    struct Created has copy, drop {
        pool: 0x2::object::ID,
        meme_reserve: u64,
        quote_nav: u64,
        lp_supply: u64,
        timestamp_ms: u64,
    }

    struct Swap has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        buyer: address,
        buy: bool,
        input: u64,
        output: u64,
        fee: u64,
        meme_reserve: u64,
        quote_nav: u64,
        hot_only: bool,
        timestamp_ms: u64,
    }

    struct CurveMoved has copy, drop {
        pool: 0x2::object::ID,
        virtual_quote: u64,
        basis: u64,
        bond_target: u64,
        depth: u64,
        meme_reserve: u64,
        timestamp_ms: u64,
    }

    struct LiquidityChanged has copy, drop {
        pool: 0x2::object::ID,
        meme_reserve: u64,
        quote_nav: u64,
        lp_supply: u64,
    }

    struct EpochFunded has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        amount: u64,
        rollover: u64,
    }

    struct Cancelled has copy, drop {
        pool: 0x2::object::ID,
    }

    struct Health has copy, drop {
        pool: 0x2::object::ID,
        engine: 0x2::object::ID,
        market: 0x2::object::ID,
        timestamp_ms: u64,
        state: u8,
        config_paused: bool,
        last_epoch_ms: u64,
        epoch_interval_ms: u64,
        meme_reserve: u64,
        quote_nav: u64,
        synth_value: u64,
        hot: u64,
        pool_lending: u64,
        reserve: u64,
        margin_shortfall: u64,
        treasury_funds: u64,
        funding_buffer: u64,
        target_synth_bps: u64,
        target_hot_bps: u64,
        session_guard: bool,
        market_pause_mode: u8,
        market_frozen: bool,
    }

    struct VolumeStatus has copy, drop, store {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        tracked: bool,
        ready: bool,
        winddown_ready: bool,
        daily_usd_e6: u128,
        started_ms: u64,
        updated_ms: u64,
        ema_tau_ms: u64,
        startup_grace_ms: u64,
        floor_usd_e6: u64,
        hibernation_enabled: bool,
        wake_cooldown_ms: u64,
    }

    struct HibernationOverrideKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HibernationOverride has copy, drop, store {
        enabled: bool,
        floor_usd_e6: u64,
    }

    struct HibernationOverridden has copy, drop {
        pool: 0x2::object::ID,
        enabled: bool,
        floor_usd_e6: u64,
        timestamp_ms: u64,
    }

    struct AdminWoken has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct LifecycleChanged has copy, drop {
        pool: 0x2::object::ID,
        state: u8,
        timestamp_ms: u64,
    }

    struct Bonded has copy, drop {
        pool: 0x2::object::ID,
        real: u64,
        virtual_quote: u64,
        burned: u64,
        meme_reserve: u64,
        quote_nav: u64,
        timestamp_ms: u64,
    }

    struct LocksReleased has copy, drop {
        pool: 0x2::object::ID,
        processed: u64,
        remaining: u64,
    }

    struct LifecycleObservation has copy, drop, store {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        state: u8,
        config_paused: bool,
        volume: VolumeStatus,
        progress: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::State,
        shares: u64,
        hot: u64,
        lending: u64,
        reserve: u64,
        can_park: bool,
        max_trade_bps: u64,
    }

    struct CashPrices<phantom T0> has drop {
        pool: 0x2::object::ID,
        at_ms: u64,
        price: u256,
        scaling: u256,
    }

    struct VolumeUnpriced has copy, drop {
        pool: 0x2::object::ID,
        raw_quote: u64,
        timestamp_ms: u64,
    }

    struct Withdrawn has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
        amount: u64,
        burned: u64,
        timestamp_ms: u64,
    }

    struct Deposited has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct BasketRebalanced has copy, drop {
        pool: 0x2::object::ID,
        nav_before: u64,
        nav_after: u64,
        synth_before: u64,
        synth_after: u64,
    }

    struct MarginDefended has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        amount: u64,
        treasury_left: u64,
    }

    struct MarginAdded has copy, drop {
        pool: 0x2::object::ID,
        donor: address,
        timestamp_ms: u64,
        to_margin: u64,
        to_treasury: u64,
    }

    struct RedeemGapCovered has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        gap: u64,
        free_before: u64,
        moved: u64,
        hot_left: u64,
    }

    struct TreasuryFunded has copy, drop {
        pool: 0x2::object::ID,
        donor: address,
        amount: u64,
    }

    public fun join<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg2: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg3: &0x2::clock::Clock) {
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(arg1) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0) && 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(&arg2) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v0 = 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg1);
        let v1 = 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg2);
        sync_effective_lock<T0, T1, T2>(arg0, arg1, arg3);
        let v2 = &mut arg2;
        sync_effective_lock<T0, T1, T2>(arg0, v2, arg3);
        settle_record<T0, T1, T2>(arg0, v0);
        settle_record<T0, T1, T2>(arg0, v1);
        let Record {
            lots    : _,
            amount  : _,
            lock    : _,
            account : v6,
        } = 0x2::table::remove<0x2::object::ID, Record>(&mut arg0.records, v1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::join<T0>(arg1, arg2);
        let v7 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::merge(&mut v7.account, v6);
        v7.amount = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(arg1);
        v7.lots = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lots<T0>(arg1);
    }

    public fun deposit<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0> {
        check<T0, T1, T2>(arg0, arg1);
        let v0 = if (arg0.state == 0) {
            true
        } else if (arg0.state == 2) {
            true
        } else {
            arg0.state == 6
        };
        assert!(v0 && !0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 3);
        let v3 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::new<T0>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::coin::into_balance<T0>(arg2), v1, arg4);
        register_new<T0, T1, T2>(arg0, &v3, v1);
        let v4 = Deposited{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            position     : 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&v3),
            owner        : 0x2::tx_context::sender(arg4),
            amount       : v2,
            timestamp_ms : v1,
        };
        0x2::event::emit<Deposited>(v4);
        v3
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2> {
        active<T0, T1, T2>(arg0, arg1);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, true);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg15);
        let v1 = rebalance_step<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::maintenance_bps(&arg0.settings, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::max_trade(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1))), arg15);
        if (v1 == 0) {
            let v2 = &mut arg5;
            observe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v2, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
            return arg5
        };
        let (v3, v4, v5, v6, v7) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::rebalance<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v1, arg14, arg15, arg16);
        let v8 = v3;
        let v9 = BasketRebalanced{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            nav_before   : v4,
            nav_after    : v5,
            synth_before : v6,
            synth_after  : v7,
        };
        0x2::event::emit<BasketRebalanced>(v9);
        let v10 = &mut v8;
        observe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v10, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        v8
    }

    public fun refill_hot<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::refill_hot<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        observe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        v0
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        check<T0, T1, T2>(arg0, arg1);
        let v0 = if (arg0.state <= 2) {
            true
        } else if (arg0.state == 5) {
            true
        } else {
            arg0.state == 6
        };
        assert!(v0, 2);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(&arg2) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v1 = &mut arg2;
        sync_effective_lock<T0, T1, T2>(arg0, v1, arg3);
        let v2 = if (arg0.state == 6) {
            0
        } else {
            arg0.state
        };
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::assert_unlocked(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lock<T0>(&arg2), 0x2::clock::timestamp_ms(arg3), v2);
        withdraw_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun defend_margin<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::engine_id<T1, T2>(&arg0.quote) == 0x2::object::id<0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>>(arg2), 1);
        assert!(arg0.state == 0 || arg0.state == 5, 2);
        let v0 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury);
        assert!(v0 > 0, 9);
        let v1 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::defend_margin<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x2::coin::from_balance<T2>(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::drain<T2>(&mut arg0.treasury, v0), arg12), arg11, arg12);
        let v2 = v0 - 0x2::coin::value<T2>(&v1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::deposit<T2>(&mut arg0.treasury, 0x2::coin::into_balance<T2>(v1));
        assert!(v2 > 0, 9);
        let v3 = MarginDefended{
            pool          : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg11),
            amount        : v2,
            treasury_left : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury),
        };
        0x2::event::emit<MarginDefended>(v3);
    }

    public fun share<T0, T1, T2>(arg0: CompositePool<T0, T1, T2>) {
        0x2::transfer::share_object<CompositePool<T0, T1, T2>>(arg0);
    }

    public fun activate<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &PoolCap, arg3: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg4: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg8: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg9: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg10: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg11: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg12: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, LpPosition) {
        check<T0, T1, T2>(arg0, arg1);
        owner<T0, T1, T2>(arg0, arg2);
        assert!(arg0.state == 3 && !0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
        timely(arg17, arg16);
        if (0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id) > 0) {
            assert!(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::engine_id<T1, T2>(&arg0.quote) == 0x2::object::id<0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>>(arg3), 1);
            0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::deposit_cash<T1, T2>(&mut arg0.quote, arg9, arg10, arg11, arg8, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.pending_seed, 0x2::balance::value<T2>(&arg0.pending_seed)), arg18), arg15, arg17, arg18);
            let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg9, arg10, arg11, arg8, arg17);
            let v1 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::sqrt((0x2::balance::value<T0>(&arg0.meme) as u256) * (v0 as u256));
            assert!(v1 > 1000, 3);
            arg0.lp_supply = v1;
            arg0.state = 6;
            arg0.epoch_ms = 0x2::clock::timestamp_ms(arg17);
            arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg17);
            let v2 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::hibernation(arg1);
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::sync(&mut arg0.id, &v2, 0x2::clock::timestamp_ms(arg17));
            let v3 = Created{
                pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
                meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
                quote_nav    : v0,
                lp_supply    : v1,
                timestamp_ms : 0x2::clock::timestamp_ms(arg17),
            };
            0x2::event::emit<Created>(v3);
            let v4 = LifecycleChanged{
                pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
                state        : 6,
                timestamp_ms : 0x2::clock::timestamp_ms(arg17),
            };
            0x2::event::emit<LifecycleChanged>(v4);
            emit_curve_valued<T0, T1, T2>(arg0, v0, 0x2::clock::timestamp_ms(arg17));
            let v5 = LpPosition{
                id     : 0x2::object::new(arg18),
                pool   : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
                shares : 0,
            };
            return (arg6, v5)
        };
        session<T0, T1, T2>(arg0, arg3, arg4, &arg6, true);
        let v6 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg3, arg4, arg5, &mut arg6, arg7, arg12, arg13, arg14, arg17);
        let (v7, _) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::deposit<T1, T2>(&mut arg0.quote, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.pending_seed, 0x2::balance::value<T2>(&arg0.pending_seed)), arg18), arg15, arg16, arg17, arg18);
        arg6 = v7;
        let v9 = nav<T0, T1, T2>(arg0, arg3, arg4, arg5, &arg6, arg7, arg8, arg9, arg10, arg11, &v6, arg17);
        let v10 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::sqrt((0x2::balance::value<T0>(&arg0.meme) as u256) * (v9 as u256));
        assert!(v10 > 1000, 3);
        arg0.lp_supply = v10;
        arg0.state = 0;
        arg0.epoch_ms = 0x2::clock::timestamp_ms(arg17);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg17);
        let v11 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::hibernation(arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::sync(&mut arg0.id, &v11, 0x2::clock::timestamp_ms(arg17));
        let v12 = Created{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : v9,
            lp_supply    : v10,
            timestamp_ms : 0x2::clock::timestamp_ms(arg17),
        };
        0x2::event::emit<Created>(v12);
        let v13 = LpPosition{
            id     : 0x2::object::new(arg18),
            pool   : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            shares : 0,
        };
        (arg6, v13)
    }

    fun active<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 0 && !0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: 0x2::coin::Coin<T0>, arg15: 0x2::coin::Coin<T2>, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, LpPosition, 0x2::coin::Coin<T0>) {
        active<T0, T1, T2>(arg0, arg1);
        timely(arg18, arg17);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id) == 0, 40);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, true);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg18);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg18);
        let (v2, v3) = deposit_capped<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, &v0, arg17, arg18, arg19);
        arg5 = v2;
        let v4 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(v3, arg0.lp_supply, v1);
        assert!(v4 > 0 && v4 >= arg16, 4);
        let v5 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v4, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply);
        assert!(0x2::coin::value<T0>(&arg14) >= v5, 3);
        0x2::balance::join<T0>(&mut arg0.meme, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, v5, arg19)));
        arg0.lp_supply = arg0.lp_supply + v4;
        let v6 = LiquidityChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg18),
            lp_supply    : arg0.lp_supply,
        };
        0x2::event::emit<LiquidityChanged>(v6);
        let v7 = LpPosition{
            id     : 0x2::object::new(arg19),
            pool   : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            shares : v4,
        };
        (arg5, v7, arg14)
    }

    public fun add_margin<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg11: 0x2::coin::Coin<T2>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::engine_id<T1, T2>(&arg0.quote) == 0x2::object::id<0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>>(arg2), 1);
        assert!((arg0.state <= 2 || arg0.state == 5) && 0x2::coin::value<T2>(&arg11) > 0, 3);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::defend_margin<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v1 = 0x2::coin::value<T2>(&v0);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::deposit<T2>(&mut arg0.treasury, 0x2::coin::into_balance<T2>(v0));
        let v2 = MarginAdded{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            donor        : 0x2::tx_context::sender(arg13),
            timestamp_ms : 0x2::clock::timestamp_ms(arg12),
            to_margin    : 0x2::coin::value<T2>(&arg11) - v1,
            to_treasury  : v1,
        };
        0x2::event::emit<MarginAdded>(v2);
    }

    public fun admin_begin_wake<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::AdminCap, arg3: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::authorize(arg1, arg2);
        assert!(!0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
        if (arg0.state == 5) {
            return
        };
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::admin_wake(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg3));
        arg0.state = 5;
        let v0 = AdminWoken{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminWoken>(v0);
        let v1 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 5,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LifecycleChanged>(v1);
    }

    public fun admin_set_hibernation<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::AdminCap, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::authorize(arg1, arg2);
        assert!(!arg3 || arg4 > 0, 3);
        let v0 = HibernationOverrideKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HibernationOverrideKey>(&arg0.id, v0)) {
            let v1 = HibernationOverrideKey{dummy_field: false};
            0x2::dynamic_field::remove<HibernationOverrideKey, HibernationOverride>(&mut arg0.id, v1);
        };
        let v2 = HibernationOverrideKey{dummy_field: false};
        let v3 = HibernationOverride{
            enabled      : arg3,
            floor_usd_e6 : arg4,
        };
        0x2::dynamic_field::add<HibernationOverrideKey, HibernationOverride>(&mut arg0.id, v2, v3);
        let v4 = HibernationOverridden{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            enabled      : arg3,
            floor_usd_e6 : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<HibernationOverridden>(v4);
    }

    public fun automatic_funding_status<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::Status {
        check<T0, T1, T2>(arg0, arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::status(&arg0.id, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury))
    }

    public fun begin_wake<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(!0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
        if (arg0.state == 5) {
            return
        };
        let v0 = volume_status<T0, T1, T2>(arg0, arg1, arg2);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::wake(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg2), v0.tracked, v0.ready, v0.daily_usd_e6, v0.floor_usd_e6, v0.wake_cooldown_ms);
        arg0.state = 5;
        let v1 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 5,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LifecycleChanged>(v1);
    }

    public fun begin_winddown<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        if (arg0.state == 1) {
            return
        };
        let v0 = volume_status<T0, T1, T2>(arg0, arg1, arg2);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::begin(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg2), 0, v0.tracked, v0.winddown_ready, v0.daily_usd_e6, v0.hibernation_enabled, v0.floor_usd_e6, v0.wake_cooldown_ms);
        arg0.state = 1;
        let v1 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LifecycleChanged>(v1);
    }

    public fun bond<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 6 && !0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg6);
        let (v1, v2) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::retire(&mut arg0.id);
        let v3 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::burn_share(0x2::balance::value<T0>(&arg0.meme), v1, v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, v3), arg7), @0x0);
        };
        let v4 = 0x2::clock::timestamp_ms(arg6);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::bond_wake(&mut arg0.id, arg0.state, v4);
        arg0.state = 5;
        let v5 = Bonded{
            pool          : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            real          : v2,
            virtual_quote : v1,
            burned        : v3,
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav     : v0,
            timestamp_ms  : v4,
        };
        0x2::event::emit<Bonded>(v5);
        let v6 = CurveMoved{
            pool          : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            virtual_quote : 0,
            basis         : 0,
            bond_target   : 0,
            depth         : v0,
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            timestamp_ms  : v4,
        };
        0x2::event::emit<CurveMoved>(v6);
        let v7 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 5,
            timestamp_ms : v4,
        };
        0x2::event::emit<LifecycleChanged>(v7);
    }

    public fun buy<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: 0x2::coin::Coin<T2>, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>) {
        active<T0, T1, T2>(arg0, arg1);
        timely(arg17, arg16);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, true);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg17);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg17);
        let v2 = 0x2::balance::value<T0>(&arg0.meme);
        let v3 = 0x2::coin::value<T2>(&arg14);
        trade_limit<T0, T1, T2>(arg0, arg1, v3, v1);
        let v4 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v3, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::base_fee(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1)), 10000);
        assert!(v3 > v4, 3);
        route_fee<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut arg14, v4, arg18)));
        let (v5, v6) = deposit_capped<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, &v0, arg16, arg17, arg18);
        arg5 = v5;
        let v7 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::buy(&mut arg0.id, v2, v1, v6);
        assert!(v7 > 0 && v7 >= arg15, 4);
        let v8 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::new<T0>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::balance::split<T0>(&mut arg0.meme, v7), 0x2::clock::timestamp_ms(arg17), arg18);
        register_new<T0, T1, T2>(arg0, &v8, 0x2::clock::timestamp_ms(arg17));
        let v9 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg17);
        buy_invariant(v2, v1, v6, v9);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg17);
        let v10 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::hibernation(arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::record_quote(&mut arg0.id, &v10, v3, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_price(&v0), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_scaling(&v0), 0x2::clock::timestamp_ms(arg17));
        let v11 = Swap{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            position     : 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&v8),
            buyer        : 0x2::tx_context::sender(arg18),
            buy          : true,
            input        : v3,
            output       : v7,
            fee          : v4,
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : v9,
            hot_only     : false,
            timestamp_ms : 0x2::clock::timestamp_ms(arg17),
        };
        0x2::event::emit<Swap>(v11);
        emit_curve_valued<T0, T1, T2>(arg0, v9, 0x2::clock::timestamp_ms(arg17));
        (arg5, v8)
    }

    public fun buy_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: 0x2::coin::Coin<T2>, arg7: CashPrices<T2>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(cash_state<T0, T1, T2>(arg0) && !0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
        timely(arg10, arg9);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg10);
        let v1 = 0x2::balance::value<T0>(&arg0.meme);
        let v2 = 0x2::coin::value<T2>(&arg6);
        trade_limit<T0, T1, T2>(arg0, arg1, v2, v0);
        let v3 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v2, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::base_fee(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1)), 10000);
        assert!(v2 > v3, 3);
        route_fee<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut arg6, v3, arg11)));
        let v4 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::deposit_cash<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, 1, arg10, arg11);
        let v5 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::buy(&mut arg0.id, v1, v0, v4);
        assert!(v5 > 0 && v5 >= arg8, 4);
        let v6 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::new<T0>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::balance::split<T0>(&mut arg0.meme, v5), 0x2::clock::timestamp_ms(arg10), arg11);
        register_new<T0, T1, T2>(arg0, &v6, 0x2::clock::timestamp_ms(arg10));
        let v7 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg10);
        buy_invariant(v1, v0, v4, v7);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg10);
        record_cash_volume<T0, T1, T2>(arg0, arg1, arg7, v2, arg10);
        let v8 = Swap{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            position     : 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&v6),
            buyer        : 0x2::tx_context::sender(arg11),
            buy          : true,
            input        : v2,
            output       : v5,
            fee          : v3,
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : v7,
            hot_only     : false,
            timestamp_ms : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<Swap>(v8);
        emit_curve_valued<T0, T1, T2>(arg0, v7, 0x2::clock::timestamp_ms(arg10));
        v6
    }

    fun buy_invariant(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        invariant(arg0, arg1, arg0 - 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::output(arg2, arg1, arg0), arg3);
    }

    public fun cancel_funding_buffer<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::AdminCap) {
        assert!(arg0.config == 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config>(arg1), 1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::authorize(arg1, arg2);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_policy::cancel(&mut arg0.id);
    }

    public fun cancel_preparation<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &PoolCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        owner<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 3, 2);
        arg0.state = 4;
        let v0 = Cancelled{pool: 0x2::object::id<CompositePool<T0, T1, T2>>(arg0)};
        0x2::event::emit<Cancelled>(v0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, 0x2::balance::value<T0>(&arg0.meme)), arg2), 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.pending_seed, 0x2::balance::value<T2>(&arg0.pending_seed)), arg2))
    }

    public fun cash_prices<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) : CashPrices<T2> {
        assert!(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::engine_id<T1, T2>(&arg0.quote) == 0x2::object::id<0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>>(arg1), 1);
        let (v0, v1) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::cash_quote_price<T1, T2>(arg1, arg2, arg3, arg4, arg5);
        CashPrices<T2>{
            pool    : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            at_ms   : 0x2::clock::timestamp_ms(arg5),
            price   : v0,
            scaling : v1,
        }
    }

    fun cash_state<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : bool {
        arg0.state == 2 || arg0.state == 6
    }

    fun check<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config) {
        assert!(arg0.config == 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config>(arg1), 1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::assert_version(arg1);
    }

    public fun claim<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(arg1) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v0 = 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg1);
        settle_record<T0, T1, T2>(arg0, v0);
        let v1 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::take(&mut 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0).account);
        assert!(v1 > 0, 3);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.dividends, v1), arg2)
    }

    public fun claimable<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::claimable(&arg0.ledger, &v0.account, &v0.lots, &v0.lock)
    }

    public fun collect_platform<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check<T0, T1, T2>(arg0, arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::authorize(arg1, arg2);
        let v0 = 0x2::balance::value<T2>(&arg0.platform);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::platform_fees::collected<T2>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config>(arg1), v0, 0x2::balance::value<T2>(&arg0.platform), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.platform, v0), arg3)
    }

    fun consume_exit<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg2: bool, arg3: &mut 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.meme, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::destroy<T0>(arg1, 0x2::object::id<CompositePool<T0, T1, T2>>(arg0)));
        let v0 = remove_exit<T0, T1, T2>(arg0, 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg1), 0x2::clock::timestamp_ms(arg4));
        if (arg2) {
            let (v1, v2, v3) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::forfeit_half(&mut v0);
            0x2::coin::join<T2>(arg3, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.dividends, v1), arg5));
            arg0.rollover = arg0.rollover + v2;
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::deposit<T2>(&mut arg0.treasury, 0x2::balance::split<T2>(&mut arg0.dividends, v3));
        } else {
            0x2::coin::join<T2>(arg3, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.dividends, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::take(&mut v0)), arg5));
        };
    }

    public fun cover_redeem_gap<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1, T2>(arg0, arg1);
        assert!(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::engine_id<T1, T2>(&arg0.quote) == 0x2::object::id<0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>>(arg2), 1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = redeem_gap<T2>(arg4, arg5, &v0);
        let v2 = 0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::balance<T2>(arg3, arg4);
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        let v4 = 0x1::u64::min(v3, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::hot<T1, T2>(&arg0.quote));
        if (v4 > 0) {
            0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::deposit<T2>(arg3, arg4, arg7, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::withdraw_hot<T1, T2>(&mut arg0.quote, v4, arg11));
        };
        let v5 = RedeemGapCovered{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg10),
            gap          : v1,
            free_before  : v2,
            moved        : v4,
            hot_left     : 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::hot<T1, T2>(&arg0.quote),
        };
        0x2::event::emit<RedeemGapCovered>(v5);
        v4
    }

    public fun creator_fees<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : (address, u64) {
        let v0 = CreatorKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<CreatorKey, CreatorFees<T2>>(&arg0.id, v0);
        (v1.creator, 0x2::balance::value<T2>(&v1.funds))
    }

    public fun curve<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : (u64, u64, u64) {
        (0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::basis(&arg0.id), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::bond_target(&arg0.id))
    }

    public fun curve_depth<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: u64) : u64 {
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::depth(&arg0.id, arg1)
    }

    fun deposit_capped<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg8: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg9: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: 0x2::coin::Coin<T2>, arg14: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::Prices, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, u64) {
        let v0 = 0x2::coin::value<T2>(&arg13);
        let (v1, _, _, _) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::allocations(&arg0.settings);
        let (v5, v6) = engine_limits<T0, T1, T2>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg14, arg16);
        let v7 = if (v5 < v6) {
            0
        } else {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(v5, 10000, v1)
        };
        let v8 = if (v0 < v7) {
            v0
        } else {
            v7
        };
        let v9 = if (v8 > 0 && 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(v8, v1, 10000) < v6) {
            0
        } else {
            v8
        };
        if (v9 == v0) {
            return 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::deposit<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 1, arg15, arg16, arg17)
        };
        let v10 = arg4;
        let v11 = 0;
        if (v9 > 0) {
            let (v12, v13) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::deposit<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, v10, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::coin::split<T2>(&mut arg13, v9, arg17), 1, arg15, arg16, arg17);
            v10 = v12;
            v11 = v13;
        };
        let v14 = 0x2::coin::value<T2>(&arg13);
        0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::deposit<T2>(arg8, arg9, arg10, arg13);
        let v15 = ExposureCapped{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg16),
            to_engine    : v9,
            to_cash      : v14,
        };
        0x2::event::emit<ExposureCapped>(v15);
        (v10, v11 + 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::share_math::contribution(nav<T0, T1, T2>(arg0, arg1, arg2, arg3, &v10, arg5, arg6, arg7, arg8, arg9, arg14, arg16), nav<T0, T1, T2>(arg0, arg1, arg2, arg3, &v10, arg5, arg6, arg7, arg8, arg9, arg14, arg16), v14))
    }

    fun distribute_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>, arg2: u64) {
        arg0.rollover = arg0.rollover + 0x2::balance::value<T2>(&arg1);
        0x2::balance::join<T2>(&mut arg0.dividends, arg1);
        let v0 = arg0.rollover;
        let v1 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::fund(&mut arg0.ledger, v0, arg2);
        arg0.rollover = v0 - v1;
        arg0.epoch_ms = arg2;
        let v2 = EpochFunded{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms : arg2,
            amount       : v1,
            rollover     : arg0.rollover,
        };
        0x2::event::emit<EpochFunded>(v2);
    }

    public fun effective_lock<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: 0x2::object::ID) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::Lock {
        0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, arg1).lock
    }

    fun emit_curve<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: u64) {
        if (0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id) == 0) {
            return
        };
        let v0 = CurveMoved{
            pool          : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            virtual_quote : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id),
            basis         : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::basis(&arg0.id),
            bond_target   : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::bond_target(&arg0.id),
            depth         : 0,
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            timestamp_ms  : arg1,
        };
        0x2::event::emit<CurveMoved>(v0);
    }

    fun emit_curve_valued<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: u64, arg2: u64) {
        if (0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id) == 0) {
            return
        };
        let v0 = CurveMoved{
            pool          : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            virtual_quote : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id),
            basis         : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::basis(&arg0.id),
            bond_target   : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::bond_target(&arg0.id),
            depth         : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::depth(&arg0.id, arg1),
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            timestamp_ms  : arg2,
        };
        0x2::event::emit<CurveMoved>(v0);
    }

    fun engine_limits<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::Prices, arg8: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_price(arg7);
        let v1 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_scaling(arg7);
        let v2 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::mark(arg7);
        let (v3, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T2>(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg3)));
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T2>(arg4);
        let (v6, v7) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::max_open_interest_position_params(v5);
        (room_math(notional_limit_usd_e6<T0, T1, T2>(arg0), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::share_math::collateral_usd_e6(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::total<T2>(arg2, arg3, arg4, arg7, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T1, T2>(arg5, arg6, arg8)), v0, v1, true), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v3), v2, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::leverage_bps<T1, T2>(arg1), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::max_open_interest(v5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::open_interest(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T2>(arg4)), v6, v7, v0, v1), min_engine_deposit(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v5), v2, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::leverage_bps<T1, T2>(arg1), v0, v1))
    }

    fun engine_room<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::Prices, arg8: &0x2::clock::Clock) : u64 {
        let (v0, v1) = engine_limits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        if (v0 < v1) {
            0
        } else {
            v0
        }
    }

    public fun execute_funding_buffer<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::set_buffer<T2>(&mut arg0.treasury, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::set_floor(&mut arg0.id, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_policy::execute(&mut arg0.id, arg1), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury)));
    }

    public fun finish_hibernation<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        if (arg0.state == 2) {
            return
        };
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg6);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::hibernate(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg6), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::shares<T1, T2>(&arg0.quote), 0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::balance<T2>(arg3, arg4));
        arg0.state = 2;
        let v0 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<LifecycleChanged>(v0);
    }

    public fun finish_wake<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 5 && !0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
        session<T0, T1, T2>(arg0, arg2, arg3, arg5, true);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg11, arg12, arg13, arg14);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg14);
        let v2 = v1 - 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::hot<T1, T2>(&arg0.quote) - 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T1, T2>(arg8, arg7, arg14) - 0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::balance<T2>(arg9, arg10);
        assert!(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::margin_shortfall<T2>(arg4, arg5, &v0, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::venue_margin_bps<T1, T2>(arg2)) == 0, 9);
        let (v3, _, _, _) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::allocations(&arg0.settings);
        if ((v2 as u128) * 10000 < (v1 as u128) * (v3 as u128) && (engine_room<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg14) as u128) * 100 < (v1 as u128)) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::finish_wake_capped(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg14), v1, v2);
        } else {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::finish_wake(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg14), v1, v2, v3);
        };
        arg0.state = 0;
        let v7 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<LifecycleChanged>(v7);
    }

    public fun fund_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        abort 9
    }

    public fun fund_epoch_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = refresh_cash_funding<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury) >= 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::buffer(&v0), 9);
        fund_epoch_inner<T0, T1, T2>(arg0, arg1, arg6);
    }

    fun fund_epoch_inner<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 0 || arg0.state == 2, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.epoch_ms + 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::epoch_ms(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1)), 8);
        let v1 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::surplus<T2>(&mut arg0.treasury);
        distribute_epoch<T0, T1, T2>(arg0, v1, v0);
    }

    public fun fund_epoch_reinvest<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2> {
        check<T0, T1, T2>(arg0, arg1);
        timely(arg15, arg14);
        let v0 = &mut arg5;
        let v1 = refresh_funding_reserve<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::ready(&v1) && 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury) >= 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::buffer(&v1), 9);
        assert!(arg0.state == 0, 2);
        let v2 = 0x2::clock::timestamp_ms(arg15);
        assert!(v2 >= arg0.epoch_ms + 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::epoch_ms(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1)), 8);
        let v3 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::surplus<T2>(&mut arg0.treasury);
        let v4 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(0x2::balance::value<T2>(&v3), arg0.reinvest_bps, 10000);
        if (v4 > 0) {
            let v5 = 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v3, v4), arg16);
            let v6 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg15);
            let (v7, v8) = deposit_capped<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v5, &v6, arg14, arg15, arg16);
            arg5 = v7;
            let v9 = Reinvested{
                pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
                timestamp_ms : v2,
                amount       : v4,
                added_nav    : v8,
            };
            0x2::event::emit<Reinvested>(v9);
        };
        distribute_epoch<T0, T1, T2>(arg0, v3, v2);
        arg5
    }

    public fun fund_epoch_reserved<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        start_reserved<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public fun fund_treasury<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::tx_context::TxContext) {
        assert!((arg0.state <= 2 || arg0.state == 5) && 0x2::coin::value<T2>(&arg1) > 0, 3);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::deposit<T2>(&mut arg0.treasury, 0x2::coin::into_balance<T2>(arg1));
        let v0 = TreasuryFunded{
            pool   : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            donor  : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T2>(&arg1),
        };
        0x2::event::emit<TreasuryFunded>(v0);
    }

    public fun funding_buffer_status<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : (u64, bool, u64, u64) {
        let (v0, v1, v2) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_policy::status(&arg0.id);
        (0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::buffer<T2>(&arg0.treasury), v0, v1, v2)
    }

    fun hibernation_enabled_of<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : bool {
        let v0 = HibernationOverrideKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HibernationOverrideKey>(&arg0.id, v0)) {
            let v2 = HibernationOverrideKey{dummy_field: false};
            0x2::dynamic_field::borrow<HibernationOverrideKey, HibernationOverride>(&arg0.id, v2).enabled
        } else {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::hibernation_enabled(&arg0.settings)
        }
    }

    fun hibernation_floor_of<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : u64 {
        let v0 = HibernationOverrideKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HibernationOverrideKey>(&arg0.id, v0)) {
            let v2 = HibernationOverrideKey{dummy_field: false};
            0x2::dynamic_field::borrow<HibernationOverrideKey, HibernationOverride>(&arg0.id, v2).floor_usd_e6
        } else {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::hibernation_floor(&arg0.settings)
        }
    }

    public fun hibernation_override<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : 0x1::option::Option<HibernationOverride> {
        let v0 = HibernationOverrideKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HibernationOverrideKey>(&arg0.id, v0)) {
            let v2 = HibernationOverrideKey{dummy_field: false};
            0x1::option::some<HibernationOverride>(*0x2::dynamic_field::borrow<HibernationOverrideKey, HibernationOverride>(&arg0.id, v2))
        } else {
            0x1::option::none<HibernationOverride>()
        }
    }

    fun invariant(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg2 as u128) * (arg3 as u128) >= (arg0 as u128) * (arg1 as u128), 7);
    }

    public fun lifecycle_observation<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock) : LifecycleObservation {
        check<T0, T1, T2>(arg0, arg1);
        let (v0, v1, v2, v3, v4) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_maintenance<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg6);
        LifecycleObservation{
            pool          : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg6),
            state         : arg0.state,
            config_paused : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1),
            volume        : volume_status<T0, T1, T2>(arg0, arg1, arg6),
            progress      : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::status(&arg0.id),
            shares        : v0,
            hot           : v1,
            lending       : v2,
            reserve       : v3,
            can_park      : v4,
            max_trade_bps : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::trade_cap(&arg0.settings, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::max_trade(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1))),
        }
    }

    public fun lifecycle_status<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::State {
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::status(&arg0.id)
    }

    public fun min_engine_deposit(arg0: u64, arg1: u256, arg2: u256, arg3: u64, arg4: u256, arg5: u256) : u64 {
        if (arg3 == 0) {
            return 18446744073709551615
        };
        let v0 = (arg0 as u256) * arg2 / 1000000000000000000000 + 1;
        let v1 = arg1 / 1000000000000 + 1;
        let v2 = if (2 * v0 > v1 + v0) {
            2 * v0
        } else {
            v1 + v0
        };
        let v3 = arg5 * arg4;
        if (v3 == 0) {
            return 18446744073709551615
        };
        let v4 = (v2 * 10000 / (arg3 as u256) + 1) * 1000000000000000000000000000000 / v3 + 1;
        if (v4 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v4 as u64)
        }
    }

    fun nav<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg8: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg9: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg10: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::Prices, arg11: &0x2::clock::Clock) : u64 {
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::value_at<T1, T2>(&arg0.quote, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun notional_limit_usd_e6<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : u64 {
        let v0 = NotionalLimitKey{dummy_field: false};
        if (0x2::dynamic_field::exists<NotionalLimitKey>(&arg0.id, v0)) {
            let v2 = NotionalLimitKey{dummy_field: false};
            *0x2::dynamic_field::borrow<NotionalLimitKey, u64>(&arg0.id, v2)
        } else {
            75000 * 1000000
        }
    }

    public fun observe<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock) : Health {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg11, arg12, arg13, arg14);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg14);
        let v2 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::hot<T1, T2>(&arg0.quote);
        let v3 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T1, T2>(arg8, arg7, arg14);
        let v4 = 0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::balance<T2>(arg9, arg10);
        let (v5, v6, _, _) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::allocations(&arg0.settings);
        let v9 = Health{
            pool              : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            engine            : 0x2::object::id<0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>>(arg2),
            market            : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg5),
            timestamp_ms      : 0x2::clock::timestamp_ms(arg14),
            state             : arg0.state,
            config_paused     : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1),
            last_epoch_ms     : arg0.epoch_ms,
            epoch_interval_ms : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::epoch_ms(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1)),
            meme_reserve      : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav         : v1,
            synth_value       : v1 - v2 - v3 - v4,
            hot               : v2,
            pool_lending      : v3,
            reserve           : v4,
            margin_shortfall  : 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::margin_shortfall<T2>(arg4, arg5, &v0, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::venue_margin_bps<T1, T2>(arg2)),
            treasury_funds    : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury),
            funding_buffer    : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::buffer<T2>(&arg0.treasury),
            target_synth_bps  : v5,
            target_hot_bps    : v6,
            session_guard     : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::session_guard(&arg0.settings),
            market_pause_mode : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T2>(arg5),
            market_frozen     : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T2>(arg5),
        };
        0x2::event::emit<Health>(v9);
        v9
    }

    public fun observe_cash<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &0x2::clock::Clock) : Health {
        check<T0, T1, T2>(arg0, arg1);
        assert!(cash_state<T0, T1, T2>(arg0), 2);
        assert!(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::market_id<T1, T2>(&arg0.quote) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg6), 1);
        let (v0, v1, _, _) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::allocations(&arg0.settings);
        let v4 = Health{
            pool              : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            engine            : 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::engine_id<T1, T2>(&arg0.quote),
            market            : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg6),
            timestamp_ms      : 0x2::clock::timestamp_ms(arg7),
            state             : arg0.state,
            config_paused     : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1),
            last_epoch_ms     : arg0.epoch_ms,
            epoch_interval_ms : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::epoch_ms(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1)),
            meme_reserve      : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav         : 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg7),
            synth_value       : 0,
            hot               : 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::hot<T1, T2>(&arg0.quote),
            pool_lending      : 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T1, T2>(arg2, arg5, arg7),
            reserve           : 0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::balance<T2>(arg3, arg4),
            margin_shortfall  : 0,
            treasury_funds    : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury),
            funding_buffer    : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::buffer<T2>(&arg0.treasury),
            target_synth_bps  : v0,
            target_hot_bps    : v1,
            session_guard     : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::session_guard(&arg0.settings),
            market_pause_mode : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T2>(arg6),
            market_frozen     : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T2>(arg6),
        };
        0x2::event::emit<Health>(v4);
        v4
    }

    fun owner<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &PoolCap) {
        assert!(arg1.pool == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
    }

    public fun park_hibernation_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.state == 1 || arg0.state == 2, 2);
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::park_cash<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun pay_creator<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<CreatorKey, CreatorFees<T2>>(&mut arg0.id, v0);
        let v2 = 0x2::balance::value<T2>(&v1.funds);
        assert!(v2 > 0, 3);
        let v3 = v1.creator;
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v1.funds, v2), arg1), v3);
        let v4 = CreatorPaid{
            pool    : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            creator : v3,
            amount  : v2,
        };
        0x2::event::emit<CreatorPaid>(v4);
    }

    public(friend) fun prepare<T0, T1, T2>(arg0: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T2>, arg8: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::Settings, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (CompositePool<T0, T1, T2>, PoolCap) {
        let v0 = if (!0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg0)) {
            if (0x2::coin::value<T0>(&arg6) > 0) {
                0x2::coin::value<T2>(&arg7) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg12 <= 10000, 3);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::validate(&arg8);
        let (v1, v2, v3, v4) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::allocations(&arg8);
        let v5 = 0x1::u64::max(5500, arg11 * ((0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T2>(arg2)) * 10000 / 1000000000000000000) as u64) / 10000 + 500);
        assert!(v5 <= 10000, 3);
        let (v6, v7, v8) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::new<T1, T2>(arg1, arg2, arg3, arg4, arg5, 0x1::u64::min(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::engine_lending_bps(&arg8), 10000 - v5), v5, arg9, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::max_notional_usd(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg0)), 1000000, 1), arg10, arg11, arg14, arg15);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let (v12, v13, v14) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::new<T1, T2>(&v11, &v10, arg1, arg3, v1, v2, v3, v4, arg15);
        let v15 = v14;
        let v16 = v13;
        let v17 = 0x2::clock::timestamp_ms(arg14);
        let v18 = CompositePool<T0, T1, T2>{
            id            : 0x2::object::new(arg15),
            config        : 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config>(arg0),
            meme          : 0x2::coin::into_balance<T0>(arg6),
            quote         : v12,
            pending_seed  : 0x2::coin::into_balance<T2>(arg7),
            treasury      : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::new<T2>(),
            dividends     : 0x2::balance::zero<T2>(),
            platform      : 0x2::balance::zero<T2>(),
            rollover      : 0,
            settings      : arg8,
            state         : 3,
            created_ms    : v17,
            last_trade_ms : v17,
            epoch_ms      : v17,
            lp_supply     : 0,
            records       : 0x2::table::new<0x2::object::ID, Record>(arg15),
            ledger        : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::new(v17, arg15),
            reinvest_bps  : arg12,
        };
        let v19 = CreatorKey{dummy_field: false};
        let v20 = CreatorFees<T2>{
            creator : 0x2::tx_context::sender(arg15),
            funds   : 0x2::balance::zero<T2>(),
        };
        0x2::dynamic_field::add<CreatorKey, CreatorFees<T2>>(&mut v18.id, v19, v20);
        let v21 = NotionalLimitKey{dummy_field: false};
        0x2::dynamic_field::add<NotionalLimitKey, u64>(&mut v18.id, v21, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::max_notional_usd(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg0)), 1000000, 1));
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::install(&mut v18.id, arg13, 0x2::balance::value<T2>(&v18.pending_seed));
        emit_curve<T0, T1, T2>(&v18, v17);
        let v22 = Prepared{
            pool            : 0x2::object::id<CompositePool<T0, T1, T2>>(&v18),
            engine          : 0x2::object::id<0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>>(&v11),
            engine_vault    : 0x2::object::id<0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>>(&v10),
            engine_sleeve   : 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>>(&v9),
            engine_account  : 0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::account_id<T2>(&v10),
            pool_sleeve     : 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>>(&v16),
            reserve         : 0x2::object::id<0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>>(&v15),
            reserve_account : 0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::account_id<T2>(&v15),
            creator         : 0x2::tx_context::sender(arg15),
        };
        0x2::event::emit<Prepared>(v22);
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::share<T1, T2>(v11);
        0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::share<T2>(v10);
        0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::share<T1, T2>(v9);
        0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::share<T1, T2>(v16);
        0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::share<T2>(v15);
        let v23 = PoolCap{
            id   : 0x2::object::new(arg15),
            pool : 0x2::object::id<CompositePool<T0, T1, T2>>(&v18),
        };
        (v18, v23)
    }

    public fun propose_funding_buffer<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.config == 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config>(arg1), 1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::authorize(arg1, arg2);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_policy::propose(&mut arg0.id, arg1, arg3, arg4);
    }

    fun rebalance_step<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg8: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg9: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg10: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::Prices, arg11: u64, arg12: &0x2::clock::Clock) : u64 {
        let v0 = nav<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        let v1 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::shares<T1, T2>(&arg0.quote);
        let v2 = if (v1 == 0) {
            0
        } else {
            0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::share_math::redeem_assets_scaled(v1, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::total<T2>(arg2, arg3, arg4, arg10, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T1, T2>(arg5, arg6, arg12)), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::supply<T1, T2>(arg1), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_scaling(arg10))
        };
        let (v3, _, _, _) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::allocations(&arg0.settings);
        if (v0 == 0 || (v2 as u128) * 10000 >= (v0 as u128) * (v3 as u128)) {
            return arg11
        };
        let v7 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(engine_room<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg12), 10000, v0);
        if (v7 < arg11) {
            v7
        } else {
            arg11
        }
    }

    fun record_cash_volume<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: CashPrices<T2>, arg3: u64, arg4: &0x2::clock::Clock) {
        let CashPrices {
            pool    : v0,
            at_ms   : v1,
            price   : v2,
            scaling : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0) && v1 == 0x2::clock::timestamp_ms(arg4), 1);
        let v4 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::hibernation(arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::record_quote(&mut arg0.id, &v4, arg3, v2, v3, v1);
    }

    public fun record_count<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : u64 {
        0x2::table::length<0x2::object::ID, Record>(&arg0.records)
    }

    fun redeem_gap<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::Prices) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg0);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg1, v0)) {
            return 0
        };
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg1, v0);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1);
        let v3 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::margin_requirement(v1, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::mark(arg2), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(v2)));
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(v2);
        let v5 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_price(arg2);
        let (v6, v7) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(arg1));
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::margin_topup(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v1), v5), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::one(), v4)), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::calculate_position_funding_internal(v1, v6, v7)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v3, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v3, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64fraction(50, 10000))), v5, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_scaling(arg2), v4)
    }

    public fun refill_hot_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1, T2>(arg0, arg1);
        assert!(cash_state<T0, T1, T2>(arg0), 2);
        observe_cash<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg9);
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::refill_cash<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10)
    }

    public fun refresh_cash_funding<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::Status {
        check<T0, T1, T2>(arg0, arg1);
        assert!(cash_state<T0, T1, T2>(arg0), 2);
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg6);
        let v0 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::no_exposure(&mut arg0.id, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::buffer<T2>(&arg0.treasury), arg6);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::set_buffer<T2>(&mut arg0.treasury, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::buffer(&v0));
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::emit_status(v0);
        v0
    }

    public fun refresh_funding_reserve<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::Status {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg11, arg12, arg13, arg14);
        nav<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg14);
        let (v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T2>(arg5));
        let v3 = if (0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::long<T1, T2>(arg2)) {
            v1
        } else {
            v2
        };
        let (v4, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_params(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T2>(arg5));
        let v6 = 0;
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T2>(arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg4))) {
            let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T2>(arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg4));
            let (v8, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v7);
            if (0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::long<T1, T2>(arg2)) {
                assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v7), 9);
                v6 = v8;
            } else {
                assert!(v8 == 0 || 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v8), 9);
                v6 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v8);
            };
        };
        let v10 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::funding(arg1);
        let v11 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::update(&mut arg0.id, &v10, v3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_last_upd_ms(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T2>(arg5)), v4, v6, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::shares<T1, T2>(&arg0.quote), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::supply<T1, T2>(arg2), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_price(&v0), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_scaling(&v0), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::buffer<T2>(&arg0.treasury), arg14);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::set_buffer<T2>(&mut arg0.treasury, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::buffer(&v11));
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::emit_status(v11);
        v11
    }

    public fun refresh_volume_tracking<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::hibernation(arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::sync(&mut arg0.id, &v0, 0x2::clock::timestamp_ms(arg2));
    }

    fun register_new<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg2: u64) {
        let v0 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lots<T0>(arg1);
        let v1 = *0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lock<T0>(arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::insert_position(&mut arg0.ledger, &v0, &v1, arg2);
        let v2 = Record{
            lots    : v0,
            amount  : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(arg1),
            lock    : v1,
            account : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::open(&arg0.ledger),
        };
        0x2::table::add<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg1), v2);
    }

    fun register_split<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg2: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::Account) {
        let v0 = Record{
            lots    : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lots<T0>(arg1),
            amount  : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(arg1),
            lock    : *0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lock<T0>(arg1),
            account : arg2,
        };
        0x2::table::add<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg1), v0);
    }

    public fun reinvest_bps<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : u64 {
        arg0.reinvest_bps
    }

    public fun release_winddown_locks<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = if (arg0.state == 1) {
            if (arg1 > 0) {
                arg1 <= 64
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_lifecycle::next_unlock(&mut arg0.id, 0);
        let v1 = LocksReleased{
            pool      : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            processed : 0,
            remaining : 0,
        };
        0x2::event::emit<LocksReleased>(v1);
    }

    fun remove_exit<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0x2::object::ID, arg2: u64) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::Account {
        let Record {
            lots    : v0,
            amount  : _,
            lock    : v2,
            account : v3,
        } = 0x2::table::remove<0x2::object::ID, Record>(&mut arg0.records, arg1);
        let v4 = v3;
        let v5 = v2;
        let v6 = v0;
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::settle(&arg0.ledger, &mut v4, &v6, &v5);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::remove_position(&mut arg0.ledger, &v6, &v5, arg2);
        v4
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg8: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg9: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: LpPosition, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        timely(arg17, arg16);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id) == 0, 40);
        session<T0, T1, T2>(arg0, arg1, arg2, &arg4, true);
        let LpPosition {
            id     : v0,
            pool   : v1,
            shares : v2,
        } = arg13;
        let v3 = if (v1 == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0)) {
            if (arg0.state <= 2 || arg0.state == 5) {
                if (v2 > 0) {
                    v2 < arg0.lp_supply
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 1);
        let v4 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg1, arg2, arg3, &mut arg4, arg5, arg10, arg11, arg12, arg17);
        let v5 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(v2, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply);
        assert!(v5 >= arg14, 4);
        let (v6, v7) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::withdraw<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v2, arg0.lp_supply, arg15, arg16, arg17, arg18);
        arg4 = v6;
        arg0.lp_supply = arg0.lp_supply - v2;
        0x2::object::delete(v0);
        let v8 = LiquidityChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : nav<T0, T1, T2>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v4, arg17),
            lp_supply    : arg0.lp_supply,
        };
        0x2::event::emit<LiquidityChanged>(v8);
        (arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, v5), arg18), v7)
    }

    public fun remove_liquidity_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: LpPosition, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        timely(arg10, arg9);
        assert!(arg0.state == 2, 2);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id) == 0, 40);
        let LpPosition {
            id     : v0,
            pool   : v1,
            shares : v2,
        } = arg6;
        let v3 = if (v1 == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0)) {
            if (v2 > 0) {
                v2 < arg0.lp_supply
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 1);
        let v4 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(v2, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply);
        assert!(v4 >= arg7, 4);
        arg0.lp_supply = arg0.lp_supply - v2;
        0x2::object::delete(v0);
        let v5 = LiquidityChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg1, arg2, arg3, arg4, arg10),
            lp_supply    : arg0.lp_supply,
        };
        0x2::event::emit<LiquidityChanged>(v5);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, v4), arg11), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::withdraw_cash<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4, arg5, v2, arg0.lp_supply, arg8, arg10, arg11))
    }

    public fun restore_wake_exposure<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 5 && !0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::paused(arg1), 2);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, true);
        let v0 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg15);
        let v1 = rebalance_step<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::maintenance_bps(&arg0.settings, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::max_trade(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1))), arg15);
        if (v1 == 0) {
            return arg5
        };
        let (v2, v3, v4, v5, v6) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::rebalance<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v1, arg14, arg15, arg16);
        let v7 = BasketRebalanced{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            nav_before   : v3,
            nav_after    : v4,
            synth_before : v5,
            synth_after  : v6,
        };
        0x2::event::emit<BasketRebalanced>(v7);
        v2
    }

    public fun room_math(arg0: u64, arg1: u64, arg2: u256, arg3: u256, arg4: u64, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256) : u64 {
        let v0 = if (arg1 >= arg0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = arg2 * arg3;
        let v2 = if (v1 % 1000000000000000000000000000000 > 0) {
            1
        } else {
            0
        };
        let v3 = v1 / 1000000000000000000000000000000 + v2;
        let v4 = (arg0 as u256);
        if (v3 >= v4) {
            return 0
        };
        let v5 = (arg4 as u256);
        let v6 = (v4 - v3) * 10000 / v5;
        let v7 = ((arg0 - arg1) as u256);
        let v8 = 1000000000000000000;
        let v9 = if (arg8 > v8) {
            v8
        } else {
            arg8
        };
        let v10 = if (arg5 > arg6) {
            arg5 - arg6
        } else {
            0
        };
        let v11 = arg6 / v8 * v9 + arg6 % v8 * v9 / v8;
        let v12 = if (v11 > arg2) {
            v11 - arg2
        } else {
            0
        };
        let v13 = if (arg7 > arg6) {
            arg7 - arg6
        } else {
            0
        };
        let v14 = if (v13 > v12) {
            v13
        } else {
            v12
        };
        let v15 = if (v10 < v14) {
            v10
        } else {
            v14
        };
        let v16 = v15;
        let v17 = v4 * 1000000000000000000000000000000 / arg3 + 1;
        if (v15 > v17) {
            v16 = v17;
        };
        let v18 = v16 * arg3 / 1000000000000000000000000000000 * 10000 / v5;
        let v19 = if (v6 < v7) {
            v6
        } else {
            v7
        };
        let v20 = v19;
        if (v18 < v19) {
            v20 = v18;
        };
        let v21 = arg10 * arg9;
        if (v21 == 0) {
            return 0
        };
        let v22 = (v20 - v20 / 100) * 1000000000000000000000000000000 / v21;
        if (v22 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v22 as u64)
        }
    }

    fun route_fee<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg2);
        let (v1, v2, _) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::splits(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1));
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::deposit<T2>(&mut arg0.treasury, 0x2::balance::split<T2>(&mut arg2, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(v0, v1, 10000)));
        let v4 = if (v2 > 1000) {
            1000
        } else {
            0
        };
        let v5 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(v0, v4, 10000);
        if (v5 > 0) {
            let v6 = CreatorKey{dummy_field: false};
            0x2::balance::join<T2>(&mut 0x2::dynamic_field::borrow_mut<CreatorKey, CreatorFees<T2>>(&mut arg0.id, v6).funds, 0x2::balance::split<T2>(&mut arg2, v5));
        };
        let v7 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div(v0, v2 - v4, 10000);
        0x2::balance::join<T2>(&mut arg0.dividends, 0x2::balance::split<T2>(&mut arg2, v7));
        arg0.rollover = arg0.rollover + v7;
        0x2::balance::join<T2>(&mut arg0.platform, arg2);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::platform_fees::accrued<T2>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config>(arg1), 0x2::balance::value<T2>(&arg2), 0x2::balance::value<T2>(&arg0.platform));
    }

    public fun sell<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg15: bool, arg16: bool, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, 0x2::coin::Coin<T2>) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        timely(arg19, arg18);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, !arg16);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(&arg14) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v0 = &mut arg14;
        sync_effective_lock<T0, T1, T2>(arg0, v0, arg19);
        if (!arg15) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::assert_unlocked(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lock<T0>(&arg14), 0x2::clock::timestamp_ms(arg19), arg0.state);
        };
        let v1 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg19);
        let v2 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v1, arg19);
        let v3 = 0x2::balance::value<T0>(&arg0.meme);
        let v4 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(&arg14);
        trade_limit<T0, T1, T2>(arg0, arg1, v4, v3);
        let v5 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::sell(&mut arg0.id, v3, v2, v4);
        assert!(v5 > 0, 3);
        let v6 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1);
        let v7 = if (arg15) {
            arg0.state == 0
        } else {
            false
        };
        let v8 = if (v7) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v4, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_max(v6), 10000)
        } else if (arg0.state != 0) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v4, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_min(v6), 10000)
        } else {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::fee<T0>(&arg14, 0x2::clock::timestamp_ms(arg19), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_max(v6), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_min(v6), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::tau(v6))
        };
        let v9 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v5, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::session_policy::exit_fee(v4, v8, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_max(v6), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::session_guard(&arg0.settings), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T2>(&arg5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T2>(&arg5), arg0.state), v4);
        let v10 = if (arg16) {
            0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::withdraw_hot<T1, T2>(&mut arg0.quote, v5, arg20)
        } else {
            let (v11, v12) = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::withdraw<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v5, v2, 1, arg18, arg19, arg20);
            arg5 = v11;
            v12
        };
        let v13 = v10;
        assert!(0x2::coin::value<T2>(&v13) > v9, 3);
        route_fee<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v13, v9, arg20)));
        let v14 = 0x2::coin::value<T2>(&v13);
        assert!(v14 >= arg17, 4);
        let v15 = 0x2::object::id<CompositePool<T0, T1, T2>>(arg0);
        let v16 = &mut v13;
        consume_exit<T0, T1, T2>(arg0, arg14, v7, v16, arg19, arg20);
        let v17 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v1, arg19);
        sell_invariant<T0, T1, T2>(arg0, v3, v2, v5, v17);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg19);
        let v18 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::hibernation(arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::record_quote(&mut arg0.id, &v18, v14, 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_price(&v1), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::valuation::collateral_scaling(&v1), 0x2::clock::timestamp_ms(arg19));
        let v19 = Swap{
            pool         : v15,
            position     : 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg14),
            buyer        : 0x2::tx_context::sender(arg20),
            buy          : false,
            input        : v4,
            output       : v14,
            fee          : v9,
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : v17,
            hot_only     : arg16,
            timestamp_ms : 0x2::clock::timestamp_ms(arg19),
        };
        0x2::event::emit<Swap>(v19);
        emit_curve_valued<T0, T1, T2>(arg0, v17, 0x2::clock::timestamp_ms(arg19));
        (arg5, v13)
    }

    public fun sell_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg8: 0x1::option::Option<CashPrices<T2>>, arg9: bool, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(cash_state<T0, T1, T2>(arg0), 2);
        timely(arg13, arg12);
        let v0 = &mut arg7;
        sync_effective_lock<T0, T1, T2>(arg0, v0, arg13);
        let v1 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1);
        let v2 = if (arg9) {
            arg0.state == 6
        } else {
            false
        };
        if (arg0.state == 6 && !arg9) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::assert_unlocked(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lock<T0>(&arg7), 0x2::clock::timestamp_ms(arg13), 0);
        };
        let v3 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg13);
        let v4 = 0x2::balance::value<T0>(&arg0.meme);
        let v5 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(&arg7);
        trade_limit<T0, T1, T2>(arg0, arg1, v5, v4);
        let v6 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::sell(&mut arg0.id, v4, v3, v5);
        assert!(v6 > 0, 3);
        let v7 = if (v2) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v5, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_max(v1), 10000)
        } else if (arg0.state == 6) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::fee<T0>(&arg7, 0x2::clock::timestamp_ms(arg13), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_max(v1), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_min(v1), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::tau(v1))
        } else {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v5, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_min(v1), 10000)
        };
        let v8 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v6, v7, v5);
        let v9 = if (arg10) {
            0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::withdraw_hot<T1, T2>(&mut arg0.quote, v6, arg14)
        } else {
            0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::withdraw_cash<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, v6, v3, 1, arg13, arg14)
        };
        let v10 = v9;
        assert!(0x2::coin::value<T2>(&v10) > v8, 3);
        route_fee<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v10, v8, arg14)));
        let v11 = 0x2::coin::value<T2>(&v10);
        assert!(v11 >= arg11, 4);
        let v12 = 0x2::object::id<CompositePool<T0, T1, T2>>(arg0);
        let v13 = &mut v10;
        consume_exit<T0, T1, T2>(arg0, arg7, v2, v13, arg13, arg14);
        let v14 = 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg13);
        sell_invariant<T0, T1, T2>(arg0, v4, v3, v6, v14);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg13);
        if (0x1::option::is_some<CashPrices<T2>>(&arg8)) {
            record_cash_volume<T0, T1, T2>(arg0, arg1, 0x1::option::destroy_some<CashPrices<T2>>(arg8), v11, arg13);
        } else {
            0x1::option::destroy_none<CashPrices<T2>>(arg8);
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::record_unpriced(&mut arg0.id, 0x2::clock::timestamp_ms(arg13));
            let v15 = VolumeUnpriced{
                pool         : v12,
                raw_quote    : v11,
                timestamp_ms : 0x2::clock::timestamp_ms(arg13),
            };
            0x2::event::emit<VolumeUnpriced>(v15);
        };
        let v16 = Swap{
            pool         : v12,
            position     : 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg7),
            buyer        : 0x2::tx_context::sender(arg14),
            buy          : false,
            input        : v5,
            output       : v11,
            fee          : v8,
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : v14,
            hot_only     : arg10,
            timestamp_ms : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<Swap>(v16);
        emit_curve_valued<T0, T1, T2>(arg0, v14, 0x2::clock::timestamp_ms(arg13));
        v10
    }

    public fun sell_cash_partial<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg8: u64, arg9: 0x1::option::Option<CashPrices<T2>>, arg10: bool, arg11: bool, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(cash_state<T0, T1, T2>(arg0), 2);
        let v0 = split_for_exit<T0, T1, T2>(arg0, arg7, arg8, arg14, arg15);
        sell_cash<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    fun sell_invariant<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::curve::virtual_quote(&arg0.id) == 0) {
            invariant(arg1, arg2, 0x2::balance::value<T0>(&arg0.meme), arg4);
        } else {
            assert!(arg4 + arg3 + 1 >= arg2, 7);
        };
    }

    public fun sell_partial<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg15: u64, arg16: bool, arg17: bool, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, 0x2::coin::Coin<T2>) {
        check<T0, T1, T2>(arg0, arg1);
        let v0 = split_for_exit<T0, T1, T2>(arg0, arg14, arg15, arg20, arg21);
        sell<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v0, arg16, arg17, arg18, arg19, arg20, arg21)
    }

    fun session<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg2: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg4: bool) {
        assert!(0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::market_id<T1, T2>(arg1, arg2) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg3), 1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::session_policy::assert_allowed(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::session_guard(&arg0.settings), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T2>(arg3), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T2>(arg3), arg4);
    }

    fun set_record_lock<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0x2::object::ID, arg2: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::Lock, arg3: u64) {
        settle_record<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, arg1);
        let v1 = v0.lock;
        let v2 = v0.lots;
        if (v1 == arg2) {
            return
        };
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::remove_position(&mut arg0.ledger, &v2, &v1, arg3);
        0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, arg1).lock = arg2;
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::insert_position(&mut arg0.ledger, &v2, &arg2, arg3);
    }

    fun settle_record<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0x2::object::ID) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, arg1);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::settle(&arg0.ledger, &mut v0.account, &v0.lots, &v0.lock);
    }

    fun split_for_exit<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0> {
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(arg1) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        sync_effective_lock<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg1);
        settle_record<T0, T1, T2>(arg0, v0);
        let v1 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::split<T0>(arg1, arg2, arg4);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0);
        v2.amount = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(arg1);
        v2.lots = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lots<T0>(arg1);
        register_split<T0, T1, T2>(arg0, &v1, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::split(&mut v2.account, arg2, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(arg1)));
        v1
    }

    fun start_reserved<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = refresh_funding_reserve<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::ready(&v0) && 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::treasury::value<T2>(&arg0.treasury) >= 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::funding_reserve::buffer(&v0), 9);
        fund_epoch_inner<T0, T1, T2>(arg0, arg1, arg14);
    }

    public fun sweep_winddown_reserve<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.state == 1 || arg0.state == 2, 2);
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::sweep_reserve<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4)
    }

    public fun sweep_winddown_synth<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 1, 2);
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::basket::sweep_synth<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::maintenance_bps(&arg0.settings, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::max_trade(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1))), arg14, arg15, arg16)
    }

    fun sync_effective_lock<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(arg1) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v0 = 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg1);
        let v1 = if (arg0.state == 1) {
            true
        } else if (arg0.state == 2) {
            true
        } else {
            arg0.state == 5
        };
        if (v1) {
            set_record_lock<T0, T1, T2>(arg0, v0, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::flexible(), 0x2::clock::timestamp_ms(arg2));
        };
        if (0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, v0).lock == 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::flexible()) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::clear_lock<T0>(arg1);
        };
    }

    fun timely(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1 && arg1 - v0 <= 120000, 6);
    }

    public fun total_weight<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : u256 {
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::total_weight(&arg0.ledger)
    }

    fun trade_limit<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: u64, arg3: u64) {
        let v0 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::settings::trade_cap(&arg0.settings, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::max_trade(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1)));
        assert!(arg2 > 0, 3);
        if (v0 > 0) {
            assert!((arg2 as u128) * 10000 <= (arg3 as u128) * (v0 as u128), 3);
        };
    }

    public fun upgrade_lock<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg3: u8, arg4: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!((arg0.state == 0 || arg0.state == 6) && 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(arg2) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        sync_effective_lock<T0, T1, T2>(arg0, arg2, arg4);
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::upgrade<T0>(arg2, arg3, 0x2::clock::timestamp_ms(arg4), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1));
        set_record_lock<T0, T1, T2>(arg0, 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg2), *0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lock<T0>(arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public fun volume_status<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x2::clock::Clock) : VolumeStatus {
        check<T0, T1, T2>(arg0, arg1);
        let v0 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::hibernation(arg1);
        let (v1, v2) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation_rules::values(&v0);
        let (v3, v4, v5, v6, v7) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::status(&arg0.id, &v0, 0x2::clock::timestamp_ms(arg2));
        VolumeStatus{
            pool                : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg2),
            tracked             : v3,
            ready               : v4,
            winddown_ready      : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::volume_policy::winddown_ready(&arg0.id, &v0, 0x2::clock::timestamp_ms(arg2)),
            daily_usd_e6        : v5,
            started_ms          : v6,
            updated_ms          : v7,
            ema_tau_ms          : v1,
            startup_grace_ms    : v2,
            floor_usd_e6        : hibernation_floor_of<T0, T1, T2>(arg0),
            hibernation_enabled : hibernation_enabled_of<T0, T1, T2>(arg0),
            wake_cooldown_ms    : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::cooldown(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1)),
        }
    }

    fun withdraw_internal<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::params(arg1);
        let v2 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(&arg2);
        let v3 = 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg2);
        let v4 = if (arg0.state == 0 || arg0.state == 6) {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::fee<T0>(&arg2, v0, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_max(v1), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_min(v1), 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::tau(v1))
        } else {
            0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::math::mul_div_ceil(v2, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::exit_min(v1), 10000)
        };
        assert!(v4 < v2, 3);
        let v5 = 0x2::object::id<CompositePool<T0, T1, T2>>(arg0);
        let v6 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::destroy<T0>(arg2, v5);
        let v7 = remove_exit<T0, T1, T2>(arg0, v3, v0);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg4), @0x0);
        };
        let v8 = Withdrawn{
            pool         : v5,
            position     : v3,
            owner        : 0x2::tx_context::sender(arg4),
            amount       : 0x2::balance::value<T0>(&v6),
            burned       : v4,
            timestamp_ms : v0,
        };
        0x2::event::emit<Withdrawn>(v8);
        (0x2::coin::from_balance<T0>(v6, arg4), 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.dividends, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::conviction::take(&mut v7)), arg4))
    }

    public fun withdraw_partial<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        check<T0, T1, T2>(arg0, arg1);
        let v0 = if (arg0.state <= 2) {
            true
        } else if (arg0.state == 5) {
            true
        } else {
            arg0.state == 6
        };
        assert!(v0, 2);
        let v1 = split_for_exit<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5);
        let v2 = if (arg0.state == 6) {
            0
        } else {
            arg0.state
        };
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::assert_unlocked(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lock<T0>(&v1), 0x2::clock::timestamp_ms(arg4), v2);
        withdraw_internal<T0, T1, T2>(arg0, arg1, v1, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

