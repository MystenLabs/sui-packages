module 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale_domain::UpgradeAdmin>, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        0x2::package::authorize_upgrade(&mut arg0.upgrade_cap, 0x2::package::upgrade_policy(&arg0.upgrade_cap), arg2)
    }

    public fun commit_upgrade(arg0: &mut PackageAdmin, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale_domain::UpgradeAdmin>, arg2: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.upgrade_cap, arg2);
    }

    fun seal_dependency_only(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : PackageAdmin {
        let v0 = 0x2::package::upgrade_package(&arg0);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<PackageAdmin>() && 0x2::package::version(&arg0) == 1, 13835058295800397826);
        0x2::package::only_dep_upgrades(&mut arg0);
        PackageAdmin{
            id          : 0x2::object::new(arg1),
            upgrade_cap : arg0,
        }
    }

    public fun wrap(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PackageAdmin>(seal_dependency_only(arg0, arg1));
    }

    // decompiled from Move bytecode v7
}

