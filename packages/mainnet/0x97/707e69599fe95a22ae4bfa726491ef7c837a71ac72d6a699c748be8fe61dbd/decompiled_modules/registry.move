module 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::registry {
    struct MarketRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        platform_fee_bps: u64,
        creator_fee_bps: u64,
        resolver_fee_bps: u64,
        min_bet: u64,
        claim_deadline_ms: u64,
        market_count: u64,
        total_volume: u64,
        supported_feeds: 0x2::table::Table<0x1::string::String, vector<u8>>,
        treasury: 0x2::balance::Balance<T0>,
        paused: bool,
    }

    public fun void_market<T0>(arg0: &MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: &mut 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::status<T0>(arg2) == 0, 19);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::void_market<T0>(arg2);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_market_voided(0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg2), arg3);
    }

    public fun add_feed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 21);
        0x2::table::add<0x1::string::String, vector<u8>>(&mut arg0.supported_feeds, arg2, arg3);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_feed_added(arg2, arg3);
    }

    public fun admin_resolve<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: &mut 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::status<T0>(arg2) == 0, 19);
        if (0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::should_auto_void<T0>(arg2)) {
            0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::void_market<T0>(arg2);
            0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_market_voided(0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg2), 0x1::string::utf8(b"auto-void: pool imbalance exceeds threshold"));
            return
        };
        resolve_internal<T0>(arg0, arg2, arg3, 0, 0x2::clock::timestamp_ms(arg4), arg5);
    }

    public fun claim<T0>(arg0: &MarketRegistry<T0>, arg1: &mut 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>, arg2: 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::status<T0>(arg1) == 1, 13);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::market_id(&arg2) == 0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg1), 15);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::side(&arg2) == 0x1::option::destroy_some<bool>(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::outcome<T0>(arg1)), 16);
        assert!(0x2::clock::timestamp_ms(arg3) < 0x1::option::destroy_some<u64>(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::resolved_at_ms<T0>(arg1)) + arg0.claim_deadline_ms, 17);
        let v0 = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::registry_inner::calculate_payout(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::amount(&arg2), 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::winning_total<T0>(arg1), 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::remaining_pool<T0>(arg1));
        let (_, _, v3, v4) = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::destroy(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::withdraw_payout<T0>(arg1, v0), arg4), v4);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_winnings_claimed(0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg1), v4, v3, v0);
    }

    public(friend) fun create_and_share<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry<T0>{
            id                : 0x2::object::new(arg0),
            version           : 1,
            platform_fee_bps  : 200,
            creator_fee_bps   : 50,
            resolver_fee_bps  : 10,
            min_bet           : 1000000,
            claim_deadline_ms : 7776000000,
            market_count      : 0,
            total_volume      : 0,
            supported_feeds   : 0x2::table::new<0x1::string::String, vector<u8>>(arg0),
            treasury          : 0x2::balance::zero<T0>(),
            paused            : false,
        };
        0x2::transfer::share_object<MarketRegistry<T0>>(v0);
    }

    public fun create_market<T0>(arg0: &mut MarketRegistry<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!arg0.paused, 0);
        assert!(arg5 <= 1, 4);
        assert!(0x2::coin::value<T0>(&arg7) >= arg0.min_bet, 3);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg3), 7);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = arg6 - v0;
        assert!(v1 >= 86400000, 5);
        assert!(v1 <= 63072000000, 6);
        let v2 = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::registry_inner::calculate_betting_close(arg6, v0);
        let v3 = 0x2::coin::value<T0>(&arg7);
        let v4 = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::new<T0>(arg1, 0x2::tx_context::sender(arg10), arg2, arg3, *0x2::table::borrow<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg3), arg4, arg5, arg6, v2, arg7, arg8, v0, arg10);
        let v5 = 0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(&v4);
        arg0.market_count = arg0.market_count + 1;
        arg0.total_volume = arg0.total_volume + v3;
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_market_created(v5, arg1, 0x2::tx_context::sender(arg10), arg2, arg3, arg4, arg5, arg6, v2, arg8, v3);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::share<T0>(v4);
        0x2::transfer::public_transfer<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::Position>(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::new(v5, arg8, v3, 0x2::tx_context::sender(arg10), v0, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun create_registry<T0>(arg0: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_share<T0>(arg1);
    }

    public fun market_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.market_count
    }

    public fun migrate<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.version;
        assert!(v0 < 1, 25);
        arg0.version = 1;
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_migrated(v0, 1);
    }

    public fun pause<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        arg0.paused = true;
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_paused();
    }

    public fun paused<T0>(arg0: &MarketRegistry<T0>) : bool {
        arg0.paused
    }

    public fun place_bet<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!arg0.paused, 0);
        assert!(0x2::coin::value<T0>(&arg2) >= arg0.min_bet, 3);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::is_betting_open<T0>(arg1, 0x2::clock::timestamp_ms(arg4)), 2);
        let v0 = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::add_bet<T0>(arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg1);
        let v2 = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::new(v1, arg3, v0, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4), arg5);
        arg0.total_volume = arg0.total_volume + v0;
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_bet_placed(v1, 0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::Position>(&v2), 0x2::tx_context::sender(arg5), arg3, v0, 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::yes_total<T0>(arg1), 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::no_total<T0>(arg1));
        0x2::transfer::public_transfer<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::Position>(v2, 0x2::tx_context::sender(arg5));
    }

    public fun refund<T0>(arg0: &mut 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>, arg1: 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::status<T0>(arg0) == 2, 14);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::market_id(&arg1) == 0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg0), 15);
        let (_, v1, v2, v3) = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::position::destroy(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::withdraw_refund<T0>(arg0, v2, v1), arg2), v3);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_void_refunded(0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg0), v3, v2);
    }

    public fun remove_feed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 22);
        0x2::table::remove<0x1::string::String, vector<u8>>(&mut arg0.supported_feeds, arg2);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_feed_removed(arg2);
    }

    public fun resolve<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!arg0.paused, 0);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::status<T0>(arg1) == 0, 19);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::is_resolvable<T0>(arg1, 0x2::clock::timestamp_ms(arg3)), 9);
        if (0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::should_auto_void<T0>(arg1)) {
            0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::void_market<T0>(arg1);
            0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_market_voided(0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg1), 0x1::string::utf8(b"auto-void: pool imbalance exceeds threshold"));
            return
        };
        let (v0, _) = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::price::read_price(arg2, 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::pyth_feed_id<T0>(arg1), arg3);
        let v2 = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::determine_outcome(v0, 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::target_price<T0>(arg1), 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::direction<T0>(arg1));
        resolve_internal<T0>(arg0, arg1, v2, v0, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    fun resolve_internal<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::resolve_market<T0>(arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg0.platform_fee_bps, arg0.creator_fee_bps, arg0.resolver_fee_bps);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        0x2::balance::join<T0>(&mut arg0.treasury, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg5), 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::creator<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg5), 0x2::tx_context::sender(arg5));
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_market_resolved(0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg1), arg2, arg3, 0x2::tx_context::sender(arg5), v3, 0x2::balance::value<T0>(&v6), 0x2::balance::value<T0>(&v5), 0x2::balance::value<T0>(&v4));
    }

    public fun sweep_unclaimed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: &mut 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::status<T0>(arg2) == 1, 13);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::option::destroy_some<u64>(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::resolved_at_ms<T0>(arg2)) + arg0.claim_deadline_ms, 18);
        let v0 = 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::sweep_remaining<T0>(arg2);
        0x2::balance::join<T0>(&mut arg0.treasury, v0);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_unclaimed_swept(0x2::object::id<0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market::Market<T0>>(arg2), 0x2::balance::value<T0>(&v0));
    }

    public fun total_volume<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.total_volume
    }

    public fun treasury_balance<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun unpause<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        arg0.paused = false;
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_unpaused();
    }

    public fun update_fees<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::registry_inner::validate_fees(arg2, arg3, arg4), 23);
        arg0.platform_fee_bps = arg2;
        arg0.creator_fee_bps = arg3;
        arg0.resolver_fee_bps = arg4;
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_fees_updated(arg2, arg3, arg4);
    }

    public fun version<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.version
    }

    public fun withdraw_treasury<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::admin::AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x2::balance::value<T0>(&arg0.treasury) >= arg2, 24);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, arg2), arg4), arg3);
        0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::events::emit_treasury_withdrawn(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

