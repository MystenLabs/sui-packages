module 0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::upgrade_custody::UpgradeCustody<0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::BLAST_FUN_MIGRATORS>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::PackageVersion, arg2: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::assert_current(arg1);
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::upgrade_custody::authorize_upgrade<0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::BLAST_FUN_MIGRATORS>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::PackageVersion, arg2: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::assert_next(arg1);
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::upgrade_custody::commit_upgrade<0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::BLAST_FUN_MIGRATORS>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::advance(arg1);
    }

    public fun wrap(arg0: 0x2::package::Publisher, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = PackageAdmin{
            id      : v0,
            custody : 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::upgrade_custody::new<0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::BLAST_FUN_MIGRATORS>(0x2::object::uid_to_inner(&v0), arg0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v1);
    }

    // decompiled from Move bytecode v7
}

