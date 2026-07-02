module 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::resolution {
    struct Council has key {
        id: 0x2::object::UID,
        members: vector<address>,
        threshold: u64,
    }

    struct CouncilCap has store, key {
        id: 0x2::object::UID,
    }

    struct Resolution<phantom T0> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
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

    struct CouncilCreated has copy, drop {
        council: 0x2::object::ID,
        members: u64,
        threshold: u64,
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

    public fun add_member(arg0: &CouncilCap, arg1: &mut Council, arg2: address) {
        if (!0x1::vector::contains<address>(&arg1.members, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.members, arg2);
        };
        let v0 = min_threshold(0x1::vector::length<address>(&arg1.members));
        if (arg1.threshold < v0) {
            arg1.threshold = v0;
        };
    }

    public fun bond_value<T0>(arg0: &Resolution<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.bond)
    }

    public fun council_members(arg0: &Council) : vector<address> {
        arg0.members
    }

    public fun council_threshold(arg0: &Council) : u64 {
        arg0.threshold
    }

    public fun create_council(arg0: &CouncilCap, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = if (v0 > 0) {
            if (arg2 >= min_threshold(v0)) {
                arg2 <= v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 10);
        let v2 = Council{
            id        : 0x2::object::new(arg3),
            members   : arg1,
            threshold : arg2,
        };
        let v3 = CouncilCreated{
            council   : 0x2::object::id<Council>(&v2),
            members   : 0x1::vector::length<address>(&v2.members),
            threshold : arg2,
        };
        0x2::event::emit<CouncilCreated>(v3);
        0x2::transfer::share_object<Council>(v2);
    }

    public fun dispute<T0>(arg0: &mut Resolution<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
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

    public fun dispute_bond_value<T0>(arg0: &Resolution<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.dispute_bond)
    }

    public fun dispute_window_ms() : u64 {
        86400000
    }

    public fun disputer<T0>(arg0: &Resolution<T0>) : address {
        arg0.disputer
    }

    public fun final_outcome<T0>(arg0: &Resolution<T0>) : u8 {
        arg0.final_outcome
    }

    fun finalize_internal<T0>(arg0: &mut Resolution<T0>, arg1: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg2: u8, arg3: u8) {
        arg0.finalized = true;
        arg0.final_outcome = arg2;
        if (arg2 == 2) {
            0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::set_invalid<T0>(arg1);
        } else {
            0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::set_resolved<T0>(arg1, arg2);
        };
        let v0 = Finalized{
            market_id : arg0.market_id,
            outcome   : arg2,
            by        : arg3,
        };
        0x2::event::emit<Finalized>(v0);
    }

    public fun finalize_optimistic<T0>(arg0: &mut Resolution<T0>, arg1: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finalized, 0);
        assert!(arg0.proposed, 5);
        assert!(!arg0.disputed, 11);
        assert!(0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>>(arg1) == arg0.market_id, 8);
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        setup(arg0);
    }

    public fun is_disputed<T0>(arg0: &Resolution<T0>) : bool {
        arg0.disputed
    }

    public fun is_finalized<T0>(arg0: &Resolution<T0>) : bool {
        arg0.finalized
    }

    public fun is_proposed<T0>(arg0: &Resolution<T0>) : bool {
        arg0.proposed
    }

    fun is_valid_outcome(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg0 == 2
        }
    }

    fun min_threshold(arg0: u64) : u64 {
        (2 * arg0 + 2) / 3
    }

    public fun outcome_invalid() : u8 {
        2
    }

    public fun outcome_no() : u8 {
        0
    }

    public fun outcome_yes() : u8 {
        1
    }

    public fun propose<T0>(arg0: &mut Resolution<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finalized, 0);
        assert!(!arg0.proposed, 6);
        assert!(is_valid_outcome(arg1), 9);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 7);
        arg0.proposed = true;
        arg0.proposer = 0x2::tx_context::sender(arg5);
        arg0.proposed_outcome = arg1;
        0x2::balance::join<T0>(&mut arg0.bond, 0x2::coin::into_balance<T0>(arg2));
        arg0.dispute_deadline_ms = 0x2::clock::timestamp_ms(arg4) + 86400000;
        let v0 = OutcomeProposed{
            market_id   : arg0.market_id,
            outcome     : arg1,
            proposer    : arg0.proposer,
            bond        : 0x2::coin::value<T0>(&arg2),
            deadline_ms : arg0.dispute_deadline_ms,
        };
        0x2::event::emit<OutcomeProposed>(v0);
    }

    public fun proposer<T0>(arg0: &Resolution<T0>) : address {
        arg0.proposer
    }

    public fun set_threshold(arg0: &CouncilCap, arg1: &mut Council, arg2: u64) {
        let v0 = 0x1::vector::length<address>(&arg1.members);
        assert!(arg2 >= min_threshold(v0) && arg2 <= v0, 10);
        arg1.threshold = arg2;
    }

    fun settle_bonds<T0>(arg0: &mut Resolution<T0>, arg1: u8, arg2: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::Treasury<T0>, arg3: &mut 0x2::tx_context::TxContext) {
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
                    0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::deposit<T0>(arg2, v3, 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::kind_slashed_bond(), 0x1::option::some<0x2::object::ID>(arg0.market_id), arg0.proposer);
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

    fun setup(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CouncilCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CouncilCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun start<T0>(arg0: &0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::assert_closed<T0>(arg0);
        let v0 = Resolution<T0>{
            id                  : 0x2::object::new(arg1),
            market_id           : 0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>>(arg0),
            proposed            : false,
            proposer            : @0x0,
            proposed_outcome    : 2,
            bond                : 0x2::balance::zero<T0>(),
            dispute_deadline_ms : 0,
            disputed            : false,
            disputer            : @0x0,
            dispute_bond        : 0x2::balance::zero<T0>(),
            votes               : 0x2::vec_map::empty<address, u8>(),
            finalized           : false,
            final_outcome       : 2,
        };
        let v1 = ResolutionStarted{
            market_id  : 0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>>(arg0),
            resolution : 0x2::object::id<Resolution<T0>>(&v0),
        };
        0x2::event::emit<ResolutionStarted>(v1);
        0x2::transfer::share_object<Resolution<T0>>(v0);
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

    public fun vote<T0>(arg0: &Council, arg1: &mut Resolution<T0>, arg2: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>, arg3: &mut 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::treasury::Treasury<T0>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.finalized, 0);
        assert!(0x2::object::id<0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market::Market<T0>>(arg2) == arg1.market_id, 8);
        assert!(is_valid_outcome(arg4), 9);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg0.members, &v0), 1);
        if (0x2::vec_map::contains<address, u8>(&arg1.votes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<address, u8>(&mut arg1.votes, &v0);
        };
        0x2::vec_map::insert<address, u8>(&mut arg1.votes, v0, arg4);
        let v3 = tally_for(&arg1.votes, arg4);
        let v4 = Voted{
            market_id : arg1.market_id,
            voter     : v0,
            outcome   : arg4,
            tally     : v3,
            threshold : arg0.threshold,
        };
        0x2::event::emit<Voted>(v4);
        if (v3 >= arg0.threshold) {
            finalize_internal<T0>(arg1, arg2, arg4, 1);
            settle_bonds<T0>(arg1, arg4, arg3, arg5);
        };
    }

    public fun votes_for<T0>(arg0: &Resolution<T0>, arg1: u8) : u64 {
        tally_for(&arg0.votes, arg1)
    }

    // decompiled from Move bytecode v7
}

