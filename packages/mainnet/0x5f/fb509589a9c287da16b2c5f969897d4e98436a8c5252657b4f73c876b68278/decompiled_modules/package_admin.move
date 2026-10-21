module 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::UpgradeCustody<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::BLAST_FUN>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::PackageVersion, arg2: &0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::blast_acl::AdminWitness<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::assert_current(arg1);
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::authorize_upgrade<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::BLAST_FUN>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::PackageVersion, arg2: &0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::blast_acl::AdminWitness<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::assert_next(arg1);
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::commit_upgrade<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::BLAST_FUN>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::advance(arg1);
    }

    public fun make_immutable(arg0: &mut PackageAdmin, arg1: &0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::PackageVersion, arg2: &0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::blast_acl::AdminWitness<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun_domain::UpgradeAdmin>) {
        0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::assert_current(arg1);
        0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::make_immutable<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::BLAST_FUN>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun wrap(arg0: 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::Bootstrap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::destroy(arg0);
        let v2 = 0x2::object::new(arg2);
        let v3 = PackageAdmin{
            id      : v2,
            custody : 0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::upgrade_custody::new<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::BLAST_FUN>(0x2::object::uid_to_inner(&v2), v0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v3);
        0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::share_version(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

