module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::composite_pool {
    struct CompositePool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        meme: 0x2::balance::Balance<T0>,
        quote: 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::Basket<T1, T2>,
        pending_seed: 0x2::balance::Balance<T2>,
        treasury: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::Treasury<T2>,
        dividends: 0x2::balance::Balance<T2>,
        platform: 0x2::balance::Balance<T2>,
        rollover: u64,
        settings: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::Settings,
        state: u8,
        created_ms: u64,
        last_trade_ms: u64,
        epoch_ms: u64,
        lp_supply: u64,
        records: 0x2::table::Table<0x2::object::ID, Record>,
        ids: vector<0x2::object::ID>,
    }

    struct PagedEpochKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PagedEpochs<phantom T0> has store {
        book: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::Book<T0>,
        funded: bool,
    }

    struct EpochStarted has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        expires_ms: u64,
        amount: u64,
        positions: u64,
    }

    struct EpochExitPaid has copy, drop {
        pool: 0x2::object::ID,
        recipient: address,
        payment: u64,
        rollover: u64,
        treasury: u64,
    }

    struct Record has store {
        lots: vector<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>,
        amount: u64,
        lock: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::Lock,
        credit: u64,
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

    struct LifecycleChanged has copy, drop {
        pool: 0x2::object::ID,
        state: u8,
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
        progress: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::State,
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

    struct BasketRebalanced has copy, drop {
        pool: 0x2::object::ID,
        nav_before: u64,
        nav_after: u64,
        synth_before: u64,
        synth_after: u64,
    }

    struct TreasuryFunded has copy, drop {
        pool: 0x2::object::ID,
        donor: address,
        amount: u64,
    }

    public fun join<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>) {
        assert!(!paged_epochs<T0, T1, T2>(arg0), 8);
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg1) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0) && 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(&arg2) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v0 = if (arg0.state == 1) {
            true
        } else if (arg0.state == 2) {
            true
        } else {
            arg0.state == 5
        };
        if (v0) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::clear(&mut 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1)).lock);
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::clear(&mut 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg2)).lock);
        };
        if (0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1)).lock == 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::flexible()) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::clear_lock<T0>(arg1);
        };
        if (0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg2)).lock == 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::flexible()) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::clear_lock<T0>(&mut arg2);
        };
        let v1 = remove<T0, T1, T2>(arg0, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg2));
        let Record {
            lots   : _,
            amount : _,
            lock   : _,
            credit : v5,
        } = v1;
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::join<T0>(arg1, arg2);
        let v6 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1));
        v6.credit = v6.credit + v5;
        v6.amount = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg1);
        v6.lots = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg1);
    }

    fun remove<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0x2::object::ID) : Record {
        if (!paged_epochs<T0, T1, T2>(arg0)) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position_index::remove(&mut arg0.id, &mut arg0.ids, arg1);
        };
        0x2::table::remove<0x2::object::ID, Record>(&mut arg0.records, arg1)
    }

    public fun share<T0, T1, T2>(arg0: CompositePool<T0, T1, T2>) {
        0x2::transfer::share_object<CompositePool<T0, T1, T2>>(arg0);
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2> {
        active<T0, T1, T2>(arg0, arg1);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, true);
        let (v0, v1, v2, v3, v4) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::rebalance<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::max_trade(&arg0.settings), arg14, arg15, arg16);
        let v5 = v0;
        let v6 = BasketRebalanced{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            nav_before   : v1,
            nav_after    : v2,
            synth_before : v3,
            synth_after  : v4,
        };
        0x2::event::emit<BasketRebalanced>(v6);
        let v7 = &mut v5;
        observe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v7, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        v5
    }

    public fun refill_hot<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::refill_hot<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        observe<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        v0
    }

    public fun activate<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &PoolCap, arg3: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg4: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg8: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg9: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg10: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg11: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg12: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, LpPosition) {
        check<T0, T1, T2>(arg0, arg1);
        owner<T0, T1, T2>(arg0, arg2);
        assert!(arg0.state == 3 && !0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1), 2);
        timely(arg17, arg16);
        session<T0, T1, T2>(arg0, arg3, arg4, &arg6, true);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T1, T2>(arg3, arg4, arg5, &mut arg6, arg7, arg12, arg13, arg14, arg17);
        let (v1, _) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::deposit<T1, T2>(&mut arg0.quote, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.pending_seed, 0x2::balance::value<T2>(&arg0.pending_seed)), arg18), arg15, arg16, arg17, arg18);
        arg6 = v1;
        let v3 = nav<T0, T1, T2>(arg0, arg3, arg4, arg5, &arg6, arg7, arg8, arg9, arg10, arg11, &v0, arg17);
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::sqrt((0x2::balance::value<T0>(&arg0.meme) as u256) * (v3 as u256));
        assert!(v4 > 1000, 3);
        arg0.lp_supply = v4;
        arg0.state = 0;
        arg0.epoch_ms = 0x2::clock::timestamp_ms(arg17);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg17);
        let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::hibernation(arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::volume_policy::sync(&mut arg0.id, &v5, 0x2::clock::timestamp_ms(arg17));
        let v6 = Created{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : v3,
            lp_supply    : v4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg17),
        };
        0x2::event::emit<Created>(v6);
        let v7 = LpPosition{
            id     : 0x2::object::new(arg18),
            pool   : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            shares : v4 - 1000,
        };
        (arg6, v7)
    }

    fun active<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 0 && !0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1), 2);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: 0x2::coin::Coin<T0>, arg15: 0x2::coin::Coin<T2>, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, LpPosition, 0x2::coin::Coin<T0>) {
        active<T0, T1, T2>(arg0, arg1);
        timely(arg18, arg17);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, true);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg18);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg18);
        let (v2, v3) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::deposit<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, 1, arg17, arg18, arg19);
        arg5 = v2;
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v3, arg0.lp_supply, v1);
        assert!(v4 > 0 && v4 >= arg16, 4);
        let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v4, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply);
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

    public fun advance_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = paged_mut<T0, T1, T2>(arg0);
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::advance<T2>(&mut v0.book, arg1, arg2);
        while (!0x1::vector::is_empty<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::Delivery<T2>>(&v1)) {
            let (v2, v3, v4, v5) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::unpack<T2>(0x1::vector::pop_back<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::Delivery<T2>>(&mut v1));
            let v6 = v5;
            let v7 = v4;
            let v8 = v3;
            let v9 = 0x2::balance::value<T2>(&v8);
            let v10 = 0x2::balance::value<T2>(&v7);
            0x2::balance::join<T2>(&mut arg0.dividends, v7);
            arg0.rollover = arg0.rollover + v10;
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::deposit<T2>(&mut arg0.treasury, v6);
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v8, arg3), v2);
            } else {
                0x2::balance::destroy_zero<T2>(v8);
            };
            let v11 = EpochExitPaid{
                pool      : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
                recipient : v2,
                payment   : v9,
                rollover  : v10,
                treasury  : 0x2::balance::value<T2>(&v6),
            };
            0x2::event::emit<EpochExitPaid>(v11);
        };
        0x1::vector::destroy_empty<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::Delivery<T2>>(v1);
    }

    public fun allocate_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = paged_mut<T0, T1, T2>(arg0);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::allocate<T2>(&mut v0.book, arg1, arg2);
        announce_epoch<T0, T1, T2>(arg0);
    }

    fun announce_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>) {
        let v0 = 0x2::object::id<CompositePool<T0, T1, T2>>(arg0);
        let v1 = paged_mut<T0, T1, T2>(arg0);
        let (v2, _, v4, v5, v6, v7) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::progress<T2>(&v1.book);
        let v8 = if (!v1.funded) {
            if (v5 == v4) {
                v6 == v4
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            v1.funded = true;
            let v9 = EpochFunded{
                pool         : v0,
                timestamp_ms : v2,
                amount       : v7,
                rollover     : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::pot<T2>(&v1.book) - v7,
            };
            0x2::event::emit<EpochFunded>(v9);
        };
    }

    public fun automatic_funding_status<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::Status {
        check<T0, T1, T2>(arg0, arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::status(&arg0.id, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::value<T2>(&arg0.treasury))
    }

    public fun begin_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0, T1, T2>(arg0, arg1);
        abort 9
    }

    fun begin_epoch_inner<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 0 || arg0.state == 2, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::epoch_ms(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1));
        assert!(v0 >= arg0.epoch_ms + v1, 8);
        let v2 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::surplus<T2>(&mut arg0.treasury);
        arg0.rollover = arg0.rollover + 0x2::balance::value<T2>(&v2);
        0x2::balance::join<T2>(&mut arg0.dividends, v2);
        let v3 = 0x2::balance::split<T2>(&mut arg0.dividends, arg0.rollover);
        arg0.rollover = 0;
        let v4 = paged_mut<T0, T1, T2>(arg0);
        v4.funded = false;
        arg0.epoch_ms = v0;
        let v5 = EpochStarted{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms : v0,
            expires_ms   : v0 + v1,
            amount       : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::begin<T2>(&mut v4.book, v3, v1, arg2, arg3),
            positions    : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::length<T2>(&v4.book),
        };
        0x2::event::emit<EpochStarted>(v5);
    }

    public fun begin_epoch_reserved<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(paged_epochs<T0, T1, T2>(arg0), 8);
        start_reserved<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public fun begin_wake<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(!0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1), 2);
        if (arg0.state == 5) {
            return
        };
        let v0 = volume_status<T0, T1, T2>(arg0, arg1, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::wake(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg2), v0.tracked, v0.ready, v0.daily_usd_e6, v0.floor_usd_e6, v0.wake_cooldown_ms);
        arg0.state = 5;
        let v1 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 5,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LifecycleChanged>(v1);
    }

    public fun begin_winddown<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        if (arg0.state == 1) {
            return
        };
        let v0 = volume_status<T0, T1, T2>(arg0, arg1, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::begin(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg2), 0x2::table::length<0x2::object::ID, Record>(&arg0.records), v0.tracked, v0.winddown_ready, v0.daily_usd_e6, v0.hibernation_enabled, v0.floor_usd_e6, v0.wake_cooldown_ms);
        arg0.state = 1;
        let v1 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LifecycleChanged>(v1);
    }

    public fun buy<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: 0x2::coin::Coin<T2>, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>) {
        active<T0, T1, T2>(arg0, arg1);
        timely(arg17, arg16);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, true);
        assert!(0x2::table::length<0x2::object::ID, Record>(&arg0.records) < 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_positions(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 5);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg17);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg17);
        let v2 = 0x2::balance::value<T0>(&arg0.meme);
        let v3 = 0x2::coin::value<T2>(&arg14);
        trade_limit<T0, T1, T2>(arg0, arg1, v3, v1);
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v3, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::base_fee(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 10000);
        assert!(v3 > v4, 3);
        route_fee<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut arg14, v4, arg18)));
        let (v5, v6) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::deposit<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 1, arg16, arg17, arg18);
        arg5 = v5;
        let v7 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::output(v6, v1, v2);
        assert!(v7 > 0 && v7 >= arg15, 4);
        let v8 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::new<T0>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::balance::split<T0>(&mut arg0.meme, v7), 0x2::clock::timestamp_ms(arg17), arg18);
        register<T0, T1, T2>(arg0, arg1, &v8, 0, arg17);
        let v9 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg17);
        invariant(v2, v1, 0x2::balance::value<T0>(&arg0.meme), v9);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg17);
        let v10 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::hibernation(arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::volume_policy::record_quote(&mut arg0.id, &v10, v3, 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::collateral_price(&v0), 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::collateral_scaling(&v0), 0x2::clock::timestamp_ms(arg17));
        let v11 = Swap{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            position     : 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&v8),
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
        (arg5, v8)
    }

    public fun buy_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: 0x2::coin::Coin<T2>, arg7: CashPrices<T2>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 2 && !0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1), 2);
        timely(arg10, arg9);
        assert!(0x2::table::length<0x2::object::ID, Record>(&arg0.records) < 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_positions(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 5);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg10);
        let v1 = 0x2::balance::value<T0>(&arg0.meme);
        let v2 = 0x2::coin::value<T2>(&arg6);
        trade_limit<T0, T1, T2>(arg0, arg1, v2, v0);
        let v3 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v2, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::base_fee(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 10000);
        assert!(v2 > v3, 3);
        route_fee<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut arg6, v3, arg11)));
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::output(0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::deposit_cash<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, 1, arg10, arg11), v0, v1);
        assert!(v4 > 0 && v4 >= arg8, 4);
        let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::new<T0>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::balance::split<T0>(&mut arg0.meme, v4), 0x2::clock::timestamp_ms(arg10), arg11);
        register<T0, T1, T2>(arg0, arg1, &v5, 0, arg10);
        let v6 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg10);
        invariant(v1, v0, 0x2::balance::value<T0>(&arg0.meme), v6);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg10);
        record_cash_volume<T0, T1, T2>(arg0, arg1, arg7, v2, arg10);
        let v7 = Swap{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            position     : 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&v5),
            buyer        : 0x2::tx_context::sender(arg11),
            buy          : true,
            input        : v2,
            output       : v4,
            fee          : v3,
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : v6,
            hot_only     : false,
            timestamp_ms : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<Swap>(v7);
        v5
    }

    public fun cancel_funding_buffer<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::AdminCap) {
        assert!(arg0.config == 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg1), 1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::authorize(arg1, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_policy::cancel(&mut arg0.id);
    }

    public fun cancel_preparation<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &PoolCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        owner<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 3, 2);
        arg0.state = 4;
        let v0 = Cancelled{pool: 0x2::object::id<CompositePool<T0, T1, T2>>(arg0)};
        0x2::event::emit<Cancelled>(v0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, 0x2::balance::value<T0>(&arg0.meme)), arg2), 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.pending_seed, 0x2::balance::value<T2>(&arg0.pending_seed)), arg2))
    }

    public fun cash_prices<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) : CashPrices<T2> {
        assert!(0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::engine_id<T1, T2>(&arg0.quote) == 0x2::object::id<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>>(arg1), 1);
        let (v0, v1) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::cash_quote_price<T1, T2>(arg1, arg2, arg3, arg4, arg5);
        CashPrices<T2>{
            pool    : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            at_ms   : 0x2::clock::timestamp_ms(arg5),
            price   : v0,
            scaling : v1,
        }
    }

    fun check<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config) {
        assert!(arg0.config == 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg1), 1);
    }

    public fun claim<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(!paged_epochs<T0, T1, T2>(arg0), 8);
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg1) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1));
        let v1 = v0.credit;
        assert!(v1 > 0, 3);
        v0.credit = 0;
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.dividends, v1), arg2)
    }

    public fun claim_paged<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::claim<T0, T2>(&mut paged_mut<T0, T1, T2>(arg0).book, arg1, arg2);
        assert!(0x2::balance::value<T2>(&v0) > 0, 3);
        0x2::coin::from_balance<T2>(v0, arg3)
    }

    public fun claimable<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, arg1).credit
    }

    public fun claimable_paged<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: &0x2::clock::Clock) : u64 {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::claimable<T0, T2>(&paged<T0, T1, T2>(arg0).book, arg1, arg2)
    }

    public fun cleanup_epochs<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: u64) {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::cleanup<T2>(&mut paged_mut<T0, T1, T2>(arg0).book, arg1);
    }

    public fun collect_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = paged_mut<T0, T1, T2>(arg0);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::collect<T2>(&mut v0.book, arg1, arg2);
        announce_epoch<T0, T1, T2>(arg0);
    }

    public fun collect_platform<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check<T0, T1, T2>(arg0, arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::authorize(arg1, arg2);
        let v0 = 0x2::balance::value<T2>(&arg0.platform);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::platform_fees::collected<T2>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg1), v0, 0x2::balance::value<T2>(&arg0.platform), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.platform, v0), arg3)
    }

    fun consume_exit<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: bool, arg3: &mut 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<CompositePool<T0, T1, T2>>(arg0);
        if (paged_epochs<T0, T1, T2>(arg0)) {
            let v1 = paged_mut<T0, T1, T2>(arg0);
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::exit<T0, T2>(&mut v1.book, &arg1, arg2, arg4, arg5);
        };
        0x2::balance::join<T0>(&mut arg0.meme, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::destroy<T0>(arg1, v0));
        let v2 = remove<T0, T1, T2>(arg0, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg1));
        let Record {
            lots   : _,
            amount : _,
            lock   : _,
            credit : v6,
        } = v2;
        if (arg2) {
            let (v7, v8, v9) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividends::ragequit_forfeit(v6);
            0x2::coin::join<T2>(arg3, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.dividends, v7), arg5));
            arg0.rollover = arg0.rollover + v8;
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::deposit<T2>(&mut arg0.treasury, 0x2::balance::split<T2>(&mut arg0.dividends, v9));
        } else {
            0x2::coin::join<T2>(arg3, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.dividends, v6), arg5));
        };
    }

    public fun effective_lock<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: 0x2::object::ID) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::Lock {
        0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, arg1).lock
    }

    public fun enable_paged_epochs<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &PoolCap, arg2: &mut 0x2::tx_context::TxContext) {
        owner<T0, T1, T2>(arg0, arg1);
        let v0 = if (arg0.state == 3) {
            if (0x2::table::is_empty<0x2::object::ID, Record>(&arg0.records)) {
                if (0x1::vector::is_empty<0x2::object::ID>(&arg0.ids)) {
                    !paged_epochs<T0, T1, T2>(arg0)
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
        assert!(0x2::balance::value<T2>(&arg0.dividends) == arg0.rollover, 7);
        let v1 = PagedEpochKey{dummy_field: false};
        let v2 = PagedEpochs<T2>{
            book   : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::new<T2>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), arg2),
            funded : false,
        };
        0x2::dynamic_field::add<PagedEpochKey, PagedEpochs<T2>>(&mut arg0.id, v1, v2);
    }

    public fun execute_funding_buffer<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::set_buffer<T2>(&mut arg0.treasury, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::set_floor(&mut arg0.id, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_policy::execute(&mut arg0.id, arg1), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::value<T2>(&arg0.treasury)));
    }

    public fun expire_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::expire<T2>(&mut paged_mut<T0, T1, T2>(arg0).book, arg1);
    }

    public fun finish_hibernation<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        if (arg0.state == 2) {
            return
        };
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg6);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::hibernate(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg6), 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::shares<T1, T2>(&arg0.quote), 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T2>(arg3, arg4));
        arg0.state = 2;
        let v0 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<LifecycleChanged>(v0);
    }

    public fun finish_wake<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 5 && !0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1), 2);
        session<T0, T1, T2>(arg0, arg2, arg3, arg5, true);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg11, arg12, arg13, arg14);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg14);
        assert!(0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::margin_shortfall<T2>(arg4, arg5, &v0, 5500) == 0, 9);
        let (v2, _, _, _) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::allocations(&arg0.settings);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::finish_wake(&mut arg0.id, arg0.state, 0x2::clock::timestamp_ms(arg14), v1, v1 - 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::hot<T1, T2>(&arg0.quote) - 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T1, T2>(arg8, arg7, arg14) - 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T2>(arg9, arg10), v2);
        arg0.state = 0;
        let v6 = LifecycleChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            state        : 0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<LifecycleChanged>(v6);
    }

    public fun fund_epoch<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        abort 9
    }

    public fun fund_epoch_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = refresh_cash_funding<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::value<T2>(&arg0.treasury) >= 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::buffer(&v0), 9);
        if (paged_epochs<T0, T1, T2>(arg0)) {
            begin_epoch_inner<T0, T1, T2>(arg0, arg1, arg6, arg7);
        } else {
            fund_epoch_inner<T0, T1, T2>(arg0, arg1, arg6);
        };
    }

    fun fund_epoch_inner<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock) {
        assert!(!paged_epochs<T0, T1, T2>(arg0), 8);
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 0 || arg0.state == 2, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.epoch_ms + 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::epoch_ms(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 8);
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::surplus<T2>(&mut arg0.treasury);
        arg0.rollover = arg0.rollover + 0x2::balance::value<T2>(&v1);
        0x2::balance::join<T2>(&mut arg0.dividends, v1);
        let v2 = vector[];
        let v3 = &arg0.ids;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(v3)) {
            let v5 = 0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, *0x1::vector::borrow<0x2::object::ID>(v3, v4));
            let v6 = 0;
            let v7 = &v5.lots;
            let v8 = 0;
            while (v8 < 0x1::vector::length<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>(v7)) {
                let v9 = 0x1::vector::borrow<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>(v7, v8);
                v6 = v6 + 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividends::weight(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lot_amount(v9), v0 - 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lot_entry(v9), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::multiplier(&v5.lock, v0));
                v8 = v8 + 1;
            };
            0x1::vector::push_back<u128>(&mut v2, v6);
            v4 = v4 + 1;
        };
        let v10 = arg0.rollover;
        let (v11, v12) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividends::allocate(v10, &v2);
        let v13 = v11;
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x2::object::ID>(&arg0.ids)) {
            let v15 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, *0x1::vector::borrow<0x2::object::ID>(&arg0.ids, v14));
            v15.credit = v15.credit + *0x1::vector::borrow<u64>(&v13, v14);
            v14 = v14 + 1;
        };
        arg0.rollover = v12;
        arg0.epoch_ms = v0;
        let v16 = EpochFunded{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms : v0,
            amount       : v10 - v12,
            rollover     : v12,
        };
        0x2::event::emit<EpochFunded>(v16);
    }

    public fun fund_epoch_reserved<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!paged_epochs<T0, T1, T2>(arg0), 8);
        start_reserved<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public fun fund_treasury<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::tx_context::TxContext) {
        assert!((arg0.state <= 2 || arg0.state == 5) && 0x2::coin::value<T2>(&arg1) > 0, 3);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::deposit<T2>(&mut arg0.treasury, 0x2::coin::into_balance<T2>(arg1));
        let v0 = TreasuryFunded{
            pool   : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            donor  : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T2>(&arg1),
        };
        0x2::event::emit<TreasuryFunded>(v0);
    }

    public fun funding_buffer_status<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : (u64, bool, u64, u64) {
        let (v0, v1, v2) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_policy::status(&arg0.id);
        (0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::buffer<T2>(&arg0.treasury), v0, v1, v2)
    }

    public fun index_positions<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        assert!(!paged_epochs<T0, T1, T2>(arg0), 8);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position_index::backfill(&mut arg0.id, &arg0.ids, arg1, arg2)
    }

    fun invariant(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg2 as u128) * (arg3 as u128) >= (arg0 as u128) * (arg1 as u128), 7);
    }

    public fun join_paged<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: &0x2::clock::Clock) {
        assert!(paged_epochs<T0, T1, T2>(arg0), 8);
        sync_effective_lock<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = &mut arg2;
        sync_effective_lock<T0, T1, T2>(arg0, v0, arg3);
        let v1 = paged_mut<T0, T1, T2>(arg0);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::join<T0, T2>(&mut v1.book, arg1, arg2, arg3);
        let v2 = remove<T0, T1, T2>(arg0, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg2));
        let Record {
            lots   : _,
            amount : _,
            lock   : _,
            credit : v6,
        } = v2;
        let v7 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1));
        v7.credit = v7.credit + v6;
        v7.amount = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg1);
        v7.lots = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg1);
    }

    public fun lifecycle_observation<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock) : LifecycleObservation {
        check<T0, T1, T2>(arg0, arg1);
        let (v0, v1, v2, v3, v4) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_maintenance<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg6);
        LifecycleObservation{
            pool          : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg6),
            state         : arg0.state,
            config_paused : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1),
            volume        : volume_status<T0, T1, T2>(arg0, arg1, arg6),
            progress      : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::status(&arg0.id),
            shares        : v0,
            hot           : v1,
            lending       : v2,
            reserve       : v3,
            can_park      : v4,
            max_trade_bps : 0x1::u64::min(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::max_trade(&arg0.settings), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_trade(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1))),
        }
    }

    public fun lifecycle_status<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::State {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::status(&arg0.id)
    }

    fun nav<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg8: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg9: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg10: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::Prices, arg11: &0x2::clock::Clock) : u64 {
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::value_at<T1, T2>(&arg0.quote, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun observe<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock) : Health {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg11, arg12, arg13, arg14);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg14);
        let v2 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::hot<T1, T2>(&arg0.quote);
        let v3 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T1, T2>(arg8, arg7, arg14);
        let v4 = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T2>(arg9, arg10);
        let (v5, v6, _, _) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::allocations(&arg0.settings);
        let v9 = Health{
            pool              : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            engine            : 0x2::object::id<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>>(arg2),
            market            : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg5),
            timestamp_ms      : 0x2::clock::timestamp_ms(arg14),
            state             : arg0.state,
            config_paused     : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1),
            last_epoch_ms     : arg0.epoch_ms,
            epoch_interval_ms : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::epoch_ms(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)),
            meme_reserve      : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav         : v1,
            synth_value       : v1 - v2 - v3 - v4,
            hot               : v2,
            pool_lending      : v3,
            reserve           : v4,
            margin_shortfall  : 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::margin_shortfall<T2>(arg4, arg5, &v0, 5500),
            treasury_funds    : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::value<T2>(&arg0.treasury),
            funding_buffer    : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::buffer<T2>(&arg0.treasury),
            target_synth_bps  : v5,
            target_hot_bps    : v6,
            session_guard     : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::session_guard(&arg0.settings),
            market_pause_mode : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T2>(arg5),
            market_frozen     : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T2>(arg5),
        };
        0x2::event::emit<Health>(v9);
        v9
    }

    public fun observe_cash<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &0x2::clock::Clock) : Health {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 2, 2);
        assert!(0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::market_id<T1, T2>(&arg0.quote) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg6), 1);
        let (v0, v1, _, _) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::allocations(&arg0.settings);
        let v4 = Health{
            pool              : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            engine            : 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::engine_id<T1, T2>(&arg0.quote),
            market            : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg6),
            timestamp_ms      : 0x2::clock::timestamp_ms(arg7),
            state             : arg0.state,
            config_paused     : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1),
            last_epoch_ms     : arg0.epoch_ms,
            epoch_interval_ms : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::epoch_ms(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)),
            meme_reserve      : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav         : 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg7),
            synth_value       : 0,
            hot               : 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::hot<T1, T2>(&arg0.quote),
            pool_lending      : 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T1, T2>(arg2, arg5, arg7),
            reserve           : 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T2>(arg3, arg4),
            margin_shortfall  : 0,
            treasury_funds    : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::value<T2>(&arg0.treasury),
            funding_buffer    : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::buffer<T2>(&arg0.treasury),
            target_synth_bps  : v0,
            target_hot_bps    : v1,
            session_guard     : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::session_guard(&arg0.settings),
            market_pause_mode : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T2>(arg6),
            market_frozen     : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T2>(arg6),
        };
        0x2::event::emit<Health>(v4);
        v4
    }

    fun owner<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &PoolCap) {
        assert!(arg1.pool == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
    }

    fun paged<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : &PagedEpochs<T2> {
        let v0 = PagedEpochKey{dummy_field: false};
        0x2::dynamic_field::borrow<PagedEpochKey, PagedEpochs<T2>>(&arg0.id, v0)
    }

    public fun paged_epoch_progress<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : (u64, u64, u64, u64, u64, u64) {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::progress<T2>(&paged<T0, T1, T2>(arg0).book)
    }

    public fun paged_epochs<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : bool {
        let v0 = PagedEpochKey{dummy_field: false};
        0x2::dynamic_field::exists<PagedEpochKey>(&arg0.id, v0)
    }

    fun paged_mut<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>) : &mut PagedEpochs<T2> {
        let v0 = PagedEpochKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PagedEpochKey, PagedEpochs<T2>>(&mut arg0.id, v0)
    }

    public fun park_hibernation_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.state == 1 || arg0.state == 2, 2);
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::park_cash<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun prepare<T0, T1, T2>(arg0: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T2>, arg8: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::Settings, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (CompositePool<T0, T1, T2>, PoolCap) {
        let v0 = if (!0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg0)) {
            if (0x2::coin::value<T0>(&arg6) > 0) {
                0x2::coin::value<T2>(&arg7) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::validate(&arg8);
        let (v1, v2, v3, v4) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::allocations(&arg8);
        let (v5, v6, v7) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::new<T1, T2>(arg1, arg2, arg3, arg4, arg5, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::engine_lending_bps(&arg8), 5500, arg9, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_notional_usd(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg0)), 1000000, 1), arg10, arg11);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let (v11, v12, v13) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::new<T1, T2>(&v10, &v9, arg1, arg3, v1, v2, v3, v4, arg11);
        let v14 = v13;
        let v15 = v12;
        let v16 = 0x2::clock::timestamp_ms(arg10);
        let v17 = CompositePool<T0, T1, T2>{
            id            : 0x2::object::new(arg11),
            config        : 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg0),
            meme          : 0x2::coin::into_balance<T0>(arg6),
            quote         : v11,
            pending_seed  : 0x2::coin::into_balance<T2>(arg7),
            treasury      : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::new<T2>(),
            dividends     : 0x2::balance::zero<T2>(),
            platform      : 0x2::balance::zero<T2>(),
            rollover      : 0,
            settings      : arg8,
            state         : 3,
            created_ms    : v16,
            last_trade_ms : v16,
            epoch_ms      : v16,
            lp_supply     : 0,
            records       : 0x2::table::new<0x2::object::ID, Record>(arg11),
            ids           : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v18 = Prepared{
            pool            : 0x2::object::id<CompositePool<T0, T1, T2>>(&v17),
            engine          : 0x2::object::id<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>>(&v10),
            engine_vault    : 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>>(&v9),
            engine_sleeve   : 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>>(&v8),
            engine_account  : 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::account_id<T2>(&v9),
            pool_sleeve     : 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>>(&v15),
            reserve         : 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>>(&v14),
            reserve_account : 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::account_id<T2>(&v14),
            creator         : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<Prepared>(v18);
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::share<T1, T2>(v10);
        0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::share<T2>(v9);
        0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::share<T1, T2>(v8);
        0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::share<T1, T2>(v15);
        0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::share<T2>(v14);
        let v19 = PoolCap{
            id   : 0x2::object::new(arg11),
            pool : 0x2::object::id<CompositePool<T0, T1, T2>>(&v17),
        };
        (v17, v19)
    }

    public fun propose_funding_buffer<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.config == 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg1), 1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::authorize(arg1, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_policy::propose(&mut arg0.id, arg1, arg3, arg4);
    }

    fun record_cash_volume<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: CashPrices<T2>, arg3: u64, arg4: &0x2::clock::Clock) {
        let CashPrices {
            pool    : v0,
            at_ms   : v1,
            price   : v2,
            scaling : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0) && v1 == 0x2::clock::timestamp_ms(arg4), 1);
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::hibernation(arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::volume_policy::record_quote(&mut arg0.id, &v4, arg3, v2, v3, v1);
    }

    public fun record_count<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>) : u64 {
        0x2::table::length<0x2::object::ID, Record>(&arg0.records)
    }

    public fun refill_hot_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 2, 2);
        observe_cash<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg9);
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::refill_cash<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10)
    }

    public fun refresh_cash_funding<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x2::clock::Clock) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::Status {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 2, 2);
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg6);
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::no_exposure(&mut arg0.id, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::value<T2>(&arg0.treasury), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::buffer<T2>(&arg0.treasury), arg6);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::set_buffer<T2>(&mut arg0.treasury, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::buffer(&v0));
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::emit_status(v0);
        v0
    }

    public fun refresh_funding_reserve<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::Status {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg11, arg12, arg13, arg14);
        nav<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &v0, arg14);
        let (v1, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T2>(arg5));
        let (v3, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_params(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T2>(arg5));
        let v5 = 0;
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T2>(arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg4))) {
            let v6 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T2>(arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T2>(arg4));
            assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v6), 9);
            let (v7, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v6);
            v5 = v7;
        };
        let v9 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::funding(arg1);
        let v10 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::update(&mut arg0.id, &v9, v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_last_upd_ms(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T2>(arg5)), v3, v5, 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::shares<T1, T2>(&arg0.quote), 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::supply<T1, T2>(arg2), 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::collateral_price(&v0), 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::collateral_scaling(&v0), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::value<T2>(&arg0.treasury), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::buffer<T2>(&arg0.treasury), arg14);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::set_buffer<T2>(&mut arg0.treasury, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::buffer(&v10));
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::emit_status(v10);
        v10
    }

    public fun refresh_volume_tracking<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::hibernation(arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::volume_policy::sync(&mut arg0.id, &v0, 0x2::clock::timestamp_ms(arg2));
    }

    fun register<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::length<0x2::object::ID, Record>(&arg0.records) < 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_positions(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 5);
        register_record<T0, T1, T2>(arg0, arg2, arg3);
        if (paged_epochs<T0, T1, T2>(arg0)) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::insert<T0, T2>(&mut paged_mut<T0, T1, T2>(arg0).book, arg2, arg4);
        };
    }

    fun register_record<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: u64) {
        let v0 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1);
        if (!paged_epochs<T0, T1, T2>(arg0)) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position_index::insert(&mut arg0.id, &mut arg0.ids, v0);
        };
        let v1 = Record{
            lots   : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg1),
            amount : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg1),
            lock   : *0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lock<T0>(arg1),
            credit : arg2,
        };
        0x2::table::add<0x2::object::ID, Record>(&mut arg0.records, v0, v1);
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
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::next_unlock(&mut arg0.id, 0x2::table::length<0x2::object::ID, Record>(&arg0.records));
            if (0x1::option::is_none<u64>(&v2)) {
                0x1::option::destroy_none<u64>(v2);
                break
            };
            let v3 = if (paged_epochs<T0, T1, T2>(arg0)) {
                0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::position_at<T2>(&paged<T0, T1, T2>(arg0).book, 0x1::option::destroy_some<u64>(v2))
            } else {
                *0x1::vector::borrow<0x2::object::ID>(&arg0.ids, 0x1::option::destroy_some<u64>(v2))
            };
            if (paged_epochs<T0, T1, T2>(arg0)) {
                let v4 = paged_mut<T0, T1, T2>(arg0);
                0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::unlock_position<T2>(&mut v4.book, v3, arg2);
            };
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::clear(&mut 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v3).lock);
            v1 = v1 + 1;
        };
        let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::status(&arg0.id);
        let v6 = LocksReleased{
            pool      : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            processed : v1,
            remaining : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_lifecycle::remaining(&v5),
        };
        0x2::event::emit<LocksReleased>(v6);
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg8: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg9: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: LpPosition, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        timely(arg17, arg16);
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
        let v4 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T1, T2>(arg1, arg2, arg3, &mut arg4, arg5, arg10, arg11, arg12, arg17);
        let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v2, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply);
        assert!(v5 >= arg14, 4);
        let (v6, v7) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::withdraw<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v2, arg0.lp_supply, arg15, arg16, arg17, arg18);
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

    public fun remove_liquidity_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: LpPosition, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        timely(arg10, arg9);
        assert!(arg0.state == 2, 2);
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
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v2, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply);
        assert!(v4 >= arg7, 4);
        arg0.lp_supply = arg0.lp_supply - v2;
        0x2::object::delete(v0);
        let v5 = LiquidityChanged{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_value<T1, T2>(&arg0.quote, arg1, arg2, arg3, arg4, arg10),
            lp_supply    : arg0.lp_supply,
        };
        0x2::event::emit<LiquidityChanged>(v5);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, v4), arg11), 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::withdraw_cash<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4, arg5, v2, arg0.lp_supply, arg8, arg10, arg11))
    }

    public fun restore_wake_exposure<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 5 && !0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1), 2);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, true);
        let (v0, v1, v2, v3, v4) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::rebalance<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::u64::min(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::max_trade(&arg0.settings), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_trade(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1))), arg14, arg15, arg16);
        let v5 = BasketRebalanced{
            pool         : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            nav_before   : v1,
            nav_after    : v2,
            synth_before : v3,
            synth_after  : v4,
        };
        0x2::event::emit<BasketRebalanced>(v5);
        v0
    }

    fun route_fee<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg2);
        let (v1, v2, _) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::splits(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1));
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::deposit<T2>(&mut arg0.treasury, 0x2::balance::split<T2>(&mut arg2, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v0, v1, 10000)));
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v0, v2, 10000);
        0x2::balance::join<T2>(&mut arg0.dividends, 0x2::balance::split<T2>(&mut arg2, v4));
        arg0.rollover = arg0.rollover + v4;
        0x2::balance::join<T2>(&mut arg0.platform, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::platform_fees::accrued<T2>(0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg1), 0x2::balance::value<T2>(&arg2), 0x2::balance::value<T2>(&arg0.platform));
    }

    public fun sell<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg15: bool, arg16: bool, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, 0x2::coin::Coin<T2>) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state <= 2 || arg0.state == 5, 2);
        timely(arg19, arg18);
        session<T0, T1, T2>(arg0, arg2, arg3, &arg5, !arg16);
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(&arg14) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v0 = &mut arg14;
        sync_effective_lock<T0, T1, T2>(arg0, v0, arg19);
        if (!arg15) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::assert_unlocked(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lock<T0>(&arg14), 0x2::clock::timestamp_ms(arg19), arg0.state);
        };
        let v1 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T1, T2>(arg2, arg3, arg4, &mut arg5, arg6, arg11, arg12, arg13, arg19);
        let v2 = nav<T0, T1, T2>(arg0, arg2, arg3, arg4, &arg5, arg6, arg7, arg8, arg9, arg10, &v1, arg19);
        let v3 = 0x2::balance::value<T0>(&arg0.meme);
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(&arg14);
        trade_limit<T0, T1, T2>(arg0, arg1, v4, v3);
        let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::output(v4, v3, v2);
        assert!(v5 > 0, 3);
        let v6 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1);
        let v7 = if (arg15) {
            arg0.state == 0
        } else {
            false
        };
        let v8 = if (v7) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v4, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_max(v6), 10000)
        } else if (arg0.state != 0) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v4, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_min(v6), 10000)
        } else {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::fee<T0>(&arg14, 0x2::clock::timestamp_ms(arg19), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_max(v6), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_min(v6), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::tau(v6))
        };
        let v9 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v5, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::session_policy::exit_fee(v4, v8, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_max(v6), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::session_guard(&arg0.settings), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T2>(&arg5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T2>(&arg5), arg0.state), v4);
        let v10 = if (arg16) {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::withdraw_hot<T1, T2>(&mut arg0.quote, v5, arg20)
        } else {
            let (v11, v12) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::withdraw<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v5, v2, 1, arg18, arg19, arg20);
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
        invariant(v3, v2, 0x2::balance::value<T0>(&arg0.meme), v17);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg19);
        let v18 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::hibernation(arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::volume_policy::record_quote(&mut arg0.id, &v18, v14, 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::collateral_price(&v1), 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::collateral_scaling(&v1), 0x2::clock::timestamp_ms(arg19));
        let v19 = Swap{
            pool         : v15,
            position     : 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg14),
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
        (arg5, v13)
    }

    public fun sell_cash<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg8: 0x1::option::Option<CashPrices<T2>>, arg9: bool, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 2, 2);
        timely(arg12, arg11);
        let v0 = &mut arg7;
        sync_effective_lock<T0, T1, T2>(arg0, v0, arg12);
        let v1 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg12);
        let v2 = 0x2::balance::value<T0>(&arg0.meme);
        let v3 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(&arg7);
        trade_limit<T0, T1, T2>(arg0, arg1, v3, v2);
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::output(v3, v2, v1);
        assert!(v4 > 0, 3);
        let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v4, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v3, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_min(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 10000), v3);
        let v6 = if (arg9) {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::withdraw_hot<T1, T2>(&mut arg0.quote, v4, arg13)
        } else {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::withdraw_cash<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, v4, v1, 1, arg12, arg13)
        };
        let v7 = v6;
        assert!(0x2::coin::value<T2>(&v7) > v5, 3);
        route_fee<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v7, v5, arg13)));
        let v8 = 0x2::coin::value<T2>(&v7);
        assert!(v8 >= arg10, 4);
        let v9 = 0x2::object::id<CompositePool<T0, T1, T2>>(arg0);
        let v10 = &mut v7;
        consume_exit<T0, T1, T2>(arg0, arg7, false, v10, arg12, arg13);
        let v11 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::cash_value<T1, T2>(&arg0.quote, arg2, arg3, arg4, arg5, arg12);
        invariant(v2, v1, 0x2::balance::value<T0>(&arg0.meme), v11);
        arg0.last_trade_ms = 0x2::clock::timestamp_ms(arg12);
        if (0x1::option::is_some<CashPrices<T2>>(&arg8)) {
            record_cash_volume<T0, T1, T2>(arg0, arg1, 0x1::option::destroy_some<CashPrices<T2>>(arg8), v8, arg12);
        } else {
            0x1::option::destroy_none<CashPrices<T2>>(arg8);
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::volume_policy::record_unpriced(&mut arg0.id, 0x2::clock::timestamp_ms(arg12));
            let v12 = VolumeUnpriced{
                pool         : v9,
                raw_quote    : v8,
                timestamp_ms : 0x2::clock::timestamp_ms(arg12),
            };
            0x2::event::emit<VolumeUnpriced>(v12);
        };
        let v13 = Swap{
            pool         : v9,
            position     : 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg7),
            buyer        : 0x2::tx_context::sender(arg13),
            buy          : false,
            input        : v3,
            output       : v8,
            fee          : v5,
            meme_reserve : 0x2::balance::value<T0>(&arg0.meme),
            quote_nav    : v11,
            hot_only     : arg9,
            timestamp_ms : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<Swap>(v13);
        v7
    }

    public fun sell_cash_partial<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg8: u64, arg9: 0x1::option::Option<CashPrices<T2>>, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 2, 2);
        let v0 = split_for_exit<T0, T1, T2>(arg0, arg7, arg8, arg13, arg14);
        sell_cash<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg9, arg10, arg11, arg12, arg13, arg14)
    }

    public fun sell_partial<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg15: u64, arg16: bool, arg17: bool, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, 0x2::coin::Coin<T2>) {
        check<T0, T1, T2>(arg0, arg1);
        let v0 = split_for_exit<T0, T1, T2>(arg0, arg14, arg15, arg20, arg21);
        sell<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v0, arg16, arg17, arg18, arg19, arg20, arg21)
    }

    fun session<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg4: bool) {
        assert!(0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::market_id<T1, T2>(arg1, arg2) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>>(arg3), 1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::session_policy::assert_allowed(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::session_guard(&arg0.settings), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T2>(arg3), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T2>(arg3), arg4);
    }

    fun split_for_exit<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0> {
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg1) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        sync_effective_lock<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = if (paged_epochs<T0, T1, T2>(arg0)) {
            let v1 = paged_mut<T0, T1, T2>(arg0);
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::split<T0, T2>(&mut v1.book, arg1, arg2, arg3, arg4)
        } else {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::split<T0>(arg1, arg2, arg4)
        };
        let v2 = v0;
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1));
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v3.credit, arg2, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg1));
        v3.credit = v3.credit - v4;
        v3.amount = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg1);
        v3.lots = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg1);
        register_record<T0, T1, T2>(arg0, &v2, v4);
        v2
    }

    fun start_reserved<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = refresh_funding_reserve<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::ready(&v0) && 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::value<T2>(&arg0.treasury) >= 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_reserve::buffer(&v0), 9);
        if (paged_epochs<T0, T1, T2>(arg0)) {
            begin_epoch_inner<T0, T1, T2>(arg0, arg1, arg14, arg15);
        } else {
            fund_epoch_inner<T0, T1, T2>(arg0, arg1, arg14);
        };
    }

    public fun sweep_winddown_reserve<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.state == 1 || arg0.state == 2, 2);
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::sweep_reserve<T1, T2>(&mut arg0.quote, arg1, arg2, arg3, arg4)
    }

    public fun sweep_winddown_synth<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T1, T2>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T2>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2> {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 1, 2);
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket::sweep_synth<T1, T2>(&mut arg0.quote, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::u64::min(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::max_trade(&arg0.settings), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_trade(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1))), arg14, arg15, arg16)
    }

    fun sync_effective_lock<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: &0x2::clock::Clock) {
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg1) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        let v0 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1);
        let v1 = if (arg0.state == 1) {
            true
        } else if (arg0.state == 2) {
            true
        } else {
            arg0.state == 5
        };
        if (v1) {
            if (paged_epochs<T0, T1, T2>(arg0)) {
                let v2 = paged_mut<T0, T1, T2>(arg0);
                0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::unlock_position<T2>(&mut v2.book, v0, arg2);
            };
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::clear(&mut 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0).lock);
        };
        if (0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, v0).lock == 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::flexible()) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::clear_lock<T0>(arg1);
        };
    }

    fun timely(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1 && arg1 - v0 <= 120000, 6);
    }

    fun trade_limit<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: u64, arg3: u64) {
        assert!(arg2 > 0 && (arg2 as u128) * 10000 <= (arg3 as u128) * (0x1::u64::min(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::max_trade(&arg0.settings), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_trade(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1))) as u128), 3);
    }

    public fun upgrade_lock<T0, T1, T2>(arg0: &mut CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u8, arg4: &0x2::clock::Clock) {
        check<T0, T1, T2>(arg0, arg1);
        assert!(arg0.state == 0 && 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg2) == 0x2::object::id<CompositePool<T0, T1, T2>>(arg0), 1);
        sync_effective_lock<T0, T1, T2>(arg0, arg2, arg4);
        if (paged_epochs<T0, T1, T2>(arg0)) {
            let v0 = paged_mut<T0, T1, T2>(arg0);
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book::upgrade<T0, T2>(&mut v0.book, arg2, arg3, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1), arg4);
        } else {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::upgrade<T0>(arg2, arg3, 0x2::clock::timestamp_ms(arg4), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1));
        };
        0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg2)).lock = *0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lock<T0>(arg2);
    }

    public fun volume_status<T0, T1, T2>(arg0: &CompositePool<T0, T1, T2>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock) : VolumeStatus {
        check<T0, T1, T2>(arg0, arg1);
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::hibernation(arg1);
        let (v1, v2) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation_rules::values(&v0);
        let (v3, v4, v5, v6, v7) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::volume_policy::status(&arg0.id, &v0, 0x2::clock::timestamp_ms(arg2));
        VolumeStatus{
            pool                : 0x2::object::id<CompositePool<T0, T1, T2>>(arg0),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg2),
            tracked             : v3,
            ready               : v4,
            winddown_ready      : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::volume_policy::winddown_ready(&arg0.id, &v0, 0x2::clock::timestamp_ms(arg2)),
            daily_usd_e6        : v5,
            started_ms          : v6,
            updated_ms          : v7,
            ema_tau_ms          : v1,
            startup_grace_ms    : v2,
            floor_usd_e6        : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::hibernation_floor(&arg0.settings),
            hibernation_enabled : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::hibernation_enabled(&arg0.settings),
            wake_cooldown_ms    : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::cooldown(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)),
        }
    }

    // decompiled from Move bytecode v7
}

