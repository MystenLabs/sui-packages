module 0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle {
    struct Oracle has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        liveness_period_ms: u64,
        min_bond_amount: u64,
        requesters: 0x2::table::Table<address, bool>,
        proposers: 0x2::table::Table<address, bool>,
        markets: 0x2::table::Table<u64, MarketConfig>,
        requests: 0x2::table::Table<u64, Request>,
        final_outcomes: 0x2::table::Table<u64, u8>,
    }

    struct MarketConfig has copy, drop, store {
        num_outcomes: u8,
        invalid_outcome: u8,
    }

    struct MarketLivenessKey has copy, drop, store {
        market_id: u64,
    }

    struct Request has store {
        state: u8,
        proposed_outcome: u8,
        proposer: address,
        disputer: address,
        proposal_time_ms: u64,
        liveness_period_ms: u64,
        proposer_bond: 0x2::balance::Balance<0x2::sui::SUI>,
        disputer_bond: 0x2::balance::Balance<0x2::sui::SUI>,
        ancillary_data: vector<u8>,
    }

    struct OracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
        admin: address,
        liveness_period_ms: u64,
        min_bond_amount: u64,
    }

    struct MarketRegistered has copy, drop {
        market_id: u64,
        num_outcomes: u8,
        invalid_outcome: u8,
    }

    struct MarketLivenessConfigured has copy, drop {
        market_id: u64,
        liveness_period_ms: u64,
    }

    struct ResolutionRequested has copy, drop {
        market_id: u64,
        requester: address,
        ancillary_data: vector<u8>,
    }

    struct ProposerWhitelistUpdated has copy, drop {
        proposer: address,
        whitelisted: bool,
    }

    struct RequesterUpdated has copy, drop {
        requester: address,
        authorized: bool,
    }

    struct OutcomeProposed has copy, drop {
        market_id: u64,
        outcome: u8,
        proposer: address,
        bond: u64,
    }

    struct OutcomeDisputed has copy, drop {
        market_id: u64,
        disputer: address,
        bond: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: u64,
        outcome: u8,
        resolver: address,
    }

    struct BondClaimed has copy, drop {
        market_id: u64,
        recipient: address,
        amount: u64,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct LivenessPeriodUpdated has copy, drop {
        old_liveness_period_ms: u64,
        new_liveness_period_ms: u64,
    }

    struct MinBondUpdated has copy, drop {
        old_min_bond_amount: u64,
        new_min_bond_amount: u64,
    }

    public fun admin(arg0: &Oracle) : address {
        assert_version(arg0);
        arg0.admin
    }

    public fun admin_resolve(arg0: &mut Oracle, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_valid_outcome(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<u64, Request>(&mut arg0.requests, arg1);
        assert!(v0.state == 3, 2);
        v0.state = 4;
        let v1 = if (arg2 == v0.proposed_outcome) {
            v0.proposer
        } else {
            v0.disputer
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v0.proposer_bond);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v0.disputer_bond);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut v0.proposer_bond, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::balance::split<0x2::sui::SUI>(&mut v0.disputer_bond, v3));
        set_final_outcome(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg3), v1);
        let v5 = BondClaimed{
            market_id : arg1,
            recipient : v1,
            amount    : v2 + v3,
        };
        0x2::event::emit<BondClaimed>(v5);
        let v6 = MarketResolved{
            market_id : arg1,
            outcome   : arg2,
            resolver  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MarketResolved>(v6);
    }

    fun assert_admin(arg0: &Oracle, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    fun assert_admin_or_requester(arg0: &Oracle, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || bool_table_value(&arg0.requesters, v0), 1);
    }

    fun assert_liveness_period(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 2592000000, 2);
    }

    fun assert_valid_outcome(arg0: &Oracle, arg1: u64, arg2: u8) {
        assert_version(arg0);
        assert!(0x2::table::contains<u64, MarketConfig>(&arg0.markets, arg1), 101);
        let v0 = 0x2::table::borrow<u64, MarketConfig>(&arg0.markets, arg1);
        assert!(arg2 >= 1 && arg2 <= v0.num_outcomes || arg2 == v0.invalid_outcome, 3);
    }

    fun assert_version(arg0: &Oracle) {
        assert!(arg0.version == 1, 108);
    }

    fun bool_table_value(arg0: &0x2::table::Table<address, bool>, arg1: address) : bool {
        0x2::table::contains<address, bool>(arg0, arg1) && *0x2::table::borrow<address, bool>(arg0, arg1)
    }

    public fun can_settle(arg0: &Oracle, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        assert_version(arg0);
        if (!0x2::table::contains<u64, Request>(&arg0.requests, arg1)) {
            false
        } else {
            let v1 = 0x2::table::borrow<u64, Request>(&arg0.requests, arg1);
            v1.state == 2 && 0x2::clock::timestamp_ms(arg2) >= resolution_deadline_ms(v1.proposal_time_ms, v1.liveness_period_ms)
        }
    }

    public fun dispute_outcome(arg0: &mut Oracle, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_version(arg0);
        let v1 = 0x2::table::borrow_mut<u64, Request>(&mut arg0.requests, arg1);
        assert!(v1.state == 2, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < resolution_deadline_ms(v1.proposal_time_ms, v1.liveness_period_ms), 106);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 >= 0x2::balance::value<0x2::sui::SUI>(&v1.proposer_bond), 107);
        v1.state = 3;
        v1.disputer = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut v1.disputer_bond, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v3 = OutcomeDisputed{
            market_id : arg1,
            disputer  : v0,
            bond      : v2,
        };
        0x2::event::emit<OutcomeDisputed>(v3);
    }

    public fun get_ancillary_data(arg0: &Oracle, arg1: u64) : vector<u8> {
        assert_version(arg0);
        if (0x2::table::contains<u64, Request>(&arg0.requests, arg1)) {
            0x2::table::borrow<u64, Request>(&arg0.requests, arg1).ancillary_data
        } else {
            b""
        }
    }

    public fun get_outcome(arg0: &Oracle, arg1: u64) : (u8, bool) {
        assert_version(arg0);
        if (0x2::table::contains<u64, u8>(&arg0.final_outcomes, arg1)) {
            (*0x2::table::borrow<u64, u8>(&arg0.final_outcomes, arg1), true)
        } else {
            (0, false)
        }
    }

    public fun get_request_info(arg0: &Oracle, arg1: u64) : (u8, u8, address, address, u64, u64, u64, vector<u8>) {
        assert_version(arg0);
        if (!0x2::table::contains<u64, Request>(&arg0.requests, arg1)) {
            (0, 0, @0x0, @0x0, 0, 0, 0, b"")
        } else {
            let v8 = 0x2::table::borrow<u64, Request>(&arg0.requests, arg1);
            (v8.state, v8.proposed_outcome, v8.proposer, v8.disputer, v8.proposal_time_ms, 0x2::balance::value<0x2::sui::SUI>(&v8.proposer_bond), 0x2::balance::value<0x2::sui::SUI>(&v8.disputer_bond), v8.ancillary_data)
        }
    }

    public fun init_oracle(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = new_oracle(v0, arg0, arg1, arg2);
        let v2 = OracleCreated{
            oracle_id          : 0x2::object::id<Oracle>(&v1),
            admin              : v0,
            liveness_period_ms : arg0,
            min_bond_amount    : arg1,
        };
        0x2::event::emit<OracleCreated>(v2);
        0x2::transfer::share_object<Oracle>(v1);
    }

    public fun is_market_registered(arg0: &Oracle, arg1: u64) : bool {
        assert_version(arg0);
        0x2::table::contains<u64, MarketConfig>(&arg0.markets, arg1)
    }

    public fun is_resolution_requested(arg0: &Oracle, arg1: u64) : bool {
        assert_version(arg0);
        0x2::table::contains<u64, Request>(&arg0.requests, arg1)
    }

    public fun liveness_period_ms(arg0: &Oracle) : u64 {
        assert_version(arg0);
        arg0.liveness_period_ms
    }

    public fun liveness_remaining_ms(arg0: &Oracle, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert_version(arg0);
        if (!0x2::table::contains<u64, Request>(&arg0.requests, arg1)) {
            0
        } else {
            let v1 = 0x2::table::borrow<u64, Request>(&arg0.requests, arg1);
            if (v1.state != 2) {
                0
            } else {
                let v2 = 0x2::clock::timestamp_ms(arg2);
                let v3 = resolution_deadline_ms(v1.proposal_time_ms, v1.liveness_period_ms);
                if (v2 >= v3) {
                    0
                } else {
                    v3 - v2
                }
            }
        }
    }

    public fun market_liveness_period_ms(arg0: &Oracle, arg1: u64) : u64 {
        assert_version(arg0);
        assert!(0x2::table::contains<u64, MarketConfig>(&arg0.markets, arg1), 101);
        let v0 = MarketLivenessKey{market_id: arg1};
        if (0x2::dynamic_field::exists_with_type<MarketLivenessKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<MarketLivenessKey, u64>(&arg0.id, v0)
        } else {
            arg0.liveness_period_ms
        }
    }

    public fun min_bond_amount(arg0: &Oracle) : u64 {
        assert_version(arg0);
        arg0.min_bond_amount
    }

    fun new_oracle(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Oracle {
        assert_liveness_period(arg1);
        Oracle{
            id                 : 0x2::object::new(arg3),
            version            : 1,
            admin              : arg0,
            liveness_period_ms : arg1,
            min_bond_amount    : arg2,
            requesters         : 0x2::table::new<address, bool>(arg3),
            proposers          : 0x2::table::new<address, bool>(arg3),
            markets            : 0x2::table::new<u64, MarketConfig>(arg3),
            requests           : 0x2::table::new<u64, Request>(arg3),
            final_outcomes     : 0x2::table::new<u64, u8>(arg3),
        }
    }

    public fun outcome_invalid() : u8 {
        3
    }

    public fun outcome_multi_invalid() : u8 {
        255
    }

    public fun outcome_no() : u8 {
        2
    }

    public fun outcome_unresolved() : u8 {
        0
    }

    public fun outcome_yes() : u8 {
        1
    }

    public fun propose_outcome(arg0: &mut Oracle, arg1: u64, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_version(arg0);
        assert!(bool_table_value(&arg0.proposers, v0), 103);
        assert_valid_outcome(arg0, arg1, arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= arg0.min_bond_amount, 104);
        let v2 = 0x2::table::borrow_mut<u64, Request>(&mut arg0.requests, arg1);
        assert!(v2.state == 1, 2);
        v2.state = 2;
        v2.proposed_outcome = arg2;
        v2.proposer = v0;
        v2.proposal_time_ms = 0x2::clock::timestamp_ms(arg4);
        v2.liveness_period_ms = market_liveness_period_ms(arg0, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut v2.proposer_bond, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v3 = OutcomeProposed{
            market_id : arg1,
            outcome   : arg2,
            proposer  : v0,
            bond      : v1,
        };
        0x2::event::emit<OutcomeProposed>(v3);
    }

    public fun register_market(arg0: &mut Oracle, arg1: u64, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.liveness_period_ms;
        register_market_internal(arg0, arg1, arg2, arg3, v0, arg4);
    }

    fun register_market_internal(arg0: &mut Oracle, arg1: u64, arg2: u8, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin_or_requester(arg0, arg5);
        assert!(!0x2::table::contains<u64, MarketConfig>(&arg0.markets, arg1), 100);
        assert!(arg2 >= 2 && arg2 <= 16, 3);
        assert!(arg3 == 3 || arg3 == 255, 3);
        let v0 = MarketConfig{
            num_outcomes    : arg2,
            invalid_outcome : arg3,
        };
        0x2::table::add<u64, MarketConfig>(&mut arg0.markets, arg1, v0);
        let v1 = MarketLivenessKey{market_id: arg1};
        0x2::dynamic_field::add<MarketLivenessKey, u64>(&mut arg0.id, v1, arg4);
        let v2 = MarketRegistered{
            market_id       : arg1,
            num_outcomes    : arg2,
            invalid_outcome : arg3,
        };
        0x2::event::emit<MarketRegistered>(v2);
        let v3 = MarketLivenessConfigured{
            market_id          : arg1,
            liveness_period_ms : arg4,
        };
        0x2::event::emit<MarketLivenessConfigured>(v3);
    }

    public fun register_market_with_liveness(arg0: &mut Oracle, arg1: u64, arg2: u8, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_liveness_period(arg4);
        register_market_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun request_deadline_ms(arg0: &Oracle, arg1: u64) : u64 {
        assert_version(arg0);
        if (!0x2::table::contains<u64, Request>(&arg0.requests, arg1)) {
            0
        } else {
            let v1 = 0x2::table::borrow<u64, Request>(&arg0.requests, arg1);
            if (v1.state == 2) {
                resolution_deadline_ms(v1.proposal_time_ms, v1.liveness_period_ms)
            } else {
                0
            }
        }
    }

    public fun request_resolution(arg0: &mut Oracle, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_or_requester(arg0, arg3);
        assert!(0x2::table::contains<u64, MarketConfig>(&arg0.markets, arg1), 101);
        assert!(!0x2::table::contains<u64, Request>(&arg0.requests, arg1), 102);
        let v0 = Request{
            state              : 1,
            proposed_outcome   : 0,
            proposer           : @0x0,
            disputer           : @0x0,
            proposal_time_ms   : 0,
            liveness_period_ms : 0,
            proposer_bond      : 0x2::balance::zero<0x2::sui::SUI>(),
            disputer_bond      : 0x2::balance::zero<0x2::sui::SUI>(),
            ancillary_data     : arg2,
        };
        0x2::table::add<u64, Request>(&mut arg0.requests, arg1, v0);
        let v1 = ResolutionRequested{
            market_id      : arg1,
            requester      : 0x2::tx_context::sender(arg3),
            ancillary_data : arg2,
        };
        0x2::event::emit<ResolutionRequested>(v1);
    }

    public fun request_state(arg0: &Oracle, arg1: u64) : u8 {
        assert_version(arg0);
        if (0x2::table::contains<u64, Request>(&arg0.requests, arg1)) {
            0x2::table::borrow<u64, Request>(&arg0.requests, arg1).state
        } else {
            0
        }
    }

    fun resolution_deadline_ms(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 2);
        arg0 + arg1
    }

    fun set_bool_table(arg0: &mut 0x2::table::Table<address, bool>, arg1: address, arg2: bool) {
        if (0x2::table::contains<address, bool>(arg0, arg1)) {
            *0x2::table::borrow_mut<address, bool>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<address, bool>(arg0, arg1, arg2);
        };
    }

    fun set_final_outcome(arg0: &mut Oracle, arg1: u64, arg2: u8) {
        assert_version(arg0);
        if (0x2::table::contains<u64, u8>(&arg0.final_outcomes, arg1)) {
            *0x2::table::borrow_mut<u64, u8>(&mut arg0.final_outcomes, arg1) = arg2;
        } else {
            0x2::table::add<u64, u8>(&mut arg0.final_outcomes, arg1, arg2);
        };
    }

    public fun set_liveness_period(arg0: &mut Oracle, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_liveness_period(arg1);
        arg0.liveness_period_ms = arg1;
        let v0 = LivenessPeriodUpdated{
            old_liveness_period_ms : arg0.liveness_period_ms,
            new_liveness_period_ms : arg1,
        };
        0x2::event::emit<LivenessPeriodUpdated>(v0);
    }

    public fun set_min_bond(arg0: &mut Oracle, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.min_bond_amount = arg1;
        let v0 = MinBondUpdated{
            old_min_bond_amount : arg0.min_bond_amount,
            new_min_bond_amount : arg1,
        };
        0x2::event::emit<MinBondUpdated>(v0);
    }

    public fun set_proposer(arg0: &mut Oracle, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        let v0 = &mut arg0.proposers;
        set_bool_table(v0, arg1, arg2);
        let v1 = ProposerWhitelistUpdated{
            proposer    : arg1,
            whitelisted : arg2,
        };
        0x2::event::emit<ProposerWhitelistUpdated>(v1);
    }

    public fun set_requester(arg0: &mut Oracle, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        let v0 = &mut arg0.requesters;
        set_bool_table(v0, arg1, arg2);
        let v1 = RequesterUpdated{
            requester  : arg1,
            authorized : arg2,
        };
        0x2::event::emit<RequesterUpdated>(v1);
    }

    public fun settle_market(arg0: &mut Oracle, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::table::borrow_mut<u64, Request>(&mut arg0.requests, arg1);
        assert!(v0.state == 2, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= resolution_deadline_ms(v0.proposal_time_ms, v0.liveness_period_ms), 105);
        v0.state = 4;
        let v1 = v0.proposed_outcome;
        let v2 = v0.proposer;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v0.proposer_bond);
        set_final_outcome(arg0, arg1, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.proposer_bond, v3), arg3), v2);
        let v4 = BondClaimed{
            market_id : arg1,
            recipient : v2,
            amount    : v3,
        };
        0x2::event::emit<BondClaimed>(v4);
        let v5 = MarketResolved{
            market_id : arg1,
            outcome   : v1,
            resolver  : @0x0,
        };
        0x2::event::emit<MarketResolved>(v5);
    }

    public fun state_disputed() : u8 {
        3
    }

    public fun state_pending() : u8 {
        0
    }

    public fun state_proposed() : u8 {
        2
    }

    public fun state_requested() : u8 {
        1
    }

    public fun state_resolved() : u8 {
        4
    }

    public fun transfer_admin(arg0: &mut Oracle, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.admin = arg1;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun version(arg0: &Oracle) : u64 {
        assert_version(arg0);
        arg0.version
    }

    // decompiled from Move bytecode v7
}

