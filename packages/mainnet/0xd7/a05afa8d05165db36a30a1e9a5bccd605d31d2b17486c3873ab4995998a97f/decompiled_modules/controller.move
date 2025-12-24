module 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::controller {
    public entry fun modify_add_register(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_add_register(arg0, arg1);
    }

    public entry fun modify_admin(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_burn_amount(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_burn_amount(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: address, arg2: address, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg4), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_pool_config<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun modify_controller(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_last_time<T0, T1>(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_last_time<T0, T1>(arg0, arg1);
    }

    public entry fun modify_pool_fee(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_pool_fee(arg0, arg1);
    }

    public entry fun modify_rebot_addr<T0, T1>(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_rebot_addr<T0, T1>(arg0, arg1);
    }

    public entry fun modify_register_flag(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_register_flag(arg0, arg1);
    }

    public entry fun modify_remove_register(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_remove_register(arg0, arg1);
    }

    public entry fun modify_switch_config<T0, T1>(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: bool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg3), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_switch_config<T0, T1>(arg0, arg2, arg1);
    }

    public entry fun modify_tax_config<T0, T1>(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::admin(arg0) == 0x2::tx_context::sender(arg3), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::modify_tax_config<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun pause(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::is_emergency(arg0), 202);
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::is_emergency(arg0), 203);
        assert!(0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xd7a05afa8d05165db36a30a1e9a5bccd605d31d2b17486c3873ab4995998a97f::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

