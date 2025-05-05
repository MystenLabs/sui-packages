module 0xa5624847b0b4ed0ace977e773bd120987b617c5bbed83a095d818a8a3f363be4::dao {
    struct DAOCreatedEvent has copy, drop {
        dao_id: 0x2::object::ID,
        name: 0x1::string::String,
        admin: address,
        timestamp: u64,
    }

    struct MemberAddedEvent has copy, drop {
        dao_id: 0x2::object::ID,
        member: address,
        added_by: address,
        timestamp: u64,
    }

    struct MemberRemovedEvent has copy, drop {
        dao_id: 0x2::object::ID,
        member: address,
        removed_by: address,
        timestamp: u64,
    }

    struct ProposalCreatedEvent has copy, drop {
        dao_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        proposal_type: u8,
        creator: address,
        title: 0x1::string::String,
        expires_at: u64,
    }

    struct VoteCastEvent has copy, drop {
        dao_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        voter: address,
        vote_for: bool,
        vote_weight: u64,
    }

    struct ProposalClosedEvent has copy, drop {
        dao_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        passed: bool,
        votes_for: u64,
        votes_against: u64,
    }

    struct ProposalExecutedEvent has copy, drop {
        dao_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        executed_by: address,
        proposal_type: u8,
        success: bool,
    }

    struct ConfigUpdatedEvent has copy, drop {
        dao_id: 0x2::object::ID,
        config_key: 0x1::string::String,
        config_value: u64,
        updated_by: address,
    }

    struct DAO has drop {
        dummy_field: bool,
    }

    struct DAOState has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        member_count: u64,
        admin: address,
        vote_duration: u64,
        majority_threshold: u64,
        members: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
    }

    struct MemberCap has key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
        member_address: address,
        member_since: u64,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
        proposal_type: u8,
        title: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        created_at: u64,
        expires_at: u64,
        votes_for: u64,
        votes_against: u64,
        voters: 0x2::vec_map::VecMap<address, bool>,
        target_address: 0x1::option::Option<address>,
        config_key: 0x1::option::Option<0x1::string::String>,
        config_value: 0x1::option::Option<u64>,
        is_closed: bool,
        is_executed: bool,
        passed: bool,
    }

    public fun check_expired_proposal(arg0: &DAOState, arg1: &mut Proposal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1.is_closed) {
            return
        };
        assert!(arg1.dao_id == 0x2::object::uid_to_inner(&arg0.id), 7);
        if (0x2::clock::timestamp_ms(arg2) > arg1.expires_at) {
            let v0 = if (arg1.votes_for + arg1.votes_against > 0) {
                arg1.votes_for * 100 / (arg0.member_count + 1)
            } else {
                0
            };
            let v1 = v0 > arg0.majority_threshold;
            arg1.is_closed = true;
            arg1.passed = v1;
            let v2 = ProposalClosedEvent{
                dao_id        : 0x2::object::uid_to_inner(&arg0.id),
                proposal_id   : 0x2::object::uid_to_inner(&arg1.id),
                passed        : v1,
                votes_for     : arg1.votes_for,
                votes_against : arg1.votes_against,
            };
            0x2::event::emit<ProposalClosedEvent>(v2);
            if (v1 && arg1.proposal_type == 0) {
                arg1.is_executed = true;
                let v3 = ProposalExecutedEvent{
                    dao_id        : 0x2::object::uid_to_inner(&arg0.id),
                    proposal_id   : 0x2::object::uid_to_inner(&arg1.id),
                    executed_by   : 0x2::tx_context::sender(arg3),
                    proposal_type : arg1.proposal_type,
                    success       : true,
                };
                0x2::event::emit<ProposalExecutedEvent>(v3);
            };
        };
    }

    public fun close_proposal(arg0: &DAOState, arg1: &mut Proposal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_closed, 3);
        assert!(arg1.dao_id == 0x2::object::uid_to_inner(&arg0.id), 7);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.expires_at, 4);
        let v0 = if (arg1.votes_for + arg1.votes_against > 0) {
            arg1.votes_for * 100 / (arg0.member_count + 1)
        } else {
            0
        };
        let v1 = v0 > arg0.majority_threshold;
        arg1.is_closed = true;
        arg1.passed = v1;
        let v2 = ProposalClosedEvent{
            dao_id        : 0x2::object::uid_to_inner(&arg0.id),
            proposal_id   : 0x2::object::uid_to_inner(&arg1.id),
            passed        : v1,
            votes_for     : arg1.votes_for,
            votes_against : arg1.votes_against,
        };
        0x2::event::emit<ProposalClosedEvent>(v2);
        if (v1 && arg1.proposal_type == 0) {
            arg1.is_executed = true;
            let v3 = ProposalExecutedEvent{
                dao_id        : 0x2::object::uid_to_inner(&arg0.id),
                proposal_id   : 0x2::object::uid_to_inner(&arg1.id),
                executed_by   : 0x2::tx_context::sender(arg3),
                proposal_type : arg1.proposal_type,
                success       : true,
            };
            0x2::event::emit<ProposalExecutedEvent>(v3);
        };
    }

    public fun create_proposal(arg0: &MemberCap, arg1: &DAOState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_member_cap(arg0, arg1, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 + arg1.vote_duration * 1000;
        let v2 = Proposal{
            id             : 0x2::object::new(arg5),
            dao_id         : 0x2::object::uid_to_inner(&arg1.id),
            proposal_type  : 0,
            title          : arg2,
            description    : arg3,
            creator        : 0x2::tx_context::sender(arg5),
            created_at     : v0,
            expires_at     : v1,
            votes_for      : 0,
            votes_against  : 0,
            voters         : 0x2::vec_map::empty<address, bool>(),
            target_address : 0x1::option::none<address>(),
            config_key     : 0x1::option::none<0x1::string::String>(),
            config_value   : 0x1::option::none<u64>(),
            is_closed      : false,
            is_executed    : false,
            passed         : false,
        };
        let v3 = ProposalCreatedEvent{
            dao_id        : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id   : 0x2::object::uid_to_inner(&v2.id),
            proposal_type : 0,
            creator       : 0x2::tx_context::sender(arg5),
            title         : arg2,
            expires_at    : v1,
        };
        0x2::event::emit<ProposalCreatedEvent>(v3);
        0x2::transfer::share_object<Proposal>(v2);
    }

    public fun did_member_vote(arg0: &Proposal, arg1: address) : bool {
        0x2::vec_map::contains<address, bool>(&arg0.voters, &arg1)
    }

    public fun execute_proposal(arg0: &AdminCap, arg1: &mut DAOState, arg2: &mut Proposal, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.dao_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        assert!(arg2.dao_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert!(arg2.is_closed, 4);
        assert!(arg2.passed, 2);
        assert!(!arg2.is_executed, 7);
        let v0 = true;
        if (arg2.proposal_type == 1) {
            let v1 = 0x1::option::extract<address>(&mut arg2.target_address);
            if (!0x2::vec_set::contains<address>(&arg1.members, &v1)) {
                0x2::vec_set::insert<address>(&mut arg1.members, v1);
                arg1.member_count = arg1.member_count + 1;
                let v2 = MemberCap{
                    id             : 0x2::object::new(arg3),
                    dao_id         : 0x2::object::uid_to_inner(&arg1.id),
                    member_address : v1,
                    member_since   : 0x2::tx_context::epoch(arg3),
                };
                let v3 = MemberAddedEvent{
                    dao_id    : 0x2::object::uid_to_inner(&arg1.id),
                    member    : v1,
                    added_by  : 0x2::tx_context::sender(arg3),
                    timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
                };
                0x2::event::emit<MemberAddedEvent>(v3);
                0x2::transfer::transfer<MemberCap>(v2, v1);
            } else {
                v0 = false;
            };
        } else if (arg2.proposal_type == 2) {
            let v4 = 0x1::option::extract<address>(&mut arg2.target_address);
            if (0x2::vec_set::contains<address>(&arg1.members, &v4) && v4 != arg1.admin) {
                0x2::vec_set::remove<address>(&mut arg1.members, &v4);
                arg1.member_count = arg1.member_count - 1;
                let v5 = MemberRemovedEvent{
                    dao_id     : 0x2::object::uid_to_inner(&arg1.id),
                    member     : v4,
                    removed_by : 0x2::tx_context::sender(arg3),
                    timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
                };
                0x2::event::emit<MemberRemovedEvent>(v5);
            } else {
                v0 = false;
            };
        } else if (arg2.proposal_type == 3) {
            let v6 = 0x1::option::extract<0x1::string::String>(&mut arg2.config_key);
            let v7 = 0x1::option::extract<u64>(&mut arg2.config_value);
            if (0x1::string::utf8(b"vote_duration") == v6) {
                arg1.vote_duration = v7;
                let v8 = ConfigUpdatedEvent{
                    dao_id       : 0x2::object::uid_to_inner(&arg1.id),
                    config_key   : v6,
                    config_value : v7,
                    updated_by   : 0x2::tx_context::sender(arg3),
                };
                0x2::event::emit<ConfigUpdatedEvent>(v8);
            } else if (0x1::string::utf8(b"majority_threshold") == v6) {
                if (v7 > 0 && v7 <= 100) {
                    arg1.majority_threshold = v7;
                    let v9 = ConfigUpdatedEvent{
                        dao_id       : 0x2::object::uid_to_inner(&arg1.id),
                        config_key   : v6,
                        config_value : v7,
                        updated_by   : 0x2::tx_context::sender(arg3),
                    };
                    0x2::event::emit<ConfigUpdatedEvent>(v9);
                } else {
                    v0 = false;
                };
            } else {
                v0 = false;
            };
        };
        arg2.is_executed = true;
        let v10 = ProposalExecutedEvent{
            dao_id        : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id   : 0x2::object::uid_to_inner(&arg2.id),
            executed_by   : 0x2::tx_context::sender(arg3),
            proposal_type : arg2.proposal_type,
            success       : v0,
        };
        0x2::event::emit<ProposalExecutedEvent>(v10);
    }

    public fun get_dao_config(arg0: &DAOState) : (u64, u64) {
        (arg0.vote_duration, arg0.majority_threshold)
    }

    public fun get_member_count(arg0: &DAOState) : u64 {
        arg0.member_count
    }

    public fun get_proposal_expiry(arg0: &Proposal) : u64 {
        arg0.expires_at
    }

    public fun get_proposal_status(arg0: &Proposal) : (bool, bool, bool, u64, u64) {
        (arg0.is_closed, arg0.passed, arg0.is_executed, arg0.votes_for, arg0.votes_against)
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"Simple DAO");
        let v1 = DAOState{
            id                 : 0x2::object::new(arg1),
            name               : v0,
            description        : 0x1::string::utf8(b"A simple decentralized autonomous organization"),
            member_count       : 1,
            admin              : 0x2::tx_context::sender(arg1),
            vote_duration      : 604800,
            majority_threshold : 50,
            members            : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = AdminCap{
            id     : 0x2::object::new(arg1),
            dao_id : v2,
        };
        let v4 = MemberCap{
            id             : 0x2::object::new(arg1),
            dao_id         : v2,
            member_address : 0x2::tx_context::sender(arg1),
            member_since   : 0x2::tx_context::epoch(arg1),
        };
        let v5 = DAOCreatedEvent{
            dao_id    : v2,
            name      : v0,
            admin     : 0x2::tx_context::sender(arg1),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DAOCreatedEvent>(v5);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<MemberCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<DAOState>(v1);
    }

    public fun invite_member(arg0: &AdminCap, arg1: &mut DAOState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.dao_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        assert!(!0x2::vec_set::contains<address>(&arg1.members, &arg2), 8);
        0x2::vec_set::insert<address>(&mut arg1.members, arg2);
        let v0 = MemberCap{
            id             : 0x2::object::new(arg3),
            dao_id         : 0x2::object::uid_to_inner(&arg1.id),
            member_address : arg2,
            member_since   : 0x2::tx_context::epoch(arg3),
        };
        arg1.member_count = arg1.member_count + 1;
        let v1 = MemberAddedEvent{
            dao_id    : 0x2::object::uid_to_inner(&arg1.id),
            member    : arg2,
            added_by  : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<MemberAddedEvent>(v1);
        0x2::transfer::transfer<MemberCap>(v0, arg2);
    }

    public fun is_member(arg0: &DAOState, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun propose_add_member(arg0: &MemberCap, arg1: &DAOState, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_member_cap(arg0, arg1, arg6);
        assert!(!0x2::vec_set::contains<address>(&arg1.members, &arg2), 8);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 + arg1.vote_duration * 1000;
        let v2 = Proposal{
            id             : 0x2::object::new(arg6),
            dao_id         : 0x2::object::uid_to_inner(&arg1.id),
            proposal_type  : 1,
            title          : arg3,
            description    : arg4,
            creator        : 0x2::tx_context::sender(arg6),
            created_at     : v0,
            expires_at     : v1,
            votes_for      : 0,
            votes_against  : 0,
            voters         : 0x2::vec_map::empty<address, bool>(),
            target_address : 0x1::option::some<address>(arg2),
            config_key     : 0x1::option::none<0x1::string::String>(),
            config_value   : 0x1::option::none<u64>(),
            is_closed      : false,
            is_executed    : false,
            passed         : false,
        };
        let v3 = ProposalCreatedEvent{
            dao_id        : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id   : 0x2::object::uid_to_inner(&v2.id),
            proposal_type : 1,
            creator       : 0x2::tx_context::sender(arg6),
            title         : arg3,
            expires_at    : v1,
        };
        0x2::event::emit<ProposalCreatedEvent>(v3);
        0x2::transfer::share_object<Proposal>(v2);
    }

    public fun propose_config_update(arg0: &MemberCap, arg1: &DAOState, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        verify_member_cap(arg0, arg1, arg7);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = v0 + arg1.vote_duration * 1000;
        let v2 = Proposal{
            id             : 0x2::object::new(arg7),
            dao_id         : 0x2::object::uid_to_inner(&arg1.id),
            proposal_type  : 3,
            title          : arg4,
            description    : arg5,
            creator        : 0x2::tx_context::sender(arg7),
            created_at     : v0,
            expires_at     : v1,
            votes_for      : 0,
            votes_against  : 0,
            voters         : 0x2::vec_map::empty<address, bool>(),
            target_address : 0x1::option::none<address>(),
            config_key     : 0x1::option::some<0x1::string::String>(arg2),
            config_value   : 0x1::option::some<u64>(arg3),
            is_closed      : false,
            is_executed    : false,
            passed         : false,
        };
        let v3 = ProposalCreatedEvent{
            dao_id        : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id   : 0x2::object::uid_to_inner(&v2.id),
            proposal_type : 3,
            creator       : 0x2::tx_context::sender(arg7),
            title         : arg4,
            expires_at    : v1,
        };
        0x2::event::emit<ProposalCreatedEvent>(v3);
        0x2::transfer::share_object<Proposal>(v2);
    }

    public fun propose_remove_member(arg0: &MemberCap, arg1: &DAOState, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_member_cap(arg0, arg1, arg6);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &arg2), 9);
        assert!(arg2 != arg1.admin, 7);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 + arg1.vote_duration * 1000;
        let v2 = Proposal{
            id             : 0x2::object::new(arg6),
            dao_id         : 0x2::object::uid_to_inner(&arg1.id),
            proposal_type  : 2,
            title          : arg3,
            description    : arg4,
            creator        : 0x2::tx_context::sender(arg6),
            created_at     : v0,
            expires_at     : v1,
            votes_for      : 0,
            votes_against  : 0,
            voters         : 0x2::vec_map::empty<address, bool>(),
            target_address : 0x1::option::some<address>(arg2),
            config_key     : 0x1::option::none<0x1::string::String>(),
            config_value   : 0x1::option::none<u64>(),
            is_closed      : false,
            is_executed    : false,
            passed         : false,
        };
        let v3 = ProposalCreatedEvent{
            dao_id        : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id   : 0x2::object::uid_to_inner(&v2.id),
            proposal_type : 2,
            creator       : 0x2::tx_context::sender(arg6),
            title         : arg3,
            expires_at    : v1,
        };
        0x2::event::emit<ProposalCreatedEvent>(v3);
        0x2::transfer::share_object<Proposal>(v2);
    }

    fun verify_member_cap(arg0: &MemberCap, arg1: &DAOState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dao_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert!(arg0.member_address == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &v0), 1);
    }

    public fun vote(arg0: &MemberCap, arg1: &DAOState, arg2: &mut Proposal, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_member_cap(arg0, arg1, arg5);
        assert!(arg2.dao_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert!(!arg2.is_closed, 3);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg2.expires_at, 6);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::vec_map::contains<address, bool>(&arg2.voters, &v0), 5);
        let v1 = if (0x2::tx_context::sender(arg5) == arg1.admin) {
            2
        } else {
            1
        };
        if (arg3) {
            arg2.votes_for = arg2.votes_for + v1;
        } else {
            arg2.votes_against = arg2.votes_against + v1;
        };
        0x2::vec_map::insert<address, bool>(&mut arg2.voters, 0x2::tx_context::sender(arg5), arg3);
        let v2 = VoteCastEvent{
            dao_id      : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id : 0x2::object::uid_to_inner(&arg2.id),
            voter       : 0x2::tx_context::sender(arg5),
            vote_for    : arg3,
            vote_weight : v1,
        };
        0x2::event::emit<VoteCastEvent>(v2);
        let v3 = arg1.member_count + 1;
        if (arg2.votes_for * 100 / v3 > arg1.majority_threshold) {
            arg2.is_closed = true;
            arg2.passed = true;
            let v4 = ProposalClosedEvent{
                dao_id        : 0x2::object::uid_to_inner(&arg1.id),
                proposal_id   : 0x2::object::uid_to_inner(&arg2.id),
                passed        : true,
                votes_for     : arg2.votes_for,
                votes_against : arg2.votes_against,
            };
            0x2::event::emit<ProposalClosedEvent>(v4);
            if (arg2.proposal_type == 0) {
                arg2.is_executed = true;
                let v5 = ProposalExecutedEvent{
                    dao_id        : 0x2::object::uid_to_inner(&arg1.id),
                    proposal_id   : 0x2::object::uid_to_inner(&arg2.id),
                    executed_by   : 0x2::tx_context::sender(arg5),
                    proposal_type : arg2.proposal_type,
                    success       : true,
                };
                0x2::event::emit<ProposalExecutedEvent>(v5);
            };
        } else if (arg2.votes_against * 100 / v3 > arg1.majority_threshold) {
            arg2.is_closed = true;
            arg2.passed = false;
            let v6 = ProposalClosedEvent{
                dao_id        : 0x2::object::uid_to_inner(&arg1.id),
                proposal_id   : 0x2::object::uid_to_inner(&arg2.id),
                passed        : false,
                votes_for     : arg2.votes_for,
                votes_against : arg2.votes_against,
            };
            0x2::event::emit<ProposalClosedEvent>(v6);
        };
    }

    // decompiled from Move bytecode v6
}

