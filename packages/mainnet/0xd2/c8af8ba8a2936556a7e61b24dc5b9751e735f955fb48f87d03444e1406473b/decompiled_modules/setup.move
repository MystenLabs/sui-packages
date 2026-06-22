module 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    fun complete<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::mode::Mode, arg4: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg5: &mut 0x2::tx_context::TxContext) : (0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::state::AdminCap, 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::upgrades::UpgradeCap) {
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::upgrades::new_upgrade_cap(arg1, arg5);
        let (v2, v3) = 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::state::new<T0>(arg2, arg3, arg4, 0x2::object::id<0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::upgrades::UpgradeCap>(&v1), arg5);
        0x2::transfer::public_share_object<0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::state::State<T0>>(v2);
        (v3, v1)
    }

    public fun complete_burning<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::state::AdminCap, 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::upgrades::UpgradeCap) {
        complete<T0>(arg0, arg1, arg2, 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::mode::burning(), 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg3), arg4)
    }

    public fun complete_locking<T0>(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : (0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::state::AdminCap, 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::upgrades::UpgradeCap) {
        complete<T0>(arg0, arg1, arg2, 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::mode::locking(), 0x1::option::none<0x2::coin::TreasuryCap<T0>>(), arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

