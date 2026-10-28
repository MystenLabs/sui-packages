module 0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::upgrade_custody::UpgradeCustody<0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::BLAST_PRESALE_PACKAGE>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::PackageVersion, arg2: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::assert_current(arg1);
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::upgrade_custody::authorize_upgrade<0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::PackageVersion, arg2: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::assert_next(arg1);
        0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::upgrade_custody::commit_upgrade<0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::advance(arg1);
    }

    public fun wrap(arg0: 0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::Bootstrap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::destroy(arg0);
        let v2 = 0x2::object::new(arg2);
        let v3 = PackageAdmin{
            id      : v2,
            custody : 0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::upgrade_custody::new<0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::BLAST_PRESALE_PACKAGE>(0x2::object::uid_to_inner(&v2), v0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v3);
        0xb0279fbe54bfd1d920e985a4dba0916b2b73a5218514edeecb7b9dd30cf2863b::blast_presale_package::share_version(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

