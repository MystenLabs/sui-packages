module 0xa767d4cefd85c24d182c32fe87d0ce3ecca3dae0736729819073d9a973db249d::governance {
    struct AdminAddedEvent has copy, drop, store {
        admin: address,
    }

    struct AdminRemovedEvent has copy, drop, store {
        admin: address,
    }

    struct ConfigSetEvent has copy, drop, store {
        by: address,
        new_config_id: u64,
    }

    struct ProposalCreatedEvent has copy, drop, store {
        id: address,
        proposer: address,
        description: vector<u8>,
    }

    struct VotedEvent has copy, drop, store {
        proposal_id: address,
        voter: address,
        support: bool,
        amount: u64,
    }

    struct ProposalExecutedEvent has copy, drop, store {
        id: address,
        passed: bool,
    }

    struct Config has store {
        id: u64,
    }

    struct LendingPoolWhitelist has store {
        id: 0x2::object::UID,
        pools: vector<address>,
        approved: vector<bool>,
    }

    struct FeeConfig has store {
        performance_fee_bps: u64,
        management_fee_bps: u64,
        fee_recipient: address,
    }

    struct Governance has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
        config: Config,
        fee_config: FeeConfig,
        lending_pool_whitelist: LendingPoolWhitelist,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        proposer: address,
        description: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        executed: bool,
        deadline: u64,
    }

    struct ProposalState has store, key {
        id: 0x2::object::UID,
        proposals: vector<Proposal>,
        voting_period: u64,
        min_shares_to_propose: u64,
    }

    public entry fun add_admin(arg0: &mut Governance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        if (!0x1::vector::contains<address>(&arg0.admins, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
            let v0 = AdminAddedEvent{admin: arg1};
            0x2::event::emit<AdminAddedEvent>(v0);
        };
    }

    public entry fun add_lending_pool(arg0: &mut Governance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        0x1::vector::push_back<address>(&mut arg0.lending_pool_whitelist.pools, arg1);
        0x1::vector::push_back<bool>(&mut arg0.lending_pool_whitelist.approved, false);
    }

    public entry fun approve_lending_pool(arg0: &mut Governance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.lending_pool_whitelist.pools)) {
            if (0x1::vector::borrow<address>(&arg0.lending_pool_whitelist.pools, v0) == &arg1) {
                *0x1::vector::borrow_mut<bool>(&mut arg0.lending_pool_whitelist.approved, v0) = true;
                break
            };
            v0 = v0 + 1;
        };
    }

    fun assert_admin(arg0: &Governance, arg1: address) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.admins)) {
            if (0x1::vector::borrow<address>(&arg0.admins, v1) == &arg1) {
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 0);
    }

    public entry fun execute(arg0: &mut ProposalState, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.proposals;
        let v1 = find_proposal_mut(v0, arg1);
        assert!(!v1.executed, 102);
        assert!(0x2::tx_context::epoch(arg2) > v1.deadline, 103);
        v1.executed = true;
        let v2 = ProposalExecutedEvent{
            id     : arg1,
            passed : v1.votes_for > v1.votes_against,
        };
        0x2::event::emit<ProposalExecutedEvent>(v2);
    }

    fun find_proposal_mut(arg0: &mut vector<Proposal>, arg1: address) : &mut Proposal {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Proposal>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<Proposal>(arg0, v0);
            if (0x2::object::uid_to_address(&v1.id) == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 104
    }

    public fun get_config(arg0: &Governance) : u64 {
        arg0.config.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{id: 0};
        let v2 = FeeConfig{
            performance_fee_bps : 0,
            management_fee_bps  : 0,
            fee_recipient       : v0,
        };
        let v3 = LendingPoolWhitelist{
            id       : 0x2::object::new(arg0),
            pools    : 0x1::vector::empty<address>(),
            approved : 0x1::vector::empty<bool>(),
        };
        let v4 = Governance{
            id                     : 0x2::object::new(arg0),
            admins                 : 0x1::vector::singleton<address>(v0),
            config                 : v1,
            fee_config             : v2,
            lending_pool_whitelist : v3,
        };
        0x2::transfer::public_share_object<Governance>(v4);
    }

    public entry fun init_proposal_state(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalState{
            id                    : 0x2::object::new(arg2),
            proposals             : 0x1::vector::empty<Proposal>(),
            voting_period         : arg0,
            min_shares_to_propose : arg1,
        };
        0x2::transfer::public_share_object<ProposalState>(v0);
    }

    public fun is_admin(arg0: &Governance, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun propose(arg0: &mut ProposalState, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2 >= arg0.min_shares_to_propose, 100);
        let v1 = Proposal{
            id            : 0x2::object::new(arg3),
            proposer      : v0,
            description   : arg1,
            votes_for     : 0,
            votes_against : 0,
            executed      : false,
            deadline      : 0x2::tx_context::epoch(arg3) + arg0.voting_period,
        };
        0x1::vector::push_back<Proposal>(&mut arg0.proposals, v1);
        let v2 = 0x1::vector::borrow<Proposal>(&arg0.proposals, 0x1::vector::length<Proposal>(&arg0.proposals) - 1);
        let v3 = ProposalCreatedEvent{
            id          : 0x2::object::uid_to_address(&v2.id),
            proposer    : v0,
            description : v2.description,
        };
        0x2::event::emit<ProposalCreatedEvent>(v3);
    }

    public entry fun remove_admin(arg0: &mut Governance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::vector::length<address>(&arg0.admins);
        assert!(v0 > 1, 1);
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::borrow<address>(&arg0.admins, v1) == &arg1) {
                0x1::vector::swap_remove<address>(&mut arg0.admins, v1);
                let v2 = AdminRemovedEvent{admin: arg1};
                0x2::event::emit<AdminRemovedEvent>(v2);
                break
            };
            v1 = v1 + 1;
        };
    }

    public entry fun set_config(arg0: &mut Governance, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_admin(arg0, v0);
        arg0.config.id = arg1;
        let v1 = ConfigSetEvent{
            by            : v0,
            new_config_id : arg1,
        };
        0x2::event::emit<ConfigSetEvent>(v1);
    }

    public entry fun set_fee_config(arg0: &mut Governance, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_admin(arg0, v0);
        arg0.fee_config.performance_fee_bps = arg1;
        arg0.fee_config.management_fee_bps = arg2;
        arg0.fee_config.fee_recipient = arg3;
        let v1 = ConfigSetEvent{
            by            : v0,
            new_config_id : arg0.config.id,
        };
        0x2::event::emit<ConfigSetEvent>(v1);
    }

    public entry fun set_lending_pool_whitelist(arg0: &mut Governance, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.lending_pool_whitelist.pools = arg1;
        arg0.lending_pool_whitelist.approved = 0x1::vector::empty<bool>();
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x1::vector::push_back<bool>(&mut arg0.lending_pool_whitelist.approved, false);
            v0 = v0 + 1;
        };
    }

    public entry fun vote(arg0: &mut ProposalState, arg1: address, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.proposals;
        let v1 = find_proposal_mut(v0, arg1);
        assert!(0x2::tx_context::epoch(arg4) <= v1.deadline, 101);
        if (arg2) {
            v1.votes_for = v1.votes_for + arg3;
        } else {
            v1.votes_against = v1.votes_against + arg3;
        };
        let v2 = VotedEvent{
            proposal_id : arg1,
            voter       : 0x2::tx_context::sender(arg4),
            support     : arg2,
            amount      : arg3,
        };
        0x2::event::emit<VotedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

