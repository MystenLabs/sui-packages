module 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::registry {
    struct MarketRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u16,
        min_liquidity: u64,
        redemption_deadline_ms: u64,
        paused: bool,
        supported_feeds: 0x2::table::Table<0x1::string::String, vector<u8>>,
        treasury: 0x2::balance::Balance<T0>,
        market_count: u64,
    }

    public fun fee_bps<T0>(arg0: &MarketRegistry<T0>) : u16 {
        arg0.fee_bps
    }

    public fun admin_add_feed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 24);
        assert!(!0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 20);
        0x2::table::add<0x1::string::String, vector<u8>>(&mut arg0.supported_feeds, arg2, arg3);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_feed_added(arg2, arg3);
    }

    public fun admin_collect_fees<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::collect_fees<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_fees_collected(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), v1);
        };
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun admin_migrate<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.version;
        assert!(v0 < 3, 27);
        arg0.version = 3;
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_migrated(v0, 3);
    }

    public fun admin_pause<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 24);
        arg0.paused = true;
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_paused();
    }

    public fun admin_remove_feed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 24);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 21);
        0x2::table::remove<0x1::string::String, vector<u8>>(&mut arg0.supported_feeds, arg2);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_feed_removed(arg2);
    }

    public fun admin_sweep_unclaimed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg2: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 24);
        assert!(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::resolved<T0>(arg1) || 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::voided<T0>(arg1), 13);
        let v0 = if (0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::resolved<T0>(arg1)) {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::resolved_at<T0>(arg1) + arg0.redemption_deadline_ms
        } else {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::deadline<T0>(arg1) + arg0.redemption_deadline_ms
        };
        assert!(0x2::clock::timestamp_ms(arg3) >= v0, 19);
        let v1 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::sweep_remaining<T0>(arg1);
        let v2 = 0x2::balance::value<T0>(&v1);
        0x2::balance::join<T0>(&mut arg0.treasury, v1);
        if (v2 > 0) {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_unclaimed_swept(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg1), v2);
        };
    }

    public fun admin_unpause<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 24);
        arg0.paused = false;
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_unpaused();
    }

    public fun admin_update_fee<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 24);
        assert!(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::registry_inner::validate_fee(arg2), 22);
        arg0.fee_bps = arg2;
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_fee_updated(arg2);
    }

    public fun admin_void<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::resolved<T0>(arg0), 3);
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::voided<T0>(arg0), 4);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::mark_voided<T0>(arg0);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_market_voided(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), arg2);
    }

    public fun admin_withdraw_pool<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::withdraw_pool<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_pool_withdrawn(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg2), v1);
        };
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun admin_withdraw_treasury<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 3, 24);
        assert!(0x2::balance::value<T0>(&arg0.treasury) >= arg2, 23);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_treasury_withdrawn(arg2, 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, arg2), arg3)
    }

    public fun buy_shares<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: &MarketRegistry<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 3, 24);
        assert!(!arg1.paused, 0);
        assert!(arg3 <= 1, 26);
        assert!(0x2::coin::value<T0>(&arg2) >= 1000000, 17);
        assert!(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::is_trading_open<T0>(arg0, 0x2::clock::timestamp_ms(arg5)), 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::add_fees<T0>(arg0, 0x2::balance::split<T0>(&mut v1, (((v0 as u128) * (0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::fee_bps<T0>(arg0) as u128) / 10000) as u64)));
        let v2 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::execute_buy<T0>(arg0, v1, arg3, 0x2::tx_context::sender(arg6), v0, arg6);
        assert!(v2 >= arg4, 9);
        let (v3, v4) = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::registry_inner::compute_prices(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::yes_reserves<T0>(arg0), 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::no_reserves<T0>(arg0));
        let v5 = if (v2 > 0) {
            (((v0 as u128) * 1000000 / (v2 as u128)) as u64)
        } else {
            0
        };
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_shares_bought(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg6), arg3, v0, v2, v5, v3, v4, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::yes_reserves<T0>(arg0), 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::no_reserves<T0>(arg0));
    }

    public(friend) fun create_and_share<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry<T0>{
            id                     : 0x2::object::new(arg0),
            version                : 3,
            fee_bps                : 200,
            min_liquidity          : 100000000,
            redemption_deadline_ms : 2592000000,
            paused                 : false,
            supported_feeds        : 0x2::table::new<0x1::string::String, vector<u8>>(arg0),
            treasury               : 0x2::balance::zero<T0>(),
            market_count           : 0,
        };
        0x2::transfer::share_object<MarketRegistry<T0>>(v0);
    }

    public fun create_market<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 24);
        assert!(!arg0.paused, 0);
        assert!(arg4 <= 4, 6);
        assert!(0x2::coin::value<T0>(&arg6) >= arg0.min_liquidity, 8);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 5);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg5 > v0, 7);
        let v1 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::registry_inner::calculate_trading_cutoff(arg5, arg4);
        let v2 = arg0.market_count;
        let v3 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::new<T0>(v2, *0x2::table::borrow<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), arg2, arg3, arg4, arg5, v1, v0, arg0.fee_bps, 0x2::coin::into_balance<T0>(arg6), arg8);
        arg0.market_count = arg0.market_count + 1;
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_market_created(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(&v3), v2, arg2, arg3, arg4, arg5, v1, 0x2::coin::value<T0>(&arg6));
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::share<T0>(v3);
    }

    public fun create_registry<T0>(arg0: &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_share<T0>(arg1);
    }

    public fun market_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.market_count
    }

    public fun merge_shares<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::voided<T0>(arg0), 4);
        assert!(arg1 > 0, 17);
        let v0 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::execute_merge<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_shares_merged(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg2), arg1, 0x2::balance::value<T0>(&v0));
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun mint_shares<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::resolved<T0>(arg0), 3);
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::voided<T0>(arg0), 4);
        assert!(0x2::clock::timestamp_ms(arg2) < 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::trading_cutoff<T0>(arg0), 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 17);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::execute_mint<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::tx_context::sender(arg3), arg3);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_shares_minted(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg3), v0);
    }

    public fun paused<T0>(arg0: &MarketRegistry<T0>) : bool {
        arg0.paused
    }

    public fun redeem<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::execute_redeem<T0>(arg0, 0x2::tx_context::sender(arg1));
        let v2 = v1;
        if (v0 > 0) {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_shares_redeemed(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg1), v0, 0x2::balance::value<T0>(&v2));
        };
        0x2::coin::from_balance<T0>(v2, arg1)
    }

    public fun refund<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::execute_refund<T0>(arg0, 0x2::tx_context::sender(arg1));
        let v2 = v1;
        if (v0 > 0) {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_shares_refunded(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg1), v0, 0x2::balance::value<T0>(&v2));
        };
        0x2::coin::from_balance<T0>(v2, arg1)
    }

    public fun resolve<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::resolved<T0>(arg0), 3);
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::voided<T0>(arg0), 4);
        assert!(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::is_resolvable<T0>(arg0, 0x2::clock::timestamp_ms(arg2)), 10);
        let (v0, _) = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::price::read_price(arg1, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::pyth_feed_id<T0>(arg0), arg2);
        let v2 = if (v0 >= 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::target_price<T0>(arg0)) {
            1
        } else {
            2
        };
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::mark_resolved<T0>(arg0, v2, v0, 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_market_resolved(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), v2, v0, 0x2::tx_context::sender(arg3));
    }

    public fun sell_shares<T0>(arg0: &mut 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 <= 1, 26);
        assert!(arg2 > 0, 17);
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::resolved<T0>(arg0), 3);
        assert!(!0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::voided<T0>(arg0), 4);
        assert!(0x2::clock::timestamp_ms(arg4) < 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::trading_cutoff<T0>(arg0), 2);
        let v0 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::execute_sell<T0>(arg0, arg1, arg2, 0x2::tx_context::sender(arg5));
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::add_fees<T0>(arg0, 0x2::balance::split<T0>(&mut v0, (((0x2::balance::value<T0>(&v0) as u128) * (0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::fee_bps<T0>(arg0) as u128) / 10000) as u64)));
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 >= arg3, 9);
        let (v2, v3) = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::registry_inner::compute_prices(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::yes_reserves<T0>(arg0), 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::no_reserves<T0>(arg0));
        let v4 = if (arg2 > 0) {
            (((v1 as u128) * 1000000 / (arg2 as u128)) as u64)
        } else {
            0
        };
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events::emit_shares_sold(0x2::object::id<0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::Market<T0>>(arg0), 0x2::tx_context::sender(arg5), arg1, arg2, v1, v4, v2, v3, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::yes_reserves<T0>(arg0), 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market::no_reserves<T0>(arg0));
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    public fun treasury_balance<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun version<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

