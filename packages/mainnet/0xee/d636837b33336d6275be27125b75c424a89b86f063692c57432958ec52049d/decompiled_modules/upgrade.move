module 0xeed636837b33336d6275be27125b75c424a89b86f063692c57432958ec52049d::upgrade {
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

