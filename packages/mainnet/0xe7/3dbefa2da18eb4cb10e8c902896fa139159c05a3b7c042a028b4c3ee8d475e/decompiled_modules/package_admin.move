module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::upgrade_custody::UpgradeCustody<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::package_admin_role());
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::upgrade_custody::authorize_upgrade<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun make_immutable(arg0: &mut PackageAdmin, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::package_admin_role());
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::upgrade_custody::make_immutable<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun restrict_to_additive(arg0: &mut PackageAdmin, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::package_admin_role());
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::upgrade_custody::restrict_to_additive<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun restrict_to_dependency_only(arg0: &mut PackageAdmin, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::package_admin_role());
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::upgrade_custody::restrict_to_dependency_only<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg3: 0x2::package::UpgradeReceipt) {
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::package_admin_role());
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_next(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::upgrade_custody::commit_upgrade<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::advance(arg1);
    }

    public fun wrap(arg0: 0x2::package::Publisher, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&arg0), 0);
        let v0 = 0x2::object::new(arg2);
        let v1 = PackageAdmin{
            id      : v0,
            custody : 0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::upgrade_custody::new<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(0x2::object::uid_to_inner(&v0), arg0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v1);
    }

    // decompiled from Move bytecode v7
}

