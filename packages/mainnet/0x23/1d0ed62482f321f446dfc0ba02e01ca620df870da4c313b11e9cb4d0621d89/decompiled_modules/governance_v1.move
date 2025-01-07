module 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1 {
    struct GovernanceInfo has key {
        id: 0x2::object::UID,
        governance_manager_cap: 0x1::option::Option<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceManagerCap>,
        active: bool,
        announce_delay: u64,
        voting_delay: u64,
        max_delay: u64,
        members: vector<address>,
        his_proposal: vector<0x2::object::ID>,
    }

    struct Proposal<T0: drop + store> has key {
        id: 0x2::object::UID,
        creator: address,
        start_vote: u64,
        end_vote: 0x1::option::Option<u64>,
        expired: u64,
        package_id: 0x1::ascii::String,
        certificate: T0,
        favor_votes: vector<address>,
        against_votes: vector<address>,
        state: u8,
    }

    struct ProposalDescId has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateProposal has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    struct ChangeState has copy, drop {
        proposal_id: 0x2::object::ID,
        new_state: u8,
    }

    public entry fun activate_governance(arg0: 0x2::package::UpgradeCap, arg1: &mut GovernanceInfo, arg2: &mut 0x2::tx_context::TxContext) {
        check_member(arg1, 0x2::tx_context::sender(arg2));
        assert!(!arg1.active && 0x1::vector::length<0x2::object::ID>(&arg1.his_proposal) == 0, 0);
        0x1::option::fill<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceManagerCap>(&mut arg1.governance_manager_cap, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::init_genesis(arg0, arg2));
        arg1.active = true;
    }

    public entry fun add_description_for_proposal<T0: drop + store, T1: store>(arg0: &mut Proposal<T0>, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 10);
        let v0 = ProposalDescId{dummy_field: false};
        0x2::dynamic_field::add<ProposalDescId, T1>(&mut arg0.id, v0, arg1);
    }

    public fun add_member(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap, arg1: &mut GovernanceInfo, arg2: address) {
        assert!(!0x1::vector::contains<address>(&mut arg1.members, &arg2), 4);
        0x1::vector::push_back<address>(&mut arg1.members, arg2);
    }

    public entry fun cancel_proposal<T0: drop + store>(arg0: &mut Proposal<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::epoch(arg1) < arg0.expired) {
            assert!(arg0.state == 1, 7);
        };
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 10);
        arg0.state = 5;
        let v0 = ChangeState{
            proposal_id : 0x2::object::id<Proposal<T0>>(arg0),
            new_state   : 5,
        };
        0x2::event::emit<ChangeState>(v0);
    }

    public fun check_member(arg0: &GovernanceInfo, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.members, &arg1), 3);
    }

    public fun create_proposal<T0: drop + store>(arg0: &GovernanceInfo, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        check_member(arg0, v0);
        let v1 = 0x2::tx_context::epoch(arg2) + arg0.announce_delay;
        let v2 = if (arg0.voting_delay == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v1 + arg0.voting_delay)
        };
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = Proposal<T0>{
            id            : v3,
            creator       : v0,
            start_vote    : v1,
            end_vote      : v2,
            expired       : 0x2::tx_context::epoch(arg2) + arg0.max_delay,
            package_id    : 0x1::type_name::get_address(&v4),
            certificate   : arg1,
            favor_votes   : 0x1::vector::empty<address>(),
            against_votes : 0x1::vector::empty<address>(),
            state         : 1,
        };
        0x2::transfer::share_object<Proposal<T0>>(v5);
        let v6 = CreateProposal{proposal_id: *0x2::object::uid_as_inner(&v3)};
        0x2::event::emit<CreateProposal>(v6);
    }

    public fun create_proposal_with_history<T0: drop + store>(arg0: &mut GovernanceInfo, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        check_member(arg0, v0);
        let v1 = 0x2::tx_context::epoch(arg2) + arg0.announce_delay;
        let v2 = if (arg0.voting_delay == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v1 + arg0.voting_delay)
        };
        let v3 = 0x2::object::new(arg2);
        let v4 = *0x2::object::uid_as_inner(&v3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.his_proposal, v4);
        let v5 = 0x1::type_name::get<T0>();
        let v6 = Proposal<T0>{
            id            : v3,
            creator       : v0,
            start_vote    : v1,
            end_vote      : v2,
            expired       : 0x2::tx_context::epoch(arg2) + arg0.max_delay,
            package_id    : 0x1::type_name::get_address(&v5),
            certificate   : arg1,
            favor_votes   : 0x1::vector::empty<address>(),
            against_votes : 0x1::vector::empty<address>(),
            state         : 1,
        };
        0x2::transfer::share_object<Proposal<T0>>(v6);
        let v7 = CreateProposal{proposal_id: v4};
        0x2::event::emit<CreateProposal>(v7);
    }

    public fun destroy_governance_cap(arg0: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::destroy(arg0);
    }

    public fun ensure_two_thirds(arg0: u64, arg1: u64) : bool {
        let v0 = if (arg0 % 3 == 0) {
            arg0 * 2 / 3
        } else {
            arg0 * 2 / 3 + 1
        };
        arg1 >= v0
    }

    public fun get_his_proposal(arg0: &GovernanceInfo) : &vector<0x2::object::ID> {
        &arg0.his_proposal
    }

    public fun get_proposal_state<T0: drop + store>(arg0: &mut Proposal<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x1::ascii::String {
        if (arg0.state == 3) {
            0x1::ascii::string(b"SUCCESS")
        } else if (arg0.state == 4) {
            0x1::ascii::string(b"FAIL")
        } else if (arg0.state == 5) {
            0x1::ascii::string(b"CANCEL")
        } else if (0x2::tx_context::epoch(arg1) >= arg0.expired) {
            0x1::ascii::string(b"EXPIRED")
        } else if (arg0.state == 1) {
            0x1::ascii::string(b"ANNOUNCEMENT_PENDING")
        } else {
            0x1::ascii::string(b"VOTING_PENDING")
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GovernanceInfo{
            id                     : 0x2::object::new(arg0),
            governance_manager_cap : 0x1::option::none<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceManagerCap>(),
            active                 : false,
            announce_delay         : 0,
            voting_delay           : 0,
            max_delay              : 30,
            members                : v0,
            his_proposal           : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<GovernanceInfo>(v1);
    }

    public fun remove_member(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap, arg1: &mut GovernanceInfo, arg2: address) {
        check_member(arg1, arg2);
        let (_, v1) = 0x1::vector::index_of<address>(&mut arg1.members, &arg2);
        0x1::vector::remove<address>(&mut arg1.members, v1);
    }

    public fun update_delay(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap, arg1: &mut GovernanceInfo, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg4 > arg3 + arg2, 2);
        arg1.announce_delay = arg2;
        arg1.voting_delay = arg3;
        arg1.max_delay = arg4;
    }

    public fun upgrade(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap, arg1: &mut GovernanceInfo) : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceManagerCap {
        arg1.active = false;
        0x1::option::extract<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceManagerCap>(&mut arg1.governance_manager_cap)
    }

    public fun vote_proposal<T0: drop + store>(arg0: &GovernanceInfo, arg1: T0, arg2: &mut Proposal<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap> {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(v0 >= arg2.start_vote, 6);
        assert!(v0 < arg2.expired, 9);
        if (arg2.state == 1) {
            arg2.state = 2;
            let v1 = ChangeState{
                proposal_id : 0x2::object::id<Proposal<T0>>(arg2),
                new_state   : 2,
            };
            0x2::event::emit<ChangeState>(v1);
        };
        assert!(arg2.state == 2, 8);
        let v2 = 0x2::tx_context::sender(arg4);
        check_member(arg0, v2);
        let v3 = &mut arg2.favor_votes;
        let v4 = &mut arg2.against_votes;
        if (0x1::option::is_none<u64>(&arg2.end_vote) || v0 < *0x1::option::borrow<u64>(&arg2.end_vote)) {
            assert!(!0x1::vector::contains<address>(v3, &v2) && !0x1::vector::contains<address>(v4, &v2), 5);
            if (arg3) {
                0x1::vector::push_back<address>(v3, v2);
            } else {
                0x1::vector::push_back<address>(v4, v2);
            };
        };
        if (0x1::option::is_none<u64>(&arg2.end_vote) || v0 >= *0x1::option::borrow<u64>(&arg2.end_vote)) {
            if (ensure_two_thirds(0x1::vector::length<address>(&arg0.members), 0x1::vector::length<address>(v3))) {
                arg2.state = 3;
                let v5 = ChangeState{
                    proposal_id : 0x2::object::id<Proposal<T0>>(arg2),
                    new_state   : 3,
                };
                0x2::event::emit<ChangeState>(v5);
                return 0x1::option::some<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::create(0x1::option::borrow<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceManagerCap>(&arg0.governance_manager_cap)))
            };
            if (0x1::option::is_some<u64>(&arg2.end_vote)) {
                arg2.state = 4;
                let v6 = ChangeState{
                    proposal_id : 0x2::object::id<Proposal<T0>>(arg2),
                    new_state   : 4,
                };
                0x2::event::emit<ChangeState>(v6);
            };
            return 0x1::option::none<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>()
        };
        0x1::option::none<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>()
    }

    // decompiled from Move bytecode v6
}

