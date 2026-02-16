module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry {
    struct MarketRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u16,
        min_bet: u64,
        max_bet: u64,
        min_pool: u64,
        claim_window_ms: u64,
        paused: bool,
        supported_feeds: 0x2::table::Table<0x1::string::String, vector<u8>>,
        treasury: 0x2::balance::Balance<T0>,
        market_count: u64,
    }

    public fun deposit_fee_bps<T0>(arg0: &MarketRegistry<T0>) : u16 {
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::deposit_fee_bps(&arg0.id)
    }

    public fun collect_fees<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::collect_fees<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_fees_collected(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg1), v1);
        };
        0x2::balance::join<T0>(&mut arg0.treasury, v0);
    }

    public fun admin_add_feed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(!0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 24);
        0x2::table::add<0x1::string::String, vector<u8>>(&mut arg0.supported_feeds, arg2, arg3);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_feed_added(arg2, arg3);
    }

    public fun admin_collect_fees<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg2: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        collect_fees<T0>(arg0, arg1, arg3);
    }

    public fun admin_migrate<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.version;
        assert!(v0 < 3, 2);
        if (v0 < 2) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::init_deposit_fee(&mut arg0.id, 200);
            arg0.fee_bps = 300;
        };
        if (v0 < 3) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::init_cutoff_config(&mut arg0.id);
        };
        arg0.version = 3;
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_migrated(v0, 3);
    }

    public fun admin_pause<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        arg0.paused = true;
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_paused();
    }

    public fun admin_remove_feed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 25);
        0x2::table::remove<0x1::string::String, vector<u8>>(&mut arg0.supported_feeds, arg2);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_feed_removed(arg2);
    }

    public fun admin_sweep_unclaimed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg2: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::resolved<T0>(arg1) || 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::voided<T0>(arg1), 16);
        let v0 = if (0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::resolved<T0>(arg1)) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::resolved_at<T0>(arg1) + arg0.claim_window_ms
        } else {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::deadline<T0>(arg1) + arg0.claim_window_ms
        };
        assert!(0x2::clock::timestamp_ms(arg3) >= v0, 21);
        let v1 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::sweep_remaining<T0>(arg1);
        let v2 = 0x2::balance::value<T0>(&v1);
        0x2::balance::join<T0>(&mut arg0.treasury, v1);
        if (v2 > 0) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_unclaimed_swept(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg1), v2);
        };
    }

    public fun admin_unpause<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        arg0.paused = false;
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_unpaused();
    }

    public fun admin_update_cutoff<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(arg2 <= 4, 4);
        assert!(0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry_inner::validate_cutoff(arg3), 33);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::set_cutoff(&mut arg0.id, arg2, arg3);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_cutoff_updated(arg2, arg3);
    }

    public fun admin_update_deposit_fee<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry_inner::validate_deposit_fee(arg2), 6);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::set_deposit_fee(&mut arg0.id, arg2);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_deposit_fee_updated(arg2);
    }

    public fun admin_update_fee<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry_inner::validate_fee(arg2), 6);
        arg0.fee_bps = arg2;
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_fee_updated(arg2);
    }

    public fun admin_update_limits<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(arg2 > 0, 15);
        assert!(arg3 >= arg2, 15);
        assert!(arg4 > 0, 15);
        arg0.min_bet = arg2;
        arg0.max_bet = arg3;
        arg0.min_pool = arg4;
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_limits_updated(arg2, arg3, arg4);
    }

    public fun admin_void<T0>(arg0: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::resolved<T0>(arg0), 8);
        assert!(!0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::voided<T0>(arg0), 9);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::mark_voided<T0>(arg0);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_market_voided(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg0), arg2);
    }

    public fun admin_withdraw_treasury<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 3, 1);
        assert!(0x2::balance::value<T0>(&arg0.treasury) >= arg2, 15);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_treasury_withdrawn(arg2, 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, arg2), arg3)
    }

    public fun claim<T0>(arg0: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::execute_claim<T0>(arg0, 0x2::tx_context::sender(arg1));
        let v2 = v1;
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_claimed(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg1), v0, 0x2::balance::value<T0>(&v2));
        0x2::coin::from_balance<T0>(v2, arg1)
    }

    public(friend) fun create_and_share<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry<T0>{
            id              : 0x2::object::new(arg0),
            version         : 3,
            fee_bps         : 300,
            min_bet         : 1000000,
            max_bet         : 5000000,
            min_pool        : 2000000,
            claim_window_ms : 2592000000,
            paused          : false,
            supported_feeds : 0x2::table::new<0x1::string::String, vector<u8>>(arg0),
            treasury        : 0x2::balance::zero<T0>(),
            market_count    : 0,
        };
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::init_deposit_fee(&mut v0.id, 0);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::init_cutoff_config(&mut v0.id);
        0x2::transfer::share_object<MarketRegistry<T0>>(v0);
    }

    public fun create_market<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(!arg0.paused, 0);
        assert!(arg4 <= 4, 4);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 3);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg5 > v0, 5);
        let v1 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry_inner::calculate_trading_cutoff(&arg0.id, arg5, arg4);
        let v2 = arg0.market_count;
        let v3 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::new<T0>(v2, *0x2::table::borrow<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), arg2, arg3, arg4, arg5, v1, v0, arg0.fee_bps, arg7);
        arg0.market_count = arg0.market_count + 1;
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_market_created(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(&v3), v2, arg2, arg3, arg4, arg5, v1);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::share<T0>(v3);
    }

    public fun create_registry<T0>(arg0: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_share<T0>(arg1);
    }

    public fun deposit<T0>(arg0: &MarketRegistry<T0>, arg1: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 1);
        assert!(!arg0.paused, 0);
        assert!(arg3 <= 1, 7);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg0.min_bet, 13);
        assert!(v0 <= arg0.max_bet, 14);
        assert!(0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::is_trading_open<T0>(arg1, 0x2::clock::timestamp_ms(arg4)), 11);
        let (v1, v2) = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::execute_deposit<T0>(arg1, 0x2::coin::into_balance<T0>(arg2), arg3, 0x2::tx_context::sender(arg5), 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::deposit_fee_bps(&arg0.id));
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_deposited(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg1), 0x2::tx_context::sender(arg5), arg3, v0, v1, v2, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::yes_deposits<T0>(arg1), 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::no_deposits<T0>(arg1));
    }

    public fun fee_bps<T0>(arg0: &MarketRegistry<T0>) : u16 {
        arg0.fee_bps
    }

    public fun market_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.market_count
    }

    public fun max_bet<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.max_bet
    }

    public fun min_bet<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.min_bet
    }

    public fun min_pool<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.min_pool
    }

    public fun paused<T0>(arg0: &MarketRegistry<T0>) : bool {
        arg0.paused
    }

    public fun refund<T0>(arg0: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::execute_refund<T0>(arg0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_refunded(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg1), v1);
        };
        0x2::coin::from_balance<T0>(v0, arg1)
    }

    public fun resolve<T0>(arg0: &MarketRegistry<T0>, arg1: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::resolved<T0>(arg1), 8);
        assert!(!0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::voided<T0>(arg1), 9);
        assert!(0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::is_resolvable<T0>(arg1, 0x2::clock::timestamp_ms(arg3)), 12);
        if (0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::should_void<T0>(arg1, arg0.min_pool)) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::mark_voided<T0>(arg1);
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_market_voided(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg1), 0x1::string::utf8(b"auto-void: insufficient or one-sided liquidity"));
            return
        };
        let (v0, _) = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::price::read_price(arg2, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::pyth_feed_id<T0>(arg1), arg3);
        let v2 = if (v0 >= 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::target_price<T0>(arg1)) {
            1
        } else {
            2
        };
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events::emit_market_resolved(0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg1), v2, v0, 0x2::tx_context::sender(arg4), 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::yes_deposits<T0>(arg1), 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::no_deposits<T0>(arg1), 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::execute_resolve<T0>(arg1, v2, v0, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3)));
    }

    public(friend) fun split_treasury<T0>(arg0: &mut MarketRegistry<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.treasury, arg1)
    }

    public fun treasury_balance<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun version<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

