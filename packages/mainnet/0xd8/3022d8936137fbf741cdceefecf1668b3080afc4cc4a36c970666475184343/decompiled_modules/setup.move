module 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    fun complete<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::mode::Mode, arg4: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg5: &mut 0x2::tx_context::TxContext) : (0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::state::AdminCap, 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::upgrades::UpgradeCap) {
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::upgrades::new_upgrade_cap(arg1, arg5);
        let (v2, v3) = 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::state::new<T0>(arg2, arg3, arg4, 0x2::object::id<0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::upgrades::UpgradeCap>(&v1), arg5);
        0x2::transfer::public_share_object<0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::state::State<T0>>(v2);
        (v3, v1)
    }

    public fun complete_burning<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::state::AdminCap, 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::upgrades::UpgradeCap) {
        complete<T0>(arg0, arg1, arg2, 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::mode::burning(), 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg3), arg4)
    }

    public fun complete_locking<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : (0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::state::AdminCap, 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::upgrades::UpgradeCap) {
        complete<T0>(arg0, arg1, arg2, 0xd83022d8936137fbf741cdceefecf1668b3080afc4cc4a36c970666475184343::mode::locking(), 0x1::option::none<0x2::coin::TreasuryCap<T0>>(), arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

