module 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::immutability {
    struct PackageUpgradeRenounced has copy, drop {
        package_id: 0x2::object::ID,
        admin: address,
    }

    public entry fun renounce_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = PackageUpgradeRenounced{
            package_id : 0x2::package::upgrade_package(&arg0),
            admin      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PackageUpgradeRenounced>(v0);
        0x2::package::make_immutable(arg0);
    }

    // decompiled from Move bytecode v7
}

