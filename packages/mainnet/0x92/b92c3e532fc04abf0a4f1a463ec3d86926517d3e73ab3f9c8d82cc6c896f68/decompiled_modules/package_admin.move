module 0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0xc5d2d0113ac68a39939c8f922ea7d470f196691f8b6fe281985bd8c59f92b716::upgrade_custody::UpgradeCustody<0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::BLAST_PRESALE_PACKAGE>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::PackageVersion, arg2: &0xc5d2d0113ac68a39939c8f922ea7d470f196691f8b6fe281985bd8c59f92b716::blast_acl::AdminWitness<0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::assert_current(arg1);
        0xc5d2d0113ac68a39939c8f922ea7d470f196691f8b6fe281985bd8c59f92b716::upgrade_custody::authorize_upgrade<0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::PackageVersion, arg2: &0xc5d2d0113ac68a39939c8f922ea7d470f196691f8b6fe281985bd8c59f92b716::blast_acl::AdminWitness<0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::assert_next(arg1);
        0xc5d2d0113ac68a39939c8f922ea7d470f196691f8b6fe281985bd8c59f92b716::upgrade_custody::commit_upgrade<0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::advance(arg1);
    }

    public fun wrap(arg0: 0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::Bootstrap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::destroy(arg0);
        let v2 = 0x2::object::new(arg2);
        let v3 = PackageAdmin{
            id      : v2,
            custody : 0xc5d2d0113ac68a39939c8f922ea7d470f196691f8b6fe281985bd8c59f92b716::upgrade_custody::new<0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::BLAST_PRESALE_PACKAGE>(0x2::object::uid_to_inner(&v2), v0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v3);
        0x92b92c3e532fc04abf0a4f1a463ec3d86926517d3e73ab3f9c8d82cc6c896f68::blast_presale_package::share_version(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

