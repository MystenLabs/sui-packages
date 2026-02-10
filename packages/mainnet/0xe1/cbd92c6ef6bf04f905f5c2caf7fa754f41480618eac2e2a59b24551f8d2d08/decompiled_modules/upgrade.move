module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::upgrade {
    struct PackageDigest has copy, drop, store {
        pos0: vector<u8>,
    }

    struct UpgradeProposal has drop, store {
        epoch: u32,
        digest: PackageDigest,
        version: u64,
        voting_weight: u16,
        voters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct UpgradeManager has key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
        upgrade_proposals: 0x2::table::Table<PackageDigest, UpgradeProposal>,
    }

    struct EmergencyUpgradeCap has store, key {
        id: 0x2::object::UID,
        upgrade_manager_id: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : EmergencyUpgradeCap {
        let v0 = UpgradeManager{
            id                : 0x2::object::new(arg1),
            cap               : arg0,
            upgrade_proposals : 0x2::table::new<PackageDigest, UpgradeProposal>(arg1),
        };
        let v1 = EmergencyUpgradeCap{
            id                 : 0x2::object::new(arg1),
            upgrade_manager_id : 0x2::object::id<UpgradeManager>(&v0),
        };
        0x2::transfer::share_object<UpgradeManager>(v0);
        v1
    }

    public fun authorize_upgrade(arg0: &mut UpgradeManager, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::Staking, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        let v0 = PackageDigest{pos0: arg2};
        assert!(0x2::table::contains<PackageDigest, UpgradeProposal>(&arg0.upgrade_proposals, v0), 4);
        let v1 = 0x2::table::remove<PackageDigest, UpgradeProposal>(&mut arg0.upgrade_proposals, v0);
        assert!(v1.epoch == 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::epoch(arg1), 5);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::is_quorum(arg1, v1.voting_weight), 6);
        assert!(0x2::package::version(&arg0.cap) + 1 == v1.version, 7);
        0x2::package::authorize_upgrade(&mut arg0.cap, 0x2::package::upgrade_policy(&arg0.cap), v0.pos0)
    }

    public fun commit_upgrade(arg0: &mut UpgradeManager, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::Staking, arg2: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg3: 0x2::package::UpgradeReceipt) {
        let v0 = 0x2::package::receipt_package(&arg3);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::set_new_package_id(arg1, v0);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::set_new_package_id(arg2, v0);
        0x2::package::commit_upgrade(&mut arg0.cap, arg3);
    }

    fun add_vote(arg0: &mut UpgradeProposal, arg1: 0x2::object::ID, arg2: u16) {
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.voters, &arg1), 2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.voters, arg1);
        arg0.voting_weight = arg0.voting_weight + arg2;
    }

    public fun authorize_emergency_upgrade(arg0: &mut UpgradeManager, arg1: &EmergencyUpgradeCap, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        assert!(arg1.upgrade_manager_id == 0x2::object::id<UpgradeManager>(arg0), 0);
        0x2::package::authorize_upgrade(&mut arg0.cap, 0x2::package::upgrade_policy(&arg0.cap), arg2)
    }

    public fun burn_emergency_upgrade_cap(arg0: EmergencyUpgradeCap) {
        let EmergencyUpgradeCap {
            id                 : v0,
            upgrade_manager_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun cleanup_upgrade_proposals(arg0: &mut UpgradeManager, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::Staking, arg2: vector<vector<u8>>) {
        0x1::vector::reverse<vector<u8>>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v1 = 0x1::vector::pop_back<vector<u8>>(&mut arg2);
            assert!(0x1::vector::length<u8>(&v1) == 32, 3);
            let v2 = PackageDigest{pos0: v1};
            if (0x2::table::contains<PackageDigest, UpgradeProposal>(&arg0.upgrade_proposals, v2)) {
                let v3 = 0x2::table::borrow<PackageDigest, UpgradeProposal>(&arg0.upgrade_proposals, v2);
                if (v3.version <= 0x2::package::version(&arg0.cap) || v3.epoch < 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::epoch(arg1)) {
                    0x2::table::remove<PackageDigest, UpgradeProposal>(&mut arg0.upgrade_proposals, v2);
                };
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
    }

    fun fresh_proposal(arg0: u32, arg1: PackageDigest, arg2: u64) : UpgradeProposal {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events::emit_contract_upgrade_proposed(arg0, arg1.pos0);
        UpgradeProposal{
            epoch         : arg0,
            digest        : arg1,
            version       : arg2,
            voting_weight : 0,
            voters        : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun vote_for_upgrade(arg0: &mut UpgradeManager, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::Staking, arg2: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::auth::Authenticated, arg3: 0x2::object::ID, arg4: vector<u8>) {
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::check_governance_authorization(arg1, arg3, arg2), 1);
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::epoch(arg1);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 3);
        let v1 = PackageDigest{pos0: arg4};
        let v2 = if (0x2::table::contains<PackageDigest, UpgradeProposal>(&arg0.upgrade_proposals, v1)) {
            let v3 = 0x2::table::borrow_mut<PackageDigest, UpgradeProposal>(&mut arg0.upgrade_proposals, v1);
            if (v3.epoch != v0 || v3.version != 0x2::package::version(&arg0.cap) + 1) {
                *v3 = fresh_proposal(v0, v1, 0x2::package::version(&arg0.cap) + 1);
            };
            v3
        } else {
            0x2::table::add<PackageDigest, UpgradeProposal>(&mut arg0.upgrade_proposals, v1, fresh_proposal(v0, v1, 0x2::package::version(&arg0.cap) + 1));
            0x2::table::borrow_mut<PackageDigest, UpgradeProposal>(&mut arg0.upgrade_proposals, v1)
        };
        add_vote(v2, arg3, 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::get_current_node_weight(arg1, arg3));
        if (0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::staking::is_quorum(arg1, v2.voting_weight)) {
            0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::events::emit_contract_upgrade_quorum_reached(v0, v1.pos0);
        };
    }

    // decompiled from Move bytecode v6
}

