module 0xbdb34ef1f0ede6535473fa2078447da608e0c9f24e284aff350bf546168b92c7::prediction_market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResolverCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        admin: address,
        markets: 0x2::table::Table<0x2::object::ID, Market>,
        fee_bps: u64,
        required_nft_type: vector<u8>,
        impact_fund: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Market has store {
        question: vector<u8>,
        category: vector<u8>,
        resolution_source: 0x2::url::Url,
        expiry_ms: u64,
        yes_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        no_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        resolved: bool,
        outcome_yes: bool,
        evidence_url: vector<u8>,
        evidence_hash: vector<u8>,
        source_timestamp_ms: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        owner: address,
        outcome_yes: bool,
        stake: u64,
        claimed: bool,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        expiry_ms: u64,
    }

    struct PositionOpened has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        owner: address,
        outcome_yes: bool,
        stake: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome_yes: bool,
        evidence_url: vector<u8>,
        evidence_hash: vector<u8>,
        source_timestamp_ms: u64,
    }

    struct PositionClaimed has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        owner: address,
        payout: u64,
    }

    fun assert_evidence_limited(arg0: &vector<u8>, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= arg1, 15);
    }

    fun assert_non_empty_limited(arg0: &vector<u8>, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= arg1, 14);
    }

    public entry fun buy_position<T0: key>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: bool, arg3: &T0, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = open_position<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::transfer<Position>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun claim(arg0: &mut Registry, arg1: &mut Position, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 12);
        assert!(!arg1.claimed, 9);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, arg1.market_id), 5);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1.market_id);
        assert!(v0.resolved, 8);
        assert!(arg1.outcome_yes == v0.outcome_yes, 7);
        let v1 = if (v0.outcome_yes) {
            0x2::balance::value<0x2::sui::SUI>(&v0.yes_pool)
        } else {
            0x2::balance::value<0x2::sui::SUI>(&v0.no_pool)
        };
        assert!(v1 > 0, 10);
        let v2 = if (v0.outcome_yes) {
            0x2::balance::value<0x2::sui::SUI>(&v0.no_pool)
        } else {
            0x2::balance::value<0x2::sui::SUI>(&v0.yes_pool)
        };
        let v3 = arg1.stake;
        let v4 = if (v0.outcome_yes) {
            0x2::balance::split<0x2::sui::SUI>(&mut v0.yes_pool, v3)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut v0.no_pool, v3)
        };
        let v5 = v4;
        let v6 = if (v0.outcome_yes) {
            0x2::balance::split<0x2::sui::SUI>(&mut v0.no_pool, pro_rata_amount(v2, v3, v1))
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut v0.yes_pool, pro_rata_amount(v2, v3, v1))
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        arg1.claimed = true;
        let v7 = PositionClaimed{
            position_id : 0x2::object::id<Position>(arg1),
            market_id   : arg1.market_id,
            owner       : 0x2::tx_context::sender(arg2),
            payout      : 0x2::balance::value<0x2::sui::SUI>(&v5),
        };
        0x2::event::emit<PositionClaimed>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg2)
    }

    public entry fun claim_to_sender(arg0: &mut Registry, arg1: &mut Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun create_market(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg1.admin, 1);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6), 2);
        assert_non_empty_limited(&arg2, 280);
        assert_non_empty_limited(&arg3, 64);
        assert_non_empty_limited(&arg4, 512);
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        0x2::object::delete(v0);
        let v2 = Market{
            question            : arg2,
            category            : arg3,
            resolution_source   : 0x2::url::new_unsafe_from_bytes(arg4),
            expiry_ms           : arg5,
            yes_pool            : 0x2::balance::zero<0x2::sui::SUI>(),
            no_pool             : 0x2::balance::zero<0x2::sui::SUI>(),
            resolved            : false,
            outcome_yes         : false,
            evidence_url        : b"",
            evidence_hash       : b"",
            source_timestamp_ms : 0,
        };
        0x2::table::add<0x2::object::ID, Market>(&mut arg1.markets, v1, v2);
        let v3 = MarketCreated{
            market_id : v1,
            expiry_ms : arg5,
        };
        0x2::event::emit<MarketCreated>(v3);
    }

    fun fee_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000, 13);
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = ResolverCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ResolverCap>(v2, v0);
        let v3 = Registry{
            id                : 0x2::object::new(arg0),
            admin             : v0,
            markets           : 0x2::table::new<0x2::object::ID, Market>(arg0),
            fee_bps           : 100,
            required_nft_type : b"f6c6d439ea0da2f3e9ba79e4992a7a4c113215fbf54c442ac9020c315f953705::collection::NFT",
            impact_fund       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Registry>(v3);
    }

    public fun is_authorized_nft<T0: key>(arg0: &Registry) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)) == &arg0.required_nft_type
    }

    public fun open_position<T0: key>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: bool, arg3: &T0, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Position {
        assert!(is_authorized_nft<T0>(arg0), 11);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, arg1), 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 > 0, 6);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1);
        assert!(!v1.resolved, 4);
        assert!(0x2::clock::timestamp_ms(arg5) < v1.expiry_ms, 2);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.impact_fund, 0x2::balance::split<0x2::sui::SUI>(&mut v2, fee_amount(v0, arg0.fee_bps)));
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        assert!(v3 > 0, 6);
        if (arg2) {
            0x2::balance::join<0x2::sui::SUI>(&mut v1.yes_pool, v2);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut v1.no_pool, v2);
        };
        let v4 = Position{
            id          : 0x2::object::new(arg6),
            market_id   : arg1,
            owner       : 0x2::tx_context::sender(arg6),
            outcome_yes : arg2,
            stake       : v3,
            claimed     : false,
        };
        let v5 = PositionOpened{
            position_id : 0x2::object::id<Position>(&v4),
            market_id   : arg1,
            owner       : 0x2::tx_context::sender(arg6),
            outcome_yes : arg2,
            stake       : v3,
        };
        0x2::event::emit<PositionOpened>(v5);
        v4
    }

    fun pro_rata_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public entry fun resolve_market(arg0: &ResolverCap, arg1: &mut Registry, arg2: 0x2::object::ID, arg3: bool, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg1.markets, arg2), 5);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg1.markets, arg2);
        assert!(!v0.resolved, 4);
        assert!(0x2::clock::timestamp_ms(arg7) >= v0.expiry_ms, 3);
        assert_evidence_limited(&arg4, 512);
        assert_evidence_limited(&arg5, 128);
        assert!(arg6 > 0 && arg6 <= 0x2::clock::timestamp_ms(arg7), 16);
        v0.resolved = true;
        v0.outcome_yes = arg3;
        v0.evidence_url = arg4;
        v0.evidence_hash = arg5;
        v0.source_timestamp_ms = arg6;
        let v1 = MarketResolved{
            market_id           : arg2,
            outcome_yes         : arg3,
            evidence_url        : arg4,
            evidence_hash       : arg5,
            source_timestamp_ms : arg6,
        };
        0x2::event::emit<MarketResolved>(v1);
    }

    public entry fun set_required_nft_type(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 1);
        assert_non_empty_limited(&arg2, 512);
        arg1.required_nft_type = arg2;
    }

    public entry fun withdraw_impact_fund(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.impact_fund), 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.impact_fund, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

