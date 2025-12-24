module 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::controller {
    public entry fun modify_add_register(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_add_register(arg0, arg1);
    }

    public entry fun modify_admin(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_burn_amount(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_burn_amount(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: address, arg2: address, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg4), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_pool_config<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun modify_controller(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_last_time<T0, T1>(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_last_time<T0, T1>(arg0, arg1);
    }

    public entry fun modify_pool_fee(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_pool_fee(arg0, arg1);
    }

    public entry fun modify_rebot_addr<T0, T1>(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_rebot_addr<T0, T1>(arg0, arg1);
    }

    public entry fun modify_register_flag(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_register_flag(arg0, arg1);
    }

    public entry fun modify_remove_register(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_remove_register(arg0, arg1);
    }

    public entry fun modify_switch_config<T0, T1>(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: bool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg3), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_switch_config<T0, T1>(arg0, arg2, arg1);
    }

    public entry fun modify_tax_config<T0, T1>(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::admin(arg0) == 0x2::tx_context::sender(arg3), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::modify_tax_config<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun pause(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::is_emergency(arg0), 202);
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::is_emergency(arg0), 203);
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

