module 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0x65bffe80e883cc8b7bbb5049657e171b7f73502528d5b486d678eab6227d58bc::upgrade_custody::UpgradeCustody<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::BLAST_PRESALE_PACKAGE>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::PackageVersion, arg2: &0x65bffe80e883cc8b7bbb5049657e171b7f73502528d5b486d678eab6227d58bc::blast_acl::AdminWitness<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::assert_current(arg1);
        0x65bffe80e883cc8b7bbb5049657e171b7f73502528d5b486d678eab6227d58bc::upgrade_custody::authorize_upgrade<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::PackageVersion, arg2: &0x65bffe80e883cc8b7bbb5049657e171b7f73502528d5b486d678eab6227d58bc::blast_acl::AdminWitness<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::assert_next(arg1);
        0x65bffe80e883cc8b7bbb5049657e171b7f73502528d5b486d678eab6227d58bc::upgrade_custody::commit_upgrade<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::BLAST_PRESALE_PACKAGE>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::advance(arg1);
    }

    public fun wrap(arg0: 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::Bootstrap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::destroy(arg0);
        let v2 = 0x2::object::new(arg2);
        let v3 = PackageAdmin{
            id      : v2,
            custody : 0x65bffe80e883cc8b7bbb5049657e171b7f73502528d5b486d678eab6227d58bc::upgrade_custody::new<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::BLAST_PRESALE_PACKAGE>(0x2::object::uid_to_inner(&v2), v0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v3);
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::share_version(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

