module 0x2497004f3f3ff0f78bdb6c05c62c3c45b06ff531ea9ffd7fa191c7223b729a8::roles {
    struct Admin has key {
        id: 0x2::object::UID,
    }

    struct ROLES has drop {
        dummy_field: bool,
    }

    struct Creator has store, key {
        id: 0x2::object::UID,
        launch: 0x2::object::ID,
    }

    public fun add_admin(arg0: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::OwnerCap<ROLES>, arg1: &mut 0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<ROLES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::add_role<ROLES, Admin>(arg0, arg1, arg2, arg3);
    }

    public fun assert_launch_creator(arg0: &Creator, arg1: 0x2::object::ID) {
        assert!(arg0.launch == arg1, 0);
    }

    fun init(arg0: ROLES, arg1: &mut 0x2::tx_context::TxContext) {
        0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::default<ROLES>(&arg0, arg1);
    }

    public(friend) fun new_creator(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Creator {
        Creator{
            id     : 0x2::object::new(arg1),
            launch : arg0,
        }
    }

    public fun revoke_admin(arg0: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::OwnerCap<ROLES>, arg1: &mut 0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<ROLES>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::revoke_role_access<ROLES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

