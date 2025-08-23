module 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    fun complete<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::mode::Mode, arg4: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg5: &mut 0x2::tx_context::TxContext) : (0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::state::AdminCap, 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::upgrades::UpgradeCap) {
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::upgrades::new_upgrade_cap(arg1, arg5);
        let (v2, v3) = 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::state::new<T0>(arg2, arg3, arg4, 0x2::object::id<0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::upgrades::UpgradeCap>(&v1), arg5);
        0x2::transfer::public_share_object<0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::state::State<T0>>(v2);
        (v3, v1)
    }

    public fun complete_burning<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::state::AdminCap, 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::upgrades::UpgradeCap) {
        complete<T0>(arg0, arg1, arg2, 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::mode::burning(), 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg3), arg4)
    }

    public fun complete_locking<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : (0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::state::AdminCap, 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::upgrades::UpgradeCap) {
        complete<T0>(arg0, arg1, arg2, 0xdc78fd623420996fef4855b2361da32ad6bf88c37d144988ee85d61887f2fbf5::mode::locking(), 0x1::option::none<0x2::coin::TreasuryCap<T0>>(), arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

