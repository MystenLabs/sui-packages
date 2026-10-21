module 0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0xe1435762293d652a2fc95f10f7763d1db8df4b230e2e4d2b23ad2004696781d::upgrade_custody::UpgradeCustody<0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::BLAST_PRESALE_PACKAGE>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::PackageVersion, arg2: &0xe1435762293d652a2fc95f10f7763d1db8df4b230e2e4d2b23ad2004696781d::blast_acl::AdminWitness<0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::assert_current(arg1);
        0xe1435762293d652a2fc95f10f7763d1db8df4b230e2e4d2b23ad2004696781d::upgrade_custody::authorize_upgrade<0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::PackageVersion, arg2: &0xe1435762293d652a2fc95f10f7763d1db8df4b230e2e4d2b23ad2004696781d::blast_acl::AdminWitness<0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::assert_next(arg1);
        0xe1435762293d652a2fc95f10f7763d1db8df4b230e2e4d2b23ad2004696781d::upgrade_custody::commit_upgrade<0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::advance(arg1);
    }

    public fun wrap(arg0: 0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::Bootstrap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::destroy(arg0);
        let v2 = 0x2::object::new(arg2);
        let v3 = PackageAdmin{
            id      : v2,
            custody : 0xe1435762293d652a2fc95f10f7763d1db8df4b230e2e4d2b23ad2004696781d::upgrade_custody::new<0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::BLAST_PRESALE_PACKAGE>(0x2::object::uid_to_inner(&v2), v0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v3);
        0x9911ea68bc1684b1bef2e57564280b58579db9f27204fdbfbcfa00a4eaeb668f::blast_presale_package::share_version(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

