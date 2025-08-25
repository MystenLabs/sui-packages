module 0xbbec4b87d97ccc46256ee20a55c59ac27b8e01c97ae6a6afaeefa47ad7f81b51::acl {
    struct ACL has store {
        admins: 0x2::vec_set::VecSet<address>,
        roles: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
        upgrade_cap: 0x1::option::Option<0x2::package::UpgradeCap>,
        publisher: 0x1::option::Option<0x2::package::Publisher>,
        fund_receiver: address,
        reward_receiver: address,
        proposals: 0x2::table::Table<u64, Proposal>,
        next_proposal_id: u64,
    }

    struct Proposal has drop, store {
        id: u64,
        proposal_type: u8,
        proposer: address,
        role: u8,
        target: address,
        supporters: 0x2::vec_set::VecSet<address>,
        created_at: u64,
        expired_at: u64,
        executable_after: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        proposal_type: u8,
        proposer: address,
        target: address,
        executable_after: u64,
    }

    struct ProposalVoted has copy, drop {
        proposal_id: u64,
        voter: address,
        total_votes: u64,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: u64,
        executor: address,
        executed_at: u64,
    }

    struct ProposalCancelled has copy, drop {
        proposal_id: u64,
        cancelled_by: address,
        cancelled_at: u64,
    }

    struct UpgradeCapSet has copy, drop {
        set_by: address,
        set_at: u64,
    }

    struct PublisherSet has copy, drop {
        set_by: address,
        set_at: u64,
    }

    struct UpgradeCapTransferred has copy, drop {
        transferred_to: address,
        transferred_at: u64,
    }

    struct PublisherTransferred has copy, drop {
        transferred_to: address,
        transferred_at: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, @0xc0bb56e8f68afc82f7eba7b5c3775a3e57387720039f9b4dd0aaadcb1f0d8d42);
        0x2::vec_set::insert<address>(&mut v0, @0x2522a79181621317b7ea4fe430aef53165ba45e4bc3dc6a4c021f812165fb738);
        0x2::vec_set::insert<address>(&mut v0, @0xb90bfca915824643da287e76caf0b1ce345a0358fb56d5eed965dc93256473cf);
        let v1 = 0x2::table::new<u8, 0x2::vec_set::VecSet<address>>(arg0);
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 0, 0x2::vec_set::empty<address>());
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 1, 0x2::vec_set::empty<address>());
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 2, 0x2::vec_set::empty<address>());
        ACL{
            admins           : v0,
            roles            : v1,
            upgrade_cap      : 0x1::option::none<0x2::package::UpgradeCap>(),
            publisher        : 0x1::option::none<0x2::package::Publisher>(),
            fund_receiver    : @0x0,
            reward_receiver  : @0x0,
            proposals        : 0x2::table::new<u64, Proposal>(arg0),
            next_proposal_id : 0,
        }
    }

    public(friend) fun cancel(arg0: &mut ACL, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 1);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 5);
        let v1 = 0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1);
        if (v1.proposal_type == 1) {
            assert!(v1.target != v0, 9);
        };
        if (0x2::vec_set::size<address>(&v1.supporters) >= 0x2::vec_set::size<address>(&arg0.admins) / 2 + 1 && 0x2::clock::timestamp_ms(arg2) < v1.expired_at) {
            abort 11
        };
        0x2::table::remove<u64, Proposal>(&mut arg0.proposals, arg1);
        let v2 = ProposalCancelled{
            proposal_id  : arg1,
            cancelled_by : v0,
            cancelled_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProposalCancelled>(v2);
    }

    public(friend) fun execute(arg0: &mut ACL, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 1);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 5);
        let v1 = 0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (v1.proposal_type == 0) {
            assert!(v2 >= v1.executable_after, 3);
        };
        assert!(0x2::vec_set::size<address>(&v1.supporters) >= 0x2::vec_set::size<address>(&arg0.admins) / 2 + 1, 2);
        let v3 = 0x2::table::remove<u64, Proposal>(&mut arg0.proposals, arg1);
        execute_proposal_action(arg0, &v3, arg2);
        let v4 = ProposalExecuted{
            proposal_id : arg1,
            executor    : v0,
            executed_at : v2,
        };
        0x2::event::emit<ProposalExecuted>(v4);
    }

    fun execute_proposal_action(arg0: &mut ACL, arg1: &Proposal, arg2: &0x2::clock::Clock) {
        let v0 = arg1.proposal_type;
        if (v0 == 0) {
            0x2::vec_set::insert<address>(&mut arg0.admins, arg1.target);
        } else if (v0 == 1) {
            assert!(0x2::vec_set::size<address>(&arg0.admins) > 1, 6);
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg1.target);
            remove_from_all_roles(arg0, arg1.target);
        } else if (v0 == 2) {
            grant_role_internal(arg0, arg1.target, arg1.role);
        } else if (v0 == 3) {
            revoke_role_internal(arg0, arg1.target, arg1.role);
        } else if (v0 == 4) {
            arg0.fund_receiver = arg1.target;
        } else if (v0 == 5) {
            arg0.reward_receiver = arg1.target;
        } else if (v0 == 6) {
            assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 7);
            0x2::transfer::public_transfer<0x2::package::UpgradeCap>(0x1::option::extract<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap), arg1.target);
            let v1 = UpgradeCapTransferred{
                transferred_to : arg1.target,
                transferred_at : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<UpgradeCapTransferred>(v1);
        } else {
            assert!(v0 == 7, 12);
            assert!(0x1::option::is_some<0x2::package::Publisher>(&arg0.publisher), 8);
            0x2::transfer::public_transfer<0x2::package::Publisher>(0x1::option::extract<0x2::package::Publisher>(&mut arg0.publisher), arg1.target);
            let v2 = PublisherTransferred{
                transferred_to : arg1.target,
                transferred_at : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<PublisherTransferred>(v2);
        };
    }

    public fun get_admin_count(arg0: &ACL) : u64 {
        0x2::vec_set::size<address>(&arg0.admins)
    }

    public fun get_fund_receiver(arg0: &ACL) : address {
        arg0.fund_receiver
    }

    public fun get_reward_receiver(arg0: &ACL) : address {
        arg0.reward_receiver
    }

    fun grant_role_internal(arg0: &mut ACL, arg1: address, arg2: u8) {
        0x2::vec_set::insert<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, arg2), arg1);
    }

    public fun has_publisher(arg0: &ACL) : bool {
        0x1::option::is_some<0x2::package::Publisher>(&arg0.publisher)
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        0x2::table::contains<u8, 0x2::vec_set::VecSet<address>>(&arg0.roles, arg2) && 0x2::vec_set::contains<address>(0x2::table::borrow<u8, 0x2::vec_set::VecSet<address>>(&arg0.roles, arg2), &arg1)
    }

    public fun has_upgrade_cap(arg0: &ACL) : bool {
        0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap)
    }

    public fun is_admin(arg0: &ACL, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public(friend) fun propose(arg0: &mut ACL, arg1: u8, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_admin(arg0, v0), 1);
        let v1 = arg0.next_proposal_id;
        arg0.next_proposal_id = v1 + 1;
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = if (arg1 == 0) {
            v2 + 86400000
        } else {
            v2
        };
        let v4 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v4, v0);
        let v5 = Proposal{
            id               : v1,
            proposal_type    : arg1,
            proposer         : v0,
            role             : arg2,
            target           : arg3,
            supporters       : v4,
            created_at       : v2,
            expired_at       : v2 + 86400000,
            executable_after : v3,
        };
        0x2::table::add<u64, Proposal>(&mut arg0.proposals, v1, v5);
        let v6 = ProposalCreated{
            proposal_id      : v1,
            proposal_type    : arg1,
            proposer         : v0,
            target           : arg3,
            executable_after : v3,
        };
        0x2::event::emit<ProposalCreated>(v6);
        v1
    }

    fun remove_from_all_roles(arg0: &mut ACL, arg1: address) {
        let v0 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, 0);
        if (0x2::vec_set::contains<address>(v0, &arg1)) {
            0x2::vec_set::remove<address>(v0, &arg1);
        };
        let v1 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, 1);
        if (0x2::vec_set::contains<address>(v1, &arg1)) {
            0x2::vec_set::remove<address>(v1, &arg1);
        };
        let v2 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, 2);
        if (0x2::vec_set::contains<address>(v2, &arg1)) {
            0x2::vec_set::remove<address>(v2, &arg1);
        };
    }

    fun revoke_role_internal(arg0: &mut ACL, arg1: address, arg2: u8) {
        let v0 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, arg2);
        if (0x2::vec_set::contains<address>(v0, &arg1)) {
            0x2::vec_set::remove<address>(v0, &arg1);
        };
    }

    public(friend) fun set_publisher(arg0: &mut ACL, arg1: 0x2::package::Publisher, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_none<0x2::package::Publisher>(&arg0.publisher), 8);
        assert!(is_admin(arg0, v0), 1);
        0x1::option::fill<0x2::package::Publisher>(&mut arg0.publisher, arg1);
        let v1 = PublisherSet{
            set_by : v0,
            set_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PublisherSet>(v1);
    }

    public(friend) fun set_upgrade_cap(arg0: &mut ACL, arg1: 0x2::package::UpgradeCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_none<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 7);
        assert!(is_admin(arg0, v0), 1);
        0x1::option::fill<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap, arg1);
        let v1 = UpgradeCapSet{
            set_by : v0,
            set_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UpgradeCapSet>(v1);
    }

    public(friend) fun vote(arg0: &mut ACL, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 1);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 5);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposals, arg1);
        assert!(!0x2::vec_set::contains<address>(&v1.supporters, &v0), 4);
        assert!(0x2::clock::timestamp_ms(arg2) < v1.expired_at, 10);
        0x2::vec_set::insert<address>(&mut v1.supporters, v0);
        let v2 = ProposalVoted{
            proposal_id : arg1,
            voter       : v0,
            total_votes : 0x2::vec_set::size<address>(&v1.supporters),
        };
        0x2::event::emit<ProposalVoted>(v2);
    }

    // decompiled from Move bytecode v6
}

