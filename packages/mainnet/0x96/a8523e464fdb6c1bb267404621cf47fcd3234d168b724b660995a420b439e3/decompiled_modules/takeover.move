module 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::takeover {
    struct ProposalMigrated has copy, drop {
        proposal_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct CreatorHeartbeat has copy, drop {
        curve_id: 0x2::object::ID,
        at_ms: u64,
    }

    struct TakeoverProposed has copy, drop {
        curve_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        proposer: address,
        deadline_ms: u64,
    }

    struct TakeoverVoted has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        amount: u64,
        total_weight: u64,
    }

    struct TakeoverUnvoted has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        amount: u64,
    }

    struct TakeoverResolved has copy, drop {
        proposal_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        succeeded: bool,
        total_weight: u64,
    }

    struct VoteReclaimed has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        amount: u64,
    }

    struct TakeoverProposal<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        proposer: address,
        proposer_bond: u64,
        opened_at_ms: u64,
        deadline_ms: u64,
        escrow: 0x2::balance::Balance<T0>,
        votes: 0x2::table::Table<address, u64>,
        total_weight: u64,
        quorum_target: u64,
        resolved: bool,
        succeeded: bool,
        version: u64,
    }

    fun assert_proposal_version<T0>(arg0: &TakeoverProposal<T0>) {
        assert!(arg0.version == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13853635738754744355);
    }

    public fun creator_heartbeat<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::CreatorCap, arg1: &mut 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::assert_curve_version<T0>(arg1);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::assert_active_creator<T0>(arg0, arg1);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::stamp_creator_activity<T0>(arg1, arg2);
        let v0 = CreatorHeartbeat{
            curve_id : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg1),
            at_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CreatorHeartbeat>(v0);
    }

    public fun destroy_resolved_proposal<T0>(arg0: TakeoverProposal<T0>) {
        assert!(arg0.resolved, 13851385416409153561);
        assert!(0x2::balance::value<T0>(&arg0.escrow) == 0, 13859548195029123103);
        assert!(0x2::table::is_empty<address, u64>(&arg0.votes), 13859829674300932129);
        let TakeoverProposal {
            id            : v0,
            curve_id      : _,
            proposer      : _,
            proposer_bond : _,
            opened_at_ms  : _,
            deadline_ms   : _,
            escrow        : v6,
            votes         : v7,
            total_weight  : _,
            quorum_target : _,
            resolved      : _,
            succeeded     : _,
            version       : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v6);
        0x2::table::destroy_empty<address, u64>(v7);
        0x2::object::delete(v0);
    }

    public fun migrate_proposal<T0>(arg0: &mut TakeoverProposal<T0>) {
        assert!(arg0.version < 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13853635781704417315);
        arg0.version = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current();
        let v0 = ProposalMigrated{
            proposal_id  : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            from_version : arg0.version,
            to_version   : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        0x2::event::emit<ProposalMigrated>(v0);
    }

    public fun proposal_curve_id<T0>(arg0: &TakeoverProposal<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun proposal_deadline_ms<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun proposal_escrow_value<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun proposal_has_voter<T0>(arg0: &TakeoverProposal<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.votes, arg1)
    }

    public fun proposal_proposer<T0>(arg0: &TakeoverProposal<T0>) : address {
        arg0.proposer
    }

    public fun proposal_quorum_target<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        arg0.quorum_target
    }

    public fun proposal_resolved<T0>(arg0: &TakeoverProposal<T0>) : bool {
        arg0.resolved
    }

    public fun proposal_succeeded<T0>(arg0: &TakeoverProposal<T0>) : bool {
        arg0.succeeded
    }

    public fun proposal_total_weight<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        arg0.total_weight
    }

    public fun proposal_version<T0>(arg0: &TakeoverProposal<T0>) : u64 {
        arg0.version
    }

    public fun proposal_voter_weight<T0>(arg0: &TakeoverProposal<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.votes, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.votes, arg1)
        } else {
            0
        }
    }

    public fun propose_takeover<T0>(arg0: &mut 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::assert_curve_version<T0>(arg0);
        assert!(!0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::graduated<T0>(arg0), 13836184801297563649);
        assert!(!0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::paused<T0>(arg0), 13842940213623652355);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::last_creator_activity_ms<T0>(arg0) >= 432000000, 13846317921934245893);
        assert!(v0 >= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::cto_cooldown_until_ms<T0>(arg0), 13846599401206054919);
        assert!(!0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::has_live_takeover<T0>(arg0), 13850540055175757843);
        let v1 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::circulating_supply<T0>(arg0);
        assert!(v1 > 0, 13851665985147895835);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 13851665998032797723);
        assert!(v2 >= v1 * 100 / 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13846880927722504201);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = 0x2::table::new<address, u64>(arg3);
        0x2::table::add<address, u64>(&mut v4, v3, v2);
        let v5 = TakeoverProposal<T0>{
            id            : 0x2::object::new(arg3),
            curve_id      : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg0),
            proposer      : v3,
            proposer_bond : v2,
            opened_at_ms  : v0,
            deadline_ms   : v0 + 259200000,
            escrow        : 0x2::coin::into_balance<T0>(arg1),
            votes         : v4,
            total_weight  : v2,
            quorum_target : v1 * 2500 / 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(),
            resolved      : false,
            succeeded     : false,
            version       : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        let v6 = 0x2::object::id<TakeoverProposal<T0>>(&v5);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::set_live_takeover<T0>(arg0, v6);
        let v7 = TakeoverProposed{
            curve_id    : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg0),
            proposal_id : v6,
            proposer    : v3,
            deadline_ms : v5.deadline_ms,
        };
        0x2::event::emit<TakeoverProposed>(v7);
        0x2::transfer::share_object<TakeoverProposal<T0>>(v5);
    }

    public fun reclaim_vote<T0>(arg0: &mut TakeoverProposal<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolved, 13851385330509807641);
        assert!(0x2::table::contains<address, u64>(&arg0.votes, arg1), 13851103859827933207);
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.votes, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v0), arg2), arg1);
        let v1 = VoteReclaimed{
            proposal_id : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            voter       : arg1,
            amount      : v0,
        };
        0x2::event::emit<VoteReclaimed>(v1);
    }

    public fun resolve_takeover<T0>(arg0: &mut TakeoverProposal<T0>, arg1: &mut 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::assert_curve_version<T0>(arg1);
        assert!(arg0.curve_id == 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg1), 13847444436021805067);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.deadline_ms, 13848007394565423119);
        assert!(!arg0.resolved, 13848570348813942801);
        let v1 = arg0.quorum_target;
        let v2 = if (v0 - 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::last_creator_activity_ms<T0>(arg1) >= 432000000) {
            if (v1 > 0) {
                if (arg0.total_weight > 0) {
                    arg0.total_weight >= v1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::live_takeover_id<T0>(arg1) == 0x2::object::id<TakeoverProposal<T0>>(arg0), 13847444496151347211);
        arg0.resolved = true;
        arg0.succeeded = v2;
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::take_live_takeover<T0>(arg1);
        if (v2) {
            0x2::transfer::public_transfer<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::CreatorCap>(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::install_takeover_winner<T0>(arg1, arg0.proposer, v0, arg3), arg0.proposer);
        } else {
            let v3 = if (arg0.total_weight >= v1) {
                0
            } else {
                v1 - arg0.total_weight
            };
            let v4 = if (v1 == 0) {
                259200000
            } else {
                (((259200000 as u128) * (v3 as u128) / (v1 as u128)) as u64)
            };
            0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::set_cto_cooldown_until_ms<T0>(arg1, v0 + v4);
        };
        let v5 = TakeoverResolved{
            proposal_id  : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            curve_id     : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg1),
            succeeded    : v2,
            total_weight : arg0.total_weight,
        };
        0x2::event::emit<TakeoverResolved>(v5);
    }

    public fun unvote_takeover<T0>(arg0: &mut TakeoverProposal<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_proposal_version<T0>(arg0);
        assert!(!arg0.resolved, 13848570129770610705);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.deadline_ms, 13847725713430151181);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.votes, v0), 13851103421741269015);
        let v1 = if (v0 == arg0.proposer) {
            let v2 = *0x2::table::borrow<address, u64>(&arg0.votes, v0) - arg0.proposer_bond;
            assert!(v2 > 0, 13851947876736565277);
            *0x2::table::borrow_mut<address, u64>(&mut arg0.votes, v0) = arg0.proposer_bond;
            v2
        } else {
            0x2::table::remove<address, u64>(&mut arg0.votes, v0)
        };
        arg0.total_weight = arg0.total_weight - v1;
        let v3 = TakeoverUnvoted{
            proposal_id : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            voter       : v0,
            amount      : v1,
        };
        0x2::event::emit<TakeoverUnvoted>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v1), arg2)
    }

    public fun vote_takeover<T0>(arg0: &mut TakeoverProposal<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_proposal_version<T0>(arg0);
        assert!(!arg0.resolved, 13848569983741722641);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.deadline_ms, 13847725567401263117);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::curve_supply() * 1 / 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13850821805030506517);
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::coin::into_balance<T0>(arg1));
        let v1 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u64>(&arg0.votes, v1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.votes, v1) = *0x2::table::borrow<address, u64>(&arg0.votes, v1) + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.votes, v1, v0);
        };
        arg0.total_weight = arg0.total_weight + v0;
        let v2 = TakeoverVoted{
            proposal_id  : 0x2::object::id<TakeoverProposal<T0>>(arg0),
            voter        : v1,
            amount       : v0,
            total_weight : arg0.total_weight,
        };
        0x2::event::emit<TakeoverVoted>(v2);
    }

    // decompiled from Move bytecode v7
}

