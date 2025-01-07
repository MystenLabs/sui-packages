module 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::controller {
    public entry fun modify_add_register(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::modify_add_register(arg0, arg1);
    }

    public entry fun modify_admin(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: bool, arg2: address, arg3: address, arg4: u8, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::admin(arg0) == 0x2::tx_context::sender(arg6), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::modify_pool_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun modify_controller(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_pool_fee(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::modify_pool_fee(arg0, arg1);
    }

    public entry fun modify_register_flag(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::modify_register_flag(arg0, arg1);
    }

    public entry fun modify_remove_register(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::modify_remove_register(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::is_emergency(arg0), 202);
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::is_emergency(arg0), 203);
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

