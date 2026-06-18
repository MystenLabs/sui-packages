module 0xc4e882a3c2a1efc745030280be14cc09083bb96e6f21ee6dad7dbaaa73471371::prediction_market {
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
        entry_prize_bps: u64,
        required_nft_type: vector<u8>,
        impact_fund: 0x2::balance::Balance<0x2::sui::SUI>,
        entry_prize_fund: 0x2::balance::Balance<0x2::sui::SUI>,
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

    struct PrizeAllocation has store {
        amount: u64,
        claimed: bool,
    }

    struct PrizePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        label: vector<u8>,
        source: vector<u8>,
        claim_deadline_ms: u64,
        claims_open: bool,
        finalized: bool,
        balance: 0x2::balance::Balance<T0>,
        allocations: 0x2::table::Table<address, PrizeAllocation>,
        total_funded: u64,
        total_allocated: u64,
        total_claimed: u64,
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

    struct PositionRefunded has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct AdminRefundIssued has copy, drop {
        market_id: 0x2::object::ID,
        outcome_yes: bool,
        recipient: address,
        amount: u64,
    }

    struct EntryPrizeAllocationUpdated has copy, drop {
        entry_prize_bps: u64,
    }

    struct PrizePoolCreated<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        claim_deadline_ms: u64,
    }

    struct PrizePoolFunded<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        total_funded: u64,
    }

    struct EntryPrizeFundedPool has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct PrizeAllocationSet<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        total_allocated: u64,
    }

    struct PrizePoolClaimsOpened<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        claim_deadline_ms: u64,
        total_allocated: u64,
    }

    struct PrizeClaimed<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct PrizePoolWithdrawal<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct PrizePoolFinalized<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        remaining_amount: u64,
    }

    public entry fun admin_refund_from_pool(arg0: &AdminCap, arg1: &mut Registry, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.admin, 1);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg1.markets, arg2), 5);
        assert!(arg4 > 0, 18);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg1.markets, arg2);
        assert!(!v0.resolved, 4);
        let v1 = if (arg3) {
            assert!(arg4 <= 0x2::balance::value<0x2::sui::SUI>(&v0.yes_pool), 18);
            0x2::balance::split<0x2::sui::SUI>(&mut v0.yes_pool, arg4)
        } else {
            assert!(arg4 <= 0x2::balance::value<0x2::sui::SUI>(&v0.no_pool), 18);
            0x2::balance::split<0x2::sui::SUI>(&mut v0.no_pool, arg4)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg6), arg5);
        let v2 = AdminRefundIssued{
            market_id   : arg2,
            outcome_yes : arg3,
            recipient   : arg5,
            amount      : arg4,
        };
        0x2::event::emit<AdminRefundIssued>(v2);
    }

    fun assert_evidence_limited(arg0: &vector<u8>, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= arg1, 15);
    }

    fun assert_non_empty_limited(arg0: &vector<u8>, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= arg1, 14);
    }

    fun assert_pool_can_be_funded<T0>(arg0: &PrizePool<T0>) {
        assert!(!arg0.claims_open && !arg0.finalized, 20);
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

    public entry fun claim_prize_pool_reward<T0>(arg0: &mut PrizePool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claims_open && !arg0.finalized, 21);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.claim_deadline_ms, 25);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, PrizeAllocation>(&arg0.allocations, v0), 23);
        let v1 = 0x2::table::borrow_mut<address, PrizeAllocation>(&mut arg0.allocations, v0);
        assert!(!v1.claimed, 22);
        let v2 = v1.amount;
        assert!(v2 > 0 && v2 <= 0x2::balance::value<T0>(&arg0.balance), 19);
        v1.claimed = true;
        arg0.total_claimed = arg0.total_claimed + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg2), v0);
        let v3 = PrizeClaimed<T0>{
            pool_id   : 0x2::object::id<PrizePool<T0>>(arg0),
            recipient : v0,
            amount    : v2,
        };
        0x2::event::emit<PrizeClaimed<T0>>(v3);
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

    public entry fun create_prize_pool<T0>(arg0: &AdminCap, arg1: &Registry, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.admin, 1);
        assert_non_empty_limited(&arg2, 64);
        assert_non_empty_limited(&arg3, 512);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 19);
        let v0 = PrizePool<T0>{
            id                : 0x2::object::new(arg6),
            admin             : arg1.admin,
            label             : arg2,
            source            : arg3,
            claim_deadline_ms : arg4,
            claims_open       : false,
            finalized         : false,
            balance           : 0x2::balance::zero<T0>(),
            allocations       : 0x2::table::new<address, PrizeAllocation>(arg6),
            total_funded      : 0,
            total_allocated   : 0,
            total_claimed     : 0,
        };
        let v1 = PrizePoolCreated<T0>{
            pool_id           : 0x2::object::id<PrizePool<T0>>(&v0),
            claim_deadline_ms : arg4,
        };
        0x2::event::emit<PrizePoolCreated<T0>>(v1);
        0x2::transfer::share_object<PrizePool<T0>>(v0);
    }

    fun entry_prize_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 2000, 13);
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun fee_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000, 13);
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public entry fun finalize_prize_pool<T0>(arg0: &AdminCap, arg1: &Registry, arg2: &mut PrizePool<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin, 1);
        assert!(arg2.admin == arg1.admin, 1);
        assert!(arg2.claims_open && !arg2.finalized, 21);
        assert!(0x2::clock::timestamp_ms(arg4) > arg2.claim_deadline_ms, 26);
        let v0 = 0x2::balance::value<T0>(&arg2.balance);
        arg2.finalized = true;
        arg2.claims_open = false;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v0), arg5), arg3);
        };
        let v1 = PrizePoolFinalized<T0>{
            pool_id          : 0x2::object::id<PrizePool<T0>>(arg2),
            recipient        : arg3,
            remaining_amount : v0,
        };
        0x2::event::emit<PrizePoolFinalized<T0>>(v1);
    }

    public entry fun fund_prize_pool<T0>(arg0: &mut PrizePool<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert_pool_can_be_funded<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 19);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_funded = arg0.total_funded + v0;
        let v1 = PrizePoolFunded<T0>{
            pool_id      : 0x2::object::id<PrizePool<T0>>(arg0),
            amount       : v0,
            total_funded : arg0.total_funded,
        };
        0x2::event::emit<PrizePoolFunded<T0>>(v1);
    }

    public entry fun fund_sui_prize_pool_from_entry_fund(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut PrizePool<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1);
        assert_pool_can_be_funded<0x2::sui::SUI>(arg2);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.entry_prize_fund), 17);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.entry_prize_fund, arg3));
        arg2.total_funded = arg2.total_funded + arg3;
        let v0 = EntryPrizeFundedPool{
            pool_id : 0x2::object::id<PrizePool<0x2::sui::SUI>>(arg2),
            amount  : arg3,
        };
        0x2::event::emit<EntryPrizeFundedPool>(v0);
        let v1 = PrizePoolFunded<0x2::sui::SUI>{
            pool_id      : 0x2::object::id<PrizePool<0x2::sui::SUI>>(arg2),
            amount       : arg3,
            total_funded : arg2.total_funded,
        };
        0x2::event::emit<PrizePoolFunded<0x2::sui::SUI>>(v1);
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
            entry_prize_bps   : 0,
            required_nft_type : b"f6c6d439ea0da2f3e9ba79e4992a7a4c113215fbf54c442ac9020c315f953705::collection::NFT",
            impact_fund       : 0x2::balance::zero<0x2::sui::SUI>(),
            entry_prize_fund  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Registry>(v3);
    }

    public fun is_authorized_nft<T0: key>(arg0: &Registry) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)) == &arg0.required_nft_type
    }

    fun minimum_stake_for_category(arg0: &vector<u8>) : u64 {
        if (*arg0 == b"Storm Tier" || *arg0 == b"Storm Tier Access") {
            2000000000
        } else {
            1000000000
        }
    }

    public fun open_position<T0: key>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: bool, arg3: &T0, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Position {
        assert!(is_authorized_nft<T0>(arg0), 11);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, arg1), 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 > 0, 6);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1);
        assert!(v0 >= minimum_stake_for_category(&v1.category), 6);
        assert!(!v1.resolved, 4);
        assert!(0x2::clock::timestamp_ms(arg5) < v1.expiry_ms, 2);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.impact_fund, 0x2::balance::split<0x2::sui::SUI>(&mut v2, fee_amount(v0, arg0.fee_bps)));
        let v3 = entry_prize_amount(v0, arg0.entry_prize_bps);
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.entry_prize_fund, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
        };
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        assert!(v4 > 0, 6);
        if (arg2) {
            0x2::balance::join<0x2::sui::SUI>(&mut v1.yes_pool, v2);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut v1.no_pool, v2);
        };
        let v5 = Position{
            id          : 0x2::object::new(arg6),
            market_id   : arg1,
            owner       : 0x2::tx_context::sender(arg6),
            outcome_yes : arg2,
            stake       : v4,
            claimed     : false,
        };
        let v6 = PositionOpened{
            position_id : 0x2::object::id<Position>(&v5),
            market_id   : arg1,
            owner       : 0x2::tx_context::sender(arg6),
            outcome_yes : arg2,
            stake       : v4,
        };
        0x2::event::emit<PositionOpened>(v6);
        v5
    }

    public entry fun open_prize_pool_claims<T0>(arg0: &AdminCap, arg1: &Registry, arg2: &mut PrizePool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 1);
        assert!(arg2.admin == arg1.admin, 1);
        assert!(!arg2.claims_open && !arg2.finalized, 20);
        assert!(arg2.total_allocated > 0, 19);
        assert!(arg2.total_allocated <= 0x2::balance::value<T0>(&arg2.balance), 24);
        arg2.claims_open = true;
        let v0 = PrizePoolClaimsOpened<T0>{
            pool_id           : 0x2::object::id<PrizePool<T0>>(arg2),
            claim_deadline_ms : arg2.claim_deadline_ms,
            total_allocated   : arg2.total_allocated,
        };
        0x2::event::emit<PrizePoolClaimsOpened<T0>>(v0);
    }

    fun pro_rata_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun refund_unresolved_position(arg0: &mut Registry, arg1: &mut Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 12);
        assert!(!arg1.claimed, 9);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, arg1.market_id), 5);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1.market_id);
        assert!(!v0.resolved, 4);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.expiry_ms, 3);
        let v1 = arg1.stake;
        assert!(v1 > 0, 18);
        let v2 = if (arg1.outcome_yes) {
            0x2::balance::split<0x2::sui::SUI>(&mut v0.yes_pool, v1)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut v0.no_pool, v1)
        };
        arg1.claimed = true;
        let v3 = PositionRefunded{
            position_id : 0x2::object::id<Position>(arg1),
            market_id   : arg1.market_id,
            owner       : arg1.owner,
            amount      : v1,
        };
        0x2::event::emit<PositionRefunded>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3)
    }

    public entry fun refund_unresolved_to_sender(arg0: &mut Registry, arg1: &mut Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = refund_unresolved_position(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
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

    public entry fun set_entry_prize_allocation(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 1);
        assert!(arg2 <= 2000, 13);
        arg1.entry_prize_bps = arg2;
        let v0 = EntryPrizeAllocationUpdated{entry_prize_bps: arg2};
        0x2::event::emit<EntryPrizeAllocationUpdated>(v0);
    }

    public entry fun set_prize_allocation<T0>(arg0: &AdminCap, arg1: &Registry, arg2: &mut PrizePool<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin, 1);
        assert!(arg2.admin == arg1.admin, 1);
        assert!(!arg2.claims_open && !arg2.finalized, 20);
        assert!(arg4 > 0, 19);
        let v0 = if (0x2::table::contains<address, PrizeAllocation>(&arg2.allocations, arg3)) {
            let v1 = 0x2::table::borrow_mut<address, PrizeAllocation>(&mut arg2.allocations, arg3);
            assert!(!v1.claimed, 22);
            v1.amount = arg4;
            v1.amount
        } else {
            let v2 = PrizeAllocation{
                amount  : arg4,
                claimed : false,
            };
            0x2::table::add<address, PrizeAllocation>(&mut arg2.allocations, arg3, v2);
            0
        };
        let v3 = arg2.total_allocated - v0 + arg4;
        assert!(v3 <= 0x2::balance::value<T0>(&arg2.balance), 24);
        arg2.total_allocated = v3;
        let v4 = PrizeAllocationSet<T0>{
            pool_id         : 0x2::object::id<PrizePool<T0>>(arg2),
            recipient       : arg3,
            amount          : arg4,
            total_allocated : arg2.total_allocated,
        };
        0x2::event::emit<PrizeAllocationSet<T0>>(v4);
    }

    public entry fun set_required_nft_type(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 1);
        assert_non_empty_limited(&arg2, 512);
        arg1.required_nft_type = arg2;
    }

    fun unclaimed_allocated<T0>(arg0: &PrizePool<T0>) : u64 {
        arg0.total_allocated - arg0.total_claimed
    }

    public entry fun withdraw_impact_fund(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.impact_fund), 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.impact_fund, arg2), arg4), arg3);
    }

    public entry fun withdraw_unassigned_prizes<T0>(arg0: &AdminCap, arg1: &Registry, arg2: &mut PrizePool<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin, 1);
        assert!(arg2.admin == arg1.admin, 1);
        assert!(arg3 > 0 && arg3 <= withdrawable_unassigned<T0>(arg2), 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, arg3), arg5), arg4);
        let v0 = PrizePoolWithdrawal<T0>{
            pool_id   : 0x2::object::id<PrizePool<T0>>(arg2),
            recipient : arg4,
            amount    : arg3,
        };
        0x2::event::emit<PrizePoolWithdrawal<T0>>(v0);
    }

    fun withdrawable_unassigned<T0>(arg0: &PrizePool<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = unclaimed_allocated<T0>(arg0);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

