module 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::pari_resolution {
    struct PariResolution<phantom T0> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        num_outcomes: u8,
        proposed: bool,
        proposer: address,
        proposed_outcome: u8,
        bond: 0x2::balance::Balance<T0>,
        dispute_deadline_ms: u64,
        disputed: bool,
        disputer: address,
        dispute_bond: 0x2::balance::Balance<T0>,
        votes: 0x2::vec_map::VecMap<address, u8>,
        finalized: bool,
        final_outcome: u8,
    }

    struct ResolutionStarted has copy, drop {
        market_id: 0x2::object::ID,
        resolution: 0x2::object::ID,
    }

    struct OutcomeProposed has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        proposer: address,
        bond: u64,
        deadline_ms: u64,
    }

    struct OutcomeDisputed has copy, drop {
        market_id: 0x2::object::ID,
        disputer: address,
        counter_bond: u64,
    }

    struct Voted has copy, drop {
        market_id: 0x2::object::ID,
        voter: address,
        outcome: u8,
        tally: u64,
        threshold: u64,
    }

    struct Finalized has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        by: u8,
    }

    struct BondSettled has copy, drop {
        market_id: 0x2::object::ID,
        winner: address,
        amount: u64,
        slashed: bool,
    }

    public fun dispute<T0>(arg0: &mut PariResolution<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.finalized, 0);
        assert!(arg0.proposed, 5);
        assert!(!arg0.disputed, 4);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.dispute_deadline_ms, 2);
        assert!(0x2::coin::value<T0>(&arg1) >= 0x2::balance::value<T0>(&arg0.bond), 7);
        arg0.disputed = true;
        arg0.disputer = 0x2::tx_context::sender(arg3);
        0x2::balance::join<T0>(&mut arg0.dispute_bond, 0x2::coin::into_balance<T0>(arg1));
        let v0 = OutcomeDisputed{
            market_id    : arg0.market_id,
            disputer     : arg0.disputer,
            counter_bond : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<OutcomeDisputed>(v0);
    }

    public fun dispute_window_ms() : u64 {
        86400000
    }

    public fun final_outcome<T0>(arg0: &PariResolution<T0>) : u8 {
        arg0.final_outcome
    }

    fun finalize_internal<T0>(arg0: &mut PariResolution<T0>, arg1: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::ParimutuelMarket<T0>, arg2: u8, arg3: u8) {
        arg0.finalized = true;
        arg0.final_outcome = arg2;
        if (arg2 == 255) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::set_invalid_internal<T0>(arg1);
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::set_resolved_internal<T0>(arg1, arg2);
        };
        let v0 = Finalized{
            market_id : arg0.market_id,
            outcome   : arg2,
            by        : arg3,
        };
        0x2::event::emit<Finalized>(v0);
    }

    public fun finalize_optimistic<T0>(arg0: &mut PariResolution<T0>, arg1: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::ParimutuelMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finalized, 0);
        assert!(arg0.proposed, 5);
        assert!(!arg0.disputed, 10);
        assert!(0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::ParimutuelMarket<T0>>(arg1) == arg0.market_id, 8);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.dispute_deadline_ms, 3);
        let v0 = arg0.proposed_outcome;
        finalize_internal<T0>(arg0, arg1, v0, 0);
        let v1 = 0x2::balance::value<T0>(&arg0.bond);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.bond, v1, arg3), arg0.proposer);
            let v2 = BondSettled{
                market_id : arg0.market_id,
                winner    : arg0.proposer,
                amount    : v1,
                slashed   : false,
            };
            0x2::event::emit<BondSettled>(v2);
        };
    }

    public fun is_disputed<T0>(arg0: &PariResolution<T0>) : bool {
        arg0.disputed
    }

    public fun is_finalized<T0>(arg0: &PariResolution<T0>) : bool {
        arg0.finalized
    }

    public fun is_proposed<T0>(arg0: &PariResolution<T0>) : bool {
        arg0.proposed
    }

    public fun propose<T0>(arg0: &mut PariResolution<T0>, arg1: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finalized, 0);
        assert!(!arg0.proposed, 6);
        assert!(valid_vote<T0>(arg0, arg2), 9);
        assert!(0x2::coin::value<T0>(&arg3) >= 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::creation_bond(arg1), 7);
        arg0.proposed = true;
        arg0.proposer = 0x2::tx_context::sender(arg5);
        arg0.proposed_outcome = arg2;
        0x2::balance::join<T0>(&mut arg0.bond, 0x2::coin::into_balance<T0>(arg3));
        arg0.dispute_deadline_ms = 0x2::clock::timestamp_ms(arg4) + 86400000;
        let v0 = OutcomeProposed{
            market_id   : arg0.market_id,
            outcome     : arg2,
            proposer    : arg0.proposer,
            bond        : 0x2::coin::value<T0>(&arg3),
            deadline_ms : arg0.dispute_deadline_ms,
        };
        0x2::event::emit<OutcomeProposed>(v0);
    }

    fun settle_bonds<T0>(arg0: &mut PariResolution<T0>, arg1: u8, arg2: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::Treasury<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.proposed) {
            if (arg0.disputed) {
                let v0 = if (arg1 == arg0.proposed_outcome) {
                    arg0.proposer
                } else {
                    arg0.disputer
                };
                let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.bond);
                0x2::balance::join<T0>(&mut v1, 0x2::balance::withdraw_all<T0>(&mut arg0.dispute_bond));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), v0);
                let v2 = BondSettled{
                    market_id : arg0.market_id,
                    winner    : v0,
                    amount    : 0x2::balance::value<T0>(&v1),
                    slashed   : false,
                };
                0x2::event::emit<BondSettled>(v2);
            } else {
                let v3 = 0x2::balance::withdraw_all<T0>(&mut arg0.bond);
                if (arg1 == arg0.proposed_outcome) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg3), arg0.proposer);
                    let v4 = BondSettled{
                        market_id : arg0.market_id,
                        winner    : arg0.proposer,
                        amount    : 0x2::balance::value<T0>(&v3),
                        slashed   : false,
                    };
                    0x2::event::emit<BondSettled>(v4);
                } else {
                    0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::deposit<T0>(arg2, v3, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::kind_slashed_bond(), 0x1::option::some<0x2::object::ID>(arg0.market_id), arg0.proposer);
                    let v5 = BondSettled{
                        market_id : arg0.market_id,
                        winner    : @0x0,
                        amount    : 0x2::balance::value<T0>(&v3),
                        slashed   : true,
                    };
                    0x2::event::emit<BondSettled>(v5);
                };
            };
        };
    }

    public fun start<T0>(arg0: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::resolution::Council, arg1: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::ParimutuelMarket<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::state<T0>(arg1) == 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::state_closed(), 11);
        let v0 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::resolution::council_members(arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&v0, &v1), 1);
        let v2 = PariResolution<T0>{
            id                  : 0x2::object::new(arg2),
            market_id           : 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::ParimutuelMarket<T0>>(arg1),
            num_outcomes        : 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::num_outcomes<T0>(arg1),
            proposed            : false,
            proposer            : @0x0,
            proposed_outcome    : 255,
            bond                : 0x2::balance::zero<T0>(),
            dispute_deadline_ms : 0,
            disputed            : false,
            disputer            : @0x0,
            dispute_bond        : 0x2::balance::zero<T0>(),
            votes               : 0x2::vec_map::empty<address, u8>(),
            finalized           : false,
            final_outcome       : 255,
        };
        let v3 = ResolutionStarted{
            market_id  : 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::ParimutuelMarket<T0>>(arg1),
            resolution : 0x2::object::id<PariResolution<T0>>(&v2),
        };
        0x2::event::emit<ResolutionStarted>(v3);
        0x2::transfer::share_object<PariResolution<T0>>(v2);
    }

    fun tally_for(arg0: &0x2::vec_map::VecMap<address, u8>, arg1: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<address, u8>(arg0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, u8>(arg0, v1);
            if (*v3 == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun valid_vote<T0>(arg0: &PariResolution<T0>, arg1: u8) : bool {
        (arg1 as u64) < (arg0.num_outcomes as u64) || arg1 == 255
    }

    public fun vote<T0>(arg0: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::resolution::Council, arg1: &mut PariResolution<T0>, arg2: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::ParimutuelMarket<T0>, arg3: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::Treasury<T0>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.finalized, 0);
        assert!(0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::parimutuel::ParimutuelMarket<T0>>(arg2) == arg1.market_id, 8);
        assert!(valid_vote<T0>(arg1, arg4), 9);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::resolution::council_members(arg0);
        assert!(0x1::vector::contains<address>(&v1, &v0), 1);
        if (0x2::vec_map::contains<address, u8>(&arg1.votes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<address, u8>(&mut arg1.votes, &v0);
        };
        0x2::vec_map::insert<address, u8>(&mut arg1.votes, v0, arg4);
        let v4 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::resolution::council_threshold(arg0);
        let v5 = tally_for(&arg1.votes, arg4);
        let v6 = Voted{
            market_id : arg1.market_id,
            voter     : v0,
            outcome   : arg4,
            tally     : v5,
            threshold : v4,
        };
        0x2::event::emit<Voted>(v6);
        if (v5 >= v4) {
            finalize_internal<T0>(arg1, arg2, arg4, 1);
            settle_bonds<T0>(arg1, arg4, arg3, arg5);
        };
    }

    public fun vote_void() : u8 {
        255
    }

    public fun votes_for<T0>(arg0: &PariResolution<T0>, arg1: u8) : u64 {
        tally_for(&arg0.votes, arg1)
    }

    // decompiled from Move bytecode v7
}

