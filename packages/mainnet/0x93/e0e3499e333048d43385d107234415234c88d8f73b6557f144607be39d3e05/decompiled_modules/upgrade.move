module 0x93e0e3499e333048d43385d107234415234c88d8f73b6557f144607be39d3e05::upgrade {
    struct UpgradeCapHolder has key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
    }

    public fun transfer_upgrade_cap(arg0: UpgradeCapHolder, arg1: address) {
        0x2::transfer::transfer<UpgradeCapHolder>(arg0, arg1);
    }

    public fun unwrap_upgrade_cap(arg0: UpgradeCapHolder) : 0x2::package::UpgradeCap {
        let UpgradeCapHolder {
            id  : v0,
            cap : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun wrap_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeCapHolder{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::transfer<UpgradeCapHolder>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

