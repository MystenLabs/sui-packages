module 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::pool {
    struct LegKey has copy, drop, store {
        i: u64,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        creator: address,
        meme: 0x2::balance::Balance<T0>,
        cash: 0x2::balance::Balance<T1>,
        treasury: 0x2::balance::Balance<T1>,
        platform: 0x2::balance::Balance<T1>,
        creator_fees: 0x2::balance::Balance<T1>,
        dividends: 0x2::balance::Balance<T1>,
        state: u8,
        legs: u64,
        hot_bps: u64,
        leg_navs: vector<u64>,
        leg_nav_ms: vector<u64>,
        created_ms: u64,
        last_trade_ms: u64,
        sniper_tax: bool,
        no_record_free_ms: u64,
        staking: bool,
        buyback: 0x2::balance::Balance<T1>,
        log: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::Log,
        records: 0x2::table::Table<0x2::object::ID, Record>,
        ledger: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::Ledger,
        pending_dividends: u64,
        epoch_ms: u64,
        auto_release_bps: u64,
        creator_cut_bps: u64,
        release_epoch_ms: u64,
        released_in_epoch: u64,
        last_buyback_ms: u64,
    }

    struct Record has store {
        lots: vector<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Lot>,
        amount: u64,
        lock: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::locks::Lock,
        account: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::Account,
    }

    struct Buy<phantom T0, phantom T1> {
        pool: 0x2::object::ID,
        buyer: address,
        input: u64,
        fee: u64,
        min_out: u64,
        budget: 0x2::balance::Balance<T1>,
        shares: vector<u64>,
        visited: u64,
        meme_before: u64,
        cash_before: u64,
        legs_before: u64,
        added: u64,
    }

    struct Sell<phantom T0, phantom T1> {
        pool: 0x2::object::ID,
        seller: address,
        coins: bool,
        pos: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>,
        input: u64,
        min_out: u64,
        num: u128,
        den: u128,
        visited: u64,
        meme_before: u64,
        cash_before: u64,
        legs_before: u64,
        requested: u64,
        funds: 0x2::balance::Balance<T1>,
        fee_bps: u64,
    }

    struct Created has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        meme_reserve: u64,
        seed: u64,
        virtual_quote: u64,
        legs: u64,
        hot_bps: u64,
        timestamp_ms: u64,
    }

    struct LegAdded has copy, drop {
        pool: 0x2::object::ID,
        index: u64,
        market: 0x2::object::ID,
        account: 0x2::object::ID,
        long: bool,
        leverage_bps: u64,
        weight_bps: u64,
    }

    struct Bonded has copy, drop {
        pool: 0x2::object::ID,
        burned: u64,
        nav: u64,
        timestamp_ms: u64,
    }

    struct Swap has copy, drop {
        pool: 0x2::object::ID,
        trader: address,
        buy: bool,
        input: u64,
        output: u64,
        fee: u64,
        meme_reserve: u64,
        nav: u64,
        depth: u64,
        returned: u64,
        timestamp_ms: u64,
    }

    struct SaleDeferred has copy, drop {
        pool: 0x2::object::ID,
        trader: address,
        input: u64,
        timestamp_ms: u64,
    }

    struct StateChanged has copy, drop {
        pool: 0x2::object::ID,
        from: u8,
        to: u8,
    }

    struct LegTouched has copy, drop {
        pool: 0x2::object::ID,
        index: u64,
        nav: u64,
        skipped: bool,
        timestamp_ms: u64,
    }

    struct Deployed has copy, drop {
        pool: 0x2::object::ID,
        index: u64,
        amount: u64,
        returned: u64,
    }

    struct Staked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
        tier: u8,
    }

    struct Unstaked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
        dividends: u64,
    }

    struct Claimed has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct EpochFunded has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
        pending: u64,
        timestamp_ms: u64,
    }

    struct ProfitReleased has copy, drop {
        pool: 0x2::object::ID,
        index: u64,
        profit: u64,
        amount: u64,
        to_creator: u64,
        to_buyback: u64,
        by_keeper: bool,
    }

    struct BoughtBack has copy, drop {
        pool: 0x2::object::ID,
        spent: u64,
        coins: u64,
        to_pool: u64,
        to_dex_quote: u64,
        to_dex_coins: u64,
        nav: u64,
        timestamp_ms: u64,
    }

    struct ProfitPolicy has copy, drop {
        pool: 0x2::object::ID,
        auto_release_bps: u64,
        creator_cut_bps: u64,
    }

    struct RetargetProposed has copy, drop {
        pool: 0x2::object::ID,
        markets: vector<0x2::object::ID>,
        longs: vector<bool>,
        leverages: vector<u64>,
        weights: vector<u64>,
        effective_ms: u64,
    }

    struct RetargetCancelled has copy, drop {
        pool: 0x2::object::ID,
        by_admin: bool,
    }

    struct RetargetStarted has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct LegRetired has copy, drop {
        pool: 0x2::object::ID,
        index: u64,
        market: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct RetargetApplied has copy, drop {
        pool: 0x2::object::ID,
        legs: u64,
        timestamp_ms: u64,
    }

    struct Hibernated has copy, drop {
        pool: 0x2::object::ID,
        daily_volume_usd_e6: u64,
        by_admin: bool,
        timestamp_ms: u64,
    }

    struct Woke has copy, drop {
        pool: 0x2::object::ID,
        daily_volume_usd_e6: u64,
        by_admin: bool,
        timestamp_ms: u64,
    }

    struct LaunchChoices has copy, drop {
        pool: 0x2::object::ID,
        sniper_tax: bool,
        no_record_free_ms: u64,
        staking: bool,
    }

    struct MigratedIn has copy, drop {
        pool: 0x2::object::ID,
        from_pool: 0x2::object::ID,
        meme: u64,
        cash: u64,
        virtual_quote: u64,
        bonded: bool,
        creator: address,
    }

    struct MoveTicket<phantom T0, phantom T1> {
        from: 0x2::object::ID,
        seller: address,
        amount: u64,
    }

    struct Moved has copy, drop {
        from: 0x2::object::ID,
        to: 0x2::object::ID,
        trader: address,
        amount: u64,
    }

    struct TradedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TradeFeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TradeFees has copy, drop, store {
        buy: u64,
        sell: u64,
        pending: 0x1::option::Option<PendingFees>,
    }

    struct PendingFees has copy, drop, store {
        buy: u64,
        sell: u64,
        effective_ms: u64,
    }

    struct TradeFeesChanged has copy, drop {
        pool: 0x2::object::ID,
        buy_bps: u64,
        sell_bps: u64,
    }

    struct TradeFeesProposed has copy, drop {
        pool: 0x2::object::ID,
        buy_bps: u64,
        sell_bps: u64,
        effective_ms: u64,
    }

    struct RetargetKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LastRetargetKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RetiredKey has copy, drop, store {
        i: u64,
    }

    struct Pending has drop, store {
        markets: vector<0x2::object::ID>,
        longs: vector<bool>,
        leverages: vector<u64>,
        weights: vector<u64>,
        effective_ms: u64,
    }

    struct SleepKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VolumeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Sleep has drop, store {
        floor_usd_e6: u64,
        since_ms: u64,
    }

    struct DexPlanKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DexReserveKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CetusKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DlmmKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DlmmSlot has store {
        position: 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position,
        venue: 0x2::object::ID,
        lower: u32,
        width: u32,
    }

    struct ClmmKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ClmmSlot has store {
        position: 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position,
        venue: 0x2::object::ID,
    }

    struct DexPlan has copy, drop, store {
        venue: u8,
        bps: u64,
        tick_spacing: u32,
    }

    struct DexReserve<phantom T0, phantom T1> has store {
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
    }

    struct DexSetAside has copy, drop {
        pool: 0x2::object::ID,
        venue: u8,
        meme: u64,
        quote: u64,
    }

    struct DexSeeded has copy, drop {
        pool: 0x2::object::ID,
        venue: u8,
        venue_pool: 0x2::object::ID,
        position: 0x2::object::ID,
        meme: u64,
        quote: u64,
    }

    struct DexReturned has copy, drop {
        pool: 0x2::object::ID,
        meme: u64,
        quote: u64,
    }

    struct DexFeesCollected has copy, drop {
        pool: 0x2::object::ID,
        quote: u64,
        meme_burned: u64,
    }

    struct FeesCollected has copy, drop {
        pool: 0x2::object::ID,
        treasury: u64,
        platform: u64,
    }

    struct CreatorPaid has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    public fun collect_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::balance::value<T1>(&arg0.treasury);
        let v1 = 0x2::balance::value<T1>(&arg0.platform);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.treasury, v0), arg2), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::treasury(arg1));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.platform, v1), arg2), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::platform(arg1));
        };
        let v2 = FeesCollected{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            treasury : v0,
            platform : v1,
        };
        0x2::event::emit<FeesCollected>(v2);
    }

    public(friend) fun create<T0, T1>(arg0: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<0x2::object::ID>, arg6: vector<bool>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: bool, arg11: u64, arg12: bool, arg13: u64, arg14: u8, arg15: u64, arg16: u32, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_buying(arg0);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg5);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg0);
        assert!(v0 >= 1 && v0 <= 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::max_legs(&v1), 6);
        let v2 = if (0x1::vector::length<bool>(&arg6) == v0) {
            if (0x1::vector::length<u64>(&arg7) == v0) {
                0x1::vector::length<u64>(&arg8) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 6);
        assert!(arg9 >= 500 && arg9 <= 5000, 3);
        let v3 = 0;
        let v4 = &arg8;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(v4)) {
            v3 = v3 + *0x1::vector::borrow<u64>(v4, v5);
            v5 = v5 + 1;
        };
        assert!(v3 == 10000, 6);
        assert!(0x2::coin::value<T0>(&arg2) > 0 && 0x2::coin::value<T1>(&arg3) >= 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::min_seed(), 3);
        let v6 = 0x2::clock::timestamp_ms(arg17);
        let v7 = Pool<T0, T1>{
            id                : 0x2::object::new(arg18),
            config            : 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config>(arg0),
            creator           : 0x2::tx_context::sender(arg18),
            meme              : 0x2::coin::into_balance<T0>(arg2),
            cash              : 0x2::coin::into_balance<T1>(arg3),
            treasury          : 0x2::balance::zero<T1>(),
            platform          : 0x2::balance::zero<T1>(),
            creator_fees      : 0x2::balance::zero<T1>(),
            dividends         : 0x2::balance::zero<T1>(),
            state             : 6,
            legs              : v0,
            hot_bps           : arg9,
            leg_navs          : vector[],
            leg_nav_ms        : vector[],
            created_ms        : v6,
            last_trade_ms     : v6,
            sniper_tax        : arg10,
            no_record_free_ms : arg11,
            staking           : arg12,
            buyback           : 0x2::balance::zero<T1>(),
            log               : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::new(arg18),
            records           : 0x2::table::new<0x2::object::ID, Record>(arg18),
            ledger            : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::new(v6, arg18),
            pending_dividends : 0,
            epoch_ms          : v6,
            auto_release_bps  : 0,
            creator_cut_bps   : 0,
            release_epoch_ms  : v6,
            released_in_epoch : 0,
            last_buyback_ms   : 0,
        };
        let v8 = SleepKey{dummy_field: false};
        let v9 = Sleep{
            floor_usd_e6 : arg13 * 1000000,
            since_ms     : v6,
        };
        0x2::dynamic_field::add<SleepKey, Sleep>(&mut v7.id, v8, v9);
        let v10 = if (arg15 <= 5000) {
            if (arg15 == 0) {
                true
            } else if (arg14 == 1) {
                true
            } else {
                (arg14 == 2 || arg14 == 3) && arg16 > 0
            }
        } else {
            false
        };
        assert!(v10, 17);
        let v11 = DexPlanKey{dummy_field: false};
        let v12 = DexPlan{
            venue        : arg14,
            bps          : arg15,
            tick_spacing : arg16,
        };
        0x2::dynamic_field::add<DexPlanKey, DexPlan>(&mut v7.id, v11, v12);
        let v13 = 0x2::balance::value<T1>(&v7.cash);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::install(&mut v7.id, arg4, v13);
        let v14 = Created{
            pool          : 0x2::object::id<Pool<T0, T1>>(&v7),
            creator       : v7.creator,
            meme_reserve  : 0x2::balance::value<T0>(&v7.meme),
            seed          : v13,
            virtual_quote : arg4,
            legs          : v0,
            hot_bps       : arg9,
            timestamp_ms  : v6,
        };
        0x2::event::emit<Created>(v14);
        let v15 = 0;
        while (v15 < v0) {
            let v16 = *0x1::vector::borrow<0x2::object::ID>(&arg5, v15);
            let v17 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market(arg0, v16);
            assert!(*0x1::vector::borrow<u64>(&arg7, v15) <= 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market_max_leverage_bps(&v17), 6);
            let v18 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::new<T1>(arg1, v16, *0x1::vector::borrow<bool>(&arg6, v15), *0x1::vector::borrow<u64>(&arg7, v15), *0x1::vector::borrow<u64>(&arg8, v15), arg18);
            let v19 = LegAdded{
                pool         : 0x2::object::id<Pool<T0, T1>>(&v7),
                index        : v15,
                market       : v16,
                account      : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::account_id<T1>(&v18),
                long         : *0x1::vector::borrow<bool>(&arg6, v15),
                leverage_bps : *0x1::vector::borrow<u64>(&arg7, v15),
                weight_bps   : *0x1::vector::borrow<u64>(&arg8, v15),
            };
            0x2::event::emit<LegAdded>(v19);
            let v20 = LegKey{i: v15};
            0x2::dynamic_field::add<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut v7.id, v20, v18);
            0x1::vector::push_back<u64>(&mut v7.leg_navs, 0);
            0x1::vector::push_back<u64>(&mut v7.leg_nav_ms, v6);
            v15 = v15 + 1;
        };
        let v21 = LaunchChoices{
            pool              : 0x2::object::id<Pool<T0, T1>>(&v7),
            sniper_tax        : arg10,
            no_record_free_ms : arg11,
            staking           : arg12,
        };
        0x2::event::emit<LaunchChoices>(v21);
        v7
    }

    fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        let v0 = DexPlanKey{dummy_field: false};
        0x2::dynamic_field::borrow<DexPlanKey, DexPlan>(&arg0.id, v0).tick_spacing
    }

    public fun logged<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : u64 {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::logged(&arg0.log, arg1)
    }

    public fun claimable<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(arg1));
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::claimable(&arg0.ledger, &v0.account, &v0.lots, &v0.lock)
    }

    public fun can_bond<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.state == 6 && 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::can_bond(&arg0.id)
    }

    fun check<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config) {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_version(arg1);
        assert!(arg0.config == 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config>(arg1), 1);
    }

    public fun rebalance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: u64, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        check<T0, T1>(arg0, arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_keeper(arg1, arg2);
        assert!(arg0.state == 0 && arg3 < arg0.legs, 2);
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let v1 = LegKey{i: arg3};
        let v2 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v2, arg5, &arg6);
        if (!0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v2, &arg6, arg7, arg8, arg9)) {
            return arg6
        };
        let v3 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::prices<T1>(v2, arg5, &mut arg6, arg7, arg8, arg9);
        let v4 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market_any(arg1, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(v2));
        let v5 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::room_usd_e6<T1>(v2, arg5, &arg6, &v3, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market_cap_usd_e6(&v4));
        let v6 = arg6;
        arg6 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::rebalance<T1>(v2, arg5, v6, arg7, arg8, &v3, v5, arg4, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::rebalance_slippage_bps(&v0), arg9, arg10);
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_navs, arg3) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v2, arg5, &arg6, &v3);
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_nav_ms, arg3) = 0x2::clock::timestamp_ms(arg9);
        arg6
    }

    public fun restore_margin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: u64, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) : u64 {
        check<T0, T1>(arg0, arg1);
        assert!(arg2 < arg0.legs, 6);
        let v0 = LegKey{i: arg2};
        let v1 = 0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v0);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v1, arg3, arg4);
        if (!0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v1, arg4, arg5, arg6, arg7)) {
            return 0
        };
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::restore_margin<T1>(v1, arg3, arg4, arg5, arg6, arg7)
    }

    public fun admin_return_dex_reserve<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::AdminCap) {
        check<T0, T1>(arg0, arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::authorize(arg1, arg2);
        let v0 = take_reserve<T0, T1>(arg0);
        let DexReserve {
            meme  : v1,
            quote : v2,
        } = v0;
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T0>(&mut arg0.meme, v4);
        0x2::balance::join<T1>(&mut arg0.cash, v3);
        let v5 = DexReturned{
            pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
            meme  : 0x2::balance::value<T0>(&v4),
            quote : 0x2::balance::value<T1>(&v3),
        };
        0x2::event::emit<DexReturned>(v5);
    }

    public fun admin_set_hibernated<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::AdminCap, arg3: bool, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::authorize(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = daily_volume<T0, T1>(arg0, arg4);
        if (arg3) {
            let v2 = if (arg0.state == 0) {
                let v3 = RetargetKey{dummy_field: false};
                !0x2::dynamic_field::exists<RetargetKey>(&arg0.id, v3)
            } else {
                false
            };
            assert!(v2, 2);
            set_state<T0, T1>(arg0, 2);
            let v4 = Hibernated{
                pool                : 0x2::object::id<Pool<T0, T1>>(arg0),
                daily_volume_usd_e6 : v1,
                by_admin            : true,
                timestamp_ms        : v0,
            };
            0x2::event::emit<Hibernated>(v4);
        } else {
            assert!(arg0.state == 2, 2);
            set_state<T0, T1>(arg0, 0);
            start_volume<T0, T1>(arg0, v0);
            let v5 = Woke{
                pool                : 0x2::object::id<Pool<T0, T1>>(arg0),
                daily_volume_usd_e6 : v1,
                by_admin            : true,
                timestamp_ms        : v0,
            };
            0x2::event::emit<Woke>(v5);
        };
    }

    public fun apply_retarget<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.state == 6;
        assert!(arg0.state == 7 || v1, 2);
        let v2 = RetargetKey{dummy_field: false};
        let Pending {
            markets      : v3,
            longs        : v4,
            leverages    : v5,
            weights      : v6,
            effective_ms : v7,
        } = 0x2::dynamic_field::remove<RetargetKey, Pending>(&mut arg0.id, v2);
        let v8 = v6;
        let v9 = v5;
        let v10 = v4;
        let v11 = v3;
        assert!(v0 >= v7, 14);
        let v12 = 0x1::vector::length<0x2::object::ID>(&v11);
        let v13 = 0x1::vector::empty<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>();
        let v14 = vector[];
        let v15 = 0;
        while (v15 < arg0.legs) {
            let v16 = RetiredKey{i: v15};
            if (0x2::dynamic_field::exists<RetiredKey>(&arg0.id, v16)) {
                let v17 = RetiredKey{i: v15};
                0x2::dynamic_field::remove<RetiredKey, bool>(&mut arg0.id, v17);
            } else {
                let v18 = LegKey{i: v15};
                let v19 = 0x2::dynamic_field::remove<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v18);
                let v20 = false;
                let v21 = 0;
                while (v21 < v12) {
                    if (*0x1::vector::borrow<0x2::object::ID>(&v11, v21) == 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(&v19) && *0x1::vector::borrow<bool>(&v10, v21) == 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::long<T1>(&v19)) {
                        v20 = true;
                    };
                    v21 = v21 + 1;
                };
                assert!(v20, 15);
                0x1::vector::push_back<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut v13, v19);
                0x1::vector::push_back<u64>(&mut v14, *0x1::vector::borrow<u64>(&arg0.leg_navs, v15));
            };
            v15 = v15 + 1;
        };
        let v22 = vector[];
        let v23 = vector[];
        let v24 = 0;
        while (v24 < v12) {
            let v25 = 0x1::option::none<u64>();
            let v26 = 0;
            while (v26 < 0x1::vector::length<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&v13)) {
                if (0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(0x1::vector::borrow<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&v13, v26)) == *0x1::vector::borrow<0x2::object::ID>(&v11, v24) && 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::long<T1>(0x1::vector::borrow<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&v13, v26)) == *0x1::vector::borrow<bool>(&v10, v24)) {
                    v25 = 0x1::option::some<u64>(v26);
                };
                v26 = v26 + 1;
            };
            if (0x1::option::is_some<u64>(&v25)) {
                let v27 = 0x1::option::destroy_some<u64>(v25);
                let v28 = 0x1::vector::swap_remove<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut v13, v27);
                0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::set_target<T1>(&mut v28, *0x1::vector::borrow<u64>(&v9, v24), *0x1::vector::borrow<u64>(&v8, v24));
                let v29 = LegKey{i: v24};
                0x2::dynamic_field::add<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v29, v28);
                0x1::vector::push_back<u64>(&mut v22, 0x1::vector::swap_remove<u64>(&mut v14, v27));
            } else {
                let v30 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::new<T1>(arg2, *0x1::vector::borrow<0x2::object::ID>(&v11, v24), *0x1::vector::borrow<bool>(&v10, v24), *0x1::vector::borrow<u64>(&v9, v24), *0x1::vector::borrow<u64>(&v8, v24), arg4);
                let v31 = LegAdded{
                    pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
                    index        : v24,
                    market       : *0x1::vector::borrow<0x2::object::ID>(&v11, v24),
                    account      : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::account_id<T1>(&v30),
                    long         : *0x1::vector::borrow<bool>(&v10, v24),
                    leverage_bps : *0x1::vector::borrow<u64>(&v9, v24),
                    weight_bps   : *0x1::vector::borrow<u64>(&v8, v24),
                };
                0x2::event::emit<LegAdded>(v31);
                let v32 = LegKey{i: v24};
                0x2::dynamic_field::add<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v32, v30);
                0x1::vector::push_back<u64>(&mut v22, 0);
            };
            0x1::vector::push_back<u64>(&mut v23, v0);
            v24 = v24 + 1;
        };
        0x1::vector::destroy_empty<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(v13);
        arg0.legs = v12;
        arg0.leg_navs = v22;
        arg0.leg_nav_ms = v23;
        if (!v1) {
            set_state<T0, T1>(arg0, 0);
        };
        let v33 = LastRetargetKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LastRetargetKey>(&arg0.id, v33)) {
            let v34 = LastRetargetKey{dummy_field: false};
            0x2::dynamic_field::remove<LastRetargetKey, u64>(&mut arg0.id, v34);
        };
        let v35 = LastRetargetKey{dummy_field: false};
        0x2::dynamic_field::add<LastRetargetKey, u64>(&mut arg0.id, v35, v0);
        let v36 = RetargetApplied{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            legs         : v12,
            timestamp_ms : v0,
        };
        0x2::event::emit<RetargetApplied>(v36);
    }

    public fun apply_trade_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        let v0 = TradeFeesKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<TradeFeesKey>(&arg0.id, v0), 18);
        let v1 = TradeFeesKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TradeFeesKey, TradeFees>(&mut arg0.id, v1);
        assert!(0x1::option::is_some<PendingFees>(&v2.pending), 18);
        let PendingFees {
            buy          : v3,
            sell         : v4,
            effective_ms : v5,
        } = 0x1::option::extract<PendingFees>(&mut v2.pending);
        assert!(0x2::clock::timestamp_ms(arg2) >= v5, 18);
        v2.buy = v3;
        v2.sell = v4;
        let v6 = TradeFeesChanged{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            buy_bps  : v3,
            sell_bps : v4,
        };
        0x2::event::emit<TradeFeesChanged>(v6);
    }

    public fun auto_release<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_keeper(arg1, arg2);
        assert!(arg0.auto_release_bps > 0, 3);
        let v0 = arg0.auto_release_bps;
        release<T0, T1>(arg0, arg1, arg3, v0, true, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun begin_buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Buy<T0, T1> {
        let v0 = buy_fee_bps<T0, T1>(arg0);
        open_buy<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg5, arg6)
    }

    public fun begin_buy_moved<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: MoveTicket<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Buy<T0, T1> {
        let MoveTicket {
            from   : v0,
            seller : v1,
            amount : v2,
        } = arg2;
        let v3 = if (v0 != 0x2::object::id<Pool<T0, T1>>(arg0)) {
            if (v1 == 0x2::tx_context::sender(arg7)) {
                0x2::coin::value<T1>(&arg3) <= v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 19);
        let v4 = Moved{
            from   : v0,
            to     : 0x2::object::id<Pool<T0, T1>>(arg0),
            trader : v1,
            amount : 0x2::coin::value<T1>(&arg3),
        };
        0x2::event::emit<Moved>(v4);
        open_buy<T0, T1>(arg0, arg1, arg3, 0, arg4, arg5, arg6, arg7)
    }

    public fun begin_retarget<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        let v0 = RetargetKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RetargetKey>(&arg0.id, v0), 15);
        let v1 = RetargetKey{dummy_field: false};
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= 0x2::dynamic_field::borrow<RetargetKey, Pending>(&arg0.id, v1).effective_ms, 14);
        assert!(arg0.state == 0 || arg0.state == 6, 2);
        if (arg0.state == 0) {
            set_state<T0, T1>(arg0, 7);
        };
        let v3 = RetargetStarted{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            timestamp_ms : v2,
        };
        0x2::event::emit<RetargetStarted>(v3);
    }

    public fun begin_sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Sell<T0, T1> {
        check<T0, T1>(arg0, arg1);
        timely(arg6, arg5);
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::pool_id<T0>(&arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let (v2, v3, v4) = exit_fees_of<T0, T1>(arg0, &v1);
        let v5 = !exit_window<T0, T1>(arg0) && v0 < 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::locks::unlock_ms(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::lock<T0>(&arg2));
        assert!(!v5 || arg3, 9);
        let v6 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::amount<T0>(&arg2);
        let v7 = if (v5) {
            v2
        } else if (!sniper_applies<T0, T1>(arg0)) {
            v3
        } else {
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div_ceil(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::fee<T0>(&arg2, v0, v2, v3, v4), 10000, v6)
        };
        start_sell<T0, T1>(arg0, arg2, false, v6, arg4, v7, arg7)
    }

    public fun begin_sell_coins<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Sell<T0, T1> {
        check<T0, T1>(arg0, arg1);
        timely(arg5, arg4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let (v2, v3, v4) = exit_fees_of<T0, T1>(arg0, &v1);
        let v5 = 0x2::clock::timestamp_ms(arg5);
        let v6 = if (!sniper_applies<T0, T1>(arg0)) {
            v3
        } else {
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div_ceil(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::preview(&arg0.log, 0x2::tx_context::sender(arg6), v0, v5, v2, v3, v4, no_record_bps<T0, T1>(arg0, v2, v3, v5)), 10000, v0)
        };
        let v7 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::new<T0>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::coin::into_balance<T0>(arg2), v5, arg6);
        start_sell<T0, T1>(arg0, v7, true, v0, arg3, v6, arg6)
    }

    public fun bond<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.state == 6, 2);
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::can_bond(&arg0.id), 8);
        let (v0, v1) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::retire(&mut arg0.id);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::burn_share(0x2::balance::value<T0>(&arg0.meme), v0, v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, v2), arg3), @0x0);
        };
        set_state<T0, T1>(arg0, 0);
        start_volume<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2));
        let v3 = DexPlanKey{dummy_field: false};
        let v4 = *0x2::dynamic_field::borrow<DexPlanKey, DexPlan>(&arg0.id, v3);
        if (v4.bps > 0) {
            let v5 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(0x2::balance::value<T0>(&arg0.meme), v4.bps, 10000);
            let v6 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(0x2::balance::value<T1>(&arg0.cash), v4.bps, 10000);
            let v7 = DexReserve<T0, T1>{
                meme  : 0x2::balance::split<T0>(&mut arg0.meme, v5),
                quote : 0x2::balance::split<T1>(&mut arg0.cash, v6),
            };
            let v8 = DexReserveKey{dummy_field: false};
            0x2::dynamic_field::add<DexReserveKey, DexReserve<T0, T1>>(&mut arg0.id, v8, v7);
            let v9 = DexSetAside{
                pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
                venue : v4.venue,
                meme  : v5,
                quote : v6,
            };
            0x2::event::emit<DexSetAside>(v9);
        };
        let v10 = Bonded{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            burned       : v2,
            nav          : 0x2::balance::value<T1>(&arg0.cash),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Bonded>(v10);
    }

    fun buy_fee_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        let (v0, _) = trade_fees<T0, T1>(arg0);
        v0
    }

    fun buy_half<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = arg1 / 2;
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::balance::split<T1>(&mut arg0.buyback, v0));
        (0x2::balance::split<T0>(&mut arg0.meme, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::buy(&mut arg0.id, 0x2::balance::value<T0>(&arg0.meme), arg2, v0)), 0x2::balance::split<T1>(&mut arg0.buyback, arg1 - v0))
    }

    public fun buy_leg<T0, T1>(arg0: &mut Buy<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg3: u64, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        assert!(arg0.pool == 0x2::object::id<Pool<T0, T1>>(arg1) && arg3 < arg1.legs, 1);
        let v0 = 1 << (arg3 as u8);
        assert!(arg0.visited & v0 == 0, 7);
        arg0.visited = arg0.visited | v0;
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.budget, *0x1::vector::borrow<u64>(&arg0.shares, arg3)), arg10);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg2);
        let v3 = 0x2::clock::timestamp_ms(arg9);
        let v4 = LegKey{i: arg3};
        let v5 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg1.id, v4);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v5, arg4, &arg5);
        if (!0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v5, &arg5, arg7, arg8, arg9)) {
            let v6 = *0x1::vector::borrow<u64>(&arg1.leg_navs, arg3);
            arg0.legs_before = arg0.legs_before + v6 + 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div_ceil(v6, 200, 10000);
            arg0.added = arg0.added + 0x2::coin::value<T1>(&v1);
            0x2::balance::join<T1>(&mut arg1.cash, 0x2::coin::into_balance<T1>(v1));
            let v7 = LegTouched{
                pool         : arg0.pool,
                index        : arg3,
                nav          : v6,
                skipped      : true,
                timestamp_ms : v3,
            };
            0x2::event::emit<LegTouched>(v7);
            return arg5
        };
        let v8 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::prices<T1>(v5, arg4, &mut arg5, arg7, arg8, arg9);
        let v9 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v5, arg4, &arg5, &v8);
        let v10 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market_any(arg2, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(v5));
        let (v11, v12) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::open<T1>(v5, arg4, arg5, arg6, arg7, arg8, &v8, v1, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::room_usd_e6<T1>(v5, arg4, &arg5, &v8, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market_cap_usd_e6(&v10)), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::entry_slippage_bps(&v2), arg9, arg10);
        let v13 = v12;
        arg5 = v11;
        let v14 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v5, arg4, &arg5, &v8);
        arg0.legs_before = arg0.legs_before + v9;
        let v15 = if (v14 > v9) {
            v14 - v9
        } else {
            0
        };
        arg0.added = arg0.added + v15 + 0x2::coin::value<T1>(&v13);
        0x2::balance::join<T1>(&mut arg1.cash, 0x2::coin::into_balance<T1>(v13));
        *0x1::vector::borrow_mut<u64>(&mut arg1.leg_navs, arg3) = v14;
        *0x1::vector::borrow_mut<u64>(&mut arg1.leg_nav_ms, arg3) = v3;
        let v16 = LegTouched{
            pool         : arg0.pool,
            index        : arg3,
            nav          : v14,
            skipped      : false,
            timestamp_ms : v3,
        };
        0x2::event::emit<LegTouched>(v16);
        arg5
    }

    public fun buyback<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1, v2) = buyback_budget<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::balance::split<T1>(&mut arg0.buyback, v0));
        let v3 = BoughtBack{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            spent        : v0,
            coins        : 0,
            to_pool      : v0,
            to_dex_quote : 0,
            to_dex_coins : 0,
            nav          : v1 + v0,
            timestamp_ms : v2,
        };
        0x2::event::emit<BoughtBack>(v3);
    }

    public fun buyback_balance<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.buyback)
    }

    fun buyback_budget<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        check<T0, T1>(arg0, arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_keeper(arg1, arg2);
        assert!(arg0.state == 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.last_buyback_ms + 600000, 14);
        let v1 = 0x2::balance::value<T1>(&arg0.cash);
        let v2 = 0;
        while (v2 < arg0.legs) {
            let v3 = RetiredKey{i: v2};
            if (!0x2::dynamic_field::exists<RetiredKey>(&arg0.id, v3)) {
                assert!(v0 <= *0x1::vector::borrow<u64>(&arg0.leg_nav_ms, v2) + 900000, 13);
                v1 = v1 + *0x1::vector::borrow<u64>(&arg0.leg_navs, v2);
            };
            v2 = v2 + 1;
        };
        let v4 = 0x1::u64::min(0x1::u64::min(arg3, 0x2::balance::value<T1>(&arg0.buyback)), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v1, 50, 10000));
        assert!(v4 > 0, 3);
        arg0.last_buyback_ms = v0;
        (v4, v1, v0)
    }

    public fun buyback_cetus_mq<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2) = buyback_budget<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let (v3, v4) = buy_half<T0, T1>(arg0, v0, v1);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        let v9 = mul_price(v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5));
        let v10 = CetusKey{dummy_field: false};
        let v11 = 0x2::dynamic_object_field::borrow_mut<CetusKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v10);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v11) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), 17);
        let v12 = if (v9 + v9 / 100 <= v8) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg4, arg5, v11, v7, true, arg6)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg4, arg5, v11, v8, false, arg6)
        };
        let v13 = v12;
        let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg4, arg5, 0x2::balance::split<T0>(&mut v6, v14), 0x2::balance::split<T1>(&mut v5, v15), v13);
        finish_dex_buyback<T0, T1>(arg0, v6, v5, v0, v7, v15, v14, v1, v2);
    }

    public fun buyback_cetus_qm<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2) = buyback_budget<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let (v3, v4) = buy_half<T0, T1>(arg0, v0, v1);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        let v9 = mul_price(v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5));
        let v10 = CetusKey{dummy_field: false};
        let v11 = 0x2::dynamic_object_field::borrow_mut<CetusKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v10);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v11) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5), 17);
        let v12 = if (v9 + v9 / 100 <= v7) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg4, arg5, v11, v8, true, arg6)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg4, arg5, v11, v7, false, arg6)
        };
        let v13 = v12;
        let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg4, arg5, 0x2::balance::split<T1>(&mut v5, v14), 0x2::balance::split<T0>(&mut v6, v15), v13);
        finish_dex_buyback<T0, T1>(arg0, v6, v5, v0, v7, v14, v15, v1, v2);
    }

    public fun buyback_clmm<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg5: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = buyback_budget<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let (v3, v4) = buy_half<T0, T1>(arg0, v0, v1);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        let v9 = ClmmKey{dummy_field: false};
        let v10 = 0x2::dynamic_field::borrow_mut<ClmmKey, ClmmSlot>(&mut arg0.id, v9);
        assert!(v10.venue == 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>>(arg5), 17);
        let v11 = mul_price(v7, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::sqrt_price<T0, T1>(arg5));
        let v12 = v0 / 2;
        let v13 = (v11 as u128) * (10000 as u128) >= (v12 as u128) * ((10000 - 1000) as u128) && (v11 as u128) * (10000 as u128) <= (v12 as u128) * ((10000 + 1000) as u128);
        let v14 = if (!v13) {
            true
        } else if (v7 == 0) {
            true
        } else {
            v8 == 0
        };
        if (v14) {
            finish_dex_buyback<T0, T1>(arg0, v6, v5, v0, v7, 0, 0, v1, v2);
            return
        };
        let (v15, v16) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::add_liquidity_by_amounts<T0, T1>(arg4, arg5, &mut v10.position, 0x2::coin::from_balance<T0>(v6, arg7), 0x2::coin::from_balance<T1>(v5, arg7), v7, v8, 0, 0, arg7);
        let v17 = v16;
        let v18 = v15;
        finish_dex_buyback<T0, T1>(arg0, 0x2::coin::into_balance<T0>(v18), 0x2::coin::into_balance<T1>(v17), v0, v7, v8 - 0x2::coin::value<T1>(&v17), v7 - 0x2::coin::value<T0>(&v18), v1, v2);
    }

    public fun buyback_dlmm<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg5: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = buyback_budget<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let (v3, v4) = buy_half<T0, T1>(arg0, v0, v1);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::active_id<T0, T1>(arg5);
        let v8 = DlmmKey{dummy_field: false};
        let v9 = 0x2::dynamic_field::borrow_mut<DlmmKey, DlmmSlot>(&mut arg0.id, v8);
        assert!(v9.venue == 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>>(arg5), 17);
        if (v7 < v9.lower || v7 >= v9.lower + v9.width) {
            finish_dex_buyback<T0, T1>(arg0, v6, v5, v0, 0x2::balance::value<T0>(&v6), 0, 0, v1, v2);
            return
        };
        let v10 = ((v7 - v9.lower) as u64);
        let v11 = 0x2::balance::value<T0>(&v6);
        let v12 = 0x2::balance::value<T1>(&v5);
        let v13 = vector[];
        let v14 = vector[];
        let v15 = 0;
        while (v15 < (v9.width as u64)) {
            let v16 = if (v15 == v10) {
                v11
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v13, v16);
            let v17 = if (v15 == v10) {
                v12
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v14, v17);
            v15 = v15 + 1;
        };
        let (v18, v19) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::add_liquidity<T0, T1>(arg4, arg5, &mut v9.position, 0x2::coin::from_balance<T0>(v6, arg7), 0x2::coin::from_balance<T1>(v5, arg7), v13, v14, v7, v7, v11 / 50 + 1, v12 / 50 + 1, arg7);
        let v20 = v19;
        let v21 = v18;
        finish_dex_buyback<T0, T1>(arg0, 0x2::coin::into_balance<T0>(v21), 0x2::coin::into_balance<T1>(v20), v0, 0x2::balance::value<T0>(&v6), v12 - 0x2::coin::value<T1>(&v20), v11 - 0x2::coin::value<T0>(&v21), v1, v2);
    }

    public fun cancel_retarget<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 12);
        assert!(arg0.state != 7, 2);
        let v0 = RetargetKey{dummy_field: false};
        0x2::dynamic_field::remove<RetargetKey, Pending>(&mut arg0.id, v0);
        let v1 = RetargetCancelled{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            by_admin : false,
        };
        0x2::event::emit<RetargetCancelled>(v1);
    }

    public fun cash<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.cash)
    }

    public fun cetus_pool<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = CetusKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists<CetusKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v1 = CetusKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(0x2::dynamic_object_field::borrow<CetusKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, v1)))
    }

    public fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_version(arg1);
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::pool_id<T0>(arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(arg2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::settle(&arg0.ledger, &mut v1.account, &v1.lots, &v1.lock);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::take(&mut v1.account);
        let v3 = Claimed{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            stake  : v0,
            owner  : 0x2::tx_context::sender(arg3),
            amount : v2,
        };
        0x2::event::emit<Claimed>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.dividends, v2), arg3)
    }

    fun clmm_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        (tick_spacing<T0, T1>(arg0) as u64)
    }

    fun clmm_near(arg0: u128, arg1: u128) : bool {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (10000 as u256);
        let v3 = (50 as u256);
        v0 * v2 >= v1 * (v2 - v3) && v0 * v2 <= v1 * (v2 + v3)
    }

    public fun clmm_open_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        let v0 = DexReserveKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DexReserveKey, DexReserve<T0, T1>>(&arg0.id, v0);
        sqrt_price_x64(0x2::balance::value<T0>(&v1.meme), 0x2::balance::value<T1>(&v1.quote))
    }

    public fun clmm_pool<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = ClmmKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ClmmKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v1 = ClmmKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<ClmmKey, ClmmSlot>(&arg0.id, v1).venue)
    }

    public fun collect_cetus_fees_mq<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = CetusKey{dummy_field: false};
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0x2::dynamic_object_field::borrow<CetusKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, v0), true);
        settle_dex_fees<T0, T1>(arg0, arg1, v1, v2, arg4);
    }

    public fun collect_cetus_fees_qm<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = CetusKey{dummy_field: false};
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg2, arg3, 0x2::dynamic_object_field::borrow<CetusKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, v0), true);
        settle_dex_fees<T0, T1>(arg0, arg1, v2, v1, arg4);
    }

    public fun collect_clmm_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg3: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = ClmmKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ClmmKey, ClmmSlot>(&mut arg0.id, v0);
        assert!(v1.venue == 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>>(arg3), 17);
        let (v2, v3) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::collect_fees<T0, T1>(arg2, arg3, &mut v1.position, arg4);
        settle_dex_fees<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v2), 0x2::coin::into_balance<T1>(v3), arg4);
    }

    public fun collect_dlmm_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg3: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = DlmmKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DlmmKey, DlmmSlot>(&mut arg0.id, v0);
        assert!(v1.venue == 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>>(arg3), 17);
        let (v2, v3) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::claim_fees<T0, T1>(arg2, arg3, &mut v1.position, arg4);
        settle_dex_fees<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v2), 0x2::coin::into_balance<T1>(v3), arg4);
    }

    fun complete_buy<T0, T1>(arg0: Buy<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, address, u64) {
        check<T0, T1>(arg1, arg2);
        let Buy {
            pool        : v0,
            buyer       : v1,
            input       : v2,
            fee         : v3,
            min_out     : v4,
            budget      : v5,
            shares      : _,
            visited     : v7,
            meme_before : v8,
            cash_before : v9,
            legs_before : v10,
            added       : v11,
        } = arg0;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        assert!(v7 & legs_needed<T0, T1>(arg1) == legs_needed<T0, T1>(arg1), 7);
        let v12 = TradedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TradedKey>(&arg1.id, v12)) {
            let v13 = TradedKey{dummy_field: false};
            0x2::dynamic_field::add<TradedKey, bool>(&mut arg1.id, v13, true);
        };
        0x2::balance::destroy_zero<T1>(v5);
        let v14 = v9 + v10;
        assert!(v11 > 0, 3);
        let v15 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::buy(&mut arg1.id, v8, v14, v11);
        assert!(v15 > 0 && v15 >= v4, 4);
        let v16 = 0x2::clock::timestamp_ms(arg3);
        arg1.last_trade_ms = v16;
        record_volume<T0, T1>(arg1, v2, v16);
        let v17 = Swap{
            pool         : v0,
            trader       : v1,
            buy          : true,
            input        : v2,
            output       : v15,
            fee          : v3,
            meme_reserve : 0x2::balance::value<T0>(&arg1.meme) - v15,
            nav          : v14 + v11,
            depth        : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::depth(&arg1.id, v14 + v11),
            returned     : 0,
            timestamp_ms : v16,
        };
        0x2::event::emit<Swap>(v17);
        (0x2::balance::split<T0>(&mut arg1.meme, v15), v1, v16)
    }

    public fun create_clmm_pool<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = if (dex_venue<T0, T1>(arg0) == 3) {
            let v1 = DexReserveKey{dummy_field: false};
            0x2::dynamic_field::exists<DexReserveKey>(&arg0.id, v1)
        } else {
            false
        };
        assert!(v0, 17);
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::create<T0, T1>(arg2, clmm_fee_rate<T0, T1>(arg0), clmm_open_sqrt_price<T0, T1>(arg0), arg3);
    }

    public fun create_dlmm_pool<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = if (dex_venue<T0, T1>(arg0) == 2) {
            let v1 = DexReserveKey{dummy_field: false};
            0x2::dynamic_field::exists<DexReserveKey>(&arg0.id, v1)
        } else {
            false
        };
        assert!(v0, 17);
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::create<T0, T1>(arg2, dlmm_bin_step<T0, T1>(arg0), dlmm_open_id<T0, T1>(arg0), arg3, arg4);
    }

    public fun create_migrated<T0, T1>(arg0: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::AdminCap, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: bool, arg8: address, arg9: vector<0x2::object::ID>, arg10: vector<bool>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: bool, arg15: u64, arg16: bool, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::authorize(arg0, arg1);
        assert!(!arg7 || arg6 == 0, 3);
        let v0 = create<T0, T1>(arg0, arg2, arg4, arg5, arg6, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, 0, 0, 0, arg18, arg19);
        if (arg7) {
            let v1 = &mut v0;
            set_state<T0, T1>(v1, 0);
            let v2 = &mut v0;
            start_volume<T0, T1>(v2, 0x2::clock::timestamp_ms(arg18));
        };
        v0.creator = arg8;
        let v3 = MigratedIn{
            pool          : 0x2::object::id<Pool<T0, T1>>(&v0),
            from_pool     : arg3,
            meme          : 0x2::coin::value<T0>(&arg4),
            cash          : 0x2::coin::value<T1>(&arg5),
            virtual_quote : arg6,
            bonded        : arg7,
            creator       : arg8,
        };
        0x2::event::emit<MigratedIn>(v3);
        v0
    }

    public fun creator<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.creator
    }

    public fun daily_volume<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = VolumeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<VolumeKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = VolumeKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<VolumeKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::State>(&arg0.id, v1);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        if (v3 < 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::updated_ms(v2)) {
            return 0
        };
        let v4 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::daily_volume(v2, v3);
        if (v4 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v4 as u64)
        }
    }

    public fun deploy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::KeeperCap, arg3: u64, arg4: u64, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        check<T0, T1>(arg0, arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_keeper(arg1, arg2);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_buying(arg1);
        assert!(arg0.state == 0 && arg3 < arg0.legs, 2);
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let v1 = LegKey{i: arg3};
        let v2 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v2, arg5, &arg6);
        if (!0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v2, &arg6, arg8, arg9, arg10)) {
            return arg6
        };
        let v3 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::prices<T1>(v2, arg5, &mut arg6, arg8, arg9, arg10);
        let v4 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v2, arg5, &arg6, &v3);
        let v5 = 0x2::balance::value<T1>(&arg0.cash);
        let v6 = 0;
        while (v6 < arg0.legs) {
            if (v6 != arg3) {
                v5 = v5 + *0x1::vector::borrow<u64>(&arg0.leg_navs, v6);
            };
            v6 = v6 + 1;
        };
        let v7 = v5 + v4;
        let v8 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v7 - 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v7, arg0.hot_bps, 10000), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::weight_bps<T1>(v2), 10000);
        let v9 = if (v8 > v4) {
            v8 - v4
        } else {
            0
        };
        let v10 = 0x1::u64::min(0x1::u64::min(v9, 0x2::balance::value<T1>(&arg0.cash) - 0x1::u64::min(0x2::balance::value<T1>(&arg0.cash), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v7, arg0.hot_bps, 10000))), arg4);
        if (v10 == 0) {
            return arg6
        };
        let v11 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market_any(arg1, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(v2));
        let (v12, v13) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::open<T1>(v2, arg5, arg6, arg7, arg8, arg9, &v3, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v10), arg11), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::room_usd_e6<T1>(v2, arg5, &arg6, &v3, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market_cap_usd_e6(&v11)), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::rebalance_slippage_bps(&v0), arg10, arg11);
        let v14 = v13;
        arg6 = v12;
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(v14));
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_navs, arg3) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v2, arg5, &arg6, &v3);
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_nav_ms, arg3) = 0x2::clock::timestamp_ms(arg10);
        let v15 = Deployed{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            index    : arg3,
            amount   : v10,
            returned : 0x2::coin::value<T1>(&v14),
        };
        0x2::event::emit<Deployed>(v15);
        arg6
    }

    public fun dex_plan<T0, T1>(arg0: &Pool<T0, T1>) : (u8, u64, u32) {
        let v0 = DexPlanKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DexPlanKey, DexPlan>(&arg0.id, v0);
        (v1.venue, v1.bps, v1.tick_spacing)
    }

    fun dex_venue<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        let v0 = DexPlanKey{dummy_field: false};
        0x2::dynamic_field::borrow<DexPlanKey, DexPlan>(&arg0.id, v0).venue
    }

    fun dlmm_bin_step<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        (tick_spacing<T0, T1>(arg0) as u64)
    }

    fun dlmm_id_for(arg0: u64, arg1: u64, arg2: u64) : u32 {
        assert!(arg0 > 0 && arg1 > 0, 17);
        let v0 = ((arg1 as u256) << 64) / (arg0 as u256);
        let v1 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::max_id();
        let v2 = 1;
        while (v2 < v1) {
            v1 = v2 + (v1 - v2) / 2;
            if (dlmm_price_or_max(v1, arg2) < v0) {
                v2 = v1 + 1;
                continue
            };
        };
        if (v2 > 1 && v0 - dlmm_price_or_max(v2 - 1, arg2) < dlmm_price_or_max(v2, arg2) - v0) {
            v2 - 1
        } else {
            v2
        }
    }

    public fun dlmm_open_id<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        let v0 = DexReserveKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DexReserveKey, DexReserve<T0, T1>>(&arg0.id, v0);
        dlmm_id_for(0x2::balance::value<T0>(&v1.meme), 0x2::balance::value<T1>(&v1.quote), dlmm_bin_step<T0, T1>(arg0))
    }

    public fun dlmm_pool<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = DlmmKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<DlmmKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v1 = DlmmKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<DlmmKey, DlmmSlot>(&arg0.id, v1).venue)
    }

    fun dlmm_price_or_max(arg0: u32, arg1: u64) : u256 {
        let v0 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::id_offset();
        let v1 = if (arg0 >= v0) {
            arg0 - v0
        } else {
            v0 - arg0
        };
        if (v1 > 400000 / (arg1 as u32)) {
            if (arg0 >= v0) {
                340282366920938463463374607431768211456
            } else {
                0
            }
        } else {
            (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::price(arg0, arg1) as u256)
        }
    }

    fun exit_fees_of<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Params) : (u64, u64, u64) {
        let (v0, _, v2) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::exit_fees(arg1);
        let (_, v4) = trade_fees<T0, T1>(arg0);
        (0x1::u64::max(v0, v4), v4, v2)
    }

    fun exit_window<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        if (arg0.state != 0) {
            true
        } else {
            let v1 = RetargetKey{dummy_field: false};
            0x2::dynamic_field::exists<RetargetKey>(&arg0.id, v1)
        }
    }

    public fun fee_balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.treasury), 0x2::balance::value<T1>(&arg0.platform), 0x2::balance::value<T1>(&arg0.creator_fees), 0x2::balance::value<T1>(&arg0.dividends))
    }

    public fun finish_buy<T0, T1>(arg0: Buy<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = complete_buy<T0, T1>(arg0, arg1, arg2, arg3);
        let v3 = v0;
        if (arg1.sniper_tax) {
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::record(&mut arg1.log, v1, 0x2::balance::value<T0>(&v3), v2);
        };
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    public fun finish_buy_staked<T0, T1>(arg0: Buy<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0> {
        assert!(arg1.staking, 10);
        let (v0, v1, v2) = complete_buy<T0, T1>(arg0, arg1, arg2, arg4);
        let v3 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::new<T0>(0x2::object::id<Pool<T0, T1>>(arg1), v0, v2, arg5);
        if (arg3 > 0) {
            let v4 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg2);
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::upgrade<T0>(&mut v3, arg3, v2, &v4);
        };
        register<T0, T1>(arg1, &v3, v2);
        let v5 = Staked{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg1),
            stake  : 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(&v3),
            owner  : v1,
            amount : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::amount<T0>(&v3),
            tier   : arg3,
        };
        0x2::event::emit<Staked>(v5);
        v3
    }

    fun finish_dex_buyback<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x2::balance::join<T0>(&mut arg0.meme, arg1);
        0x2::balance::join<T1>(&mut arg0.cash, arg2);
        let v0 = BoughtBack{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            spent        : arg3,
            coins        : arg4,
            to_pool      : arg3 - arg5,
            to_dex_quote : arg5,
            to_dex_coins : arg6,
            nav          : arg7 + arg3 / 2 + 0x2::balance::value<T1>(&arg2),
            timestamp_ms : arg8,
        };
        0x2::event::emit<BoughtBack>(v0);
    }

    public fun finish_sell<T0, T1>(arg0: Sell<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_version(arg2);
        let Sell {
            pool        : v0,
            seller      : v1,
            coins       : v2,
            pos         : v3,
            input       : v4,
            min_out     : v5,
            num         : _,
            den         : _,
            visited     : v8,
            meme_before : v9,
            cash_before : v10,
            legs_before : v11,
            requested   : v12,
            funds       : v13,
            fee_bps     : v14,
        } = arg0;
        let v15 = v13;
        let v16 = v3;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        assert!(v8 & legs_needed<T0, T1>(arg1) == legs_needed<T0, T1>(arg1), 7);
        let v17 = 0x2::balance::value<T1>(&v15);
        if (v17 < v12) {
            0x2::balance::join<T1>(&mut v15, 0x2::balance::split<T1>(&mut arg1.cash, 0x1::u64::min(v12 - v17, 0x2::balance::value<T1>(&arg1.cash))));
        };
        let v18 = v10 + v11;
        let v19 = 0x1::u64::min(0x2::balance::value<T1>(&v15), v12);
        if (0x2::balance::value<T1>(&v15) > v19) {
            0x2::balance::join<T1>(&mut arg1.cash, 0x2::balance::split<T1>(&mut v15, 0x2::balance::value<T1>(&v15) - v19));
        };
        let v20 = if (v19 == 0) {
            0
        } else if (v19 >= v12) {
            v4
        } else {
            0x1::u64::min(v4, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::tokens_for(&arg1.id, v9, v18, v19))
        };
        if (v20 == 0) {
            0x2::balance::join<T1>(&mut arg1.cash, v15);
            if (v2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::destroy<T0>(v16, 0x2::object::id<Pool<T0, T1>>(arg1)), arg4), v1);
            } else {
                0x2::transfer::public_transfer<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(v16, v1);
            };
            let v21 = SaleDeferred{
                pool         : v0,
                trader       : v1,
                input        : v4,
                timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<SaleDeferred>(v21);
            return 0x2::coin::zero<T1>(arg4)
        };
        let v22 = v4 - v20;
        let v23 = 0x2::clock::timestamp_ms(arg3);
        let v24 = 0;
        if (!v2) {
            let v25 = unregister<T0, T1>(arg1, 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(&v16), v23);
            if (v22 > 0) {
                let v26 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::split<T0>(&mut v16, v22, arg4);
                register_with<T0, T1>(arg1, &v26, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::split(&mut v25, v22, v4), v23);
                0x2::transfer::public_transfer<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(v26, v1);
            };
            if (!exit_window<T0, T1>(arg1) && v23 < 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::locks::unlock_ms(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::lock<T0>(&v16))) {
                let (v27, v28, v29) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::forfeit_half(&mut v25);
                v24 = v27;
                arg1.pending_dividends = arg1.pending_dividends + v28;
                0x2::balance::join<T1>(&mut arg1.treasury, 0x2::balance::split<T1>(&mut arg1.dividends, v29));
            } else {
                v24 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::take(&mut v25);
            };
        } else {
            if (v22 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::destroy<T0>(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::split<T0>(&mut v16, v22, arg4), 0x2::object::id<Pool<T0, T1>>(arg1)), arg4), v1);
            };
            if (arg1.sniper_tax) {
                0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::take(&mut arg1.log, v1, v20);
            };
        };
        let v30 = 0x1::u64::min(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::sell(&mut arg1.id, v9, v18, v20), v19);
        if (v19 > v30) {
            0x2::balance::join<T1>(&mut arg1.cash, 0x2::balance::split<T1>(&mut v15, v19 - v30));
        };
        0x2::balance::join<T0>(&mut arg1.meme, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::destroy<T0>(v16, 0x2::object::id<Pool<T0, T1>>(arg1)));
        let v31 = 0x1::u64::min(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div_ceil(v30, v14, 10000), v30);
        route_fee<T0, T1>(arg1, arg2, 0x2::balance::split<T1>(&mut v15, v31));
        let v32 = 0x2::balance::value<T1>(&v15);
        assert!((v32 as u128) * (v4 as u128) >= (v5 as u128) * (v20 as u128), 4);
        if (v24 > 0) {
            0x2::balance::join<T1>(&mut v15, 0x2::balance::split<T1>(&mut arg1.dividends, v24));
        };
        arg1.last_trade_ms = v23;
        record_volume<T0, T1>(arg1, v32, v23);
        let v33 = Swap{
            pool         : v0,
            trader       : v1,
            buy          : false,
            input        : v20,
            output       : v32,
            fee          : v31,
            meme_reserve : 0x2::balance::value<T0>(&arg1.meme),
            nav          : v18 - v30,
            depth        : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::depth(&arg1.id, v18 - v30),
            returned     : v22,
            timestamp_ms : v23,
        };
        0x2::event::emit<Swap>(v33);
        0x2::coin::from_balance<T1>(v15, arg4)
    }

    public fun finish_sell_to_move<T0, T1>(arg0: Sell<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, MoveTicket<T0, T1>) {
        let v0 = finish_sell<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v1 = MoveTicket<T0, T1>{
            from   : 0x2::object::id<Pool<T0, T1>>(arg1),
            seller : 0x2::tx_context::sender(arg4),
            amount : 0x2::coin::value<T1>(&v0),
        };
        (v0, v1)
    }

    public fun fund_epoch<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        assert!(v0 >= arg0.epoch_ms + 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::epoch_ms(&v1), 11);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::fund(&mut arg0.ledger, arg0.pending_dividends, v0);
        arg0.pending_dividends = arg0.pending_dividends - v2;
        arg0.epoch_ms = v0;
        let v3 = EpochFunded{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount       : v2,
            pending      : arg0.pending_dividends,
            timestamp_ms : v0,
        };
        0x2::event::emit<EpochFunded>(v3);
    }

    public fun has_dex_reserve<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        let v0 = DexReserveKey{dummy_field: false};
        0x2::dynamic_field::exists<DexReserveKey>(&arg0.id, v0)
    }

    public fun hibernate<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        let v0 = if (arg0.state == 0) {
            let v1 = RetargetKey{dummy_field: false};
            !0x2::dynamic_field::exists<RetargetKey>(&arg0.id, v1)
        } else {
            false
        };
        assert!(v0, 2);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = SleepKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow<SleepKey, Sleep>(&arg0.id, v3);
        let v5 = v4.floor_usd_e6;
        assert!(v5 > 0 && v2 >= v4.since_ms + 259200000, 14);
        let v6 = daily_volume<T0, T1>(arg0, arg2);
        assert!(v6 < v5, 16);
        set_state<T0, T1>(arg0, 2);
        let v7 = Hibernated{
            pool                : 0x2::object::id<Pool<T0, T1>>(arg0),
            daily_volume_usd_e6 : v6,
            by_admin            : false,
            timestamp_ms        : v2,
        };
        0x2::event::emit<Hibernated>(v7);
    }

    public fun hibernate_floor_usd<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = SleepKey{dummy_field: false};
        0x2::dynamic_field::borrow<SleepKey, Sleep>(&arg0.id, v0).floor_usd_e6 / 1000000
    }

    fun keep_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: u64, arg3: u64) {
        let v0 = CetusKey{dummy_field: false};
        0x2::dynamic_object_field::add<CetusKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v0, arg1);
        let v1 = DexSeeded{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            venue      : 1,
            venue_pool : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1),
            position   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1),
            meme       : arg2,
            quote      : arg3,
        };
        0x2::event::emit<DexSeeded>(v1);
    }

    fun kept<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : bool {
        let v0 = RetargetKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<RetargetKey, Pending>(&arg0.id, v0);
        let v2 = LegKey{i: arg1};
        let v3 = 0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v2);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v1.markets)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&v1.markets, v4) == 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(v3) && *0x1::vector::borrow<bool>(&v1.longs, v4) == 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::long<T1>(v3)) {
                v5 = true;
            };
            v4 = v4 + 1;
        };
        v5
    }

    public fun launch<T0, T1>(arg0: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::CurrencyInitializer<T0>, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: vector<0x2::object::ID>, arg9: vector<bool>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: bool, arg14: u64, arg15: bool, arg16: u64, arg17: u8, arg18: u64, arg19: u32, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_buying(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0 && arg4 > 0, 3);
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg0);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::launch_fee_mist(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v1, 3);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v1, arg21), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::platform(arg0));
        };
        let v2 = 0x2::coin::mint<T0>(&mut arg2, arg4, arg21);
        0x2::coin_registry::make_supply_fixed_init<T0>(&mut arg3, arg2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<T0>(arg3, arg21);
        (create<T0, T1>(arg0, arg1, v2, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), arg6)
    }

    public fun launch_choices<T0, T1>(arg0: &Pool<T0, T1>) : (bool, u64, bool) {
        (arg0.sniper_tax, arg0.no_record_free_ms, arg0.staking)
    }

    public fun leg_account<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : 0x2::object::ID {
        let v0 = LegKey{i: arg1};
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::account_id<T1>(0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v0))
    }

    public fun leg_leverage<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : (u64, u64) {
        let v0 = LegKey{i: arg1};
        let v1 = 0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v0);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v1, arg2, arg3);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::oracle_prices<T1>(arg3, arg4, arg5, arg6);
        let (_, _, v5) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::exposure<T1>(v1, arg2, arg3, &v2);
        (v5, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::target_bps<T1>(v1))
    }

    public fun leg_market<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : 0x2::object::ID {
        let v0 = LegKey{i: arg1};
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v0))
    }

    public fun leg_nav<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64) {
        (*0x1::vector::borrow<u64>(&arg0.leg_navs, arg1), *0x1::vector::borrow<u64>(&arg0.leg_nav_ms, arg1))
    }

    public fun leg_oracle<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) : u256 {
        let v0 = LegKey{i: arg1};
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v0)) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 1);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::oracle_prices<T1>(arg2, arg3, arg4, arg5);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::mark(&v1)
    }

    public fun leg_profit_basis<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = LegKey{i: arg1};
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::basis<T1>(0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v0))
    }

    public fun leg_retired<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : bool {
        let v0 = RetiredKey{i: arg1};
        0x2::dynamic_field::exists<RetiredKey>(&arg0.id, v0)
    }

    public fun leg_spec<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (0x2::object::ID, bool, u64, u64, 0x2::object::ID, bool) {
        let v0 = LegKey{i: arg1};
        if (!0x2::dynamic_field::exists<LegKey>(&arg0.id, v0)) {
            let v1 = 0x2::object::id_from_address(@0x0);
            return (v1, false, 0, 0, v1, true)
        };
        let v2 = LegKey{i: arg1};
        let v3 = 0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v2);
        let v4 = RetiredKey{i: arg1};
        (0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(v3), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::long<T1>(v3), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::target_bps<T1>(v3), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::weight_bps<T1>(v3), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::account_id<T1>(v3), 0x2::dynamic_field::exists<RetiredKey>(&arg0.id, v4))
    }

    public fun leg_status<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, u64, u64) {
        let v0 = LegKey{i: arg1};
        let v1 = 0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v0);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v1, arg2, arg3);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::oracle_prices<T1>(arg3, arg4, arg5, arg6);
        let (_, v4, v5) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::exposure<T1>(v1, arg2, arg3, &v2);
        let (v6, v7) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::band_of<T1>(v1);
        (v5, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::target_bps<T1>(v1), v6, v7, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v1, arg2, arg3, &v2), v4, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::profit<T1>(v1, arg2, arg3, &v2))
    }

    public fun legs<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.legs
    }

    fun legs_needed<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        if (arg0.state == 6) {
            0
        } else {
            required_legs<T0, T1>(arg0)
        }
    }

    public fun lock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &mut 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>, arg3: u8, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::pool_id<T0>(arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = unregister<T0, T1>(arg0, 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(arg2), v0);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::upgrade<T0>(arg2, arg3, v0, &v2);
        register_with<T0, T1>(arg0, arg2, v1, v0);
    }

    public fun meme_reserve<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.meme)
    }

    fun mul_frac(arg0: u64, arg1: u128, arg2: u128) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    fun mul_price(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256);
        let v1 = (arg0 as u256) * v0 / 18446744073709551616 * v0 / 18446744073709551616;
        if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    fun no_record_bps<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0.state != 6) {
            arg2
        } else if (arg0.no_record_free_ms > 0 && arg3 >= arg0.created_ms + arg0.no_record_free_ms) {
            arg2
        } else {
            arg1
        }
    }

    fun open_buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Buy<T0, T1> {
        check<T0, T1>(arg0, arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_buying(arg1);
        timely(arg6, arg5);
        let v0 = if (arg0.state == 0) {
            true
        } else if (arg0.state == 6) {
            true
        } else if (arg0.state == 7) {
            true
        } else {
            arg0.state == 2
        };
        assert!(v0, 2);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div_ceil(v1, arg3, 10000);
        assert!(v1 > v2, 3);
        route_fee<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v2, arg7)));
        let v3 = 0x2::coin::value<T1>(&arg2);
        let v4 = 0x2::coin::into_balance<T1>(arg2);
        let v5 = vector[];
        let v6 = if (arg0.state != 0) {
            0
        } else {
            v3 - 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v3, arg0.hot_bps, 10000)
        };
        let v7 = 0;
        let v8 = 0;
        while (v8 < arg0.legs) {
            let v9 = if (v6 == 0) {
                0
            } else if (v8 + 1 == arg0.legs) {
                v6 - v7
            } else {
                let v10 = LegKey{i: v8};
                0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v6, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::weight_bps<T1>(0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v10)), 10000)
            };
            0x1::vector::push_back<u64>(&mut v5, v9);
            v7 = v7 + v9;
            v8 = v8 + 1;
        };
        let v11 = 0x2::balance::value<T1>(&v4) - v6;
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::balance::split<T1>(&mut v4, v11));
        Buy<T0, T1>{
            pool        : 0x2::object::id<Pool<T0, T1>>(arg0),
            buyer       : 0x2::tx_context::sender(arg7),
            input       : v1,
            fee         : v2,
            min_out     : arg4,
            budget      : v4,
            shares      : v5,
            visited     : 0,
            meme_before : 0x2::balance::value<T0>(&arg0.meme),
            cash_before : 0x2::balance::value<T1>(&arg0.cash),
            legs_before : 0,
            added       : v11,
        }
    }

    public fun pay_creator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_version(arg1);
        let v0 = 0x2::balance::value<T1>(&arg0.creator_fees);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.creator_fees, v0), arg2), arg0.creator);
        let v1 = CreatorPaid{
            pool    : 0x2::object::id<Pool<T0, T1>>(arg0),
            creator : arg0.creator,
            amount  : v0,
        };
        0x2::event::emit<CreatorPaid>(v1);
    }

    public fun pending_trade_fees<T0, T1>(arg0: &Pool<T0, T1>) : (bool, u64, u64, u64) {
        let v0 = TradeFeesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TradeFeesKey>(&arg0.id, v0)) {
            return (false, 0, 0, 0)
        };
        let v1 = TradeFeesKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<TradeFeesKey, TradeFees>(&arg0.id, v1);
        if (0x1::option::is_none<PendingFees>(&v2.pending)) {
            return (false, 0, 0, 0)
        };
        let v3 = 0x1::option::borrow<PendingFees>(&v2.pending);
        (true, v3.buy, v3.sell, v3.effective_ms)
    }

    public fun profit_policy<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.auto_release_bps, arg0.creator_cut_bps)
    }

    public fun propose_retarget<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: vector<0x2::object::ID>, arg3: vector<bool>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg7) == arg0.creator, 12);
        assert!(arg0.state == 0 || arg0.state == 6, 2);
        let v0 = RetargetKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<RetargetKey>(&arg0.id, v0), 15);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let (v2, v3) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::retarget_timing(&v1);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        let v5 = LastRetargetKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LastRetargetKey>(&arg0.id, v5)) {
            let v6 = LastRetargetKey{dummy_field: false};
            assert!(v4 >= *0x2::dynamic_field::borrow<LastRetargetKey, u64>(&arg0.id, v6) + v3, 14);
        };
        let v7 = 0x1::vector::length<0x2::object::ID>(&arg2);
        assert!(v7 >= 1 && v7 <= 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::max_legs(&v1), 6);
        let v8 = if (0x1::vector::length<bool>(&arg3) == v7) {
            if (0x1::vector::length<u64>(&arg4) == v7) {
                0x1::vector::length<u64>(&arg5) == v7
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 6);
        let v9 = 0;
        let v10 = &arg5;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(v10)) {
            v9 = v9 + *0x1::vector::borrow<u64>(v10, v11);
            v11 = v11 + 1;
        };
        assert!(v9 == 10000, 6);
        let v12 = 0;
        while (v12 < v7) {
            let v13 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market(arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v12));
            assert!(*0x1::vector::borrow<u64>(&arg4, v12) >= 10000 && *0x1::vector::borrow<u64>(&arg4, v12) <= 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::market_max_leverage_bps(&v13), 6);
            let v14 = 0;
            while (v14 < arg0.legs) {
                let v15 = LegKey{i: v14};
                let v16 = 0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v15);
                if (0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(v16) == *0x1::vector::borrow<0x2::object::ID>(&arg2, v12) && 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::long<T1>(v16) == *0x1::vector::borrow<bool>(&arg3, v12)) {
                    assert!(*0x1::vector::borrow<u64>(&arg4, v12) <= 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::target_bps<T1>(v16) + 10000, 6);
                };
                v14 = v14 + 1;
            };
            v12 = v12 + 1;
        };
        let v17 = v4 + v2;
        let v18 = RetargetProposed{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            markets      : arg2,
            longs        : arg3,
            leverages    : arg4,
            weights      : arg5,
            effective_ms : v17,
        };
        0x2::event::emit<RetargetProposed>(v18);
        let v19 = RetargetKey{dummy_field: false};
        let v20 = Pending{
            markets      : arg2,
            longs        : arg3,
            leverages    : arg4,
            weights      : arg5,
            effective_ms : v17,
        };
        0x2::dynamic_field::add<RetargetKey, Pending>(&mut arg0.id, v19, v20);
    }

    fun record_volume<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = VolumeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<VolumeKey>(&arg0.id, v0)) {
            return
        };
        let v1 = VolumeKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<VolumeKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::State>(&mut arg0.id, v1);
        if (arg2 >= 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::updated_ms(v2)) {
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::record(v2, arg1, arg2);
        };
    }

    public fun refresh_leg<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: u64, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        assert!(arg2 < arg0.legs, 6);
        let v0 = LegKey{i: arg2};
        let v1 = 0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v0);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v1, arg3, arg4);
        if (!0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v1, arg4, arg5, arg6, arg7)) {
            return
        };
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::prices<T1>(v1, arg3, arg4, arg5, arg6, arg7);
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_navs, arg2) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v1, arg3, arg4, &v2);
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_nav_ms, arg2) = 0x2::clock::timestamp_ms(arg7);
    }

    fun register<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>, arg2: u64) {
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::open(&arg0.ledger);
        register_with<T0, T1>(arg0, arg1, v0, arg2);
    }

    fun register_with<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>, arg2: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::Account, arg3: u64) {
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::lots<T0>(arg1);
        let v1 = *0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::lock<T0>(arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::insert_position(&mut arg0.ledger, &v0, &v1, arg3);
        let v2 = Record{
            lots    : v0,
            amount  : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::amount<T0>(arg1),
            lock    : v1,
            account : arg2,
        };
        0x2::table::add<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(arg1), v2);
    }

    fun release<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        check<T0, T1>(arg0, arg1);
        let v0 = if (arg0.state == 0) {
            if (arg2 < arg0.legs) {
                if (arg3 > 0) {
                    arg3 <= 10000
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
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg10);
        if (v2 >= arg0.release_epoch_ms + 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::epoch_ms(&v1)) {
            arg0.release_epoch_ms = v2;
            arg0.released_in_epoch = 0;
        };
        let v3 = LegKey{i: arg2};
        let v4 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v3);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v4, arg5, &arg6);
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v4, &arg6, arg8, arg9, arg10), 13);
        let v5 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::prices<T1>(v4, arg5, &mut arg6, arg8, arg9, arg10);
        let v6 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v4, arg5, &arg6, &v5);
        let v7 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::profit<T1>(v4, arg5, &arg6, &v5);
        let (v8, _) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::release_limits(&v1);
        let v10 = 0x2::balance::value<T1>(&arg0.cash);
        let v11 = 0;
        while (v11 < arg0.legs) {
            let v12 = if (v11 == arg2) {
                v6
            } else {
                *0x1::vector::borrow<u64>(&arg0.leg_navs, v11)
            };
            v10 = v10 + v12;
            v11 = v11 + 1;
        };
        let v13 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v10, v8, 10000);
        let v14 = if (v13 > arg0.released_in_epoch) {
            v13 - arg0.released_in_epoch
        } else {
            0
        };
        let v15 = 0x1::u64::min(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v7, arg3, 10000), v14);
        if (v15 == 0 || v6 == 0) {
            return arg6
        };
        let (v16, v17) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::close_share<T1>(v4, arg5, arg6, arg7, arg8, arg9, &v5, (v15 as u128), (v6 as u128), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::rebalance_slippage_bps(&v1), arg10, arg11);
        arg6 = v16;
        let (v18, _, _) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::unpack<T1>(v17);
        let v21 = v18;
        let v22 = 0x2::coin::value<T1>(&v21);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::keep_basis<T1>(v4, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::basis<T1>(v4), v22, v6));
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_navs, arg2) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v4, arg5, &arg6, &v5);
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_nav_ms, arg2) = v2;
        let v23 = 0x2::coin::into_balance<T1>(v21);
        let v24 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(0x2::balance::value<T1>(&v23), arg0.creator_cut_bps, 10000);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut v23, v24));
        0x2::balance::join<T1>(&mut arg0.buyback, v23);
        arg0.released_in_epoch = arg0.released_in_epoch + v22;
        let v25 = ProfitReleased{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            index      : arg2,
            profit     : v7,
            amount     : v22,
            to_creator : v24,
            to_buyback : 0x2::balance::value<T1>(&v23),
            by_keeper  : arg4,
        };
        0x2::event::emit<ProfitReleased>(v25);
        arg6
    }

    public fun release_profit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: u64, arg3: u64, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        assert!(0x2::tx_context::sender(arg10) == arg0.creator, 12);
        release<T0, T1>(arg0, arg1, arg2, arg3, false, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun required_legs<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0.legs) {
            let v2 = RetiredKey{i: v1};
            if (!0x2::dynamic_field::exists<RetiredKey>(&arg0.id, v2)) {
                v0 = v0 | 1 << (v1 as u8);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun retarget_status<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (bool, u64, bool) {
        let v0 = RetargetKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RetargetKey>(&arg0.id, v0)) {
            return (false, 0, true)
        };
        let v1 = RetargetKey{dummy_field: false};
        let v2 = if (arg1 >= arg0.legs) {
            true
        } else {
            let v3 = RetiredKey{i: arg1};
            if (0x2::dynamic_field::exists<RetiredKey>(&arg0.id, v3)) {
                true
            } else {
                kept<T0, T1>(arg0, arg1)
            }
        };
        (true, 0x2::dynamic_field::borrow<RetargetKey, Pending>(&arg0.id, v1).effective_ms, v2)
    }

    public fun retire_leg<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: u64, arg3: u64, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        check<T0, T1>(arg0, arg1);
        assert!(arg2 < arg0.legs, 2);
        let v0 = RetargetKey{dummy_field: false};
        assert!(arg0.state == 7 || arg0.state == 6 && 0x2::clock::timestamp_ms(arg9) >= 0x2::dynamic_field::borrow<RetargetKey, Pending>(&arg0.id, v0).effective_ms, 2);
        assert!(!kept<T0, T1>(arg0, arg2), 15);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        if (arg0.state == 6) {
            let v2 = LegKey{i: arg2};
            let v3 = 0x2::dynamic_field::remove<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v2);
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(&v3, arg4, &arg5);
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::destroy<T1>(v3, arg4);
            let v4 = RetiredKey{i: arg2};
            0x2::dynamic_field::add<RetiredKey, bool>(&mut arg0.id, v4, true);
            let v5 = LegRetired{
                pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
                index        : arg2,
                market       : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(&v3),
                timestamp_ms : 0x2::clock::timestamp_ms(arg9),
            };
            0x2::event::emit<LegRetired>(v5);
            return arg5
        };
        let v6 = LegKey{i: arg2};
        let v7 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v6);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v7, arg4, &arg5);
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v7, &arg5, arg7, arg8, arg9), 13);
        let v8 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::prices<T1>(v7, arg4, &mut arg5, arg7, arg8, arg9);
        let (_, v10, _) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::exposure<T1>(v7, arg4, &arg5, &v8);
        if (!0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::is_flat<T1>(v7, arg4, &arg5)) {
            let (v12, v13) = if (v10 <= arg3) {
                (1, 1)
            } else {
                ((arg3 as u128), (v10 as u128))
            };
            let (v14, v15) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::close_share<T1>(v7, arg4, arg5, arg6, arg7, arg8, &v8, v12, v13, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::emergency_slippage_bps(&v1), arg9, arg10);
            arg5 = v14;
            let (v16, _, _) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::unpack<T1>(v15);
            0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(v16));
        };
        let v19 = LegKey{i: arg2};
        let v20 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v19);
        if (0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::is_flat<T1>(v20, arg4, &arg5)) {
            0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::take_cash<T1>(v20, arg4, arg6, 18446744073709551615, arg10)));
            if (0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v20, arg4, &arg5, &v8) == 0) {
                let v21 = LegKey{i: arg2};
                let v22 = 0x2::dynamic_field::remove<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v21);
                0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::destroy<T1>(v22, arg4);
                let v23 = RetiredKey{i: arg2};
                0x2::dynamic_field::add<RetiredKey, bool>(&mut arg0.id, v23, true);
                *0x1::vector::borrow_mut<u64>(&mut arg0.leg_navs, arg2) = 0;
                let v24 = LegRetired{
                    pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
                    index        : arg2,
                    market       : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::market<T1>(&v22),
                    timestamp_ms : 0x2::clock::timestamp_ms(arg9),
                };
                0x2::event::emit<LegRetired>(v24);
                return arg5
            };
        };
        let v25 = LegKey{i: arg2};
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_navs, arg2) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v25), arg4, &arg5, &v8);
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_nav_ms, arg2) = 0x2::clock::timestamp_ms(arg9);
        arg5
    }

    public fun return_dex_reserve<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 12);
        let v0 = take_reserve<T0, T1>(arg0);
        let DexReserve {
            meme  : v1,
            quote : v2,
        } = v0;
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T0>(&mut arg0.meme, v4);
        0x2::balance::join<T1>(&mut arg0.cash, v3);
        let v5 = DexReturned{
            pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
            meme  : 0x2::balance::value<T0>(&v4),
            quote : 0x2::balance::value<T1>(&v3),
        };
        0x2::event::emit<DexReturned>(v5);
    }

    fun route_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: 0x2::balance::Balance<T1>) {
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let (_, v2, v3, v4) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::splits(&v0);
        let v5 = 0x2::balance::value<T1>(&arg2);
        let v6 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v5, v2, 10000);
        if (arg0.staking) {
            0x2::balance::join<T1>(&mut arg0.dividends, 0x2::balance::split<T1>(&mut arg2, v6));
            arg0.pending_dividends = arg0.pending_dividends + v6;
        } else {
            0x2::balance::join<T1>(&mut arg0.buyback, 0x2::balance::split<T1>(&mut arg2, v6));
        };
        0x2::balance::join<T1>(&mut arg0.platform, 0x2::balance::split<T1>(&mut arg2, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v5, v3, 10000)));
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut arg2, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div(v5, v4, 10000)));
        0x2::balance::join<T1>(&mut arg0.treasury, arg2);
    }

    public fun seed_cetus_mq<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = take_reserve<T0, T1>(arg0);
        let DexReserve {
            meme  : v1,
            quote : v2,
        } = v0;
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = 0x2::balance::value<T1>(&v3);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(tick_spacing<T0, T1>(arg0));
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, T1>(arg2, arg3, tick_spacing<T0, T1>(arg0), sqrt_price_x64(v5, v6), arg4, v7, v8, 0x2::coin::from_balance<T0>(v4, arg6), 0x2::coin::from_balance<T1>(v3, arg6), true, arg5, arg6);
        0x2::balance::join<T0>(&mut arg0.meme, 0x2::coin::into_balance<T0>(v10));
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(v11));
        keep_position<T0, T1>(arg0, v9, v5, v6);
    }

    public fun seed_cetus_qm<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = take_reserve<T0, T1>(arg0);
        let DexReserve {
            meme  : v1,
            quote : v2,
        } = v0;
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = 0x2::balance::value<T1>(&v3);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(tick_spacing<T0, T1>(arg0));
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T1, T0>(arg2, arg3, tick_spacing<T0, T1>(arg0), sqrt_price_x64(v6, v5), arg4, v7, v8, 0x2::coin::from_balance<T1>(v3, arg6), 0x2::coin::from_balance<T0>(v4, arg6), false, arg5, arg6);
        0x2::balance::join<T0>(&mut arg0.meme, 0x2::coin::into_balance<T0>(v11));
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(v10));
        keep_position<T0, T1>(arg0, v9, v5, v6);
    }

    public fun seed_clmm<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg3: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(dex_venue<T0, T1>(arg0) == 3, 17);
        let v0 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::pool_id<T0, T1>(arg2, clmm_fee_rate<T0, T1>(arg0));
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>>(arg3), 17);
        assert!(clmm_near(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::sqrt_price<T0, T1>(arg3), clmm_open_sqrt_price<T0, T1>(arg0)), 17);
        let v1 = take_reserve<T0, T1>(arg0);
        let DexReserve {
            meme  : v2,
            quote : v3,
        } = v1;
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let (v8, v9) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::full_range(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::tick_spacing<T0, T1>(arg3));
        let v10 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::open_position<T0, T1>(arg2, arg3, v8, v9, arg4);
        let (v11, v12) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::add_liquidity_by_amounts<T0, T1>(arg2, arg3, &mut v10, 0x2::coin::from_balance<T0>(v5, arg4), 0x2::coin::from_balance<T1>(v4, arg4), v6, v7, v6 - v6 / 50, v7 - v7 / 50, arg4);
        0x2::balance::join<T0>(&mut arg0.meme, 0x2::coin::into_balance<T0>(v11));
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(v12));
        let v13 = ClmmKey{dummy_field: false};
        let v14 = ClmmSlot{
            position : v10,
            venue    : 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>>(arg3),
        };
        0x2::dynamic_field::add<ClmmKey, ClmmSlot>(&mut arg0.id, v13, v14);
        let v15 = DexSeeded{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            venue      : 3,
            venue_pool : 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>>(arg3),
            position   : 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position>(&v10),
            meme       : v6,
            quote      : v7,
        };
        0x2::event::emit<DexSeeded>(v15);
    }

    public fun seed_dlmm<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg3: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(dex_venue<T0, T1>(arg0) == 2, 17);
        let v0 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::pool_id<T0, T1>(arg2, dlmm_bin_step<T0, T1>(arg0));
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>>(arg3), 17);
        let v1 = dlmm_open_id<T0, T1>(arg0);
        let v2 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::active_id<T0, T1>(arg3);
        assert!(v2 + 1 >= v1 && v2 <= v1 + 1, 17);
        let v3 = take_reserve<T0, T1>(arg0);
        let DexReserve {
            meme  : v4,
            quote : v5,
        } = v3;
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::balance::value<T0>(&v7);
        let v9 = 0x2::balance::value<T1>(&v6);
        let v10 = 10;
        let v11 = v2 - v10;
        let v12 = 2 * v10 + 1;
        let v13 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::open_position<T0, T1>(arg2, arg3, v11, v12, arg4);
        let v14 = (v10 as u64) * 2 + 1;
        let v15 = v9 * 2 / v14;
        let v16 = v8 * 2 / v14;
        let v17 = vector[];
        let v18 = vector[];
        let v19 = 0;
        while (v19 < v12) {
            if (v19 < v10) {
                0x1::vector::push_back<u64>(&mut v17, 0);
                0x1::vector::push_back<u64>(&mut v18, v15);
            } else if (v19 == v10) {
                0x1::vector::push_back<u64>(&mut v17, v16 / 2);
                0x1::vector::push_back<u64>(&mut v18, v15 / 2);
            } else {
                0x1::vector::push_back<u64>(&mut v17, v16);
                0x1::vector::push_back<u64>(&mut v18, 0);
            };
            v19 = v19 + 1;
        };
        let (v20, v21) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::add_liquidity<T0, T1>(arg2, arg3, &mut v13, 0x2::coin::from_balance<T0>(v7, arg4), 0x2::coin::from_balance<T1>(v6, arg4), v17, v18, v2, v2, v16 / 50 + 1, v15 / 50 + 1, arg4);
        0x2::balance::join<T0>(&mut arg0.meme, 0x2::coin::into_balance<T0>(v20));
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(v21));
        let v22 = DlmmKey{dummy_field: false};
        let v23 = DlmmSlot{
            position : v13,
            venue    : 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>>(arg3),
            lower    : v11,
            width    : v12,
        };
        0x2::dynamic_field::add<DlmmKey, DlmmSlot>(&mut arg0.id, v22, v23);
        let v24 = DexSeeded{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            venue      : 2,
            venue_pool : 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool::Pool<T0, T1>>(arg3),
            position   : 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position>(&v13),
            meme       : v8,
            quote      : v9,
        };
        0x2::event::emit<DexSeeded>(v24);
    }

    public fun sell_fee_preview<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let (v1, v2, v3) = exit_fees_of<T0, T1>(arg0, &v0);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        if (!sniper_applies<T0, T1>(arg0)) {
            return 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div_ceil(arg3, v2, 10000)
        };
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::preview(&arg0.log, arg2, arg3, v4, v1, v2, v3, no_record_bps<T0, T1>(arg0, v1, v2, v4))
    }

    public fun sell_leg<T0, T1>(arg0: &mut Sell<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg3: u64, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_version(arg2);
        assert!(arg0.pool == 0x2::object::id<Pool<T0, T1>>(arg1) && arg3 < arg1.legs, 1);
        let v0 = 1 << (arg3 as u8);
        assert!(arg0.visited & v0 == 0, 7);
        arg0.visited = arg0.visited | v0;
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let v3 = LegKey{i: arg3};
        let v4 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg1.id, v3);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v4, arg4, &arg5);
        if (!0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v4, &arg5, arg7, arg8, arg9)) {
            let v5 = *0x1::vector::borrow<u64>(&arg1.leg_navs, arg3);
            arg0.legs_before = arg0.legs_before + v5;
            arg0.requested = arg0.requested + mul_frac(v5 - 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::mul_div_ceil(v5, 200, 10000), arg0.num, arg0.den);
            let v6 = LegTouched{
                pool         : arg0.pool,
                index        : arg3,
                nav          : v5,
                skipped      : true,
                timestamp_ms : v2,
            };
            0x2::event::emit<LegTouched>(v6);
            return arg5
        };
        let v7 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::prices<T1>(v4, arg4, &mut arg5, arg7, arg8, arg9);
        let v8 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v4, arg4, &arg5, &v7);
        arg0.legs_before = arg0.legs_before + v8;
        arg0.requested = arg0.requested + mul_frac(v8, arg0.num, arg0.den);
        if (v8 > 0) {
            let (v9, v10) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::close_share<T1>(v4, arg4, arg5, arg6, arg7, arg8, &v7, arg0.num, arg0.den, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::rebalance_slippage_bps(&v1), arg9, arg10);
            arg5 = v9;
            let (v11, _, _) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::unpack<T1>(v10);
            0x2::balance::join<T1>(&mut arg0.funds, 0x2::coin::into_balance<T1>(v11));
        };
        let v14 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(v4, arg4, &arg5, &v7);
        *0x1::vector::borrow_mut<u64>(&mut arg1.leg_navs, arg3) = v14;
        *0x1::vector::borrow_mut<u64>(&mut arg1.leg_nav_ms, arg3) = v2;
        let v15 = LegTouched{
            pool         : arg0.pool,
            index        : arg3,
            nav          : v14,
            skipped      : false,
            timestamp_ms : v2,
        };
        0x2::event::emit<LegTouched>(v15);
        arg5
    }

    public fun set_creator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator && arg2 != @0x0, 12);
        arg0.creator = arg2;
    }

    public fun set_profit_policy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 12);
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let (_, v2) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::release_limits(&v0);
        assert!(arg2 <= 5000 && arg3 <= v2, 3);
        arg0.auto_release_bps = arg2;
        arg0.creator_cut_bps = arg3;
        let v3 = ProfitPolicy{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            auto_release_bps : arg2,
            creator_cut_bps  : arg3,
        };
        0x2::event::emit<ProfitPolicy>(v3);
    }

    fun set_state<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u8) {
        if (arg0.state == arg1) {
            return
        };
        let v0 = StateChanged{
            pool : 0x2::object::id<Pool<T0, T1>>(arg0),
            from : arg0.state,
            to   : arg1,
        };
        0x2::event::emit<StateChanged>(v0);
        arg0.state = arg1;
    }

    public fun set_trade_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg5) == arg0.creator, 12);
        assert!(arg2 <= 500 && arg3 <= 500, 18);
        let (v0, v1) = trade_fees<T0, T1>(arg0);
        let v2 = TradedKey{dummy_field: false};
        let v3 = !0x2::dynamic_field::exists<TradedKey>(&arg0.id, v2) || arg2 <= v0 && arg3 <= v1;
        let v4 = TradeFeesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TradeFeesKey>(&arg0.id, v4)) {
            let v5 = TradeFeesKey{dummy_field: false};
            let v6 = TradeFees{
                buy     : v0,
                sell    : v1,
                pending : 0x1::option::none<PendingFees>(),
            };
            0x2::dynamic_field::add<TradeFeesKey, TradeFees>(&mut arg0.id, v5, v6);
        };
        let v7 = TradeFeesKey{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<TradeFeesKey, TradeFees>(&mut arg0.id, v7);
        if (v3) {
            v8.buy = arg2;
            v8.sell = arg3;
            v8.pending = 0x1::option::none<PendingFees>();
            let v9 = TradeFeesChanged{
                pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
                buy_bps  : arg2,
                sell_bps : arg3,
            };
            0x2::event::emit<TradeFeesChanged>(v9);
        } else {
            let v10 = 0x2::clock::timestamp_ms(arg4) + 172800000;
            let v11 = PendingFees{
                buy          : arg2,
                sell         : arg3,
                effective_ms : v10,
            };
            v8.pending = 0x1::option::some<PendingFees>(v11);
            let v12 = TradeFeesProposed{
                pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
                buy_bps      : arg2,
                sell_bps     : arg3,
                effective_ms : v10,
            };
            0x2::event::emit<TradeFeesProposed>(v12);
        };
    }

    fun settle_dex_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        route_fee<T0, T1>(arg0, arg1, arg3);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg2, arg4), @0x0);
        } else {
            0x2::balance::destroy_zero<T0>(arg2);
        };
        let v1 = DexFeesCollected{
            pool        : 0x2::object::id<Pool<T0, T1>>(arg0),
            quote       : 0x2::balance::value<T1>(&arg3),
            meme_burned : v0,
        };
        0x2::event::emit<DexFeesCollected>(v1);
    }

    public fun share<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    fun sniper_applies<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.sniper_tax && (arg0.state == 6 || !exit_window<T0, T1>(arg0))
    }

    fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 17);
        let v0 = ((arg1 as u256) << 128) / (arg0 as u256);
        let v1 = (v0 + 1) / 2;
        while (v1 < v0) {
            let v2 = v1 + v0 / v1;
            v1 = v2 / 2;
        };
        assert!(v0 <= 340282366920938463463374607431768211455, 17);
        (v0 as u128)
    }

    public fun stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0> {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.staking, 10);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x1::vector::empty<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Lot>();
        let v3 = 0;
        if (arg0.sniper_tax) {
            let v4 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::take(&mut arg0.log, 0x2::tx_context::sender(arg5), v0);
            let v5 = &v4;
            let v6 = 0;
            while (v6 < 0x1::vector::length<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::Entry>(v5)) {
                let v7 = 0x1::vector::borrow<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::Entry>(v5, v6);
                0x1::vector::push_back<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Lot>(&mut v2, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::new_lot(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::amount(v7), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::at_ms(v7)));
                v3 = v3 + 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::amount(v7);
                v6 = v6 + 1;
            };
        };
        if (v0 > v3) {
            let v8 = if (arg0.sniper_tax) {
                v1
            } else {
                0
            };
            0x1::vector::push_back<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Lot>(&mut v2, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::new_lot(v0 - v3, v8));
        };
        let v9 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::from_lots<T0>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::coin::into_balance<T0>(arg2), v2, arg5);
        if (arg3 > 0) {
            let v10 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::upgrade<T0>(&mut v9, arg3, v1, &v10);
        };
        register<T0, T1>(arg0, &v9, v1);
        let v11 = Staked{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            stake  : 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(&v9),
            owner  : 0x2::tx_context::sender(arg5),
            amount : v0,
            tier   : arg3,
        };
        0x2::event::emit<Staked>(v11);
        v9
    }

    fun start_sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : Sell<T0, T1> {
        let v0 = 0x2::balance::value<T0>(&arg0.meme);
        let (v1, v2) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::curve::sell_fraction(&arg0.id, v0, arg3);
        assert!(v1 > 0 && v1 <= v2, 3);
        let v3 = 0x2::balance::value<T1>(&arg0.cash);
        let v4 = mul_frac(v3, v1, v2);
        Sell<T0, T1>{
            pool        : 0x2::object::id<Pool<T0, T1>>(arg0),
            seller      : 0x2::tx_context::sender(arg6),
            coins       : arg2,
            pos         : arg1,
            input       : arg3,
            min_out     : arg4,
            num         : v1,
            den         : v2,
            visited     : 0,
            meme_before : v0,
            cash_before : v3,
            legs_before : 0,
            requested   : v4,
            funds       : 0x2::balance::split<T1>(&mut arg0.cash, v4),
            fee_bps     : arg5,
        }
    }

    fun start_volume<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        let v0 = VolumeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<VolumeKey>(&arg0.id, v0)) {
            let v1 = VolumeKey{dummy_field: false};
            0x2::dynamic_field::remove<VolumeKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::State>(&mut arg0.id, v1);
        };
        let v2 = VolumeKey{dummy_field: false};
        0x2::dynamic_field::add<VolumeKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::State>(&mut arg0.id, v2, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::volume_ema::new(arg1, 604800000));
        let v3 = SleepKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<SleepKey, Sleep>(&mut arg0.id, v3).since_ms = arg1;
    }

    public fun state<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.state
    }

    public fun sweep_leg<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: u64, arg3: u64, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.state == 2 && arg2 < arg0.legs, 2);
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::params(arg1);
        let v1 = LegKey{i: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::check<T1>(v2, arg4, &arg5);
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::tradable<T1>(v2, &arg5, arg7, arg8, arg9), 13);
        let v3 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::prices<T1>(v2, arg4, &mut arg5, arg7, arg8, arg9);
        let (_, v5, _) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::exposure<T1>(v2, arg4, &arg5, &v3);
        if (!0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::is_flat<T1>(v2, arg4, &arg5)) {
            let (v7, v8) = if (v5 <= arg3) {
                (1, 1)
            } else {
                ((arg3 as u128), (v5 as u128))
            };
            let (v9, v10) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::close_share<T1>(v2, arg4, arg5, arg6, arg7, arg8, &v3, v7, v8, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::rebalance_slippage_bps(&v0), arg9, arg10);
            arg5 = v9;
            let (v11, _, _) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::unpack<T1>(v10);
            0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(v11));
        };
        let v14 = LegKey{i: arg2};
        let v15 = 0x2::dynamic_field::borrow_mut<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&mut arg0.id, v14);
        if (0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::is_flat<T1>(v15, arg4, &arg5)) {
            0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::take_cash<T1>(v15, arg4, arg6, 18446744073709551615, arg10)));
        };
        let v16 = LegKey{i: arg2};
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_navs, arg2) = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::nav<T1>(0x2::dynamic_field::borrow<LegKey, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg::Leg<T1>>(&arg0.id, v16), arg4, &arg5, &v3);
        *0x1::vector::borrow_mut<u64>(&mut arg0.leg_nav_ms, arg2) = 0x2::clock::timestamp_ms(arg9);
        arg5
    }

    fun take_reserve<T0, T1>(arg0: &mut Pool<T0, T1>) : DexReserve<T0, T1> {
        let v0 = DexReserveKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<DexReserveKey>(&arg0.id, v0), 17);
        let v1 = DexReserveKey{dummy_field: false};
        0x2::dynamic_field::remove<DexReserveKey, DexReserve<T0, T1>>(&mut arg0.id, v1)
    }

    fun timely(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1 && arg1 - v0 <= 120000, 5);
    }

    public fun trade_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        let v0 = TradeFeesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TradeFeesKey>(&arg0.id, v0)) {
            return (100, 100)
        };
        let v1 = TradeFeesKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<TradeFeesKey, TradeFees>(&arg0.id, v1);
        (v2.buy, v2.sell)
    }

    fun unregister<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: u64) : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::Account {
        let Record {
            lots    : v0,
            amount  : _,
            lock    : v2,
            account : v3,
        } = 0x2::table::remove<0x2::object::ID, Record>(&mut arg0.records, arg1);
        let v4 = v3;
        let v5 = v2;
        let v6 = v0;
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::settle(&arg0.ledger, &mut v4, &v6, &v5);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::remove_position(&mut arg0.ledger, &v6, &v5, arg2);
        v4
    }

    public fun unstake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::assert_version(arg1);
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::pool_id<T0>(&arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(exit_window<T0, T1>(arg0) || v0 >= 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::locks::unlock_ms(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::lock<T0>(&arg2)), 9);
        let v1 = 0x2::object::id<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Position<T0>>(&arg2);
        let v2 = unregister<T0, T1>(arg0, v1, v0);
        let v3 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::conviction::take(&mut v2);
        let v4 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::lots<T0>(&arg2);
        if (arg0.sniper_tax) {
            let v5 = 0x1::vector::empty<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::Entry>();
            let v6 = &v4;
            let v7 = 0;
            while (v7 < 0x1::vector::length<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Lot>(v6)) {
                let v8 = 0x1::vector::borrow<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::Lot>(v6, v7);
                0x1::vector::push_back<0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::Entry>(&mut v5, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::entry(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::lot_amount(v8), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::lot_entry(v8)));
                v7 = v7 + 1;
            };
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog::restore(&mut arg0.log, 0x2::tx_context::sender(arg4), v5);
        };
        let v9 = Unstaked{
            pool      : 0x2::object::id<Pool<T0, T1>>(arg0),
            stake     : v1,
            owner     : 0x2::tx_context::sender(arg4),
            amount    : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::amount<T0>(&arg2),
            dividends : v3,
        };
        0x2::event::emit<Unstaked>(v9);
        (0x2::coin::from_balance<T0>(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::position::destroy<T0>(arg2, 0x2::object::id<Pool<T0, T1>>(arg0)), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.dividends, v3), arg4))
    }

    public fun upkeep_times<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (arg0.pending_dividends, arg0.epoch_ms, arg0.last_buyback_ms)
    }

    public fun veto_retarget<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::AdminCap) {
        check<T0, T1>(arg0, arg1);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::authorize(arg1, arg2);
        assert!(arg0.state != 7, 2);
        let v0 = RetargetKey{dummy_field: false};
        0x2::dynamic_field::remove<RetargetKey, Pending>(&mut arg0.id, v0);
        let v1 = RetargetCancelled{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            by_admin : true,
        };
        0x2::event::emit<RetargetCancelled>(v1);
    }

    public fun wake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.state == 2, 2);
        let v0 = SleepKey{dummy_field: false};
        let v1 = daily_volume<T0, T1>(arg0, arg2);
        assert!(v1 >= 0x2::dynamic_field::borrow<SleepKey, Sleep>(&arg0.id, v0).floor_usd_e6 * 2, 16);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        set_state<T0, T1>(arg0, 0);
        start_volume<T0, T1>(arg0, v2);
        let v3 = Woke{
            pool                : 0x2::object::id<Pool<T0, T1>>(arg0),
            daily_volume_usd_e6 : v1,
            by_admin            : false,
            timestamp_ms        : v2,
        };
        0x2::event::emit<Woke>(v3);
    }

    // decompiled from Move bytecode v7
}

