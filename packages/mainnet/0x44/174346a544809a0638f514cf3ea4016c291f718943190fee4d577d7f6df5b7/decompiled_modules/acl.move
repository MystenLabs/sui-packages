module 0x44174346a544809a0638f514cf3ea4016c291f718943190fee4d577d7f6df5b7::acl {
    struct ACL has store {
        admins: 0x2::vec_set::VecSet<address>,
        roles: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
        upgrade_cap: 0x1::option::Option<0x2::package::UpgradeCap>,
        default_upgrade_cap_id: 0x1::option::Option<address>,
        publisher: 0x1::option::Option<0x2::package::Publisher>,
        fund_receiver: 0x1::option::Option<address>,
        reward_receiver: 0x1::option::Option<address>,
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

    struct ProposalAutoRemoved has copy, drop {
        proposal_id: u64,
        removed_by: address,
        removed_at: u64,
        is_expired: bool,
    }

    struct DefaultUpgradeCapIdSet has copy, drop {
        cap_id: address,
        set_by: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, @0x93e07864e87bad3c0260d0aa594a75a7994ce2634cc99fdaa445c689b59f04b0);
        0x2::vec_set::insert<address>(&mut v0, @0x39e7b1f07f969ca1f7fb45649c68f05e1c45b237af3cbaf6417fdc9af99f27ac);
        0x2::vec_set::insert<address>(&mut v0, @0x2cf885600322cd77510ef1b07accc403878c9724e2608c7e8ad5a5db5efad78c);
        let v1 = 0x2::table::new<u8, 0x2::vec_set::VecSet<address>>(arg0);
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 0, 0x2::vec_set::empty<address>());
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 1, 0x2::vec_set::empty<address>());
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 2, 0x2::vec_set::empty<address>());
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v1, 3, 0x2::vec_set::empty<address>());
        ACL{
            admins                 : v0,
            roles                  : v1,
            upgrade_cap            : 0x1::option::none<0x2::package::UpgradeCap>(),
            default_upgrade_cap_id : 0x1::option::none<address>(),
            publisher              : 0x1::option::none<0x2::package::Publisher>(),
            fund_receiver          : 0x1::option::none<address>(),
            reward_receiver        : 0x1::option::none<address>(),
            proposals              : 0x2::table::new<u64, Proposal>(arg0),
            next_proposal_id       : 0,
        }
    }

    public(friend) fun cancel(arg0: &mut ACL, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 101);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 105);
        let v1 = 0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1);
        if (v1.proposal_type == 1 || v1.proposal_type == 3) {
            assert!(v1.target != v0, 109);
        };
        if (0x2::vec_set::size<address>(&v1.supporters) >= 0x2::vec_set::size<address>(&arg0.admins) / 2 + 1 && 0x2::clock::timestamp_ms(arg2) < v1.expired_at) {
            abort 111
        };
        0x2::table::remove<u64, Proposal>(&mut arg0.proposals, arg1);
        let v2 = ProposalCancelled{
            proposal_id  : arg1,
            cancelled_by : v0,
            cancelled_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProposalCancelled>(v2);
    }

    public fun config_role() : u8 {
        0
    }

    fun count_valid_admin_votes(arg0: &ACL, arg1: &0x2::vec_set::VecSet<address>) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_set::into_keys<address>(*arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            if (is_admin(arg0, *0x1::vector::borrow<address>(&v1, v2))) {
                v0 = v0 + 1;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun execute(arg0: &mut ACL, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 101);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 105);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1);
        let v3 = v1 > v2.expired_at;
        let v4 = !v3 && is_proposal_still_valid(arg0, v2);
        assert!(v1 >= v2.executable_after, 103);
        if (v3 || !v4) {
            0x2::table::remove<u64, Proposal>(&mut arg0.proposals, arg1);
            let v5 = ProposalAutoRemoved{
                proposal_id : arg1,
                removed_by  : v0,
                removed_at  : v1,
                is_expired  : v3,
            };
            0x2::event::emit<ProposalAutoRemoved>(v5);
            return
        };
        assert!(count_valid_admin_votes(arg0, &v2.supporters) >= 0x2::vec_set::size<address>(&arg0.admins) / 2 + 1, 102);
        let v6 = 0x2::table::remove<u64, Proposal>(&mut arg0.proposals, arg1);
        execute_proposal_action(arg0, &v6, arg2);
        let v7 = ProposalExecuted{
            proposal_id : arg1,
            executor    : v0,
            executed_at : v1,
        };
        0x2::event::emit<ProposalExecuted>(v7);
    }

    fun execute_proposal_action(arg0: &mut ACL, arg1: &Proposal, arg2: &0x2::clock::Clock) {
        let v0 = arg1.proposal_type;
        if (v0 == 0) {
            0x2::vec_set::insert<address>(&mut arg0.admins, arg1.target);
        } else if (v0 == 1) {
            assert!(0x2::vec_set::size<address>(&arg0.admins) > 1, 106);
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg1.target);
            remove_from_all_roles(arg0, arg1.target);
        } else if (v0 == 2) {
            grant_role_internal(arg0, arg1.target, arg1.role);
        } else if (v0 == 3) {
            revoke_role_internal(arg0, arg1.target, arg1.role);
        } else if (v0 == 4) {
            arg0.fund_receiver = 0x1::option::some<address>(arg1.target);
        } else if (v0 == 5) {
            arg0.reward_receiver = 0x1::option::some<address>(arg1.target);
        } else if (v0 == 6) {
            assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 107);
            0x2::transfer::public_transfer<0x2::package::UpgradeCap>(0x1::option::extract<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap), arg1.target);
            let v1 = UpgradeCapTransferred{
                transferred_to : arg1.target,
                transferred_at : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<UpgradeCapTransferred>(v1);
        } else {
            assert!(v0 == 7, 112);
            assert!(0x1::option::is_some<0x2::package::Publisher>(&arg0.publisher), 108);
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
        assert!(0x1::option::is_some<address>(&arg0.fund_receiver), 113);
        *0x1::option::borrow<address>(&arg0.fund_receiver)
    }

    public fun get_reward_receiver(arg0: &ACL) : address {
        assert!(0x1::option::is_some<address>(&arg0.reward_receiver), 114);
        *0x1::option::borrow<address>(&arg0.reward_receiver)
    }

    public fun get_upgrade_cap_id(arg0: &0x2::package::UpgradeCap) : address {
        0x2::object::id_address<0x2::package::UpgradeCap>(arg0)
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

    fun is_proposal_still_valid(arg0: &ACL, arg1: &Proposal) : bool {
        arg1.proposal_type == 0 && !0x2::vec_set::contains<address>(&arg0.admins, &arg1.target) || arg1.proposal_type == 1 && 0x2::vec_set::contains<address>(&arg0.admins, &arg1.target) && 0x2::vec_set::size<address>(&arg0.admins) > 1 || arg1.proposal_type == 2 && !0x2::vec_set::contains<address>(0x2::table::borrow<u8, 0x2::vec_set::VecSet<address>>(&arg0.roles, arg1.role), &arg1.target) || arg1.proposal_type == 3 && 0x2::vec_set::contains<address>(0x2::table::borrow<u8, 0x2::vec_set::VecSet<address>>(&arg0.roles, arg1.role), &arg1.target) || true
    }

    public fun pool_manager_role() : u8 {
        1
    }

    public(friend) fun propose(arg0: &mut ACL, arg1: u8, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_admin(arg0, v0), 101);
        assert!(arg1 < 8, 112);
        assert!(arg2 < 4, 115);
        validate_proposal_creation(arg0, arg1, arg3, arg2);
        let v1 = arg0.next_proposal_id;
        arg0.next_proposal_id = v1 + 1;
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let (v3, v4) = if (arg1 == 0) {
            (v2 + 86400000, v2 + 86400000 * 2)
        } else {
            (v2, v2 + 86400000)
        };
        let v5 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v5, v0);
        let v6 = Proposal{
            id               : v1,
            proposal_type    : arg1,
            proposer         : v0,
            role             : arg2,
            target           : arg3,
            supporters       : v5,
            created_at       : v2,
            expired_at       : v4,
            executable_after : v3,
        };
        0x2::table::add<u64, Proposal>(&mut arg0.proposals, v1, v6);
        let v7 = ProposalCreated{
            proposal_id      : v1,
            proposal_type    : arg1,
            proposer         : v0,
            target           : arg3,
            executable_after : v3,
        };
        0x2::event::emit<ProposalCreated>(v7);
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
        let v3 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, 3);
        if (0x2::vec_set::contains<address>(v3, &arg1)) {
            0x2::vec_set::remove<address>(v3, &arg1);
        };
    }

    fun revoke_role_internal(arg0: &mut ACL, arg1: address, arg2: u8) {
        let v0 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, arg2);
        if (0x2::vec_set::contains<address>(v0, &arg1)) {
            0x2::vec_set::remove<address>(v0, &arg1);
        };
    }

    public fun reward_role() : u8 {
        2
    }

    public(friend) fun set_default_upgrade_cap_id(arg0: &mut ACL, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, v0), 101);
        assert!(0x1::option::is_none<address>(&arg0.default_upgrade_cap_id), 107);
        arg0.default_upgrade_cap_id = 0x1::option::some<address>(arg1);
        let v1 = DefaultUpgradeCapIdSet{
            cap_id : arg1,
            set_by : v0,
        };
        0x2::event::emit<DefaultUpgradeCapIdSet>(v1);
    }

    public(friend) fun set_publisher(arg0: &mut ACL, arg1: 0x2::package::Publisher, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_none<0x2::package::Publisher>(&arg0.publisher), 108);
        assert!(is_admin(arg0, v0), 101);
        assert!(0x2::package::from_package<ACL>(&arg1), 116);
        0x1::option::fill<0x2::package::Publisher>(&mut arg0.publisher, arg1);
        let v1 = PublisherSet{
            set_by : v0,
            set_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PublisherSet>(v1);
    }

    public(friend) fun set_upgrade_cap(arg0: &mut ACL, arg1: 0x2::package::UpgradeCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_none<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 107);
        assert!(is_admin(arg0, v0), 101);
        assert!(get_upgrade_cap_id(&arg1) == *0x1::option::borrow<address>(&arg0.default_upgrade_cap_id), 116);
        0x1::option::fill<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap, arg1);
        let v1 = UpgradeCapSet{
            set_by : v0,
            set_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UpgradeCapSet>(v1);
    }

    public fun upgrade_role() : u8 {
        3
    }

    fun validate_proposal_creation(arg0: &ACL, arg1: u8, arg2: address, arg3: u8) {
        if (arg1 == 0) {
            assert!(!0x2::vec_set::contains<address>(&arg0.admins, &arg2), 117);
        } else if (arg1 == 1) {
            assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg2), 118);
            assert!(0x2::vec_set::size<address>(&arg0.admins) > 1, 106);
        } else if (arg1 == 2) {
            assert!(!0x2::vec_set::contains<address>(0x2::table::borrow<u8, 0x2::vec_set::VecSet<address>>(&arg0.roles, arg3), &arg2), 119);
        } else if (arg1 == 3) {
            assert!(0x2::vec_set::contains<address>(0x2::table::borrow<u8, 0x2::vec_set::VecSet<address>>(&arg0.roles, arg3), &arg2), 120);
        };
    }

    public(friend) fun vote(arg0: &mut ACL, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 101);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposals, arg1), 105);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposals, arg1);
        assert!(!0x2::vec_set::contains<address>(&v1.supporters, &v0), 104);
        assert!(0x2::clock::timestamp_ms(arg2) < v1.expired_at, 110);
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

