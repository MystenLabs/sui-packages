module 0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::UpgradeCustody<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::BLAST_PRESALE_PACKAGE>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::assert_current(arg1);
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::authorize_upgrade<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::assert_next(arg1);
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::commit_upgrade<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::advance(arg1);
    }

    public fun wrap(arg0: 0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::Bootstrap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::destroy(arg0);
        let v2 = 0x2::object::new(arg2);
        let v3 = PackageAdmin{
            id      : v2,
            custody : 0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::new<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::BLAST_PRESALE_PACKAGE>(0x2::object::uid_to_inner(&v2), v0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v3);
        0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::share_version(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

