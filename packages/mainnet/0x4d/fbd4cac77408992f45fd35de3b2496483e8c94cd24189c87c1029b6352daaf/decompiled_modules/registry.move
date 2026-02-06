module 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::registry {
    struct MarketRegistry has key {
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
        proof_market_counts: 0x2::table::Table<0x1::string::String, u64>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        paused: bool,
    }

    public fun void_market(arg0: &MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::status(arg2) == 0, 19);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::void_market(arg2);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_market_voided(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg2), arg3);
    }

    public fun add_feed(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 21);
        0x2::table::add<0x1::string::String, vector<u8>>(&mut arg0.supported_feeds, arg2, arg3);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_feed_added(arg2, arg3);
    }

    public fun admin_resolve(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::status(arg2) == 0, 19);
        if (0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::should_auto_void(arg2)) {
            0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::void_market(arg2);
            0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_market_voided(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg2), 0x1::string::utf8(b"auto-void: pool imbalance exceeds threshold"));
            return
        };
        let v0 = if (0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::market_type(arg2) == 0) {
            0
        } else {
            0
        };
        let (v1, v2, v3, v4) = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::resolve_market(arg2, arg3, v0, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4), arg0.platform_fee_bps, arg0.creator_fee_bps, arg0.resolver_fee_bps);
        let v5 = v3;
        let v6 = v2;
        let v7 = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5), 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::proof_creator(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg5), 0x2::tx_context::sender(arg5));
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_market_resolved(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg2), 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::market_type(arg2), arg3, v0, 0x2::tx_context::sender(arg5), v4, 0x2::balance::value<0x2::sui::SUI>(&v7), 0x2::balance::value<0x2::sui::SUI>(&v6), 0x2::balance::value<0x2::sui::SUI>(&v5));
    }

    public fun claim(arg0: &MarketRegistry, arg1: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg2: 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::status(arg1) == 1, 13);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::market_id(&arg2) == 0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg1), 15);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::side(&arg2) == 0x1::option::destroy_some<bool>(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::outcome(arg1)), 16);
        assert!(0x2::clock::timestamp_ms(arg3) < 0x1::option::destroy_some<u64>(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::resolved_at_ms(arg1)) + arg0.claim_deadline_ms, 17);
        let v0 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::registry_inner::calculate_payout(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::amount(&arg2), 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::winning_total(arg1), 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::remaining_pool(arg1));
        let (_, _, v3, v4) = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::destroy(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::withdraw_payout(arg1, v0), arg4), v4);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_winnings_claimed(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg1), v4, v3, v0);
    }

    public(friend) fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry{
            id                  : 0x2::object::new(arg0),
            version             : 1,
            platform_fee_bps    : 200,
            creator_fee_bps     : 50,
            resolver_fee_bps    : 10,
            min_bet             : 100000000,
            claim_deadline_ms   : 7776000000,
            market_count        : 0,
            total_volume        : 0,
            supported_feeds     : 0x2::table::new<0x1::string::String, vector<u8>>(arg0),
            proof_market_counts : 0x2::table::new<0x1::string::String, u64>(arg0),
            treasury            : 0x2::balance::zero<0x2::sui::SUI>(),
            paused              : false,
        };
        0x2::transfer::share_object<MarketRegistry>(v0);
    }

    public fun create_market(arg0: &mut MarketRegistry, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!arg0.paused, 0);
        assert!(arg5 <= 1, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg0.min_bet, 3);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg3), 7);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = arg6 - v0;
        assert!(v1 >= 86400000, 5);
        assert!(v1 <= 63072000000, 6);
        let v2 = if (0x2::table::contains<0x1::string::String, u64>(&arg0.proof_market_counts, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.proof_market_counts, arg1)
        } else {
            0
        };
        assert!(v2 < 3, 8);
        let v3 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::registry_inner::calculate_betting_close(arg6, v0);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg7);
        let v5 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::new_oracle(arg1, 0x2::tx_context::sender(arg10), arg2, arg3, *0x2::table::borrow<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg3), arg4, arg5, arg6, v3, arg7, arg8, v0, arg10);
        let v6 = 0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(&v5);
        arg0.market_count = arg0.market_count + 1;
        arg0.total_volume = arg0.total_volume + v4;
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.proof_market_counts, arg1)) {
            let v7 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.proof_market_counts, arg1);
            *v7 = *v7 + 1;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.proof_market_counts, arg1, 1);
        };
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_market_created(v6, 0, arg1, 0x2::tx_context::sender(arg10), arg2, 0x1::string::utf8(b""), arg3, arg4, arg5, arg6, v3, 0x1::option::none<address>(), arg8, v4);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::share(v5);
        0x2::transfer::public_transfer<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::Position>(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::new(v6, arg8, v4, 0x2::tx_context::sender(arg10), v0, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun create_open_market(arg0: &mut MarketRegistry, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!arg0.paused, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg0.min_bet, 3);
        assert!(0x1::string::length(&arg3) > 0, 28);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = arg4 - v0;
        assert!(v1 >= 86400000, 5);
        assert!(v1 <= 63072000000, 6);
        let v2 = if (0x2::table::contains<0x1::string::String, u64>(&arg0.proof_market_counts, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.proof_market_counts, arg1)
        } else {
            0
        };
        assert!(v2 < 3, 8);
        let v3 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::registry_inner::calculate_betting_close(arg4, v0);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        let v5 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::new_manual(arg1, 0x2::tx_context::sender(arg9), arg2, arg3, arg4, v3, arg5, arg6, arg7, v0, arg9);
        let v6 = 0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(&v5);
        arg0.market_count = arg0.market_count + 1;
        arg0.total_volume = arg0.total_volume + v4;
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.proof_market_counts, arg1)) {
            let v7 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.proof_market_counts, arg1);
            *v7 = *v7 + 1;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.proof_market_counts, arg1, 1);
        };
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_market_created(v6, 1, arg1, 0x2::tx_context::sender(arg9), arg2, arg3, 0x1::string::utf8(b""), 0, 0, arg4, v3, 0x1::option::some<address>(arg5), arg7, v4);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::share(v5);
        0x2::transfer::public_transfer<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::Position>(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::new(v6, arg7, v4, 0x2::tx_context::sender(arg9), v0, arg9), 0x2::tx_context::sender(arg9));
    }

    public fun market_count(arg0: &MarketRegistry) : u64 {
        arg0.market_count
    }

    public fun migrate(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.version;
        assert!(v0 < 1, 25);
        arg0.version = 1;
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_migrated(v0, 1);
    }

    public fun pause(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        arg0.paused = true;
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_paused();
    }

    public fun paused(arg0: &MarketRegistry) : bool {
        arg0.paused
    }

    public fun place_bet(arg0: &mut MarketRegistry, arg1: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!arg0.paused, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.min_bet, 3);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::is_betting_open(arg1, 0x2::clock::timestamp_ms(arg4)), 2);
        let v0 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::add_bet(arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg1);
        let v2 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::new(v1, arg3, v0, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4), arg5);
        arg0.total_volume = arg0.total_volume + v0;
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_bet_placed(v1, 0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::Position>(&v2), 0x2::tx_context::sender(arg5), arg3, v0, 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::yes_total(arg1), 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::no_total(arg1));
        0x2::transfer::public_transfer<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::Position>(v2, 0x2::tx_context::sender(arg5));
    }

    public fun refund(arg0: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg1: 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::status(arg0) == 2, 14);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::market_id(&arg1) == 0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg0), 15);
        let (_, v1, v2, v3) = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::position::destroy(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::withdraw_refund(arg0, v2, v1), arg2), v3);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_void_refunded(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg0), v3, v2);
    }

    public fun remove_feed(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.supported_feeds, arg2), 22);
        0x2::table::remove<0x1::string::String, vector<u8>>(&mut arg0.supported_feeds, arg2);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_feed_removed(arg2);
    }

    public fun resolve(arg0: &mut MarketRegistry, arg1: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!arg0.paused, 0);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::market_type(arg1) == 0, 29);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::status(arg1) == 0, 19);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::is_resolvable(arg1, 0x2::clock::timestamp_ms(arg3)), 9);
        if (0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::should_auto_void(arg1)) {
            0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::void_market(arg1);
            0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_market_voided(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg1), 0x1::string::utf8(b"auto-void: pool imbalance exceeds threshold"));
            return
        };
        let (v0, _) = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::price::read_price(arg2, 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::pyth_feed_id(arg1), arg3);
        let v2 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::determine_outcome(v0, 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::target_price(arg1), 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::direction(arg1));
        resolve_internal(arg0, arg1, v2, v0, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    fun resolve_internal(arg0: &mut MarketRegistry, arg1: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::resolve_market(arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg0.platform_fee_bps, arg0.creator_fee_bps, arg0.resolver_fee_bps);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg5), 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::proof_creator(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg5), 0x2::tx_context::sender(arg5));
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_market_resolved(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg1), 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::market_type(arg1), arg2, arg3, 0x2::tx_context::sender(arg5), v3, 0x2::balance::value<0x2::sui::SUI>(&v6), 0x2::balance::value<0x2::sui::SUI>(&v5), 0x2::balance::value<0x2::sui::SUI>(&v4));
    }

    public fun resolve_manual(arg0: &mut MarketRegistry, arg1: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(!arg0.paused, 0);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::market_type(arg1) == 1, 29);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::status(arg1) == 0, 19);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::is_manually_resolvable(arg1, 0x2::clock::timestamp_ms(arg3)), 9);
        let v0 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::designated_resolver(arg1);
        assert!(0x1::option::is_some<address>(&v0), 26);
        assert!(*0x1::option::borrow<address>(&v0) == 0x2::tx_context::sender(arg4), 26);
        if (0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::should_auto_void(arg1)) {
            0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::void_market(arg1);
            0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_market_voided(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg1), 0x1::string::utf8(b"auto-void: pool imbalance exceeds threshold"));
            return
        };
        resolve_internal(arg0, arg1, arg2, 0, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public fun sweep_unclaimed(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: &mut 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::status(arg2) == 1, 13);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::option::destroy_some<u64>(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::resolved_at_ms(arg2)) + arg0.claim_deadline_ms, 18);
        let v0 = 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::sweep_remaining(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v0);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_unclaimed_swept(0x2::object::id<0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market::Market>(arg2), 0x2::balance::value<0x2::sui::SUI>(&v0));
    }

    public fun total_volume(arg0: &MarketRegistry) : u64 {
        arg0.total_volume
    }

    public fun treasury_balance(arg0: &MarketRegistry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun unpause(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        arg0.paused = false;
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_unpaused();
    }

    public fun update_fees(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::registry_inner::validate_fees(arg2, arg3, arg4), 23);
        arg0.platform_fee_bps = arg2;
        arg0.creator_fee_bps = arg3;
        arg0.resolver_fee_bps = arg4;
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_fees_updated(arg2, arg3, arg4);
    }

    public fun version(arg0: &MarketRegistry) : u64 {
        arg0.version
    }

    public fun withdraw_treasury(arg0: &mut MarketRegistry, arg1: &0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::admin::AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 25);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg2, 24);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg2), arg4), arg3);
        0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events::emit_treasury_withdrawn(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

