module 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    fun complete<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::mode::Mode, arg4: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg5: &mut 0x2::tx_context::TxContext) : (0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::state::AdminCap, 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::upgrades::UpgradeCap) {
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::upgrades::new_upgrade_cap(arg1, arg5);
        let (v2, v3) = 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::state::new<T0>(arg2, arg3, arg4, 0x2::object::id<0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::upgrades::UpgradeCap>(&v1), arg5);
        0x2::transfer::public_share_object<0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::state::State<T0>>(v2);
        (v3, v1)
    }

    public fun complete_burning<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::state::AdminCap, 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::upgrades::UpgradeCap) {
        complete<T0>(arg0, arg1, arg2, 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::mode::burning(), 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg3), arg4)
    }

    public fun complete_locking<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : (0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::state::AdminCap, 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::upgrades::UpgradeCap) {
        complete<T0>(arg0, arg1, arg2, 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::mode::locking(), 0x1::option::none<0x2::coin::TreasuryCap<T0>>(), arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

