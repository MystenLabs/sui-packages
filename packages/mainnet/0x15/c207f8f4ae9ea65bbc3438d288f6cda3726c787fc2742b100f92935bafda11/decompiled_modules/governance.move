module 0x15c207f8f4ae9ea65bbc3438d288f6cda3726c787fc2742b100f92935bafda11::governance {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GovernanceConfig has key {
        id: 0x2::object::UID,
        voting_period: u64,
        whitelist: vector<address>,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        address: address,
        name: vector<u8>,
        metadata: vector<u8>,
        votes: vector<address>,
        timestamp: u64,
        executed: bool,
    }

    struct ProposalCreatedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        address: address,
        name: vector<u8>,
        metadata: vector<u8>,
        timestamp: u64,
    }

    struct ProposalExecutedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        address: address,
        result: bool,
    }

    struct VoteCastEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        address: address,
        vote: bool,
    }

    public entry fun cast_vote(arg0: &mut Proposal, arg1: &GovernanceConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.timestamp;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= v0, 1);
        assert!(v1 < v0 + arg1.voting_period, 2);
        let v2 = 0x2::tx_context::sender(arg4);
        if (0x1::vector::contains<address>(&arg0.votes, &v2)) {
            assert!(arg2 == false, 3);
            let (_, v4) = 0x1::vector::index_of<address>(&arg0.votes, &v2);
            0x1::vector::remove<address>(&mut arg0.votes, v4);
        } else {
            assert!(arg2 == true, 3);
            0x1::vector::push_back<address>(&mut arg0.votes, v2);
        };
        let v5 = VoteCastEvent{
            proposal_id : 0x2::object::uid_to_inner(&arg0.id),
            address     : v2,
            vote        : arg2,
        };
        0x2::event::emit<VoteCastEvent>(v5);
    }

    public entry fun create_proposal(arg0: &AdminCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = Proposal{
            id        : v0,
            address   : arg1,
            name      : arg2,
            metadata  : arg3,
            votes     : vector[],
            timestamp : arg4,
            executed  : false,
        };
        0x2::transfer::share_object<Proposal>(v1);
        let v2 = ProposalCreatedEvent{
            proposal_id : 0x2::object::uid_to_inner(&v0),
            address     : arg1,
            name        : arg2,
            metadata    : arg3,
            timestamp   : arg4,
        };
        0x2::event::emit<ProposalCreatedEvent>(v2);
    }

    public fun execute_proposal(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: &mut Proposal, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) > arg2.timestamp + arg1.voting_period, 3);
        assert!(!arg2.executed, 5);
        arg2.executed = true;
        if (arg3) {
            0x1::vector::push_back<address>(&mut arg1.whitelist, arg2.address);
        };
        let v0 = ProposalExecutedEvent{
            proposal_id : 0x2::object::uid_to_inner(&arg2.id),
            address     : arg2.address,
            result      : arg3,
        };
        0x2::event::emit<ProposalExecutedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_governance(arg0: &AdminCap, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceConfig{
            id            : 0x2::object::new(arg3),
            voting_period : arg1,
            whitelist     : arg2,
        };
        0x2::transfer::share_object<GovernanceConfig>(v0);
    }

    public fun is_whitelisted(arg0: &mut GovernanceConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelist, &arg1)
    }

    // decompiled from Move bytecode v6
}

