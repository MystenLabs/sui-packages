module 0x71d16410f64c97eb5d4d85f9a283435d1ce456a4c12493db2e9127bb3a2e0b4c::plhh_dao {
    struct ProposalStatus has copy, drop, store {
        is_active: bool,
        is_executed: bool,
        is_canceled: bool,
        voting_end_time: u64,
        execution_time: u64,
        votes_for: u64,
        votes_against: u64,
        total_voters: u64,
    }

    struct ProposalAction has copy, drop, store {
        action_type: u8,
    }

    struct Proposal has store {
        id: u64,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        created_at: u64,
        status: ProposalStatus,
        action: ProposalAction,
    }

    struct DAOConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        proposal_count: u64,
        voting_period: u64,
        execution_delay: u64,
        quorum_threshold: u64,
    }

    struct DAOStorage has key {
        id: 0x2::object::UID,
        proposals: 0x2::table::Table<u64, Proposal>,
        votes: 0x2::table::Table<address, 0x2::vec_map::VecMap<u64, bool>>,
        voter_count: 0x2::table::Table<u64, u64>,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        created_at: u64,
        voting_end_time: u64,
    }

    struct VoteCast has copy, drop {
        proposal_id: u64,
        voter: address,
        support: bool,
        votes_for: u64,
        votes_against: u64,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: u64,
        executor: address,
        succeeded: bool,
    }

    struct ProposalCanceled has copy, drop {
        proposal_id: u64,
        canceler: address,
    }

    struct DAOConfigChanged has copy, drop {
        parameter: 0x1::string::String,
        old_value: u64,
        new_value: u64,
        admin: address,
    }

    public entry fun cancel_proposal(arg0: &DAOConfig, arg1: &mut DAOStorage, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<u64, Proposal>(&arg1.proposals, arg2), 10);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg1.proposals, arg2);
        assert!(v1.status.is_active, 1);
        assert!(!v1.status.is_executed, 8);
        assert!(!v1.status.is_canceled, 5);
        assert!(v0 == v1.creator || v0 == arg0.admin, 11);
        v1.status.is_active = false;
        v1.status.is_canceled = true;
        let v2 = ProposalCanceled{
            proposal_id : arg2,
            canceler    : v0,
        };
        0x2::event::emit<ProposalCanceled>(v2);
    }

    public entry fun cast_vote(arg0: &mut DAOStorage, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::coin::Coin<0xa787193d3c84a1349a9b68bdf43cecb194780cc05c58dd33431096f1f9ddb95c::plhh::PLHH>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xa787193d3c84a1349a9b68bdf43cecb194780cc05c58dd33431096f1f9ddb95c::plhh::PLHH>(arg4) > 0, 7);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 10);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposals, arg1);
        assert!(v1.status.is_active, 1);
        assert!(!v1.status.is_executed, 8);
        assert!(!v1.status.is_canceled, 5);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 <= v1.status.voting_end_time, 3);
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, bool>>(&arg0.votes, v0)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<u64, bool>>(&mut arg0.votes, v0, 0x2::vec_map::empty<u64, bool>());
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, bool>>(&mut arg0.votes, v0);
        assert!(!0x2::vec_map::contains<u64, bool>(v2, &arg1), 2);
        0x2::vec_map::insert<u64, bool>(v2, arg1, arg2);
        if (arg2) {
            v1.status.votes_for = v1.status.votes_for + 1;
        } else {
            v1.status.votes_against = v1.status.votes_against + 1;
        };
        let v3 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.voter_count, arg1);
        *v3 = *v3 + 1;
        v1.status.total_voters = *v3;
        let v4 = VoteCast{
            proposal_id   : arg1,
            voter         : v0,
            support       : arg2,
            votes_for     : v1.status.votes_for,
            votes_against : v1.status.votes_against,
        };
        0x2::event::emit<VoteCast>(v4);
    }

    public entry fun create_proposal(arg0: &mut DAOConfig, arg1: &mut DAOStorage, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::coin::Coin<0xa787193d3c84a1349a9b68bdf43cecb194780cc05c58dd33431096f1f9ddb95c::plhh::PLHH>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xa787193d3c84a1349a9b68bdf43cecb194780cc05c58dd33431096f1f9ddb95c::plhh::PLHH>(arg6) > 0, 7);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v2 = arg0.proposal_count + 1;
        arg0.proposal_count = v2;
        let v3 = v1 + arg0.voting_period;
        let v4 = ProposalStatus{
            is_active       : true,
            is_executed     : false,
            is_canceled     : false,
            voting_end_time : v3,
            execution_time  : v3 + arg0.execution_delay,
            votes_for       : 0,
            votes_against   : 0,
            total_voters    : 0,
        };
        let v5 = ProposalAction{action_type: arg4};
        let v6 = Proposal{
            id          : v2,
            creator     : v0,
            title       : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            created_at  : v1,
            status      : v4,
            action      : v5,
        };
        0x2::table::add<u64, Proposal>(&mut arg1.proposals, v2, v6);
        0x2::table::add<u64, u64>(&mut arg1.voter_count, v2, 0);
        let v7 = ProposalCreated{
            proposal_id     : v2,
            creator         : v0,
            title           : 0x1::string::utf8(arg2),
            description     : 0x1::string::utf8(arg3),
            created_at      : v1,
            voting_end_time : v3,
        };
        0x2::event::emit<ProposalCreated>(v7);
    }

    public entry fun execute_proposal(arg0: &mut DAOStorage, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 10);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposals, arg1);
        assert!(v1.status.is_active, 1);
        assert!(!v1.status.is_executed, 8);
        assert!(!v1.status.is_canceled, 5);
        assert!(v0 > v1.status.voting_end_time, 4);
        assert!(v0 >= v1.status.execution_time, 6);
        let v2 = v1.status.votes_for > v1.status.votes_against && v1.status.votes_for + v1.status.votes_against > 0;
        v1.status.is_active = false;
        v1.status.is_executed = true;
        let v3 = ProposalExecuted{
            proposal_id : arg1,
            executor    : 0x2::tx_context::sender(arg3),
            succeeded   : v2,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public fun get_dao_config(arg0: &DAOConfig) : (u64, u64, u64, address) {
        (arg0.voting_period, arg0.execution_delay, arg0.quorum_threshold, arg0.admin)
    }

    public fun get_proposal(arg0: &DAOStorage, arg1: u64) : (0x1::string::String, 0x1::string::String, u64, u64, u64, bool, bool, bool) {
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 10);
        let v0 = 0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1);
        (v0.title, v0.description, v0.status.votes_for, v0.status.votes_against, v0.status.total_voters, v0.status.is_active, v0.status.is_executed, v0.status.is_canceled)
    }

    public fun get_proposal_count(arg0: &DAOConfig) : u64 {
        arg0.proposal_count
    }

    public fun has_voted(arg0: &DAOStorage, arg1: address, arg2: u64) : bool {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, bool>>(&arg0.votes, arg1)) {
            return false
        };
        0x2::vec_map::contains<u64, bool>(0x2::table::borrow<address, 0x2::vec_map::VecMap<u64, bool>>(&arg0.votes, arg1), &arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DAOConfig{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            proposal_count   : 0,
            voting_period    : 604800,
            execution_delay  : 172800,
            quorum_threshold : 10,
        };
        let v1 = DAOStorage{
            id          : 0x2::object::new(arg0),
            proposals   : 0x2::table::new<u64, Proposal>(arg0),
            votes       : 0x2::table::new<address, 0x2::vec_map::VecMap<u64, bool>>(arg0),
            voter_count : 0x2::table::new<u64, u64>(arg0),
        };
        0x2::transfer::share_object<DAOConfig>(v0);
        0x2::transfer::share_object<DAOStorage>(v1);
    }

    public fun is_proposal_passed(arg0: &DAOStorage, arg1: u64, arg2: &DAOConfig) : bool {
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 10);
        let v0 = 0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1);
        v0.status.votes_for > v0.status.votes_against
    }

    public entry fun transfer_admin(arg0: &mut DAOConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 11);
        arg0.admin = arg1;
    }

    public entry fun update_dao_config(arg0: &mut DAOConfig, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.admin, 11);
        let v1 = if (0x1::string::utf8(arg1) == 0x1::string::utf8(b"voting_period")) {
            arg0.voting_period = arg2;
            arg0.voting_period
        } else if (0x1::string::utf8(arg1) == 0x1::string::utf8(b"execution_delay")) {
            arg0.execution_delay = arg2;
            arg0.execution_delay
        } else if (0x1::string::utf8(arg1) == 0x1::string::utf8(b"quorum_threshold")) {
            arg0.quorum_threshold = arg2;
            arg0.quorum_threshold
        } else {
            return
        };
        let v2 = DAOConfigChanged{
            parameter : 0x1::string::utf8(arg1),
            old_value : v1,
            new_value : arg2,
            admin     : v0,
        };
        0x2::event::emit<DAOConfigChanged>(v2);
    }

    // decompiled from Move bytecode v6
}

