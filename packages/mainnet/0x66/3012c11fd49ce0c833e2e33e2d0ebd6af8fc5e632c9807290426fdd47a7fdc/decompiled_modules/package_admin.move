module 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::AdminRegistry, arg2: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::AdminCap, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::assert_admin_cap(arg1, arg2);
        0x2::package::authorize_upgrade(&mut arg0.upgrade_cap, 0x2::package::upgrade_policy(&arg0.upgrade_cap), arg3)
    }

    public fun commit_upgrade(arg0: &mut PackageAdmin, arg1: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::AdminRegistry, arg2: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::AdminCap, arg3: 0x2::package::UpgradeReceipt) {
        0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::assert_admin_cap(arg1, arg2);
        0x2::package::commit_upgrade(&mut arg0.upgrade_cap, arg3);
    }

    fun seal_dependency_only(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : PackageAdmin {
        let v0 = 0x2::package::upgrade_package(&arg0);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<PackageAdmin>() && 0x2::package::version(&arg0) == 1, 13835058317275234306);
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

