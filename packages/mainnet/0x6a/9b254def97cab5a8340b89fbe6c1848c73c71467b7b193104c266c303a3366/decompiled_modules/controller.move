module 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::controller {
    public entry fun modify_add_register(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::modify_add_register(arg0, arg1);
    }

    public entry fun modify_admin(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: bool, arg2: address, arg3: address, arg4: u8, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::admin(arg0) == 0x2::tx_context::sender(arg6), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::modify_pool_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun modify_controller(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_pool_fee(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::modify_pool_fee(arg0, arg1);
    }

    public entry fun modify_register_flag(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::modify_register_flag(arg0, arg1);
    }

    public entry fun modify_remove_register(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::modify_remove_register(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::is_emergency(arg0), 202);
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::is_emergency(arg0), 203);
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

