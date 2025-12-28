module 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::controller {
    public entry fun modify_add_register(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_add_register(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: address, arg2: address, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg4), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_pool_config<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun modify_controller(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_pool_fee(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_pool_fee(arg0, arg1);
    }

    public entry fun modify_rebot_addr<T0, T1>(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_rebot_addr<T0, T1>(arg0, arg1);
    }

    public entry fun modify_register_flag(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_register_flag(arg0, arg1);
    }

    public entry fun modify_remove_register(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_remove_register(arg0, arg1);
    }

    public entry fun modify_switch_config<T0, T1>(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: bool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg3), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_switch_config<T0, T1>(arg0, arg2, arg1);
    }

    public entry fun modify_tax_config<T0, T1>(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg3), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::modify_tax_config<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun pause(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::is_emergency(arg0), 202);
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::is_emergency(arg0), 203);
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::resume(arg0);
    }

    public fun upgrade_version(arg0: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::admin(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::upgrade_version(arg0);
    }

    // decompiled from Move bytecode v6
}

