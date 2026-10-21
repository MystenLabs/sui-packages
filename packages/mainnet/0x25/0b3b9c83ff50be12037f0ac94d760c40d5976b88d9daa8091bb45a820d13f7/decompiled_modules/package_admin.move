module 0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::UpgradeCustody<0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::BLAST_PRESALE_PACKAGE>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::PackageVersion, arg2: &0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::blast_acl::AdminWitness<0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::assert_current(arg1);
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::authorize_upgrade<0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::PackageVersion, arg2: &0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::blast_acl::AdminWitness<0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::assert_next(arg1);
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::commit_upgrade<0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::advance(arg1);
    }

    public fun wrap(arg0: 0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::Bootstrap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::destroy(arg0);
        let v2 = 0x2::object::new(arg2);
        let v3 = PackageAdmin{
            id      : v2,
            custody : 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::new<0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::BLAST_PRESALE_PACKAGE>(0x2::object::uid_to_inner(&v2), v0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v3);
        0x250b3b9c83ff50be12037f0ac94d760c40d5976b88d9daa8091bb45a820d13f7::blast_presale_package::share_version(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

